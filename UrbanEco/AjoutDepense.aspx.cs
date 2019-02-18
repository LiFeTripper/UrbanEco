using System;
using System.Linq;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using System.IO;

namespace UrbanEco
{
    public partial class AjoutDepense : System.Web.UI.Page
    {
        /*
            Fait par Marc-André
            Terminé le 12 novembre 2018

            TODO :
            Gestion des erreurs (champs vide)
        */



        protected enum TypeKm { Voiture, Camion, Nothing}
        protected static TypeKm typeKm = TypeKm.Voiture;

        private static tbl_Kilometrage prixKilometrage;

        protected void Page_Load(object sender, EventArgs e)
        {
            Autorisation2.Autorisation(true, true);
            //Empecher la page de remonter a chaque action
            Page.MaintainScrollPositionOnPostBack = true;

            

            if (!IsPostBack)
            {

                CoecoDataContext ctx = new CoecoDataContext();

                List<ListItem> ListTypeDepense = new List<ListItem>();

                tbl_Employe empConnected = BD.GetUserConnected(ctx, Session["username"].ToString());
                tbl_TypeEmploye typeEmpl = empConnected.tbl_TypeEmploye;


                prixKilometrage = BD.GetDeplacementPrice(ctx);


                //Nouvelle dépense
                if (Request.QueryString["Dep"] == "New")
                {

                    typeKm = TypeKm.Voiture;

                    //Ajouter les --- pour les sous-catégorie (pas de projet selectionner)
                    tbx_categorie.Items.Add("-----");


                    //Query les projet accessible par l'employé
                    var query_Projets_Employes = BD.GetEmployeProjet(ctx,empConnected);

                    tbx_projet.DataSource = query_Projets_Employes;
                    tbx_projet.DataBind();

                    //Insérer un text pour sélectionner le projet au début
                    tbx_projet.Items.Insert(0, "Veuillez sélectionner le projet");
                    tbx_projet.SelectedIndex = 0;

                    if(empConnected.username == "admin")
                    {
                        


                        //Remplissage du dropdownlist d'employé
                        List<ListItem> listItemEmployes = new List<ListItem>();

                        var allEmployes = BD.GetAllEmployes(ctx);
                        allEmployes = allEmployes.OrderBy(o => o.nom).ThenBy(o => o.prenom).ToList();

                        foreach (var employes in allEmployes)
                        {
                            listItemEmployes.Add(new ListItem(employes.nom + ", " + employes.prenom, employes.idEmploye.ToString()));
                        }

                        ddlEmp.DataSource = listItemEmployes;
                        ddlEmp.DataBind();

                        ddlEmp.Items.Insert(0, "Veuillez choisir un employé");
                        divEmp.Visible = true;
                       
                    }
                    tbx_typeDepense.SelectedIndex = 0;


                    var query_Dépense_Kilometrage = BD.GetDepenseDeplacement(ctx);

                    var query_Type_Depense_UserType = BD.GetTypeDepense(ctx,empConnected.idTypeEmpl);


                    ListTypeDepense.Add(new ListItem("Veuillez sélectionner un type de dépense", "-1"));

                    foreach (var item in query_Dépense_Kilometrage)
                    {
                        ListItem l = new ListItem(item.nomDepense, item.idTypeDepense.ToString());
                        ListTypeDepense.Add(l);
                    }

                    foreach (var item in query_Type_Depense_UserType)
                    {
                        ListItem l = new ListItem(item.nomDepense, item.idTypeDepense.ToString());
                        ListTypeDepense.Add(l);
                    }


                    tbx_typeDepense.DataSource = ListTypeDepense;
                    tbx_typeDepense.DataBind();

                    km_html.Visible = false;
                    montant_html.Visible = false;

                    Calendar.Value = Layout.ToCalendarDate(DateTime.Today);
                }
                else //Modification dépense
                {                 
                    tbl_Depense depenseToModify = BD.GetDepense(ctx,int.Parse(Request.QueryString["Dep"]));

                    //Ajouter les --- pour les sous-catégorie (pas de projet selectionner)
                    tbx_categorie.Items.Add("-----");

                    tbl_Employe employe_Associer_depense = null;


                    employe_Associer_depense = BD.GetEmploye(ctx,depenseToModify.idEmploye);

                    imageUploading.Visible = false;
                    typeEmpl = employe_Associer_depense.tbl_TypeEmploye;

                    var queryProjet = BD.GetEmployeProjet(ctx,employe_Associer_depense);


                    tbx_projet.DataSource = queryProjet;
                    tbx_projet.DataBind();


                    var queryKilometreDepense = BD.GetDepenseDeplacement(ctx);

                    var queryTypeDepense = BD.GetTypeDepense(ctx,empConnected.idTypeEmpl);

                    ListTypeDepense.Add(new ListItem("Veuillez sélectionner un type de dépense", "-1"));

                    foreach (var item in queryKilometreDepense)
                    {
                        ListItem l = new ListItem(item.nomDepense, item.idTypeDepense.ToString());
                        ListTypeDepense.Add(l);
                    }

                    foreach (var item in queryTypeDepense)
                    {
                        ListItem l = new ListItem(item.nomDepense, item.idTypeDepense.ToString());
                        ListTypeDepense.Add(l);
                    }


                    tbx_typeDepense.DataSource = ListTypeDepense;
                    tbx_typeDepense.DataBind();

                    km_html.Visible = false;
                    montant_html.Visible = false;

                    Calendar.Value = Layout.ToCalendarDate(DateTime.Today);

                    var querryCat = from tbl in ctx.tbl_ProjetCat
                                    where tbl.idProjetCat == depenseToModify.idProjetCat
                                    select tbl;

                    tbx_projet.SelectedValue = querryCat.First().idProjet.ToString();

                    tbx_categorie.Enabled = true;


                    tbx_categorie.DataSource = null;
                    tbx_categorie.DataSourceID = null;

                    SProjet.Visible = true;
                    tbx_categorie.Items.Clear();

                    int projectID = int.Parse(tbx_projet.Items[tbx_projet.SelectedIndex].Value);

                    var query = BD.GetProjetLinkedCategorieEmploye(ctx,projectID, employe_Associer_depense.idEmploye);

                    List<ListItem> listeCategorieEmploye = new List<ListItem>();

                    foreach (tbl_ProjetCatEmploye item in query)
                    {
                        ListItem categorie = new ListItem(BD.GetCategorieById(ctx, (int)BD.GetCategorieById(ctx, item.idCategorie).idCatMaitre).titre + " - " + item.tbl_ProjetCat.titre, item.idCategorie.ToString());
                        listeCategorieEmploye.Add(categorie);
                    }


                    tbx_categorie.DataSource = listeCategorieEmploye;
                    tbx_categorie.DataBind();

                    var TypeDepense = from tbl in ctx.tbl_TypeDepense
                                      where tbl.nomDepense == depenseToModify.typeDepense
                                      select tbl;


                    tbx_categorie.SelectedValue = depenseToModify.idProjetCat.ToString();
                    tbx_typeDepense.SelectedValue = TypeDepense.First().idTypeDepense.ToString();

                    Calendar.Value = Layout.ToCalendarDate((DateTime)depenseToModify.dateDepense);

                    if (depenseToModify.typeDepense == "Déplacement (Voiture)")
                    {
                        km_html.Visible = true;
                        typeKm = TypeKm.Voiture;
                        prixTotalKm.InnerText = depenseToModify.montant.ToString();
                        tbx_nbKm.Text = (depenseToModify.montant / prixKilometrage.prixKilometrageVoiture).ToString();
                    }
                    else if (depenseToModify.typeDepense == "Déplacement (Camion)")
                    {
                        km_html.Visible = true;
                        typeKm = TypeKm.Camion;
                        prixTotalKm.InnerText = depenseToModify.montant.ToString();
                        tbx_nbKm.Text = (depenseToModify.montant / prixKilometrage.prixKilometrageCamion).ToString();
                    }
                    else
                    {
                        montant_html.Visible = true;
                        tbx_montantNormal.Text = depenseToModify.montant.ToString();
                    }


                    tbx_note.Text = depenseToModify.note.ToString();

                }
            }

            //Mettre a jour le recapitulatif de la dépense
            //UpdateRecapitulatif();
        }

