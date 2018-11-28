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
        CoecoDataContext context = new CoecoDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
                Calendar1.Value = Layout.ToCalendarDate(DateTime.Today);

                if (Request.QueryString["FT"] != "New")
                {
                    LoadFT();
                }
                else if(Layout.GetUserConnected().username == "admin")
                {
                    tbl_employe.Visible = true;
                    LoadListEmploye();
                }
                else
                {
                //    tbx_projetEmp.Visible = true;
                //    //Query les projet
                //    var queryProjet = from tbl in context.tbl_Projet
                //                      orderby tbl.titre
                //                      select tbl;

                //    tbx_projetEmp.DataSource = queryProjet;
                //    tbx_projetEmp.DataBind();

                //    //Insérer un text pour sélectionne rle projet au début
                //    tbx_projetEmp.Items.Insert(0, "Veuillez sélectionner le projet");
                //    tbx_projetEmp.SelectedIndex = 0;




                    //Query les projet accessible par l'employé
                    var queryProjet = (from tblProjetCat in context.tbl_ProjetCatEmploye
                                       join tblProjet in context.tbl_Projet on tblProjetCat.idProjet equals tblProjet.idProjet
                                       where tblProjetCat.idEmploye == Layout.GetUserConnected().idEmploye
                                       orderby tblProjet.titre
                                       select tblProjet);

                    List<ListItem> listeProjet = new List<ListItem>();
                    listeProjet.Add(new ListItem("Aucune", (-1).ToString()));

                    foreach (tbl_Projet item in queryProjet.ToList())
                    {

                        ListItem projet = new ListItem(item.titre, item.idProjet.ToString());
                        listeProjet.Add(projet);
                    }

                    tbx_projet.DataSource = listeProjet.Distinct();
                    tbx_projet.DataBind();
                }



            }

        }

        //On obient la liste des employées et on la link au DropDownList
        protected void LoadListEmploye()
        {
            //Remplissage du dropdownlist d'employé

            List<string> listEmp = new List<string>();

            var tblEmp = from tbl in context.tbl_Employe
                         where tbl.username != "admin"
                         & tbl.inactif == false
                         select tbl;

            foreach (var n in tblEmp)
            {
                listEmp.Add(n.nom + "," + n.prenom);
            }

            ddl_employe.DataSource = null;
            ddl_employe.DataBind();
            ddl_employe.DataSource = listEmp;
            ddl_employe.DataBind();

            ddl_employe.Items.Insert(0, "Veuillez choisir un employé");
        }

        

        protected void tbx_projet_SelectedIndexChanged(object sender, EventArgs e)
        {

            //Obtenir les catégorie
            CoecoDataContext context = new CoecoDataContext();

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

            if (Layout.GetUserConnected().username != "admin")

            {
                int projectID = int.Parse(tbx_projet.Items[tbx_projet.SelectedIndex].Value);

                //var query = from tbl in context.tbl_ProjetCat
                //            where tbl.idProjet == projectID

                //            select tbl;

                var query = from tbl in context.tbl_ProjetCatEmploye
                            where tbl.idProjet == projectID && tbl.idEmploye == Layout.GetUserConnected().idEmploye
                            select tbl;

                List<ListItem> listeCategorieEmploye = new List<ListItem>();
                listeCategorieEmploye.Add(new ListItem("Aucune", (-1).ToString()));

                foreach (tbl_ProjetCatEmploye item in query.ToList())
                {

                    ListItem categorie = new ListItem(item.tbl_ProjetCat.titre, item.idCategorie.ToString());
                    listeCategorieEmploye.Add(categorie);
                }

                tbx_categorie.DataSource = listeCategorieEmploye.Distinct();
                tbx_categorie.DataBind();
            }
            else
            {
                int projectID = int.Parse(tbx_projet.Items[tbx_projet.SelectedIndex].Value);

                //var query = from tbl in context.tbl_ProjetCat
                //            where tbl.idProjet == projectID

                //            select tbl;

                var query = from tbl in context.tbl_ProjetCatEmploye
                            where tbl.idProjet == projectID && tbl.idEmploye == GetIDEmp(ddl_employe.SelectedItem.Text)
                            select tbl;

                List<ListItem> listeCategorieEmploye = new List<ListItem>();
                listeCategorieEmploye.Add(new ListItem("Aucune", (-1).ToString()));

                foreach (tbl_ProjetCatEmploye item in query.ToList())
                {

                    ListItem categorie = new ListItem(item.tbl_ProjetCat.titre, item.idCategorie.ToString());
                    listeCategorieEmploye.Add(categorie);
                }

                tbx_categorie.DataSource = listeCategorieEmploye.Distinct();
                tbx_categorie.DataBind();
            }
            

            

        }

        protected void Btn_Enreg_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["FT"] == "New")
            {
                tbl_FeuilleTemps tbFT = new tbl_FeuilleTemps();
                if(ddl_employe.Visible == true)
                { 
                    tbFT.idEmploye = GetIDEmp(ddl_employe.SelectedItem.Text);
                }
                else
                {
                    tbFT.idEmploye = Layout.GetUserConnected().idEmploye;
                }
                
                tbFT.idCat = int.Parse(tbx_categorie.SelectedItem.Value);
                tbFT.idProjet = int.Parse(tbx_projet.SelectedItem.Value);
                tbFT.nbHeure = int.Parse(tbx_nbHeure.Text);
                tbFT.dateCreation = DateTime.Parse(Calendar1.Value);
                tbFT.commentaire = txa_comments.Value;
                tbFT.approuver = false;

                context.tbl_FeuilleTemps.InsertOnSubmit(tbFT);
                context.SubmitChanges();

                Response.Redirect("GestionFeuilleTemps.aspx");
            }
            else
            {
                int value = int.Parse(Request.QueryString["FT"]);

                var query1 = from tbl in context.tbl_FeuilleTemps
                             where tbl.idFeuille == value
                             select tbl;

                tbl_FeuilleTemps temp = query1.First<tbl_FeuilleTemps>();

                temp.idCat = int.Parse(tbx_categorie.SelectedItem.Value);
                temp.idProjet = int.Parse(tbx_projet.SelectedItem.Value);
                temp.nbHeure = int.Parse(tbx_nbHeure.Text);
                temp.dateCreation = DateTime.Parse(Calendar1.Value);

                temp.commentaire = txa_comments.Value;

                context.tbl_FeuilleTemps.DeleteOnSubmit(temp);
                context.tbl_FeuilleTemps.InsertOnSubmit(temp);
                context.SubmitChanges();


                Response.Redirect("GestionFeuilleTemps.aspx");
            }

        }

        protected void LoadFT()
        {

            int value = -1;
            try
            {
                
                int.TryParse(Request.QueryString["FT"],out value);

                if (value <= 0)
                    throw new Exception();
            }
            catch(Exception n)
            {
                //alert_failed.Visible = true;
                return;
            }

            var query1 = from tbl in context.tbl_FeuilleTemps
                         where tbl.idFeuille == value
                         select tbl;

            tbl_FeuilleTemps temp = query1.First<tbl_FeuilleTemps>();

            var queryEmp = from tbl in context.tbl_Employe
                           where tbl.idEmploye == temp.idEmploye
                           select tbl;



            //lbl_Top.Text = "Feuille de temps de " + queryEmp.First<tbl_Employe>().prenom + " " + queryEmp.First<tbl_Employe>().nom 
                //+ " (" + temp.dateCreation.ToString().Split(' ')[0] + ")";
            tbx_projet.SelectedValue = temp.idProjet.ToString();
            tbx_categorie.Enabled = true;
            int projectID = int.Parse(tbx_projet.Items[tbx_projet.SelectedIndex].Value);

            var query2 = from tbl in context.tbl_ProjetCat
                         where tbl.idProjet == projectID
                         select tbl;

            tbx_categorie.DataSource = query2;
            tbx_categorie.DataBind();
            tbx_categorie.SelectedValue = temp.idCat.ToString();

            DateTime dt = (DateTime)temp.dateCreation;

            tbx_nbHeure.Text = temp.nbHeure.ToString();

            dateFormated.InnerText = DatePauvre(DateTime.Parse(temp.dateCreation.ToString()));
            Calendar1.Value = DatePauvre(DateTime.Parse(temp.dateCreation.ToString()));
            txa_comments.Value = temp.commentaire;
        }

        protected void ChangeDate()
        {
            dateFormated.InnerText = Calendar1.Value;
        }

        string DatePauvre (DateTime datePauvre)
        {
            string result = "";

            result += datePauvre.Year;
            result += "-";
            result += datePauvre.Month;
            result += "-";
            result += datePauvre.Day;

            return result;
        }

        //Obtient l'id de l'empolòyé à l'aide de son nom et prénom séparé par une virgule
        protected int GetIDEmp(string nomEmp)
        {
            string[] nomEmpArray = nomEmp.Split(',');

            var id = from tblEmp in context.tbl_Employe
                     where tblEmp.nom == nomEmpArray[0]
                     where tblEmp.prenom == nomEmpArray[1]
                     select tblEmp.idEmploye;

            return id.First();
        }

        protected void ddl_employe_SelectedIndexChanged(object sender, EventArgs e)
        {

            if (ddl_employe.Text != "Veuillez choisir un employé")
            {


                //Query les projet accessible par l'employé
                var queryProjet = (from tblProjetCat in context.tbl_ProjetCatEmploye
                                   join tblProjet in context.tbl_Projet on tblProjetCat.idProjet equals tblProjet.idProjet
                                   where tblProjetCat.idEmploye == GetIDEmp(ddl_employe.SelectedItem.Text)
                                   orderby tblProjet.titre
                                   select tblProjet);

                List<ListItem> listeProjet = new List<ListItem>();
                listeProjet.Add(new ListItem("Aucune", (-1).ToString()));

                foreach (tbl_Projet item in queryProjet.ToList())
                {

                    ListItem projet = new ListItem(item.titre, item.idProjet.ToString());
                    listeProjet.Add(projet);
                }

                tbx_projet.DataSource = listeProjet.Distinct();
                tbx_projet.DataBind();
            }
        }

        protected void btn_annuler_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }
    }
}