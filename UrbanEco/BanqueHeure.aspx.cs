using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Linq;

namespace UrbanEco
{
    //Restant :
    //Verification de l'utilisateur connecté 
    //Update des heures lorsqu'une feuille de temps est approuvé 
    //et lorsque du temps supplémentaire s'accumule dans la BH


    public partial class BanqueHeure : System.Web.UI.Page
    {
        CoecoDataContext cdc = new CoecoDataContext();

        static bool admin = true;   //Bool pour savoir si c'est l'admin qui se connecte

        List<string> listEmp = new List<string>();

        protected void Page_Load(object sender, EventArgs e)
        {
            Page.MaintainScrollPositionOnPostBack = true;
            tbl_Employe emp = BD.GetUserConnected(Request.Cookies["userInfo"]);

            if (emp.username == "admin")
            {
                if (!IsPostBack)
                {
                    LoadListEmploye();
                }
            }
            else
            {
                LoadUser();
            }
        }

        //Clic du bouton pour passer de mode visionnage à modification
        protected void btn_modifBH_Click(object sender, EventArgs e)
        {
            //Si un employé est sélectionner
            if (ddl_empBH.Text != "Veuillez choisir un employé")
            {
                tbl_BH.Enabled = true;

                tbx_nbHeureBanque.Enabled = true;
                tbx_nbHeureCongeMaladie.Enabled = true;
                tbx_nbHeureCongePerso.Enabled = true;
                tbx_nbHeureJourFerie.Enabled = true;
                tbx_nbHeureVacance.Enabled = true;
                tbx_nbHeureBanqueI.Enabled = false;
                tbx_nbHeureCongeMaladieI.Enabled = false;
                tbx_nbHeureCongePersoI.Enabled = false;
                tbx_nbHeureJourFerieI.Enabled = false;
                tbx_nbHeureVacanceI.Enabled = false;
                btn_modifBHI.Visible = true;
                btn_Sauvegarder.Visible = true;
                btn_Annuler.Visible = true;
                btn_modifBH.Visible = false;
                ddl_empBH.Enabled = false;
            }
            //Si aucun employé n'est sélectionner, on affiche une alerte
            else
            {
                AlertDiv.Visible = true;
            }
        }

        //Bouton pour passer d'admin à employé, bouton de test
        //À remplacer par la détection de l'utilisateur au PageLoad()
        protected void btn_Admin_Click(object sender, EventArgs e)
        {
            if (admin == true)
                admin = false;
            else
                admin = true;

            if (admin)
            {
                this.Page.Title = "Gestion de la banque d'heures";
                h1TitlePage.InnerText = "Gestion de la Banque d'Heures";

                ddl_empBH.Visible = true;
                btn_modifBH.Visible = true;

                ClearTbx();

                LoadListEmploye();
            }

            else
            {
                LoadUser();
            }
        }

        //Methode pour faire afficher la banque d'heure de l'employé connecté ou de l'employé sélectionné
        protected void load_BHemp(string nomEmp)
        {
            //Si un employé est sélectionner
            if (nomEmp != "Veuillez choisir un employé")
            {
                int idInt = GetIDEmp(nomEmp);

                var BH = from tblBH in cdc.tbl_BanqueHeure
                         where tblBH.idEmploye == idInt
                         select tblBH;

                tbl_BH.Enabled = true;  //Activation de la table pour faire des modifs

                //Pour chaque ligne de la banque d'heure, on n'affiche la
                foreach (var heureBH in BH)
                {
                    switch (heureBH.idTypeHeure)
                    {
                        case 1:
                            tbx_nbHeureBanque.Text = heureBH.nbHeure.ToString();
                            tbx_nbHeureBanqueI.Text = heureBH.nbHeureInitial.ToString();
                            break;
                        case 2:
                            tbx_nbHeureJourFerie.Text = heureBH.nbHeure.ToString();
                            tbx_nbHeureJourFerieI.Text = heureBH.nbHeureInitial.ToString();
                            break;
                        case 3:
                            tbx_nbHeureCongePerso.Text = heureBH.nbHeure.ToString();
                            tbx_nbHeureCongePersoI.Text = heureBH.nbHeureInitial.ToString();
                            break;
                        case 4:
                            tbx_nbHeureVacance.Text = heureBH.nbHeure.ToString();
                            tbx_nbHeureVacanceI.Text = heureBH.nbHeureInitial.ToString();
                            break;
                        case 5:
                            tbx_nbHeureCongeMaladie.Text = heureBH.nbHeure.ToString();
                            tbx_nbHeureCongeMaladieI.Text = heureBH.nbHeureInitial.ToString();
                            break;
                    }
                }
                tbl_BH.Enabled = false;     //Désactivation de la table pour faire des modifs
            }
        }

