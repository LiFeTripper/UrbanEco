using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UrbanEco
{
    public partial class RapportProjet : System.Web.UI.Page
    {
        static List<tbl_ProjetCat> sortedCats = new List<tbl_ProjetCat>();


        static List<tbl_Employe> emp_bureau = new List<tbl_Employe>();
        static List<tbl_Employe> emp_terrain = new List<tbl_Employe>();

        static List<tbl_ProjetCat> projet_categorie = new List<tbl_ProjetCat>();

        static List<tbl_ProjetCatEmploye> projet_categorie_employe = new List<tbl_ProjetCatEmploye>();

        static List<int> SelectedEmployes = new List<int>();
        static List<int> SelectedCategories = new List<int>();

        protected void Page_Load(object sender, EventArgs e)
        {

            //Permet de recréer les repeater asp pour vérifier les valeurs selected pour les employés et les catégories
            RepBureau.DataSource = emp_bureau;
            RepBureau.DataBind();

            RepTerrain.DataSource = emp_terrain;
            RepTerrain.DataBind();

            repParentCat.DataSource = projet_categorie;
            repParentCat.DataBind();

            if (!IsPostBack)
            {    
                

                //tbx_categorie.Items.Add("Sélectionner un projet pour avoir accès au sous-catégorie");

                //Query pour les projet
                CoecoDataContext context = new CoecoDataContext();

                var empBureau = from emp in context.tbl_Employe
                                where emp.idTypeEmpl == 1 && emp.idEmploye != 4
                                orderby emp.nom, emp.prenom
                                select emp;

                var empTerrain = from emp in context.tbl_Employe
                                where emp.idTypeEmpl == 2 && emp.idEmploye != 4
                                 orderby emp.nom, emp.prenom
                                select emp;


                emp_bureau = empBureau.ToList();
                emp_terrain = empTerrain.ToList();

                RepBureau.DataSource = emp_bureau;
                RepBureau.DataBind();

                RepTerrain.DataSource = emp_terrain;
                RepTerrain.DataBind();

                var queryProjet = from tbl in context.tbl_Projet
                            //where tbl.archiver == false
                            orderby tbl.titre
                            select tbl;

                lst_projet.DataSource = queryProjet;
                lst_projet.DataBind();

                lst_projet.Items.Insert(0, "Veuillez sélectionner le projet");
                lst_projet.SelectedIndex = 0;



                RequeryCategorie();
                RequeryEmployes();
            }
        }

        void RequeryCategorie()
        {
            CoecoDataContext context = new CoecoDataContext();
            int idProjet = -1;

            idProjet = ConvertValueToInt(lst_projet.Items[lst_projet.SelectedIndex].Value);

            //No project selected
            if (idProjet <= -1)
            {
                repParentCat.DataSource = null;
                repParentCat.DataBind();
                return;
            }

            var queryCatMaster = from tbl in context.tbl_ProjetCat
                                 join tbl2 in context.tbl_ProjetCat on tbl.idProjetCat equals tbl2.idCatMaitre
                                 where tbl.idCatMaitre == null && tbl.idProjet == idProjet
                                 orderby tbl.titre
                                 select tbl;


            projet_categorie = queryCatMaster.Distinct().ToList();
             
            repParentCat.DataSource = queryCatMaster.Distinct();
            repParentCat.DataBind();


        }

        void RequeryEmployes()
        {
            CoecoDataContext context = new CoecoDataContext();
            int idProjet = -1;

            idProjet = ConvertValueToInt(lst_projet.Items[lst_projet.SelectedIndex].Value);

            //No project selected
            if (idProjet <= -1)
            {
                RepTerrain.DataSource = null;
                RepTerrain.DataBind();

                RepBureau.DataSource = null;
                RepBureau.DataBind();
                return;
            }

            var queryEmpBureau = from tbl in context.tbl_ProjetCatEmploye
                                 join empBureau in context.tbl_Employe on tbl.idEmploye equals empBureau.idEmploye
                                 where tbl.idProjet == idProjet && empBureau.idTypeEmpl == 1
                                 select empBureau;

            var queryEmpterrain = from tbl in context.tbl_ProjetCatEmploye
                                 join empterrain in context.tbl_Employe on tbl.idEmploye equals empterrain.idEmploye
                                 where tbl.idProjet == idProjet && empterrain.idTypeEmpl == 2
                                 select empterrain;

            emp_bureau = queryEmpBureau.Distinct().ToList();
            emp_terrain = queryEmpterrain.Distinct().ToList();

            RepBureau.DataSource = emp_bureau;
            RepBureau.DataBind();

            RepTerrain.DataSource = emp_terrain;
            RepTerrain.DataBind();


        }

        protected void lst_projet_SelectedIndexChanged(object sender, EventArgs e)
        {
            SelectedCategories.Clear();
            hiddenFieldCat.Value = "";

            SelectedEmployes.Clear();
            hiddenFieldEmploye.Value = "";

            RequeryCategorie();
            RequeryEmployes();
        }


        private int ConvertValueToInt(string value)
        {
            int result = int.MinValue;

            int.TryParse(value, out result);

            return result;
        }

        protected string EmployeSelected(object id)
        {
            int idEmploye = (int) id;

            //Permet de lire la liste des employé dans le textbox hidden
            UpdateSelectedEmployeList();

            foreach (var item in SelectedEmployes)
            {
                if (item == idEmploye)
                    return "selected";
            }

            return "";
        }

        protected string CategorieSelected(object id)
        {
            int idProjetCat = (int) id;

            //Permet de lire la liste des catégories dans le textbox hidden
            UpdateSelectedCategorieList();

            foreach (var item in SelectedCategories)
            {
                if (item == idProjetCat)
                    return "selected";
            }

            return "";
        }

        /// <summary>
        /// To delete
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void BtnTesting_Click(object sender, EventArgs e)
        {
            UpdateSelectedEmployeList();
            UpdateSelectedCategorieList();
        }

        /// <summary>
        /// Update la liste des employés sélectionnés
        /// </summary>
        void UpdateSelectedEmployeList()
        {
            List<int> listEmp = new List<int>();

            foreach (var idEmpl in hiddenFieldEmploye.Value.Split(','))
            {
                int id = -1;

                if (string.IsNullOrWhiteSpace(idEmpl))
                    continue;

                id = ConvertValueToInt(idEmpl);

                if (id <= -1)
                    continue;

                listEmp.Add(id);
            }

            SelectedEmployes = listEmp;
        }

        /// <summary>
        /// Update la liste des catégories sélectionner
        /// </summary>
        void UpdateSelectedCategorieList()
        {
            List<int> listCat = new List<int>();

            foreach (var idCat in hiddenFieldCat.Value.Split(','))
            {
                int id = -1;

                if (string.IsNullOrWhiteSpace(idCat))
                    continue;

                id = ConvertValueToInt(idCat);

                if (id <= -1)
                    continue;

                listCat.Add(id);
            }

            SelectedCategories = listCat;
        }

        protected void btn_generer_Click(object sender, EventArgs e)
        {
            tbl_Projet projet = null;
            List<tbl_Employe> employes = new List<tbl_Employe>();
            List<tbl_ProjetCat> categories = new List<tbl_ProjetCat>();

            DateTime dateDebut;
            DateTime dateFin;

            int idProjet = ConvertValueToInt(lst_projet.Items[lst_projet.SelectedIndex].Value);

            if(idProjet <= -1)
            {
                alert_failed.Visible = true;
                return;
            }

            CoecoDataContext ctx = new CoecoDataContext();

            dateDebut = DateTime.Parse(date_debut.Value);
            dateFin = DateTime.Parse(date_fin.Value);

            projet = ctx.tbl_Projet.Where(p => p.idProjet == idProjet).First();

            employes = ctx.tbl_Employe.Where(emp => SelectedEmployes.Contains(emp.idEmploye)).Distinct().ToList();

            categories = ctx.tbl_ProjetCat.Where(cat => SelectedCategories.Contains(cat.idProjetCat)).Distinct().ToList();
        }

        protected void btn_retour_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }
    }
}