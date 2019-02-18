using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UrbanEco.RapportDepenses;

namespace UrbanEco
{
    public partial class RapportDepensePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Autorisation2.Autorisation(false, false);

            RapportDepenseNode rapportNode = (RapportDepenseNode)Session["rapportNode"];
            tbx_dateDebut.InnerHtml = Layout.GetDateFormated((DateTime)Session["dateDebut"]);
            tbx_dateFin.InnerHtml = Layout.GetDateFormated((DateTime)Session["dateFin"]);

            if (rapportNode != null)
            {
                rapportRepeater.DataSource = rapportNode.Childs;
                rapportRepeater.DataBind();
            }
        }
    }
}