        //Load_BHEmp pour un id au lieu du nom employé
        protected void load_BHemp(int idInt)
        {
            var BH = from tblBH in cdc.tbl_BanqueHeure
                     where tblBH.idEmploye == idInt
                     select tblBH;

            tbl_BH.Enabled = true;

            foreach (var heureBH in BH)
            {
                switch (heureBH.idTypeHeure)
                {
                    case 1:
                        tbx_nbHeureBanque.Text = heureBH.nbHeure.ToString();
                        tbx_nbHeureBanqueI.Text = heureBH.nbHeureInitial.ToString();
                        break;
                    case 2:
                        tbx_nbHeureJourFerie.Text = heureBH.nbHeure.ToString();
                        tbx_nbHeureJourFerieI.Text = heureBH.nbHeureInitial.ToString();
                        break;
                    case 3:
                        tbx_nbHeureCongePerso.Text = heureBH.nbHeure.ToString();
                        tbx_nbHeureCongePersoI.Text = heureBH.nbHeureInitial.ToString();
                        break;
                    case 4:
                        tbx_nbHeureVacance.Text = heureBH.nbHeure.ToString();
                        tbx_nbHeureVacanceI.Text = heureBH.nbHeureInitial.ToString();
                        break;
                    case 5:
                        tbx_nbHeureCongeMaladie.Text = heureBH.nbHeure.ToString();
                        tbx_nbHeureCongeMaladieI.Text = heureBH.nbHeureInitial.ToString();
                        break;
                }
            }
            tbl_BH.Enabled = false;
        }

        //On affiche les heures dans la banque d'heures lorsqu'un employé est sélectionner
        protected void ddl_empBH_SelectedIndexChanged(object sender, EventArgs e)
        {
            //On vide les textBox si aucun employé n'est sélectionner
            if (ddl_empBH.Text == "Veuillez choisir un employé")
            {
                tbx_nbHeureBanque.Text = "";

                tbx_nbHeureJourFerie.Text = "";

                tbx_nbHeureCongePerso.Text = "";

                tbx_nbHeureVacance.Text = "";

                tbx_nbHeureCongeMaladie.Text = "";
                tbx_nbHeureBanqueI.Text = "";

                tbx_nbHeureJourFerieI.Text = "";

                tbx_nbHeureCongePersoI.Text = "";

                tbx_nbHeureVacanceI.Text = "";

                tbx_nbHeureCongeMaladieI.Text = "";
            }
            else
            {
                tbx_nbHeureBanque.Text = "";

                tbx_nbHeureJourFerie.Text = "";

                tbx_nbHeureCongePerso.Text = "";

                tbx_nbHeureVacance.Text = "";

                tbx_nbHeureCongeMaladie.Text = "";
                tbx_nbHeureBanqueI.Text = "";

                tbx_nbHeureJourFerieI.Text = "";

                tbx_nbHeureCongePersoI.Text = "";

                tbx_nbHeureVacanceI.Text = "";

                tbx_nbHeureCongeMaladieI.Text = "";
                load_BHemp(ddl_empBH.Text);
                AlertDiv.Visible = false;   //On cache l'alerte de choix d'employé
            }
        }

