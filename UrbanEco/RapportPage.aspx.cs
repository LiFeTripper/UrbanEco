using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UrbanEco.Rapports;

namespace UrbanEco
{
    public partial class RapportPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Authentification.Autorisation(true, false, false))
            {
                Response.Redirect("Login.aspx");
            }

            chercherRapport();
        }

        private void chercherRapport()
        {
            RapportNode rapportNode = (RapportNode)Session["rapportNode"];

            if (rapportNode != null)
            {
                rapportRepeater.DataSource = rapportNode.Child;
                rapportRepeater.DataBind();
            }
        }

        public string formatHeure(object p_nbHeure)
        {
            TimeSpan nbHeure = (TimeSpan)p_nbHeure;

            Console.WriteLine(nbHeure);

            int heure = nbHeure.Days * 24;
            heure += nbHeure.Hours;

            int minute = nbHeure.Minutes;

            return string.Format("{0} h {1}", heure, minute.ToString("00"));
        }
    }
}