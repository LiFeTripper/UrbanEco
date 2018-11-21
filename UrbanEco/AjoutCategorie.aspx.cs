using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UrbanEco
{
    public partial class AjoutCategorie : System.Web.UI.Page
    {
        string argument;

        CoecoDataContext context = new CoecoDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            //Recherche de l'argument dans l'adresse
            argument = Request.QueryString["Prj"];

            lbl_noProjet.Text = argument;

            if (!IsPostBack)
            {
                Page.MaintainScrollPositionOnPostBack = true;

                //CODE POUR BIND LE REPEATER DE CATÉGORIE

                var query = from tblCat in context.tbl_ProjetCat
                            join tblP in context.tbl_Projet on tblCat.idProjet equals tblP.idProjet
                            where tblP.idProjet.Equals(argument) && tblCat.idCatMaitre.Equals(null)
                            select tblCat;

                Rptr_Categorie.DataSource = null;
                Rptr_Categorie.DataSourceID = null;

                //TEST
                var t = query.Distinct().ToList();

                Rptr_Categorie.DataBind();
                Rptr_Categorie.DataSource = query.Distinct();
                Rptr_Categorie.DataBind();

            }
        }

        protected void Btn_AjoutSousCat_Click(object sender, EventArgs e)
        {
            //Référence au bouton dans l'interface
            Button button = (sender as Button);

            //Ramassage du CommandArgument du bouton
            string commandArgument = button.CommandArgument;

            //Objet de ma table Projet
            tbl_ProjetCat tableCat = new tbl_ProjetCat();

            //Remplissage des champs de la table temporaire avec les contrôles
            
            
        }
    }
}