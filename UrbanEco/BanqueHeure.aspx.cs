using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UrbanEco
{
    public partial class BanqueHeure : System.Web.UI.Page
    {
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
    }
}