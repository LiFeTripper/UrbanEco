using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UrbanEco
{
    public partial class Layout : System.Web.UI.MasterPage
    {
        private static tbl_Employe userConnected;

        protected void Page_Load(object sender, EventArgs e)
        {
            CoecoDataContext context = new CoecoDataContext();

            var query = from tbl in context.tbl_Employe
                        where tbl.idEmploye == 1
                        select tbl;

            userConnected = query.First();
        }

        public static tbl_Employe GetUserConnected()
        {
            return userConnected;
        }

        public static string GetUserName()
        {
            tbl_Employe emp = GetUserConnected();

            if (emp == null)
                return "";

            return emp.prenom + " " + emp.nom;
        }
    }
}