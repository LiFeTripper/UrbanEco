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
            Response.Redirect("AjouterProjets.aspx?Prj=*");
        }

        protected void Btn_Modif_Click(object sender, EventArgs e)
        {
            //Get the reference of the clicked button.
            Button button = (sender as Button);

            //Get the Repeater Item reference
            //RepeaterItem item = button.NamingContainer as RepeaterItem;

            //Get the repeater item index
            //int index = item.ItemIndex;

            string commandArgument = button.CommandArgument;

            Response.Redirect("AjoutDepense.aspx?Prj=" + commandArgument);

        }
    }
}