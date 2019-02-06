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
        static bool admin = true;   //Bool pour savoir si c'est l'admin qui se connecte

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Authentification.Autorisation(true,true,false))
            {
                Response.Redirect("Home.aspx");
            }

            CoecoDataContext ctx = new CoecoDataContext();
            Page.MaintainScrollPositionOnPostBack = true;
            tbl_Employe emp = BD.GetUserConnected(ctx,Request.Cookies["userInfo"]);

            if (emp.username == "admin")
            {
                if (!IsPostBack)
                {
                    LoadListEmploye();
                    Load_Heure_Use(ddl_empBH.SelectedItem.Value);
                    loadHeureMinEmp(ddl_empBH.SelectedItem.Value);
                }
            }
            else
            {
                LoadUser();
                load_Heure_Use_Emp(emp.nom + "," +  emp.prenom);
                loadHeureSemaineEmp(emp.nom + "," + emp.prenom);
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
                tbx_heureMinimum.Enabled = true;
            }
            //Si aucun employé n'est sélectionner, on affiche une alerte
            else
            {
                AlertDiv.Visible = true;
            }
        }

        protected void loadHeureSemaineEmp(string nomEmp)
        {
            CoecoDataContext ctx = new CoecoDataContext();

            if (nomEmp != "Veuillez choisir un employé")
            {
                int idInt = GetIDEmp(nomEmp);

                var BH = (from emp in ctx.tbl_Employe
                          where emp.idEmploye == idInt
                          select emp).First();

                tbx_heureMinimum.Text = BH.nbHeureSemaine.ToString();
            }
        }

        protected void loadHeureMinEmp(string nomEmp)
        {
            CoecoDataContext ctx = new CoecoDataContext();

            if (nomEmp != "Veuillez choisir un employé")
            {
                int idInt = GetIDEmp(nomEmp);

                var BH = (from emp in ctx.tbl_Employe
                         where emp.idEmploye == idInt
                         select emp).First();

                tbx_heureMinimum.Text = BH.nbHeureSemaine.ToString();
            }            
        }

        protected void load_Heure_Use_Emp(string nomEmp)
        {
            CoecoDataContext ctx = new CoecoDataContext();

            if (nomEmp != "Veuillez choisir un employé")
            {
                int idInt = GetIDEmp(nomEmp);

                var BH = from tblBH in ctx.tbl_BanqueHeure
                         where tblBH.idEmploye == idInt
                         select tblBH;

                tbl_BH.Enabled = true;  //Activation de la table pour faire des modifs

                foreach (var heureBH in BH)
                {
                    switch (heureBH.idTypeHeure)
                    {
                        case 1:
                            tbx_nbHeureBanqueU.Text = (heureBH.nbHeureInitial - heureBH.nbHeure).ToString();
                            break;
                        case 2:
                            tbx_nbHeureJourFerieU.Text = (heureBH.nbHeureInitial - heureBH.nbHeure).ToString();
                            break;
                        case 3:
                            tbx_nbHeureCongePersoU.Text = (heureBH.nbHeureInitial - heureBH.nbHeure).ToString();
                            break;
                        case 4:
                            tbx_nbHeureVacanceU.Text = (heureBH.nbHeureInitial - heureBH.nbHeure).ToString();
                            break;
                        case 5:
                            tbx_nbHeureCongeMaladieU.Text = (heureBH.nbHeureInitial - heureBH.nbHeure).ToString();
                            break;
                    }
                }

                tbl_BH.Enabled = false;

            }

            }

        protected void Load_Heure_Use(string nomEmp)
        {
            tbx_nbHeureBanqueU.Text = "0";
            tbx_nbHeureJourFerieU.Text = "0";
            tbx_nbHeureCongePersoU.Text = "0";
            tbx_nbHeureVacanceU.Text = "0";
            tbx_nbHeureCongeMaladieU.Text = "0";

            CoecoDataContext ctx = new CoecoDataContext();

            tbl_Employe emp = BD.GetUserConnected(ctx, Request.Cookies["userInfo"]);

                if (nomEmp != "Veuillez choisir un employé")
                {
                    int idInt = GetIDEmp(nomEmp);

                    var BH = from tblBH in ctx.tbl_BanqueHeure
                             where tblBH.idEmploye == idInt
                             select tblBH;

                    tbl_BH.Enabled = true;

                    foreach (var heureBH in BH)
                    {
                        switch (heureBH.idTypeHeure)
                        {
                            case 1:
                                tbx_nbHeureBanqueU.Text = (heureBH.nbHeureInitial - heureBH.nbHeure).ToString();
                                break;
                            case 2:
                                tbx_nbHeureJourFerieU.Text = (heureBH.nbHeureInitial - heureBH.nbHeure).ToString();
                                break;
                            case 3:
                                tbx_nbHeureCongePersoU.Text = (heureBH.nbHeureInitial - heureBH.nbHeure).ToString();
                                break;
                            case 4:
                                tbx_nbHeureVacanceU.Text = (heureBH.nbHeureInitial - heureBH.nbHeure).ToString();
                                break;
                            case 5:
                                tbx_nbHeureCongeMaladieU.Text = (heureBH.nbHeureInitial - heureBH.nbHeure).ToString();
                                break;
                        }
                    }
                }
                else //vider les champs
                {
                    tbl_BH.Enabled = true;

                    tbx_nbHeureBanqueU.Text = "0";
                    tbx_nbHeureJourFerieU.Text = "0";
                    tbx_nbHeureCongePersoU.Text = "0";
                    tbx_nbHeureVacanceU.Text = "0";
                    tbx_nbHeureCongeMaladieU.Text = "0";
                }
            

            tbl_BH.Enabled = false;

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
            CoecoDataContext ctx = new CoecoDataContext();
            //Si un employé est sélectionner
            if (nomEmp != "Veuillez choisir un employé")
            {
                int idInt = GetIDEmp(nomEmp);

                var BH = from tblBH in ctx.tbl_BanqueHeure
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
        protected void load_BHemp(int idEmploye)
        {
            CoecoDataContext ctx = new CoecoDataContext();
            var BH = BD.GetBanqueHeure(ctx,idEmploye);

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

            //"Veuillez choisir un employé"
            if (ddl_empBH.SelectedIndex != -1)
            {        
                //On cache l'alerte de choix d'employé
                load_BHemp(ddl_empBH.SelectedItem.Value);
                AlertDiv.Visible = false;
                Load_Heure_Use(ddl_empBH.SelectedItem.Value);
                loadHeureMinEmp(ddl_empBH.SelectedItem.Value);
            }
        }

        //Sauvegarde des données de l'empoyé afficher
        protected void Update_BH()
        {
            CoecoDataContext ctx = new CoecoDataContext();
            if (ddl_empBH.SelectedIndex == -1)
            {
                return;
            }

            string[] splitname = ddl_empBH.SelectedItem.Value.Split(',');

            int idEmp = -1;

            if (splitname.Length == 2)
            {
                idEmp = BD.GetEmployeByName(ctx,splitname[0].Trim(), splitname[1].Trim()).idEmploye;
            }
            else
            {
                try
                {
                    int.TryParse(ddl_empBH.SelectedItem.Value, out idEmp);
                    if (idEmp == -1)
                        throw new Exception();

                   
                }
                catch(Exception ex)
                {

                    return;
                }
            }

            var BH = BD.GetBanqueHeure(ctx,idEmp);
            Update_HeureSemaine(idEmp);


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


            
            ctx.SubmitChanges();

        }

        //Obtient l'id de l'empolòyé à l'aide de son nom et prénom séparé par une virgule
        protected int GetIDEmp(string nomEmp)
        {
            CoecoDataContext ctx = new CoecoDataContext();
            string[] nomEmpArray = nomEmp.Split(',');

            var id = from tblEmp in ctx.tbl_Employe
                     where tblEmp.nom == nomEmpArray[0].Trim()
                     where tblEmp.prenom == nomEmpArray[1].Trim()
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
            CoecoDataContext ctx = new CoecoDataContext();

            this.Page.Title = "Ma banque d'heures";
            h1TitlePage.InnerText = "Ma banque d'heure";

            ddl_empBH.Visible = false;
            btn_modifBH.Visible = false;

            load_BHemp(BD.GetUserConnected(ctx,Request.Cookies["userInfo"]).idEmploye);
        }

        //On obient la liste des employées et on la link au DropDownList
        protected void LoadListEmploye()
        {

            CoecoDataContext ctx = new CoecoDataContext();
            //Remplissage du dropdownlist d'employé

            var tblEmp = BD.GetAllEmployes(ctx);

            List<ListItem> listEmp = new List<ListItem>();

            foreach (var emp in tblEmp)
            {
                if ((bool)!emp.inactif) {
                    listEmp.Add(new ListItem(emp.nom + ", " + emp.prenom, emp.idEmploye.ToString()));
                }
            }

            //trier le ddl en ordre 
            List<ListItem> listCopy = new List<ListItem>();
            foreach (ListItem item in listEmp)
                listCopy.Add(item);

            listEmp.Clear();

            foreach (ListItem item in listCopy.OrderBy(item => item.Text))
            {
                listEmp.Add(item);
            }

            ddl_empBH.DataSource = null;
            ddl_empBH.DataBind();
            ddl_empBH.DataSource = listEmp;
            ddl_empBH.DataBind();
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

            tbx_heureMinimum.Enabled = false;
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
            tbx_heureMinimum.Enabled = false;

            load_BHemp(ddl_empBH.Text);
            Load_Heure_Use(ddl_empBH.SelectedItem.Value);
        }

        protected void Update_HeureSemaine(int idEmp)
        {
            CoecoDataContext ctx = new CoecoDataContext();
            var BH = (from emp in ctx.tbl_Employe
                      where emp.idEmploye == idEmp
                      select emp).First();

            BH.nbHeureSemaine = float.Parse(tbx_heureMinimum.Text);
            ctx.SubmitChanges();
        }
    }

    
}