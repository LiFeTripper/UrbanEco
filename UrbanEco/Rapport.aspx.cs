using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UrbanEco.Rapports;

namespace UrbanEco
{
    public partial class Rapport : System.Web.UI.Page
    {
        static List<tbl_ProjetCat> sortedCats = new List<tbl_ProjetCat>();

        static List<tbl_Employe> emp_bureau = new List<tbl_Employe>();
        static List<tbl_Employe> emp_terrain = new List<tbl_Employe>();

        static List<tbl_ProjetCat> projet_categorie = new List<tbl_ProjetCat>();

        static List<tbl_ProjetCatEmploye> projet_categorie_employe = new List<tbl_ProjetCatEmploye>();

        static List<int> SelectedProjets = new List<int>();
        static List<int> SelectedEmployes = new List<int>();
        static List<int> SelectedCategories = new List<int>();

        protected void Page_Load(object sender, EventArgs e)
        {
            Autorisation2.Autorisation(false, false);
            //Permet de recréer les repeater asp pour vérifier les valeurs selected pour les employés et les catégories
            RepBureau.DataSource = emp_bureau;
            RepBureau.DataBind();

            RepTerrain.DataSource = emp_terrain;
            RepTerrain.DataBind();

            repParentCat.DataSource = projet_categorie;
            repParentCat.DataBind();

            CoecoDataContext ctx = new CoecoDataContext();

            rptr_projets.DataSource = BD.GetAllProjets(ctx).Where(p => p.archiver == chkbox_projets.Checked);
            rptr_projets.DataBind();
            
            if (!IsPostBack)
            {
                //Query pour les projet
                CoecoDataContext context = new CoecoDataContext();

                var empBureau = from emp in context.tbl_Employe                 //1 = Bureau
                                where emp.idTypeEmpl == 1 && emp.idEmploye != 4 //4 = Administrateur
                                orderby emp.nom, emp.prenom
                                select emp;

                var empTerrain = from emp in context.tbl_Employe                //2 = Terrain
                                where emp.idTypeEmpl == 2 && emp.idEmploye != 4
                                 orderby emp.nom, emp.prenom
                                select emp;


                emp_bureau = empBureau.Where(ep => ep.inactif == chkbox_employes.Checked).ToList(); //on prend la request de la BD et on met dans la liste des employés
                emp_terrain = empTerrain.Where(ep => ep.inactif == chkbox_employes.Checked).ToList();

                RepBureau.DataSource = emp_bureau; //On met la liste des employés au repeter
                RepBureau.DataBind();

                RepTerrain.DataSource = emp_terrain;
                RepTerrain.DataBind();

                var queryProjet = from tbl in context.tbl_Projet
                            where tbl.archiver == false
                            orderby tbl.titre
                            select tbl;

                
                date_debut.Value = Layout.ToCalendarDate(DateTime.Today);
                date_fin.Value = Layout.ToCalendarDate(DateTime.Today);
            }

            if (IsPostBack)
            {
                RequeryCategorie();
                RequeryEmployes();
            }
        }

        void RequeryCategorie()
        {
            CoecoDataContext context = new CoecoDataContext();

            string[] projetSelectedStr = hiddenFieldProjet.Value.Split(',');

            if (projetSelectedStr.Length == 0)
            {
                repParentCat.DataSource = null;
                repParentCat.DataBind();
                return;
            }

            List<ListItem> categoriesAvailable = new List<ListItem>();

            foreach (string IDProjet in projetSelectedStr)
            {
                if (string.IsNullOrWhiteSpace(IDProjet))
                    continue;

                int idProjet = Convert.ToInt32(IDProjet);

                var queryCatNiveau2 = from tblProjetCat in context.tbl_ProjetCat
                                      where tblProjetCat.idCatMaitre != null && tblProjetCat.idProjet == idProjet
                                      select tblProjetCat;

                foreach (var cat in queryCatNiveau2.ToList())
                {
                    ListItem ls = new ListItem(cat.tbl_ProjetCat1.titre + " - " + cat.titre, cat.idProjetCat.ToString());

                    categoriesAvailable.Add(ls);
                }
            }

            repParentCat.DataSource = categoriesAvailable;
            repParentCat.DataBind();
        }

