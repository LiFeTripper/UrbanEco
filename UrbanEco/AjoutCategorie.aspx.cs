using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UrbanEco
{
    public partial class AjoutCategorie : System.Web.UI.Page
    {
        string argument;

        protected void Page_Load(object sender, EventArgs e)
        {
            //Recherche de l'projet dans l'adresse
            argument = Request.QueryString["Prj"];

            lbl_noProjet.Text = argument;

            

            if (!IsPostBack)
            {
                Page.MaintainScrollPositionOnPostBack = true;

                //CODE POUR BIND LE REPEATER DE CATÉGORIE
                CoecoDataContext ctx = new CoecoDataContext();
                var queryMasterProjetCat = BD.GetMasterCategorieProjet(ctx,int.Parse(argument));

                Rptr_Categorie.DataSource = null;
                Rptr_Categorie.DataSourceID = null;

                Rptr_Categorie.DataBind();
                Rptr_Categorie.DataSource = queryMasterProjetCat.Distinct();
                Rptr_Categorie.DataBind();

                lbl_nomProjet.InnerText = "Sous-Projets de " + BD.GetProjet(ctx, int.Parse(argument)).titre;
            }
        }


        protected void Btn_AjoutSousProjet_Click(object sender, EventArgs e)
        {
            Response.Redirect("ModifCategorie.aspx?Prj=" + argument + "&Mode=*");
        }

        protected void Btn_ModifSousProjet_Click(object sender, ImageClickEventArgs e)
        {
            //Référence au bouton dans l'interface
            ImageButton button = (sender as ImageButton);

            //Ramassage du CommandArgument du bouton
            string commandArgument = button.CommandArgument;

            Response.Redirect("ModifCategorie.aspx?Prj=" + argument + "&Cat=" + commandArgument + "&Mode=M");
        }

        protected void Btn_AjoutSSProjet_Click(object sender, ImageClickEventArgs e)
        {
            //Référence au bouton dans l'interface
            ImageButton button = (sender as ImageButton);

            //Ramassage du CommandArgument du bouton
            string commandArgument = button.CommandArgument;

            Response.Redirect("ModifCategorie.aspx?Prj=" + argument + "&Cat=" + commandArgument + "&Mode=*");
        }
    }
}