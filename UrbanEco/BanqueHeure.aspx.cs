using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Linq;

namespace UrbanEco
{
    public partial class BanqueHeure : System.Web.UI.Page
    {
        CoecoDataContext cdc = new CoecoDataContext();
        

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_modifBH_Click(object sender, EventArgs e)
        {
            if(ddl_empBH.Text != "")
            {
                tb_BH.Enabled = true;
            }
        }

        protected void ddl_empBH_TextChanged(object sender, EventArgs e)
        {

        }

        protected void load_BHemp(string nomEmp)
        {
            string[] nomEmpArray = nomEmp.Split(',');

            var id = from tbl in cdc.tbl_Employe
                     where tbl.prenom == nomEmpArray[0]
                     where tbl.nom == nomEmpArray[1]
                     select tbl.idEmploye;

            id = id;
            //var querry = from tbl2 in cdc.tbl_BanqueHeure
            //             where tbl.idEmploye == id.Select<>;
            //             orderby cust.Name ascending
            //             select tbl.;
            //tb_nbHeureBanque.Text = 
        }
    }
}