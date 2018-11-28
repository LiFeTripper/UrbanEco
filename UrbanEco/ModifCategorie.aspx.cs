using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UrbanEco
{
    public partial class ModifCategorie : System.Web.UI.Page
    {
        string argument;
        string argument2;
        string mode;

        bool SousCat;
        bool modif;

        CoecoDataContext context = new CoecoDataContext();

        static List<tbl_Employe> emp_bureau = new List<tbl_Employe>();
        static List<tbl_Employe> emp_terrain = new List<tbl_Employe>();

        static List<int> AllEmployes = new List<int>();
        static List<int> UnselectedEmployes = new List<int>();
        static List<int> SelectedEmployes = new List<int>();
        static List<string> SelectedEmployesString = new List<string>();

        protected void Page_Load(object sender, EventArgs e)
        {


            //Réassigne les datasources des repeater
            RepBureau.DataSource = emp_bureau;
            RepBureau.DataBind();

            RepTerrain.DataSource = emp_terrain;
            RepTerrain.DataBind();

           

            if (!IsPostBack)
            {
                //Reset du hiddenfield
                hiddenFieldEmploye.Value = String.Empty;
                //Reset du hiddenfield
                hiddenFieldTotal.Value = String.Empty;

                AllEmployees();


                //Recherche de l'argument dans l'adresse
                argument = Request.QueryString["Prj"];

                argument2 = Request.QueryString["Cat"];

                //On trouve les employé qui ont été associé a cette catégorie
                List<int> listEmp = new List<int>();
                int prj = int.Parse(argument);

                if (argument2 != null)
                {
                    int cat = int.Parse(argument2);

                    var empSelect = from emp in context.tbl_ProjetCatEmploye
                                    where emp.idProjet == prj && emp.idCategorie == cat
                                    orderby emp.idEmploye
                                    select emp.idEmploye;

                    //On les ajoute a la liste que Marc utilise pour voyager les infos et les garder
                    foreach (int emp in empSelect)
                    {
                        listEmp.Add(emp);
                    }
                }
                else
                {
                    var empSelect = from emp in context.tbl_ProjetCatEmploye
                                    where emp.idProjet == prj
                                    orderby emp.idEmploye
                                    select emp.idEmploye;

                    //On les ajoute a la liste que Marc utilise pour voyager les infos et les garder
                    foreach (int emp in empSelect)
                    {
                        listEmp.Add(emp);
                    }

                }

                //Ajoute la liste a Selected Employes
                SelectedEmployes = listEmp;

                SelectedEmployesString.Clear();

                //On transforme cette liste de int ID en liste de string
                foreach (int id in SelectedEmployes)
                {
                    SelectedEmployesString.Add(id.ToString());
                }

                //On transforme cette liste en string ordinaire pour l'envoyer dans le hiddenfield de Marc qui est utilisé
                var result = String.Join(",", SelectedEmployesString.ToArray());
                hiddenFieldEmploye.Value = result;

                //Call méthode qui recherche les employé
                RequeryEmployes();
            }


            //Recherche du mode dans l'adresse
            mode = Request.QueryString["Mode"];

            if (argument2 != null)
                SousCat = true;
            else
                SousCat = false;

            if (mode != null)
            {
                modif = true;
                Div_Multiselect.Visible = true;

                if (!IsPostBack)
                {
                    int id = int.Parse(argument2);

                    var query = (from tbl in context.tbl_ProjetCat
                                 where tbl.idProjetCat == id
                                 select tbl).First();

                    Tbx_Titre.Text = query.titre;
                    Tbx_Description.Text = query.description;
                }
            }
        }

        void RequeryEmployes()
        {
            CoecoDataContext context = new CoecoDataContext();

            //On remplie le côté gauche du multiselect avec la liste complète des employés
            var empBureau = from emp in context.tbl_Employe
                            where emp.idTypeEmpl == 1 && emp.idEmploye != 4
                            orderby emp.nom, emp.prenom
                            select emp;

            var empTerrain = from emp in context.tbl_Employe
                             where emp.idTypeEmpl == 2 && emp.idEmploye != 4
                             orderby emp.nom, emp.prenom
                             select emp;

            //On transforme en liste le résultat de la query et on envoi dans un objet liste
            emp_bureau = empBureau.ToList();
            emp_terrain = empTerrain.ToList();

            //Permet de recréer les repeater asp pour vérifier les valeurs selected pour les employés et les catégories
            RepBureau.DataSource = emp_bureau;
            RepBureau.DataBind();

            RepTerrain.DataSource = emp_terrain;
            RepTerrain.DataBind();

        }

        protected void Btn_Enregistrer_Click(object sender, EventArgs e)
        {
            //Objet de ma table Projet
            tbl_ProjetCat tableCat = new tbl_ProjetCat();

            if (!modif)
            {
                switch (SousCat)
                {
                    case true:
                        {
                            //Remplissage des champs de la table temporaire avec les contrôles
                            tableCat.titre = Tbx_Titre.Text;
                            tableCat.description = Tbx_Description.Text;
                            tableCat.idProjet = int.Parse(argument);
                            tableCat.idCatMaitre = int.Parse(argument2);
                            break;
                        }
                    case false:
                        {
                            //Remplissage des champs de la table temporaire avec les contrôles
                            tableCat.titre = Tbx_Titre.Text;
                            tableCat.description = Tbx_Description.Text;
                            tableCat.idProjet = int.Parse(argument);
                            break;
                        }
                }

                //AJOUT en cas de nouveauté
                context.tbl_ProjetCat.InsertOnSubmit(tableCat);
            }
            else if (modif)
            {
                argument = Request.QueryString["Prj"];
                argument2 = Request.QueryString["Cat"];
                int id = int.Parse(argument2);

                var query = (from tbl in context.tbl_ProjetCat
                             where tbl.idProjetCat == id
                             select tbl).First();

                query.titre = Tbx_Titre.Text;
                query.description = Tbx_Description.Text;

                //Méthode de traitement des employés
                AjoutSuppressionTableCatEmp();

            }

            //Étape finale SUBMIT CHANGES
            context.SubmitChanges();

            Response.Redirect("AjoutCategorie.aspx?Prj=" + argument);
        }

        protected void Btn_Annuler_Click(object sender, EventArgs e)
        {
            Response.Redirect("AjoutCategorie.aspx?Prj=" + argument);
        }

        public void AjoutSuppressionTableCatEmp()
        {
            UpdateSelectedEmployeList();

            argument = Request.QueryString["Prj"];
            int projet = int.Parse(argument);
            argument2 = Request.QueryString["Cat"];
            int cat = int.Parse(argument2);

            //DELETE 
            //Liste d'employé non sélectionné
            UnselectedEmployes = AllEmployes.Except(SelectedEmployes).ToList();

            tbl_ProjetCatEmploye TableCatEmp = new tbl_ProjetCatEmploye();

            foreach (var emp in UnselectedEmployes)
            {
                var query = from tbl in context.tbl_ProjetCatEmploye
                            where tbl.idCategorie == cat && tbl.idEmploye == emp
                            select tbl;

                if (query.Count() == 1)
                    context.tbl_ProjetCatEmploye.DeleteOnSubmit(query.First());
            }

            //ADD
            foreach (var emp in SelectedEmployes)
            {
                var query = from tbl in context.tbl_ProjetCatEmploye
                            where tbl.idCategorie == cat && tbl.idEmploye == emp
                            select tbl;

                if (query.Count() == 1)
                    context.tbl_ProjetCatEmploye.DeleteOnSubmit(query.First());

                tbl_ProjetCatEmploye tableCatEmp = new tbl_ProjetCatEmploye();

                tableCatEmp.idCategorie = cat;
                tableCatEmp.idEmploye = emp;
                tableCatEmp.idProjet = projet;

                context.tbl_ProjetCatEmploye.InsertOnSubmit(tableCatEmp);
            }
        }

        public void AllEmployees()
        {
            List<int> listAllEmp = new List<int>();
            List<string> AllEmployesString = new List<string>();

            var empSelect = from emp in context.tbl_Employe
                            where emp.idEmploye != 4
                            orderby emp.idEmploye
                            select emp.idEmploye;

            //On les ajoute a la liste que Marc utilise pour voyager les infos et les garder
            foreach (int emp in empSelect)
            {
                listAllEmp.Add(emp);
            }

            //Ajoute la liste a Selected Employes
            AllEmployes = listAllEmp;

            AllEmployesString.Clear();

            //On transforme cette liste de int ID en liste de string
            foreach (int id in AllEmployes)
            {
                AllEmployesString.Add(id.ToString());
            }

            //On transforme cette liste en string ordinaire pour l'envoyer dans le hiddenfield de Marc qui est utilisé
            hiddenFieldTotal.Value = string.Empty;
            var result = String.Join(",", AllEmployesString.ToArray());
            hiddenFieldTotal.Value = result;
        }

        protected string EmployeSelected(object id)
        {
            int idEmploye = (int)id;

            //Permet de lire la liste des employé dans le textbox hidden
            UpdateSelectedEmployeList();

            foreach (var item in SelectedEmployes)
            {
                if (item == idEmploye)
                    return "selected";
            }

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

        private int ConvertValueToInt(string value)
        {
            int result = int.MinValue;

            int.TryParse(value, out result);

            return result;
        }
    }
}