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
            if(!IsPostBack)
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

        }
    }
}