        /// <summary>
        /// Boutton confirmer la dépense
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btn_envoyer_Click(object sender, EventArgs e)
        {
            CoecoDataContext ctx = new CoecoDataContext();

            try
            {
                if (Request.QueryString["Dep"] == "New")
                {

                    //Créer une dépense
                    tbl_Depense dep = new tbl_Depense();

                    //obtenir l'employé connecter
                    tbl_Employe empConnected = BD.GetUserConnected(ctx, Session["username"].ToString());

                    if(empConnected.username == "admin")
                    {
                        dep.idEmploye = int.Parse(ddlEmp.SelectedValue);
                    }
                    else
                    {
                        dep.idEmploye = empConnected.idEmploye;
                    }

                    //obtenir le id du type de la dépense
                    int idTypeDepense = tbx_typeDepense.SelectedIndex + 1;

                    //Assigner les valeurs a la dépense
                    dep.typeDepense = tbx_typeDepense.SelectedItem.Text;

                    //Pas de sous-catégorie sélectionner
                    if (tbx_categorie.SelectedIndex == 0)
                    {
                        //message d'erreur
                        alert_failed.Visible = true;
                        //dep.idProjetCat = null;
                    }
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

                    if (base64img.Value != "") {
                        //DirectoryInfo dir = Directory.CreateDirectory("Factures");
                        string[] base64 = base64img.Value.Split(';');
                        string ext = base64[0].Split('/')[1];

                        if (!Directory.Exists(Server.MapPath("Factures"))) {
                            Directory.CreateDirectory(Server.MapPath("Factures"));
                        }

                        string filename = System.Guid.NewGuid().ToString() + "." + ext;
                        string filepath = Server.MapPath("Factures\\" + filename);
                        File.WriteAllBytes(filepath, Convert.FromBase64String(base64[1].Split(',')[1]));

                        dep.facturePath = "Factures\\" + filename;
                    } else {
                        dep.facturePath = "";
                    }

                    //Insérer la déepense
                    CoecoDataContext context = new CoecoDataContext();
                    context.tbl_Depense.InsertOnSubmit(dep);
                    context.SubmitChanges();

                    Response.Redirect("GestionDepense.aspx");
                }
                else
                {


                    CoecoDataContext context = new CoecoDataContext();

                    var querry = from tbl in context.tbl_Depense
                                 where tbl.idDepense == int.Parse(Request.QueryString["Dep"])
                                 select tbl;

                    tbl_Depense tblDep = querry.First();

                    tblDep.dateDepense = DateTime.Parse(Calendar.Value);
                    tblDep.typeDepense = tbx_typeDepense.SelectedItem.Text;
                    tblDep.idProjetCat = int.Parse(tbx_categorie.Items[tbx_categorie.SelectedIndex].Value);
                    

                    tblDep.note = tbx_note.Text;

                    if (km_html.Visible && typeKm != TypeKm.Nothing)
                    {
                        switch (typeKm)
                        {
                            case TypeKm.Voiture:
                                tblDep.montant = float.Parse(tbx_nbKm.Text) * prixKilometrage.prixKilometrageVoiture;
                                tblDep.prixKilometrage = prixKilometrage.prixKilometrageVoiture;
                                break;
                            case TypeKm.Camion:
                                tblDep.montant = float.Parse(tbx_nbKm.Text) * prixKilometrage.prixKilometrageCamion;
                                tblDep.prixKilometrage = prixKilometrage.prixKilometrageCamion;
                                break;
                        }

                    }
                    else
                    {
                        //Montant autre
                        tblDep.montant = float.Parse(tbx_montantNormal.Text);
                        tblDep.prixKilometrage = null;
                    }

                    context.tbl_Depense.DeleteOnSubmit(querry.First());
                    context.tbl_Depense.InsertOnSubmit(tblDep);
                    context.SubmitChanges();

                    Response.Redirect("GestionDepense.aspx");




                }
            }
            catch (Exception ex)
            {
                //erreur lors de l'ajout de la dépense
                alert_failed.Visible = true;
                //Console.Write(ex);
            }
        }

        
                

        

