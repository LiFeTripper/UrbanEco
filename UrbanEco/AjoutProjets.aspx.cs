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
            //Recherche de l'argument dans l'adresse
            argument = Request.QueryString["Prj"];

            //Choix entre un projet ou un nouveau projet
            switch (argument)
            {
                case "*":
                case null:
                    {
                        lbl_Top.Text = "Nouveau Projet";

                        //Par défault, la date d'aujourd'hui
                        Cal_DateDebut.Value = DateTime.Today.ToShortDateString();
                        Cal_DateFin.Value = DateTime.Today.ToShortDateString();

                        insert = true;
                        break;
                    }

                default:
                    {
                        if (!IsPostBack)
                        {
                            CoecoDataContext context = new CoecoDataContext();

                            int id = int.Parse(argument);

                            var query = (from tbl in context.tbl_Projet
                                         where tbl.idProjet == id
                                         select tbl).First();

                            lbl_Top.Text = query.titre;

                            Tbx_Titre.Text = query.titre;
                            Tbx_Description.Text = query.description;
                            Ddl_Responsable.SelectedIndex = (int)query.idEmployeResp -1;
                            Ddl_Status.SelectedIndex = (int)query.idStatus - 1;
                            Tbx_HeuresAlloues.Text = query.tempsAllouer.ToString();
                            Cal_DateDebut.Value = query.dateDebut.Value.ToShortDateString();
                            Cal_DateFin.Value = query.dateFin.Value.ToShortDateString();

                            insert = false;
                        }
                        break;
                    }
            }

        }

        protected void Btn_Enregister_Click(object sender, EventArgs e)
        {

            CoecoDataContext context = new CoecoDataContext();

            //Insertion dans la base de données
            if (insert == true)
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

                context.tbl_Projet.InsertOnSubmit(tableProjet);
            }
            //Modification dans la base de données
            else
            {
                int id = int.Parse(argument);

                var query = (from tbl in context.tbl_Projet
                             where tbl.idProjet == id
                             select tbl).First();

                query.titre = Tbx_Titre.Text;
                query.description = Tbx_Description.Text;
                query.idEmployeResp = int.Parse(Ddl_Responsable.SelectedValue);
                query.idStatus = int.Parse(Ddl_Status.SelectedValue);
                query.tempsAllouer = float.Parse(Tbx_HeuresAlloues.Text);
                query.dateDebut = DateTime.Parse(Cal_DateDebut.Value);
                query.dateFin = DateTime.Parse(Cal_DateFin.Value);
            }

            //Étape finale SUBMIT CHANGES
            context.SubmitChanges();

            
            Response.Redirect("Projets.aspx");

        }
    }
}