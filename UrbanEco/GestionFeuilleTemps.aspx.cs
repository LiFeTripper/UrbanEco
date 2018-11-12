using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UrbanEco
{
    public partial class GestionFeuilleTemps : System.Web.UI.Page
    {
        CoecoDataContext cdc = new CoecoDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            Page.MaintainScrollPositionOnPostBack = true;
        }

        protected void Btn_Modif_Click(object sender, EventArgs e)
        {

        }

        protected void Btn_Approve_Click(object sender, EventArgs e)
        {
            Button temp = (sender as Button);
            int idFeuille = int.Parse(temp.CommandArgument);

            var FT = from tblFT in cdc.tbl_FeuilleTemps
                     where tblFT.idFeuille == idFeuille
                     select tblFT;

            FT.First<tbl_FeuilleTemps>().approuver = true;
            cdc.tbl_FeuilleTemps.DeleteOnSubmit(FT.First<tbl_FeuilleTemps>());
            FT.First<tbl_FeuilleTemps>().approuver = true;
            cdc.tbl_FeuilleTemps.InsertOnSubmit(FT.First<tbl_FeuilleTemps>());

            cdc.SubmitChanges();


        }

        protected void Rptr_FeuilleTemps_Load(object sender, EventArgs e)
        {
          
        }
    }
}