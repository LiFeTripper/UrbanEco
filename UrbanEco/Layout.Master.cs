using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace UrbanEco
{
    public partial class Layout : System.Web.UI.MasterPage
    {
        private static tbl_Employe userConnected;

        protected void Page_Load(object sender, EventArgs e)
        {
            CoecoDataContext context = new CoecoDataContext();

            //User not connected, redirect to login page
            if (Request.Cookies["userinfo"] == null)
            {
                return;
             //   Response.Redirect("Login.aspx");
            }
            string cookie = Request.Cookies["userInfo"].Value;

            var query = from tbl in context.tbl_Employe
                        where tbl.username == cookie
                        select tbl;
            var t = query.ToList();

            userConnected = query.First();

            if(Request.Cookies["userInfo"].Value == "admin")
            {
                liAdmin.Visible = true;
                liEmpBureau.Visible = false;
                liEmpTerrain.Visible = false;
            }
            else if(userConnected.idTypeEmpl == 1)
            {
                liAdmin.Visible = false;
                liEmpBureau.Visible = true;
                liEmpTerrain.Visible = false;
            }
            else if (userConnected.idTypeEmpl == 2)
            {
                liAdmin.Visible = false;
                liEmpBureau.Visible = false;
                liEmpTerrain.Visible = true;
            }

            Lbl_HelloUser1.InnerText = "Bonjour " + GetUserName();
            //Lbl_HelloUser2.InnerText = "Bonjour " + GetUserName();
            //Lbl_HelloUser3.InnerText = "Bonjour " + GetUserName();
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

        public static string ToCalendarDate(DateTime date)
        {
            return date.ToString("yyyy-MM-dd");
        }

        protected void Btn_Deconnect_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();

            if (Request.Cookies["userInfo"] != null)
            {
                Response.Cookies["userInfo"].Expires = DateTime.Now.AddDays(-1);
            }

            Response.Redirect("Login.aspx");
        }
    }
}