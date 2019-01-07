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
        //private static tbl_Employe userConnected;

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

            tbl_Employe userConnected = query.First();

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

        }

        public static tbl_Projet GetProjectFromEmploye(tbl_Employe employe)
        {
            CoecoDataContext context = new CoecoDataContext();

            var query = (from tblProjetCat in context.tbl_ProjetCatEmploye
             join tblProjet in context.tbl_Projet on tblProjetCat.idProjet equals tblProjet.idProjet
             where tblProjetCat.idEmploye == employe.idEmploye
             orderby tblProjet.titre
             select tblProjet);

            if(query != null)
            {
                return query.First();
            }

            return null;
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

        public static string GetDateFormated(DateTime time)
        {
            string[] months = new string[12] {"Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre" };



            return time.Day + " " + months[time.Month - 1] + " " + time.Year;
        }
    }
}