using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UrbanEco
{
    public partial class AjoutDepense : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_envoyer_Click(object sender, EventArgs e)
        {
            tbl_Depense dep = new tbl_Depense();
            tbl_Employe empConnected = Layout.GetUserConnected();

            int idTypeDepense = tbx_typeDepense.SelectedIndex + 1;

            dep.idEmploye = empConnected.idEmploye;
            dep.idTypeDepense = idTypeDepense;
            dep.montant = float.Parse(tbx_montant.Text);
          
        }

        protected void tbx_projet_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}