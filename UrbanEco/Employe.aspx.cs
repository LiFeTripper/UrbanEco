using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace UrbanEco
{
    

    public partial class Employe : System.Web.UI.Page
    {
        static bool showInactive = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            CoecoDataContext context = new CoecoDataContext();

            Chkbx_Inactif.Checked = showInactive;

        }

        protected void Btn_Modif_Click(object sender, EventArgs e)
        {
            //Référence au bouton dans l'interface
            Button button = (sender as Button);


            //Ramassage du CommandArgument du bouton
            string commandArgument = button.CommandArgument;

            //Redirige l'adresse vers l'ajout de projet avec le id en argument
            Response.Redirect("AjoutEmp.aspx?Emp=" + commandArgument);
        }

        protected void Chkbx_Inactif_CheckedChanged(object sender, EventArgs e)
        {
            showInactive = !showInactive;
            Response.Redirect(Request.RawUrl);
        }
    }
}