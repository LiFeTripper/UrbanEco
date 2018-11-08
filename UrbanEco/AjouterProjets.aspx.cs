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
            //Recherche de l'argument dans l'adresse
            string argument = Request.QueryString["Prj"];

            //Choix entre un projet ou un nouveau projet
            if (argument == "*")
            {
                lbl_Top.Text = "Nouveau Projet";

                Cal_DateDebut.Value = DateTime.Today.ToShortDateString();
                Cal_DateFin.Value = DateTime.Today.ToShortDateString();
            }
            else
            {
                if (!IsPostBack)
                {
                    CoecoDataContext context = new CoecoDataContext();

                    int id = int.Parse(argument);

                    var query = (from tbl in context.tbl_Projet
                                where tbl.idStatus == id
                                select tbl).First();

                    lbl_Top.Text = query.titre;

                    Tbx_Titre.Text = query.titre;
                    Tbx_Description.Text = query.description;
                    Ddl_Responsable.SelectedIndex = (int)query.idEmployeResp;
                    Ddl_Status.SelectedIndex = (int)query.idStatus;
                    Tbx_HeuresAlloues.Text = query.tempsAllouer.ToString();
                    Cal_DateDebut.Value = query.dateDebut.Value.ToShortDateString();
                    Cal_DateFin.Value = query.dateFin.Value.ToShortDateString();

                }
                    
            }
        }

        protected void AddProject_Click(object sender, EventArgs e)
        {
            //Objet de ma table Projet
            tbl_Projet tableProjet = new tbl_Projet();

            //Remplissage des champs de la table temporaire avec les contrôles
            tableProjet.titre = Tbx_Titre.Text;
            tableProjet.description = Tbx_Description.Text;
            tableProjet.tempsAllouer = float.Parse(Tbx_HeuresAlloues.Text);
            tableProjet.idStatus = int.Parse(Ddl_Status.SelectedValue);

            DateTime date1 = DateTime.Parse(Cal_DateDebut.Value);
            tableProjet.dateDebut = date1;

            DateTime date2 = DateTime.Parse(Cal_DateDebut.Value);
            tableProjet.dateFin = date2;

            tableProjet.idEmployeResp = int.Parse(Ddl_Responsable.SelectedValue);

            //Insertion dans la base de données
            CoecoDataContext context = new CoecoDataContext();
            context.tbl_Projet.InsertOnSubmit(tableProjet);
            context.SubmitChanges();

            
        }
    }
}