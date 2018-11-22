using System;
using System.Linq;
using System.Web.UI;

namespace UrbanEco
{
    public partial class AjoutDepense : System.Web.UI.Page
    {
        /*
            Fait par Marc-André
            Terminé le 12 novembre 2018

            TODO :
            Gestion des erreurs (champs vide)
            Permettre les modifications
        */

        static bool DepenseAjouter = false;

        static tbl_Kilometrage prixKilometrage;

        protected void Page_Load(object sender, EventArgs e)
        {
            //Empecher la page de remonter a chaque action
            Page.MaintainScrollPositionOnPostBack = true;

            if (!IsPostBack)
            {
                //La dépense n'est pas ajouté a la BD
                DepenseAjouter = false;

                //Ajouter les --- pour les sous-catégorie (pas de projet selectionner)
                tbx_categorie.Items.Add("-----");

                //Bd context
                CoecoDataContext context = new CoecoDataContext();

                //Query les projet
                var queryProjet = from tbl in context.tbl_Projet
                                  where tbl.archiver == false
                                  orderby tbl.titre
                                  select tbl;

                tbx_projet.DataSource = queryProjet;
                tbx_projet.DataBind();

                //Insérer un text pour sélectionne rle projet au début
                tbx_projet.Items.Insert(0,"Veuillez sélectionner le projet");
                tbx_projet.SelectedIndex = 0;
 
                tbx_typeDepense.SelectedIndex = 0;

                //Obtenir le prix du kilometrage
                var queryKilo = from tbl in context.tbl_Kilometrage
                        select tbl;

                prixKilometrage = queryKilo.First();
               
            }

            //Mettre a jour le recapitulatif de la dépense
            UpdateRecapitulatif();
        }

        /// <summary>
        /// Boutton envoyé la dépense
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btn_envoyer_Click(object sender, EventArgs e)
        {
            try
            {
                //La dépense est déja ajouté a la BD
                if (DepenseAjouter)
                {
                    if (alert_failed.Visible == true)
                        return;

                    alert_success.Visible = false;
                    alert_warning.Visible = true;
                    return;
                }

                //Créer une dépense
                tbl_Depense dep = new tbl_Depense();

                //obtenir l'employé connecter
                tbl_Employe empConnected = Layout.GetUserConnected();

                //Peut etre améliorer
                //obtenir le id du type de la dépense
                int idTypeDepense = tbx_typeDepense.SelectedIndex + 1;

                //Assigner les valeurs a la dépense
                dep.idEmploye = empConnected.idEmploye;
                dep.idTypeDepense = idTypeDepense;
                dep.idProjetCat = int.Parse(tbx_categorie.Items[tbx_categorie.SelectedIndex].Value);
                dep.note = tbx_note.Text;

                //Date de dépense
                DateTime date = DateTime.Parse(Calendar.Value);
                dep.dateDepense = date;

                //Si le type de dépense = KM
                if (km_html.Visible)
                {
                    //KM
                    dep.montant = float.Parse(tbx_montant1.Text) * prixKilometrage.prixKilometrage;

                    //Stocker le prix du KM a cette date
                    dep.prixKilometrage = prixKilometrage.prixKilometrage;
                }
                else
                {
                    //Montant autre
                    dep.montant = float.Parse(tbx_montant2.Text);
                    dep.prixKilometrage = null;
                }

                //Insérer la déepense
                CoecoDataContext context = new CoecoDataContext();
                context.tbl_Depense.InsertOnSubmit(dep);
                context.SubmitChanges();

                //La dépense est ajouté
                alert_success.Visible = true;
                alert_failed.Visible = false;
                alert_warning.Visible = false;
                DepenseAjouter = true;
            }
            catch (Exception ex)
            {
                //erreur lors de l'ajout de la dépense
                alert_failed.Visible = true;
                DepenseAjouter = false;
                Console.Write(ex);
            }

        }

        /// <summary>
        /// Le projet est changé
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void tbx_projet_SelectedIndexChanged(object sender, EventArgs e)
        {

            //Reset les catégories
            if(!tbx_categorie.Enabled)
                tbx_categorie.Enabled = true;


            tbx_categorie.DataSource = null;
            tbx_categorie.DataSourceID = null;

            //Aucun projet choisi
            if (tbx_projet.SelectedIndex == 0)
            {
                tbx_categorie.Enabled = false;
                tbx_categorie.Items.Clear();
                tbx_categorie.Items.Add("-----");

                return;
            }

            //Obtenir les catégorie
            CoecoDataContext context = new CoecoDataContext();
            int projectID = int.Parse(tbx_projet.Items[tbx_projet.SelectedIndex].Value);

            var query = from tbl in context.tbl_ProjetCat
                        where tbl.idProjet == projectID
                        select tbl;


            tbx_categorie.DataSource = query;
            tbx_categorie.DataBind();      
        }

        /// <summary>
        /// Mettre a jour le récapitulatif de la dépense
        /// </summary>
        void UpdateRecapitulatif()
        {
            if (tbx_categorie.SelectedIndex == -1)
                    return;

            rep_categorie.InnerText = tbx_categorie.Items[tbx_categorie.SelectedIndex].Text;          

            //Dépense KM
            if (km_html.Visible)
            {
                float prix = -1;
                float.TryParse(tbx_montant1.Text, out prix);

                if(prix != -1)
                {
                    rep_montant.InnerText = (prix * prixKilometrage.prixKilometrage) + "$";
                }
            }
            else
            {
                rep_montant.InnerText = (tbx_montant2.Text) + "$";
            }

            //Obtenir l'employé connecté
            if (Layout.GetUserConnected() != null)
                rep_nomEmployer.InnerText = Layout.GetUserConnected().nom + ", " + Layout.GetUserConnected().prenom;

            rep_projet.InnerText = tbx_projet.Items[tbx_projet.SelectedIndex].Text;

            if(tbx_typeDepense.SelectedIndex != -1)
                rep_typeDepense.InnerText = tbx_typeDepense.Items[tbx_typeDepense.SelectedIndex].Text;
        }

        protected void tbx_typeDepense_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Type de dépense KM
            if (tbx_typeDepense.SelectedIndex == 0)
            {
                //KM
                montant_html.Visible = false;
                km_html.Visible = true;
            }
            else
            {
                //Montant
                montant_html.Visible = true;
                km_html.Visible = false;
            }
             
        }

        /// <summary>
        /// Montant KM
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void tbx_montant1_TextChanged(object sender, EventArgs e)
        {
            montantTotalDepense.InnerText = " * "+ prixKilometrage.prixKilometrage+"$ = " + (float.Parse(tbx_montant1.Text) * prixKilometrage.prixKilometrage) + "$";
        }

        protected void btn_annuler_Click(object sender, EventArgs e)
        {
            Response.Redirect("GestionDepense.aspx");
        }
    }
}