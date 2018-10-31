using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UrbanEco
{
    public partial class Employe : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            CoecoDataContext context = new CoecoDataContext();


            GridView1.DataSource = context.tbl_Employe;
            GridView1.DataBind();

            GridView2.DataSource = context.tbl_Projet;
            GridView2.DataBind();

            GridView3.DataSource = context.tbl_FeuilleTemps;
            GridView3.DataBind();
        }
    }
}