        void RequeryEmployes()
        {
            CoecoDataContext context = new CoecoDataContext();
            

            var queryEmpBureau = from tbl in context.tbl_ProjetCatEmploye
                                 join empBureau in context.tbl_Employe on tbl.idEmploye equals empBureau.idEmploye
                                 where (SelectedProjets.Count > 0 ? SelectedProjets.Contains(tbl.idProjet) : true) && empBureau.idTypeEmpl == 1 && empBureau.inactif == chkbox_employes.Checked
                                 select empBureau;

            var queryEmpterrain = from tbl in context.tbl_ProjetCatEmploye
                                 join empterrain in context.tbl_Employe on tbl.idEmploye equals empterrain.idEmploye
                                 where (SelectedProjets.Count > 0 ? SelectedProjets.Contains(tbl.idProjet) : true) && empterrain.idTypeEmpl == 2 && empterrain.inactif == chkbox_employes.Checked
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

        protected string ProjetSelected(object id)
        {
            int idProjet = (int) id;

            //Permet de lire la liste des employé dans le textbox hidden
            UpdateSelectedProjetList();

            foreach (var item in SelectedProjets)
            {
                if (item == idProjet)
                    return "selected";
            }

            return "";
        }

        protected string CategorieSelected(object id)
        {
            int idProjetCat = -1;
            int.TryParse(id.ToString(), out idProjetCat);

            //Permet de lire la liste des catégories dans le textbox hidden
            UpdateSelectedCategorieList();

            foreach (var item in SelectedCategories)
            {
                if (item == idProjetCat)
                    return "selected";
            }

            return "";
        }

        protected string FormatCategorieName(object idCat)
        {
            return "";
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
        /// Update la liste des employés sélectionnés
        /// </summary>
        void UpdateSelectedProjetList()
        {
            List<int> listProjet = new List<int>();

            foreach (var idProjet in hiddenFieldProjet.Value.Split(','))
            {
                int id = -1;

                if (string.IsNullOrWhiteSpace(idProjet))
                    continue;

                id = ConvertValueToInt(idProjet);

                if (id <= -1)
                    continue;

                listProjet.Add(id);
            }

            SelectedProjets = listProjet;
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
            CoecoDataContext ctx = new CoecoDataContext();

            DateTime dateDebut = DateTime.Parse(date_debut.Value);
            DateTime dateFin = DateTime.Parse(date_fin.Value);

            // Loop through all projets
            List<tbl_Projet> projets = ctx.tbl_Projet
                                                        .Where(p => SelectedProjets.Count > 0 ?
                                                                            SelectedProjets.Contains(p.idProjet):
                                                                            true)
                                                        .Distinct()
                                                        .ToList();

            RapportNode rapportNode = new RapportNode("rapport");
            // Loop through all projects
            foreach(tbl_Projet projet in projets)
            {
                RapportNode projNode = new RapportNode(projet.titre);

                List<tbl_ProjetCat> categories = ctx.tbl_ProjetCat
                                                            .Where(cat => SelectedCategories.Count > 0 ?
                                                                                SelectedCategories.Contains(cat.idProjetCat) :
                                                                                true)
                                                            .Where(cat => cat.idProjet == projet.idProjet)
                                                            .Distinct()
                                                            .ToList();

                // Loop trough all categories in the project
                foreach(tbl_ProjetCat categorie in categories)
                {
                    RapportNode catNode = new RapportNode(categorie.titre);

                    var catemp = ctx.tbl_ProjetCatEmploye.Where(c => c.idCategorie == categorie.idProjetCat)
                                                            .Where(c => SelectedEmployes.Count > 0 ?
                                                                            SelectedEmployes.Contains(c.idEmploye):
                                                                            true)
                                                            .Distinct()
                                                            .ToList();

                    var employes = ctx.tbl_Employe
                        .Where(emp => catemp.Select(ce => ce.idEmploye).Contains(emp.idEmploye));
                    
                    // Loop through all employes in category
                    foreach (tbl_Employe employe in employes)
                    {
                        RapportNode EmplNode = new RapportNode(string.Format("{0} {1}", employe.prenom, employe.nom));

                        // Get entries in Feuille de temps from employe
                        var heures = ctx.tbl_FeuilleTemps.Where(c => c.idCat == categorie.idProjetCat)
                                                        .Where(c => c.idEmploye == employe.idEmploye)
                                                        .Where(c => (bool)c.approuver)
                                                        .Where(c => c.dateCreation <= dateFin)
                                                        .Where(c => c.dateCreation >= dateDebut);

                        // Compile the entries
                        foreach (var heure in heures)
                        {
                            int hrs = (int)heure.nbHeure;
                            int min = (int)(heure.nbHeure - hrs) * 100;
                            EmplNode.NbHeure += new TimeSpan(hrs, min, 0);
                        }

                        // Add employe to category node
                        if (EmplNode.NbHeure > TimeSpan.Zero)
                        {
                            catNode.NbHeure += EmplNode.NbHeure;
                            catNode.Child.Add(EmplNode);
                        }
                    }

                    // Add all hours
                    if (catNode.NbHeure > TimeSpan.Zero)
                    {
                        projNode.NbHeure += catNode.NbHeure;
                        projNode.Child.Add(catNode);
                    }
                }

                // Ajouter les heures du projet au rapport node
                // Ajouter le projet au rapport node en tant qu'enfant
                if (projNode.NbHeure > TimeSpan.Zero)
                {
                    rapportNode.NbHeure += projNode.NbHeure;
                    rapportNode.Child.Add(projNode);
                }
            }
            
            Session["rapportNode"] = rapportNode;
            Session["dateDebut"] = dateDebut;
            Session["dateFin"] = dateFin;
            Response.Redirect("RapportPage.aspx");
        }

        protected void btn_retour_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }
    }
}