        /// <summary>
        /// Le projet est changé
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void tbx_projet_SelectedIndexChanged(object sender, EventArgs e)
        {
            CoecoDataContext ctx = new CoecoDataContext();
            //Reset les catégories
            if (!tbx_categorie.Enabled)
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

            tbl_Employe empConnected = BD.GetUserConnected(ctx, Session["username"].ToString());

            var query = BD.GetProjetLinkedCategorieEmploye(ctx, projectID, empConnected.idEmploye);

            if (empConnected.username == "admin")
            {
                //Connecté en admin
                query = BD.GetProjetLinkedCategorieEmploye(ctx, projectID, int.Parse(ddlEmp.SelectedValue));
            }


            List<ListItem> listeCategorieEmploye = new List<ListItem>();
            listeCategorieEmploye.Add(new ListItem("Aucune", (-1).ToString()));

            foreach (tbl_ProjetCatEmploye item in query)
            {
                //Inséré la catégorie maitre en premier
                ListItem categorie = new ListItem(BD.GetCategorieById(ctx, (int)BD.GetCategorieById(ctx, item.idCategorie).idCatMaitre).titre + " - " + item.tbl_ProjetCat.titre, item.idCategorie.ToString());
                listeCategorieEmploye.Add(categorie);
            }


            tbx_categorie.DataSource = listeCategorieEmploye;
            tbx_categorie.DataBind();

            tbx_categorie.SelectedIndex = 0;
        }

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
        protected void ddlEmp_SelectedIndexChanged(object sender, EventArgs e)
        {
            CoecoDataContext ctx = new CoecoDataContext();
            var query_Projets2 = BD.GetEmployeProjet(ctx, BD.GetEmploye(ctx, int.Parse(ddlEmp.SelectedValue)));

            tbx_projet.DataSource = query_Projets2;
            tbx_projet.DataBind();

            //Insérer un text pour sélectionner le projet au début
            tbx_projet.Items.Insert(0, "Veuillez sélectionner le projet");
            tbx_projet.SelectedIndex = 0;
        }
    }
}