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

<<<<<<< HEAD
=======
        protected void Btn_Modif_Click(object sender, EventArgs e)
        {
            //Référence au bouton dans l'interface
            Button button = (sender as Button);


            //Ramassage du CommandArgument du bouton
            string commandArgument = button.CommandArgument;

            //Redirige l'adresse vers l'ajout de projet avec le id en projet
            Response.Redirect("AjoutEmp.aspx?Emp=" + commandArgument);
        }

>>>>>>> d8d14c6679497c88aa06d93edefabc8b39c08e97
        protected void Chkbx_Inactif_CheckedChanged(object sender, EventArgs e)
        {
            showInactive = !showInactive;
            Response.Redirect(Request.RawUrl);
        }

        protected void Btn_Ajout_Click(object sender, EventArgs e)
        {
            Response.Redirect("AjoutEmp.aspx");
        }

        protected void Btn_Modif_Click(object sender, ImageClickEventArgs e)
        {
            //Référence au bouton dans l'interface
            ImageButton button = (sender as ImageButton);


            //Ramassage du CommandArgument du bouton
            string commandArgument = button.CommandArgument;

            //Redirige l'adresse vers l'ajout de projet avec le id en argument
            Response.Redirect("AjoutEmp.aspx?Emp=" + commandArgument);
        }
    }
}