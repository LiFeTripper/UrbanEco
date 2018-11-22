using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace UrbanEco
{
    public partial class Home : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

            if(Layout.GetUserConnected() != null)
            {               
                lbl_bienvenue.InnerText = "Bonjour, " + Layout.GetUserName();
            }
            
        }
    }
}