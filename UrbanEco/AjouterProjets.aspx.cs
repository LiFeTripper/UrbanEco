using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UrbanEco
{
    public partial class Projets : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string s = Request.QueryString["Prj"];

            if (s == "*")
            {
                lbl_Top.Text = "NEW PROJECT";
            }
            else
            {
                lbl_Top.Text = "OLD PROJECT";
            }
        }

        protected void AddProject_Click(object sender, EventArgs e)
        {
            //Objet de ma table Projet
            tbl_Projet tableProjet = new tbl_Projet();

            //Remplissage des champs de la table avec les contrôles
            tableProjet.titre = Tbx_Titre.Text;
            tableProjet.description = Tbx_Description.Text;
            tableProjet.tempsAllouer = float.Parse(Tbx_HeuresAlloues.Text);
            tableProjet.idStatus = int.Parse(Ddl_Status.SelectedValue);
            tableProjet.dateDebut = Dtp_DateDebut.SelectedDate;
            tableProjet.dateFin = Dtp_DateFin.SelectedDate;

            //Insertion dans la base de données
            CoecoDataContext context = new CoecoDataContext();
            context.tbl_Projet.InsertOnSubmit(tableProjet);
            context.SubmitChanges();

            
        }
    }
}