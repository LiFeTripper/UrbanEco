using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UrbanEco
{
    public partial class AjoutCat : System.Web.UI.Page
    {
        string argument;

        protected void Page_Load(object sender, EventArgs e)
        {
            //Recherche de l'argument dans l'adresse
            argument = Request.QueryString["Prj"];

            if (!IsPostBack)
            {
                CoecoDataContext context = new CoecoDataContext();

                int id = int.Parse(argument);

                var queryCat = (from tbl in context.tbl_ProjetCat
                             where tbl.idProjet == id & tbl.idCatMaitre == null
                             select tbl);

                foreach (var souscat in queryCat)
                {
                    ListItem maliste = new ListItem(souscat.titre, souscat.idProjetCat.ToString());
                    Lbx_Cat1.Items.Add(maliste);
                }

                lbl_Top.Text = "Sous-Catégorie de projet";
                
            }

        }

        protected void Lbx_Cat1_SelectedIndexChanged(object sender, EventArgs e)
        {
            int idCat1 = int.Parse(Lbx_Cat1.SelectedValue);

            CoecoDataContext context = new CoecoDataContext();

            var queryCat = (from tbl in context.tbl_ProjetCat
                            where tbl.idCatMaitre == idCat1
                            select tbl);

            foreach (var souscat in queryCat)
            {
                ListItem maliste = new ListItem(souscat.titre, souscat.idProjetCat.ToString());
                Lbx_Cat2.Items.Add(maliste);
            }
        }
    }
}