        //Sauvegarde des données de l'empoyé afficher
        protected void Update_BH()
        {
            int idInt = GetIDEmp(ddl_empBH.Text);

            var BH = from tblBH in cdc.tbl_BanqueHeure
                     where tblBH.idEmploye == idInt
                     select tblBH;

            //On obtient les heures actuelles de l'employé
            List<tbl_BanqueHeure> listHeure = new List<tbl_BanqueHeure>();
            foreach (var heure in BH)
            {
                listHeure.Add(heure);
            }

            //On modifie des valeurs si il y a un changement
            foreach (var heureBH in listHeure)
            {
                switch (heureBH.idTypeHeure)
                {
                    case 1:
                        if(tbx_nbHeureBanqueI.Enabled)
                            heureBH.nbHeure = float.Parse(tbx_nbHeureBanqueI.Text);
                        else
                            heureBH.nbHeure = float.Parse(tbx_nbHeureBanque.Text);

                        heureBH.nbHeureInitial = float.Parse(tbx_nbHeureBanqueI.Text);
                        break;
                    case 2:
                        if (tbx_nbHeureJourFerieI.Enabled)
                            heureBH.nbHeure = float.Parse(tbx_nbHeureJourFerieI.Text);
                        else
                            heureBH.nbHeure = float.Parse(tbx_nbHeureJourFerie.Text);

                        heureBH.nbHeureInitial = float.Parse(tbx_nbHeureJourFerieI.Text);
                        break;
                    case 3:
                        if (tbx_nbHeureCongePersoI.Enabled)
                            heureBH.nbHeure = float.Parse(tbx_nbHeureCongePersoI.Text);
                        else
                            heureBH.nbHeure = float.Parse(tbx_nbHeureCongePerso.Text);
                        
                        heureBH.nbHeureInitial = float.Parse(tbx_nbHeureCongePersoI.Text);
                        break;
                    case 4:
                        if (tbx_nbHeureVacanceI.Enabled)
                            heureBH.nbHeure = float.Parse(tbx_nbHeureVacanceI.Text);
                        else
                            heureBH.nbHeure = float.Parse(tbx_nbHeureVacance.Text);
                        
                        heureBH.nbHeureInitial = float.Parse(tbx_nbHeureVacanceI.Text);
                        break;
                    case 5:
                        if (tbx_nbHeureCongeMaladieI.Enabled)
                            heureBH.nbHeure = float.Parse(tbx_nbHeureCongeMaladieI.Text);
                        else
                            heureBH.nbHeure = float.Parse(tbx_nbHeureCongeMaladie.Text);

                        heureBH.nbHeureInitial = float.Parse(tbx_nbHeureCongeMaladieI.Text);
                        break;
                }
            }

            //On enregistre chaque entré de la table en supprimant l'ancienne entrée
            foreach (var heureBH in listHeure)
            {
                cdc.tbl_BanqueHeure.DeleteOnSubmit(heureBH);
                cdc.tbl_BanqueHeure.InsertOnSubmit(heureBH);
            }

            cdc.SubmitChanges();

        }

        //Obtient l'id de l'empolòyé à l'aide de son nom et prénom séparé par une virgule
        protected int GetIDEmp(string nomEmp)
        {
            string[] nomEmpArray = nomEmp.Split(',');

            var id = from tblEmp in cdc.tbl_Employe
                     where tblEmp.nom == nomEmpArray[0]
                     where tblEmp.prenom == nomEmpArray[1]
                     select tblEmp.idEmploye;

            return id.First();
        }

        //Vidage des textBox de la banque d'heures
        protected void ClearTbx()
        {
            tbx_nbHeureBanque.Text = "";

            tbx_nbHeureJourFerie.Text = "";

            tbx_nbHeureCongePerso.Text = "";

            tbx_nbHeureVacance.Text = "";

            tbx_nbHeureCongeMaladie.Text = "";
        }

        //On obtient l'utilisateur connecté et on affiche ses heures
        protected void LoadUser()
        {
            this.Page.Title = "Ma banque d'heures";
            h1TitlePage.InnerText = "Ma banque d'heure";

            ddl_empBH.Visible = false;
            btn_modifBH.Visible = false;

            load_BHemp(BD.GetUserConnected(Request.Cookies["userInfo"]).idEmploye);
        }

