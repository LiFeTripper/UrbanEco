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
        private static tbl_Employe connectedUser;
        CoecoDataContext context = new CoecoDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            var query = from tbl in context.tbl_Employe
                            where tbl.idEmploye == 1
                            select tbl;

            connectedUser = query.First<tbl_Employe>();

            
        }

        public static tbl_Employe GetUserConnected()
        {
            return connectedUser;
        }
    }
}