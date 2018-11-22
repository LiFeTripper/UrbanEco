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
                //Query les projet
                var queryProjet = from tbl in context.tbl_Projet
                                  orderby tbl.titre
                                  select tbl;

                tbx_projet.DataSource = queryProjet;
                tbx_projet.DataBind();

                //Insérer un text pour sélectionne rle projet au début
                tbx_projet.Items.Insert(0, "Veuillez sélectionner le projet");
                tbx_projet.SelectedIndex = 0;


                if (Request.QueryString["FT"] != "New")
                {
                    LoadFT();
                }
            }

        }

        protected void tbx_projet_SelectedIndexChanged(object sender, EventArgs e)
        {

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

            //Obtenir les catégorie
            CoecoDataContext context = new CoecoDataContext();
            int projectID = int.Parse(tbx_projet.Items[tbx_projet.SelectedIndex].Value);

            var query = from tbl in context.tbl_ProjetCat
                        where tbl.idProjet == projectID
                        select tbl;


            tbx_categorie.DataSource = query;
            tbx_categorie.DataBind();
        }

        protected void Btn_Enreg_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["FT"] == "New")
            {
                tbl_FeuilleTemps tbFT = new tbl_FeuilleTemps();
                //tbFT.idEmploye = Layout.GetUserConnected().idEmploye;
                tbFT.idEmploye = 1;     //Temporaire
                var queryEmp = from tbl in context.tbl_Employe
                               where tbl.idEmploye == tbFT.idEmploye
                               select tbl;
                
                lbl_Top.Text = "Nouvelle Feuille de Temps de " + queryEmp.First<tbl_Employe>().prenom + " " + queryEmp.First<tbl_Employe>().nom;
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
                alert_failed.Visible = true;
                return;
            }

            var query1 = from tbl in context.tbl_FeuilleTemps
                         where tbl.idFeuille == value
                         select tbl;

            tbl_FeuilleTemps temp = query1.First<tbl_FeuilleTemps>();

            var queryEmp = from tbl in context.tbl_Employe
                           where tbl.idEmploye == temp.idEmploye
                           select tbl;



            lbl_Top.Text = "Feuille de temps de " + queryEmp.First<tbl_Employe>().prenom + " " + queryEmp.First<tbl_Employe>().nom 
                + " (" + temp.dateCreation.ToString().Split(' ')[0] + ")";
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
            
            dateFormated.InnerText = temp.dateCreation.ToString().Split(' ')[0];
            Calendar1.Value = dateFormated.InnerText;
            txa_comments.Value = temp.commentaire;
        }

        protected void ChangeDate()
        {
            dateFormated.InnerText = Calendar1.Value;
        }

    }
}