        //On obient la liste des employées et on la link au DropDownList
        protected void LoadListEmploye()
        {
            //Remplissage du dropdownlist d'employé

            var tblEmp = from tbl in cdc.tbl_Employe
                         where tbl.username != "admin"
                         select tbl;

            foreach (var n in tblEmp)
            {
                listEmp.Add(n.nom + "," + n.prenom);
            }

            ddl_empBH.DataSource = null;
            ddl_empBH.DataBind();
            ddl_empBH.DataSource = listEmp;
            ddl_empBH.DataBind();

            ddl_empBH.Items.Insert(0, "Veuillez choisir un employé");
        }

        protected void btn_modifBHI_Click(object sender, EventArgs e)
        {
                if (btn_modifBHI.Text == "Activer la modification des heures initiales")
                {
                tbx_nbHeureBanqueI.Enabled = true;
                tbx_nbHeureCongeMaladieI.Enabled = true;
                tbx_nbHeureCongePersoI.Enabled = true;
                tbx_nbHeureJourFerieI.Enabled = true;
                tbx_nbHeureVacanceI.Enabled = true;
                tbx_nbHeureBanque.Enabled = false;
                tbx_nbHeureCongeMaladie.Enabled = false;
                tbx_nbHeureCongePerso.Enabled = false;
                tbx_nbHeureJourFerie.Enabled = false;
                tbx_nbHeureVacance.Enabled = false;
                btn_modifBHI.Visible = false;
                }
                //Lorsque les modifications désactivées, on enregistre les changements fait dans la table d'heures de l'employé sélectionner
                else
                {
                    tbx_nbHeureBanqueI.Enabled = false;
                    tbx_nbHeureCongeMaladieI.Enabled = false;
                    tbx_nbHeureCongePersoI.Enabled = false;
                    tbx_nbHeureJourFerieI.Enabled = false;
                    tbx_nbHeureVacanceI.Enabled = false;
                    btn_modifBHI.Visible = false;
                    btn_modifBHI.Text = "Activer la modification des heures initiales";
                }

        }

        protected void btn_Annuler_Click(object sender, EventArgs e)
        {
            tbl_BH.Enabled = false;
            btn_modifBHI.Visible = false;

            btn_Sauvegarder.Visible = false;
            btn_Annuler.Visible = false;

            //On vide les textBox si aucun employé n'est sélectionner
            if (ddl_empBH.Text == "Veuillez choisir un employé")
            {
                tbx_nbHeureBanque.Text = "";

                tbx_nbHeureJourFerie.Text = "";

                tbx_nbHeureCongePerso.Text = "";

                tbx_nbHeureVacance.Text = "";

                tbx_nbHeureCongeMaladie.Text = "";
                tbx_nbHeureBanqueI.Text = "";

                tbx_nbHeureJourFerieI.Text = "";

                tbx_nbHeureCongePersoI.Text = "";

                tbx_nbHeureVacanceI.Text = "";

                tbx_nbHeureCongeMaladieI.Text = "";
            }
            else
            {
                load_BHemp(ddl_empBH.Text);
                AlertDiv.Visible = false;   //On cache l'alerte de choix d'employé
            }

            btn_modifBH.Visible = true;
            btn_modifBHI.Text = "Activer la modification des heures initiales";
            ddl_empBH.Enabled = true;

        }

        protected void btn_Sauvegarder_Click(object sender, EventArgs e)
        {
            Update_BH();
            tbl_BH.Enabled = false;
            btn_modifBHI.Visible = false;
            btn_modifBH.Visible = true;
            btn_Sauvegarder.Visible = false;
            btn_Annuler.Visible = false;
            btn_modifBHI.Text = "Activer la modification des heures initiales";
            ddl_empBH.Enabled = true;

            load_BHemp(ddl_empBH.Text);
        }
    }

    
}