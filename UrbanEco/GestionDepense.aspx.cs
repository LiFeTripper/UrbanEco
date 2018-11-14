using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UrbanEco
{
    public partial class ApprobationDepense : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Rptr_FeuilleTemps_Load(object sender, EventArgs e)
        {

        }

        protected void Btn_Approve_Click(object sender, EventArgs e)
        {

        }

        protected void Btn_Modif_Click(object sender, EventArgs e)
        {

        }

        protected void Btn_Modif_Click1(object sender, ImageClickEventArgs e)
        {

        }

        protected void Btn_Approve_Click1(object sender, ImageClickEventArgs e)
        {
            ImageButton btn = ((ImageButton)sender);

            int idDepense = -1;

            int.TryParse(btn.CommandArgument, out idDepense);

            if (idDepense != -1)
            {
                CoecoDataContext context = new CoecoDataContext();

                (from tbl in context.tbl_Depense
                            where tbl.idDepense == idDepense
                            select tbl).First().approuver = true;

                context.SubmitChanges();
            }



        }
    }
}