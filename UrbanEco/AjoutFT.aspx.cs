using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UrbanEco
{
    public partial class AjoutFT : System.Web.UI.Page
    {       

        static List<tbl_PremierDimanche> dimanches = new List<tbl_PremierDimanche>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                CoecoDataContext ctx = new CoecoDataContext();
                //Premier dimanche
                var queryDimanche = from tbl in ctx.tbl_PremierDimanche
                                    select tbl;

                if (queryDimanche.Count() > 0)
                {
                    dimanches = queryDimanche.ToList();
                }

                DateCreation.Value = Layout.ToCalendarDate(DateTime.Today);


                tbl_Employe userConnected = BD.GetUserConnected(ctx,Request.Cookies["userInfo"]);

                List<tbl_Projet> listProjets = new List<tbl_Projet>();               

                int idFeuilleTemps = -1;
                if(Request.QueryString["FT"] != "New")
                {                    
                    int.TryParse(Request.QueryString["FT"], out idFeuilleTemps);
                }

                if (userConnected.username == "admin")
                {
                    listProjets = BD.GetAllProjets(ctx);
                    tbl_employe.Visible = true;
                    LoadListEmploye();
                    tbx_projet.Enabled = false;
                }
                else
                {
                    listProjets = BD.GetEmployeProjet(ctx,userConnected);
                }

                List<ListItem> listItemProjets = new List<ListItem>();
                listItemProjets.Add(new ListItem("Aucune", (-1).ToString()));

                foreach (tbl_Projet item in listProjets)
                {
                    ListItem projet = new ListItem(item.titre, item.idProjet.ToString());
                    listItemProjets.Add(projet);
                }

                tbx_projet.DataSource = listItemProjets.Distinct();
                tbx_projet.DataBind();

                //Mode Modif
                if (idFeuilleTemps != -1)
                {

                    tbl_FeuilleTemps ft = BD.GetFeuilleTemps(ctx,idFeuilleTemps);

                    LoadFT(ft);
                }
            }
        }

        //On obient la liste des employées et on la link au DropDownList
        protected void LoadListEmploye()
        {
            CoecoDataContext ctx = new CoecoDataContext();

            //Remplissage du dropdownlist d'employé
            List<ListItem> listItemEmployes = new List<ListItem>();

            var allEmployes = BD.GetAllEmployes(ctx);

            foreach (var employes in allEmployes)
            {
                listItemEmployes.Add(new ListItem(employes.nom + "," + employes.prenom, employes.idEmploye.ToString()));
            }

            ddl_employe.DataSource = null;
            ddl_employe.DataBind();
            ddl_employe.DataSource = listItemEmployes;
            ddl_employe.DataBind();

            ddl_employe.Items.Insert(0, "Veuillez choisir un employé");
        }

        

        protected void tbx_projet_SelectedIndexChanged(object sender, EventArgs e)
        {

            //Obtenir les catégorie
            CoecoDataContext ctx = new CoecoDataContext();
            
            //Reset les catégories
            if (!tbx_categorie.Enabled)
                tbx_categorie.Enabled = true;


            tbx_categorie.DataSource = null;
            tbx_categorie.DataSourceID = null;

            //Aucun projet choisi
            if (tbx_projet.SelectedIndex == 0)
            {
                tbx_categorie.Enabled = false;
                tbx_categorie.Items.Clear();
                tbx_categorie.Items.Add("-----");

                return;
            }

            tbl_Employe userConnected = BD.GetUserConnected(ctx,Request.Cookies["userInfo"]);

            int projectID = int.Parse(tbx_projet.Items[tbx_projet.SelectedIndex].Value);

            List<tbl_ProjetCatEmploye> query_Employe_categorie = new List<tbl_ProjetCatEmploye>();

            if (userConnected.username == "admin")
            {
                query_Employe_categorie = BD.GetProjetLinkedCategorieEmploye(ctx,projectID, int.Parse(ddl_employe.SelectedItem.Value));
            }
            else
            {
                query_Employe_categorie = BD.GetProjetLinkedCategorieEmploye(ctx,projectID, userConnected.idEmploye);
            }


            List<ListItem> listItemEmployeCategorie = new List<ListItem>();
            listItemEmployeCategorie.Add(new ListItem("Aucune", (-1).ToString()));

            foreach (tbl_ProjetCatEmploye item in query_Employe_categorie)
            {
                ListItem categorie = new ListItem(item.tbl_ProjetCat.titre, item.idCategorie.ToString());
                listItemEmployeCategorie.Add(categorie);
            }

            tbx_categorie.DataSource = listItemEmployeCategorie.Distinct();
            tbx_categorie.DataBind();

        }

        protected void Btn_Enreg_Click(object sender, EventArgs e)
        {
            CoecoDataContext ctx = new CoecoDataContext();

            if (Request.QueryString["FT"] == "New")
            {
                tbl_FeuilleTemps tbFT = new tbl_FeuilleTemps();
                
                //admin
                if(ddl_employe.Visible == true)
                { 
                    tbFT.idEmploye = int.Parse(ddl_employe.SelectedItem.Value);
                }
                else //User
                {
                    tbFT.idEmploye = BD.GetUserConnected(ctx,Request.Cookies["userInfo"]).idEmploye;
                }
                
                //S-Catégorie selected
                if(tbx_categorie.SelectedItem.Text != "Aucune")
                {
                    tbFT.idCat = int.Parse(tbx_categorie.SelectedItem.Value);
                }
                else //aucune catgorie
                {
                    tbFT.idCat = null;
                }

                if(string.IsNullOrWhiteSpace(tbx_nbHeure.Text))
                {
                    tbFT.nbHeure = 0;
                }
                else
                {
                    //string nbH = tbx_nbHeure.Text;
                    //if (nbH.Contains(","))
                    //{
                    //    nbH.Replace(",", ".");
                     //   tbFT.nbHeure = float.Parse(nbH);
                    //}
                    //else
                    //{
                        tbFT.nbHeure = float.Parse(tbx_nbHeure.Text);
                    //}
                }


                tbFT.idProjet = int.Parse(tbx_projet.SelectedItem.Value);
                tbFT.dateCreation = DateTime.Parse(DateCreation.Value);
                tbFT.commentaire = txa_comments.Value;
                tbFT.approuver = false;
                tbFT.noSemaine = GetWeekToYear(DateTime.Parse(DateCreation.Value));

                ctx.tbl_FeuilleTemps.InsertOnSubmit(tbFT);
                ctx.SubmitChanges();

                Response.Redirect("GestionFeuilleTemps.aspx");
            }
            else
            {
                int idFeuilleTemps = int.Parse(Request.QueryString["FT"]);

                tbl_FeuilleTemps feuilleTemps = BD.GetFeuilleTemps(ctx,idFeuilleTemps);

                //S-cat selected
                if (tbx_categorie.SelectedItem.Text != "Aucune")
                {
                    feuilleTemps.idCat = int.Parse(tbx_categorie.SelectedItem.Value);
                }
                else //S-cat null
                {
                    feuilleTemps.idCat = null;
                }


                feuilleTemps.idProjet = int.Parse(tbx_projet.SelectedItem.Value);
                feuilleTemps.nbHeure = float.Parse(tbx_nbHeure.Text);
                if (Request.QueryString["FT"] == "New")
                {
                    feuilleTemps.dateCreation = DateTime.Parse(DateCreation.Value);
                    feuilleTemps.noSemaine = GetWeekToYear(DateTime.Parse(DateCreation.Value));
                }           

                feuilleTemps.commentaire = txa_comments.Value;

                ctx.tbl_FeuilleTemps.DeleteOnSubmit(feuilleTemps);
                ctx.tbl_FeuilleTemps.InsertOnSubmit(feuilleTemps);
            }

            ctx.SubmitChanges();
            Response.Redirect("GestionFeuilleTemps.aspx");
        }

        protected void LoadFT(tbl_FeuilleTemps ft)
        {
            CoecoDataContext ctx = new CoecoDataContext();

            tbl_Employe emp = ft.tbl_Employe;

            ddl_employe.SelectedValue = emp.idEmploye.ToString();
            
            tbx_projet.SelectedValue = ft.idProjet.ToString();
            tbx_categorie.Enabled = true;

            List<tbl_ProjetCat> projetCategorie = BD.GetProjetCategorieEmploye(ctx,ft.idProjet, emp.idEmploye);

            List<ListItem> catList = new List<ListItem>();
            catList.Add(new ListItem("Sélectionner une catégorie", (-1).ToString()));

            foreach (var item in projetCategorie)
            {
                catList.Add(new ListItem(item.titre, item.idProjetCat.ToString()));
            }

            tbx_categorie.DataSource = catList;
            tbx_categorie.DataBind();

            if (ft.idCat == null)
                tbx_categorie.SelectedIndex = 0;
            else
                for (int i = 0; i < tbx_categorie.Items.Count; i++)
                {
                    if(tbx_categorie.Items[i].Value == ft.idCat.ToString())
                    {
                        tbx_categorie.SelectedIndex = i;
                    }
                }

            tbx_nbHeure.Text = ft.nbHeure.ToString();
            //tbx_nbHeure.Text = Layout.GetDateFormated(DateTime.Parse(ft.dateCreation.ToString()));

            dateFormated.InnerText = Layout.GetDateFormated(DateTime.Parse(ft.dateCreation.ToString()));
            DateCreation.Value = Layout.GetDateFormated(DateTime.Parse(ft.dateCreation.ToString()));
            txa_comments.Value = ft.commentaire;
            dateFormated.InnerText = DateCreation.Value.ToString();
            
        }

        protected void ChangeDate()
        {
            dateFormated.InnerText = DateCreation.Value;
        }


        //Obtient l'id de l'empolòyé à l'aide de son nom et prénom séparé par une virgule
        protected int GetIDEmp(string nomEmp)
        {
            CoecoDataContext ctx = new CoecoDataContext();

            string[] nomEmpArray = nomEmp.Split(',');

            var id = from tblEmp in ctx.tbl_Employe
                     where tblEmp.nom == nomEmpArray[0]
                     where tblEmp.prenom == nomEmpArray[1]
                     select tblEmp.idEmploye;

            return id.First();
        }

        protected void ddl_employe_SelectedIndexChanged(object sender, EventArgs e)
        {
            CoecoDataContext ctx = new CoecoDataContext();

            if (ddl_employe.SelectedIndex != 0)
            {
                //Query les projet accessible par l'employé

                tbl_Employe emp = BD.GetEmploye(ctx,int.Parse(ddl_employe.SelectedItem.Value));

                var queryProjet = BD.GetEmployeProjet(ctx,emp);

                List<ListItem> listeProjet = new List<ListItem>();
                listeProjet.Add(new ListItem("Aucune", (-1).ToString()));

                if (queryProjet != null)
                {

                    foreach (tbl_Projet item in queryProjet.ToList())
                    {

                        ListItem projet = new ListItem(item.titre, item.idProjet.ToString());
                        listeProjet.Add(projet);
                    }
                }

                tbx_projet.Enabled = true;

                tbx_projet.DataSource = listeProjet.Distinct();
                tbx_projet.DataBind();
            }
            else
            {
                tbx_projet.Enabled = false;
            }
        }

        protected void btn_annuler_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }

        protected int GetWeekToYear(DateTime date)
        {
            if (dimanches.Count == 0)
                return -100;

            for (int i = 1; i < dimanches.Count; i++)
            {
                //Si la date voulu vien avant la date du dimanche, l'index est le numéro de semaine
                if (date < dimanches[i].dateDimanche)
                {
                    return i;
                }
            }

            return 0;
        }

    }
}