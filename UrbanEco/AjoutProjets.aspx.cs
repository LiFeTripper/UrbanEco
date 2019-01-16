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
        bool insert;
        string argument;

        protected void Page_Load(object sender, EventArgs e)
        {
            insert = false;
            //Recherche de l'projet dans l'adresse
            argument = Request.QueryString["Prj"];

            //Choix entre un projet ou un nouveau projet
            switch (argument)
            {
                case "*":
                case null:
                    {
                        lbl_Top.Text = "Nouveau Projet";

                        //Par défault, la date d'aujourd'hui
                        Cal_DateDebut.Value = Layout.ToCalendarDate(DateTime.Today);
                        Cal_DateFin.Value = Layout.ToCalendarDate(DateTime.Today);

                        insert = true;
                        break;
                    }

                default:
                    {
                        if (!IsPostBack)
                        {
                            CoecoDataContext ctx = new CoecoDataContext();

                            int idProjet = int.Parse(argument);

                            tbl_Projet Projet = BD.GetProjet(ctx, idProjet);

                            lbl_Top.Text = Projet.titre;

                            Tbx_Titre.Text = Projet.titre;
                            Tbx_Description.Text = Projet.description;
                            Ddl_Responsable.SelectedIndex = (int)Projet.idEmployeResp -1;
                            Chkbx_App.Checked = (bool)Projet.approbation;
                            Ddl_Status.SelectedIndex = (int)Projet.idStatus - 1;
                            Tbx_HeuresAlloues.Text = Projet.tempsAllouer.ToString();
                            Cal_DateDebut.Value =  Layout.ToCalendarDate(Projet.dateDebut.Value);
                            Cal_DateFin.Value = Layout.ToCalendarDate(Projet.dateFin.Value);

                            insert = false;
                        }
                        break;
                    }
            }

        }

        protected void Btn_Enregister_Click(object sender, EventArgs e)
        {

            CoecoDataContext ctx = new CoecoDataContext();

            //Insertion dans la base de données
            if (insert == true)
            {
                //Objet de ma table Projet
                tbl_Projet tableProjet = new tbl_Projet();

                //Remplissage des champs de la table temporaire avec les contrôles
                tableProjet.titre = Tbx_Titre.Text;
                tableProjet.description = Tbx_Description.Text;

                if (string.IsNullOrWhiteSpace(Tbx_HeuresAlloues.Text))
                    Tbx_HeuresAlloues.Text = "0";

                tableProjet.tempsAllouer = float.Parse(Tbx_HeuresAlloues.Text);
                tableProjet.idStatus = int.Parse(Ddl_Status.SelectedValue);
                tableProjet.archiver = ChkBx_Archivé.Checked;

                DateTime date1 = DateTime.Parse(Cal_DateDebut.Value);
                tableProjet.dateDebut = date1;

                DateTime date2 = DateTime.Parse(Cal_DateDebut.Value);
                tableProjet.dateFin = date2;

                tableProjet.idEmployeResp = int.Parse(Ddl_Responsable.SelectedValue);
                tableProjet.approbation = Chkbx_App.Checked;

                ctx.tbl_Projet.InsertOnSubmit(tableProjet);
            }
            //Modification dans la base de données
            else
            {
                int idProjet = int.Parse(argument);

                tbl_Projet ProjetToModif = BD.GetProjet(ctx,idProjet);

                ProjetToModif.titre = Tbx_Titre.Text;
                ProjetToModif.description = Tbx_Description.Text;
                ProjetToModif.idEmployeResp = int.Parse(Ddl_Responsable.SelectedValue);
                ProjetToModif.approbation = Chkbx_App.Checked;
                ProjetToModif.idStatus = int.Parse(Ddl_Status.SelectedValue);
                ProjetToModif.tempsAllouer = float.Parse(Tbx_HeuresAlloues.Text);
                ProjetToModif.dateDebut = DateTime.Parse(Cal_DateDebut.Value);
                ProjetToModif.dateFin = DateTime.Parse(Cal_DateFin.Value);
                ProjetToModif.archiver = ChkBx_Archivé.Checked;
            }

            //Étape finale SUBMIT CHANGES
            ctx.SubmitChanges();
            
            Response.Redirect("Projets.aspx");

        }

        protected void Btn_Annuler_Click(object sender, EventArgs e)
        {
            ((Button)sender).CausesValidation = false;
            Response.Redirect("Projets.aspx",false);
            HttpContext.Current.ApplicationInstance.CompleteRequest();
        }
    }
}