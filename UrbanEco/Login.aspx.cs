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
            if (User.Identity.IsAuthenticated)
                Response.Redirect("/Home.aspx");
        }

        protected void Btn_Signin_Click(object sender, EventArgs e)
        {
            ValidateUser();
        }

        protected void ValidateUser()
        {
            CoecoDataContext context = new CoecoDataContext();

            string user = Tbx_InputUsername.Text;
            string password = Tbx_InputPassword.Text;

            try
            {
                var query = (from tbl in context.tbl_Employe
                             where tbl.username == Tbx_InputUsername.Text
                             select tbl).First();

                if (query.password == Tbx_InputPassword.Text)
                {
                    FormsAuthentication.RedirectFromLoginPage
                            (Tbx_InputUsername.Text, Persist.Checked);

                    Response.Cookies["userInfo"].Value = Tbx_InputUsername.Text.ToString();
                    Response.Cookies["userInfo"].Expires = DateTime.Now.AddDays(1);

                    Response.Redirect("/Home.aspx");
                }
                else
                {
                    AlertDiv.Visible = true;
                }
            }
            catch (Exception)
            {
                AlertDiv.Visible = true;
            }
        }
        }
}