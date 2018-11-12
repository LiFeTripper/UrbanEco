using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UrbanEco
{
    public partial class Projets1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Btn_Ajout_Click(object sender, EventArgs e)
        {
            //Redirige l'adresse vers un nouveau projet avec l'argument étoile
            Response.Redirect("AjoutProjets.aspx?Prj=*");
        }

        protected void Btn_Modif_Click(object sender, EventArgs e)
        {
            //Référence au bouton dans l'interface
            Button button = (sender as Button);
            

            //Ramassage du CommandArgument du bouton
            string commandArgument = button.CommandArgument;

            //Redirige l'adresse vers l'ajout de projet avec le id en argument
            Response.Redirect("AjoutProjets.aspx?Prj=" + commandArgument);

        }

        protected void Btn_Cat_Click(object sender, EventArgs e)
        {
            //Référence au bouton dans l'interface
            Button button = (sender as Button);

            //Ramassage du CommandArgument du bouton
            string commandArgument = button.CommandArgument;

            //Redirige l'adresse vers l'ajout de projet avec le id en argument
            Response.Redirect("AjoutCat.aspx?Prj=" + commandArgument);
        }
    }
}