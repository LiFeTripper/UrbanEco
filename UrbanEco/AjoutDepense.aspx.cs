using System;
using System.Linq;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;
using System.Web.UI.WebControls;

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
            Adapter pour prix voiture et camion
        */

        protected enum TypeKm { Voiture, Camion, Nothing}
        protected static TypeKm typeKm = TypeKm.Voiture;

        static tbl_TypeEmploye typeEmpl;
        static tbl_Employe empConnected;


        static bool DepenseAjouter = false;

        static tbl_Kilometrage prixKilometrage;

        protected void Page_Load(object sender, EventArgs e)
        {
            //Empecher la page de remonter a chaque action
            Page.MaintainScrollPositionOnPostBack = true;

            if (!IsPostBack)
            {
                //dépense par défaut
                typeKm = TypeKm.Voiture;

                //La dépense n'est pas ajouté a la BD
                DepenseAjouter = false;

                //Ajouter les --- pour les sous-catégorie (pas de projet selectionner)
                tbx_categorie.Items.Add("-----");

                //Bd context
                CoecoDataContext context = new CoecoDataContext();

                empConnected = (from tbl in context.tbl_Employe
                            where tbl.idEmploye == 1
                            select tbl).First();

                typeEmpl = empConnected.tbl_TypeEmploye;

                //Query les projet accessible par l'employé
                var queryProjet = (from tblProjetCat in context.tbl_ProjetCatEmploye
                                  join tblProjet in context.tbl_Projet on tblProjetCat.idProjet equals tblProjet.idProjet
                                  where tblProjetCat.idEmploye == empConnected.idEmploye
                                  orderby tblProjet.titre
                                  select tblProjet);

                tbx_projet.DataSource = queryProjet.Distinct();
                tbx_projet.DataBind();

                //Insérer un text pour sélectionne rle projet au début
                tbx_projet.Items.Insert(0,"Veuillez sélectionner le projet");
                tbx_projet.SelectedIndex = 0;
 
                tbx_typeDepense.SelectedIndex = 0;

                //Obtenir le prix du kilometrage
                var queryKilo = from tbl in context.tbl_Kilometrage
                        select tbl;

                prixKilometrage = queryKilo.First();

               

                var queryKilometreDepense = from tbl in context.tbl_TypeDepense
                                   where tbl.idTypeEmploye.Equals(null) == true
                                   select tbl;

                var queryTypeDepense = from tbl in context.tbl_TypeDepense
                                   where tbl.idTypeEmploye == typeEmpl.idType
                                   select tbl;

                List<ListItem> ListTypeDepense = new List<ListItem>();

                ListTypeDepense.Add(new ListItem("Veuillez sélectionner un type de dépense", "-1"));

                foreach (var item in queryKilometreDepense.ToList())
                {
                    ListItem l = new ListItem(item.nomDepense, item.idTypeDepense.ToString());
                    ListTypeDepense.Add(l);
                }

                foreach (var item in queryTypeDepense.ToList())
                {
                    ListItem l = new ListItem(item.nomDepense, item.idTypeDepense.ToString());
                    ListTypeDepense.Add(l);
                }
                

                tbx_typeDepense.DataSource = ListTypeDepense;
                tbx_typeDepense.DataBind();

                km_html.Visible = false;
                montant_html.Visible = false;
            }

            //Mettre a jour le recapitulatif de la dépense
            //UpdateRecapitulatif();
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
                dep.typeDepense = tbx_typeDepense.SelectedItem.Text;

                //Pas de sous-catégorie sélectionner
                if (tbx_categorie.SelectedIndex == 0)
                    dep.idProjetCat = null;
                else
                    dep.idProjetCat = int.Parse(tbx_categorie.Items[tbx_categorie.SelectedIndex].Value);

                dep.note = tbx_note.Text;

                //Date de dépense
                DateTime date = DateTime.Parse(Calendar.Value);
                dep.dateDepense = date;

                //Si le type de dépense = KM
                if (km_html.Visible && typeKm != TypeKm.Nothing)
                {
                    switch (typeKm)
                    {
                        case TypeKm.Voiture:
                            dep.montant = float.Parse(tbx_nbKm.Text) * prixKilometrage.prixKilometrageVoiture;
                            dep.prixKilometrage = prixKilometrage.prixKilometrageVoiture;
                            break;
                        case TypeKm.Camion:
                            dep.montant = float.Parse(tbx_nbKm.Text) * prixKilometrage.prixKilometrageCamion;
                            dep.prixKilometrage = prixKilometrage.prixKilometrageCamion;
                            break;
                    }
                   
                }
                else
                {
                    //Montant autre
                    dep.montant = float.Parse(tbx_montantNormal.Text);
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
                SProjet.Visible = false;
                return;
            }

            SProjet.Visible = true;
            tbx_categorie.Items.Clear();
            tbx_categorie.Items.Add("-----");

            //Obtenir les catégorie
            CoecoDataContext context = new CoecoDataContext();
            int projectID = int.Parse(tbx_projet.Items[tbx_projet.SelectedIndex].Value);

            //var query = from tbl in context.tbl_ProjetCat
            //            where tbl.idProjet == projectID

            //            select tbl;

            var query = from tbl in context.tbl_ProjetCatEmploye
                        where tbl.idProjet == projectID && tbl.idEmploye == empConnected.idEmploye
                        select tbl;

            List<ListItem> listeCategorieEmploye = new List<ListItem>();
            listeCategorieEmploye.Add(new ListItem("Aucune", (-1).ToString()));

            foreach (tbl_ProjetCatEmploye item in query.ToList())
            {
                
                ListItem categorie = new ListItem(item.tbl_ProjetCat.titre, item.idCategorie.ToString());
                listeCategorieEmploye.Add(categorie);
            }


            tbx_categorie.DataSource = listeCategorieEmploye;
            tbx_categorie.DataBind();

            tbx_categorie.SelectedIndex = 0;
        }

        /// <summary>
        /// Mettre a jour le récapitulatif de la dépense
        /// </summary>
        /*void UpdateRecapitulatif()
        {
            rep_categorie.InnerText = tbx_categorie.Items[tbx_categorie.SelectedIndex].Text;          

            //Dépense KM
            if (km_html.Visible && typeKm != TypeKm.Nothing)
            {
                float prix = -1;
                float.TryParse(tbx_nbKm.Text, out prix);

                if(prix != -1)
                {
                    string prixtotal = "";

                    switch (typeKm)
                    {
                        case TypeKm.Voiture:
                            prixtotal = (prix * prixKilometrage.prixKilometrageVoiture) + "$";
                            break;
                        case TypeKm.Camion:
                            prixtotal = (prix * prixKilometrage.prixKilometrageCamion) + "$";
                            break;
                    }
                    rep_montant.InnerText = prixtotal;
                    prixTotalKm.InnerText = prixtotal;
                }
            }
            else
            {
                rep_montant.InnerText = (tbx_montantNormal.Text) + "$";
            }

            //Obtenir l'employé connecté
            if (Layout.GetUserConnected() != null)
                rep_nomEmployer.InnerText = Layout.GetUserConnected().nom + ", " + Layout.GetUserConnected().prenom;

            rep_projet.InnerText = tbx_projet.Items[tbx_projet.SelectedIndex].Text;

            if(tbx_typeDepense.SelectedIndex != -1)
                rep_typeDepense.InnerText = tbx_typeDepense.Items[tbx_typeDepense.SelectedIndex].Text;
        }*/

        protected void tbx_typeDepense_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Type de dépense KM, voiture et camion
            if (tbx_typeDepense.SelectedIndex == 1 || tbx_typeDepense.SelectedIndex == 2)
            {
                
                if(tbx_typeDepense.SelectedIndex == 1)
                {
                    //Voiture
                    typeKm = TypeKm.Voiture;
                    prixKm.InnerText = "* " + prixKilometrage.prixKilometrageVoiture + "$/km";
                }
                else
                {
                    //Camion
                    typeKm = TypeKm.Camion;
                    prixKm.InnerText = "* " + prixKilometrage.prixKilometrageCamion + "$/km";
                }

                //KM
                montant_html.Visible = false;
                km_html.Visible = true;

                UpdateTotalPriceKM();
            }
            else
            {
                //Montant normal
                montant_html.Visible = true;
                km_html.Visible = false;

                typeKm = TypeKm.Nothing;
            }
             
        }

        protected void btn_annuler_Click(object sender, EventArgs e)
        {
            Response.Redirect("GestionDepense.aspx");
        }

        protected void tbx_nbKm_TextChanged(object sender, EventArgs e)
        {
            UpdateTotalPriceKM();
        }

        void UpdateTotalPriceKM()
        {
            //Dépense KM
            if (km_html.Visible && typeKm != TypeKm.Nothing)
            {
                float prix = -1;
                float.TryParse(tbx_nbKm.Text, out prix);

                if (prix != -1)
                {
                    string prixtotal = "";

                    switch (typeKm)
                    {
                        case TypeKm.Voiture:
                            prixtotal = (prix * prixKilometrage.prixKilometrageVoiture) + "$";
                            break;
                        case TypeKm.Camion:
                            prixtotal = (prix * prixKilometrage.prixKilometrageCamion) + "$";
                            break;
                    }
                    //rep_montant.InnerText = prixtotal;
                    prixTotalKm.InnerText = prixtotal;
                }
            }
        }
    }
}