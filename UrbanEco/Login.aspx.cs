using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UrbanEco
{
    public partial class Login : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie cookie = Request.Cookies["userInfo"];
            if (cookie != null)
            {
                CoecoDataContext bd = new CoecoDataContext();
                var querry = bd.tbl_Employe.Where(f => f.username == cookie.Value);
                if (querry.ToList().Count != 0)
                {
                    //Ne peut être inexistant puisque pas de bouton supprimer, alors Single
                    tbl_Employe empCookie = bd.tbl_Employe.Single(f => f.username == cookie.Value);
                    if (empCookie.inactif == true)
                    {
                        cookie.Expires = DateTime.Today.AddDays(-1);
                    }
                    else
                    {
                        tbl_Employe empco = querry.First();
                        Session["username"] = empco.username;
                        Session["fonction"] = empco.idTypeEmpl;
                        //Mise à jour de la value du cookie
                        Request.Cookies["userInfo"].Expires = DateTime.Now.AddDays(3);
                        Response.Redirect("/Home.aspx", true);
                    }
                }
                bd.Dispose();
            }
        }

        protected void Btn_Signin_Click(object sender, EventArgs e)
        {
            string current_Username = Tbx_InputUsername.Text;
            string current_Password = Tbx_InputPassword.Value;

            CoecoDataContext bd = new CoecoDataContext();
            var querry = bd.tbl_Employe.Where(f => f.username == current_Username);

            //Vérif si le username est présent dans la bd
            if (querry.ToList().Count != 0)
            {
                tbl_Employe empToCheck = querry.First();
                bd.Dispose();

                if (empToCheck.password == current_Password)
                {
                    //Response.Cookies["userinfo"].Value = empToCheck.username;
                    Page.Title = "Connection";
                    Session["username"] = current_Username;
                    Session["fonction"] = empToCheck.idTypeEmpl;

                    //On crée le cookie de co si coché
                    if (Persist.Checked)
                    {
                        HttpCookie newCookie = new HttpCookie("userInfo");
                        newCookie.Value = current_Username;
                        newCookie.Expires = DateTime.Now.AddDays(3);
                        Response.Cookies.Add(newCookie);
                    }
                    

                    HttpContext.Current.Response.Redirect("Home.aspx", true);
                }
                else
                {
                    AlertDiv.Visible = true;
                }
            }
            else
            {
                //pas trouvé de correspondance
                AlertDiv.Visible = true;
            }
        }
    }
}