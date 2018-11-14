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

            //if (CheckBox1.Checked == false)
            //{

            //    var query = (from tbl in context.tbl_Employe
            //                 where tbl.inactif == false
            //                 select tbl);

            //    DataTable dt = new DataTable();
            //    dt.Columns.Add("prenom");
            //    DataRow dr = dt.NewRow();

            //    foreach (var ligne in query)
            //    {
            //        dr["prenom"] = ligne.prenom;
            //        dt.Rows.Add(dr);
            //    }

            //    Repeater r = ((Repeater)FindControl("Rptr_Employe"));
            //    r.DataSource = dt; //Suppose dt is the data table to bind.
            //    r.DataBind();
            //}
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