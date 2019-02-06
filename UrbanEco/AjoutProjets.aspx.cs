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
            if (!Authentification.Autorisation(true, false, false))
            {
                Response.Redirect("Login.aspx");
            }

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
                            Ddl_Responsable.SelectedValue = Projet.idEmployeResp.ToString();
                            Chkbx_App.Checked = (bool)Projet.approbation;
                            Ddl_Status.SelectedIndex = (int)Projet.idStatus - 1;
                            Tbx_HeuresAlloues.Text = Projet.tempsAllouer.ToString();
                            if(Projet.dateDebut != null)
                                Cal_DateDebut.Value =  Layout.ToCalendarDate(Projet.dateDebut.Value);
                            if(Projet.dateFin != null)
                                Cal_DateFin.Value = Layout.ToCalendarDate(Projet.dateFin.Value);
                            ChkBx_Archivé.Checked = (bool)Projet.archiver;
                            insert = false;
                        }
                        break;
                    }
            }

        }

        protected void Btn_Enregister_Click(object sender, EventArgs e)
        {

            CoecoDataContext ctx = new CoecoDataContext();

            if(!VerifInfoProjet(insert))
            {
                return;
            }

            DateTime dateDebut;
            DateTime dateFin;

            //Date ou NULL
            DateTime.TryParse(Cal_DateDebut.Value, out dateDebut);
            DateTime.TryParse(Cal_DateDebut.Value, out dateFin);

            //Insertion dans la base de données
            if (insert == true)
            {
                //Objet de ma table Projet
                tbl_Projet nouveauProjet = new tbl_Projet();

                //Remplissage des champs de la table temporaire avec les contrôles
                nouveauProjet.titre = Tbx_Titre.Text;
                string titre = Tbx_Titre.Text;
                nouveauProjet.description = Tbx_Description.Text;

                if (string.IsNullOrWhiteSpace(Tbx_HeuresAlloues.Text))
                    Tbx_HeuresAlloues.Text = "0";

                nouveauProjet.tempsAllouer = float.Parse(Tbx_HeuresAlloues.Text);
                nouveauProjet.idStatus = int.Parse(Ddl_Status.SelectedValue);
                nouveauProjet.archiver = ChkBx_Archivé.Checked;

                nouveauProjet.dateDebut = dateDebut;
                nouveauProjet.dateFin = dateFin;

                nouveauProjet.idEmployeResp = int.Parse(Ddl_Responsable.SelectedValue);
                nouveauProjet.approbation = Chkbx_App.Checked;

                ctx.tbl_Projet.InsertOnSubmit(nouveauProjet);

                if (Tbx_Titre.Text != "")
                {
                    ctx.SubmitChanges();
                    //On retourne chercher notre ajout pour avoir son id 
                    var query_Projets = (from tblProjet in ctx.tbl_Projet
                                         where tblProjet.titre == tblProjet.titre
                                         orderby tblProjet.idProjet descending
                                         select tblProjet).First();

                    //On créé un ligne dans la table associé a ce projet 
                    tbl_ProjetCat tableCat = new tbl_ProjetCat();
                    tableCat.titre = "Général";
                    tableCat.idProjet = query_Projets.idProjet;

                    //On insert dans la table
                    ctx.tbl_ProjetCat.InsertOnSubmit(tableCat);

                    ctx.SubmitChanges();
                }
                else
                {
                    AlertDiv.Visible = true;
                }

                
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
                ProjetToModif.dateDebut = dateDebut;
                ProjetToModif.dateFin = dateFin;
                ProjetToModif.archiver = ChkBx_Archivé.Checked;
            }

            //Étape finale SUBMIT CHANGES
            if (Tbx_Titre.Text != "")
            {
                ctx.SubmitChanges();
                Response.Redirect("Projets.aspx");
            }
            else
            {
                AlertDiv.Visible = true;
            }
        }

        protected void Btn_Annuler_Click(object sender, EventArgs e)
        {
            ((Button)sender).CausesValidation = false;
            Response.Redirect("Projets.aspx",false);
            HttpContext.Current.ApplicationInstance.CompleteRequest();
        }

        private bool VerifInfoProjet(bool insert)
        {
            if(string.IsNullOrWhiteSpace(Tbx_Titre.Text))
            {
                return false;
            }


            return true;
        }
    }
}