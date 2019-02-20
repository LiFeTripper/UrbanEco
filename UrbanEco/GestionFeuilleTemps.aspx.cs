using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UrbanEco
{
    public partial class GestionFeuilleTemps : System.Web.UI.Page
    {
        CoecoDataContext cdc = new CoecoDataContext();

        tbl_Employe empConnected;

        static List<tbl_PremierDimanche> dimanches = new List<tbl_PremierDimanche>();

        protected string formatRemoveHour(object date)
        {
            DateTime dt = (DateTime)date;
            return dt.ToString().Split(' ')[0];

        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Autorisation2.Autorisation(true, true);
            CoecoDataContext ctx = new CoecoDataContext();
            empConnected = BD.GetUserConnected(ctx, Session["username"].ToString());

            if (!IsPostBack)
            {
                Page.MaintainScrollPositionOnPostBack = true;

                //Premier dimanche
                var queryDimanche = from tbl in cdc.tbl_PremierDimanche
                                    select tbl;

                if (queryDimanche.Count() > 0)
                {
                    dimanches = queryDimanche.ToList();
                }

                List<tbl_Employe> listTable = new List<tbl_Employe>();

                Calendar1.Value = "1/1/1754";
                Calendar2.Value = "1/1/3000";

                DateTime dateMin = DateTime.Parse(Calendar1.Value);
                DateTime dateMax = DateTime.Parse(Calendar2.Value);

                if (empConnected.username == "admin")
                {
                    var queryFTAttente = BD.GetAllEmployeFtFiltered(ctx, dateMin, dateMax, false);

                    var queryFTApprouver = BD.GetAllEmployeFtFiltered(ctx, dateMin, dateMax, true);
                    

                    Rptr_EmployeNonApprouver.DataSource = queryFTAttente;
                    Rptr_EmployeNonApprouver.DataBind();
                    
                }
                else
                {
                    var queryFTAttente = BD.GetEmployeFtFiltered(ctx, empConnected.idEmploye, dateMin, dateMax, false);
                    var queryFTApprouver = BD.GetEmployeFtFiltered(ctx, empConnected.idEmploye, dateMin, dateMax, true);

                    Rptr_EmployeNonApprouver.DataSource = queryFTAttente;
                    Rptr_EmployeNonApprouver.DataBind();

                }
            }
        }

        public bool isVisible(object rptItem)
        {
            CoecoDataContext ctx = new CoecoDataContext();
            
            if (empConnected.username == "admin")
            {
                return true;
            } else {
                if (rptItem is tbl_FeuilleTemps) {
                    tbl_FeuilleTemps laFeuille = (tbl_FeuilleTemps)rptItem;
                    if ((bool)laFeuille.tbl_Projet.approbation && laFeuille.tbl_Projet.idEmployeResp == empConnected.idEmploye && laFeuille.idEmploye != laFeuille.tbl_Projet.idEmployeResp) {
                        return true;
                    }
                } else if (rptItem is tbl_Employe) {
                    tbl_Employe empl = (tbl_Employe)rptItem;
                    if (empl.idEmploye != empConnected.idEmploye) {
                        foreach (tbl_FeuilleTemps item in empl.tbl_FeuilleTemps) {
                            if (!(bool)item.tbl_Projet.approbation || item.tbl_Projet.idEmployeResp != empConnected.idEmploye) {
                                return false;
                            }
                        }

                        return true;
                    }
                }
            }

            return false;
        }

        public bool IsAdmin()
        {
            CoecoDataContext ctx = new CoecoDataContext();

            tbl_Employe empconnected = BD.GetUserConnected(ctx, Session["username"].ToString());

            return empconnected.username == "admin";
        }

        public bool isModifVisible(object item) {
            CoecoDataContext ctx = new CoecoDataContext();

            if (empConnected.username == "admin" || (item as tbl_FeuilleTemps).idEmploye == empConnected.idEmploye) {
                return true;
            }
            else {
                if (item is tbl_FeuilleTemps) {
                    tbl_FeuilleTemps laFeuille = (tbl_FeuilleTemps)item;
                    if ((bool)laFeuille.tbl_Projet.approbation && laFeuille.tbl_Projet.idEmployeResp == empConnected.idEmploye) {
                        return true;
                    }
                }
            }

            return false;
        }
        
        protected void Btn_Approve_Click(object sender, EventArgs e)
        {
            CoecoDataContext ctx = new CoecoDataContext();

            // Get le id de la feuille de temps a approuver
            ImageButton temp = (sender as ImageButton);
            int idFeuille = int.Parse(temp.CommandArgument);

            tbl_FeuilleTemps FT = BD.GetFeuilleTemps(ctx, idFeuille);

            // Approuve la feuille de temps
            FT.approuver = true;
            SwitchTypeBHCongés(FT);
            ctx.SubmitChanges();

            Response.Redirect(Request.RawUrl);
        }

        protected void Rptr_FeuilleTemps_Load(object sender, EventArgs e)
        {

        }

        protected void Btn_ApproveEmp_Click(object sender, EventArgs e)
        {
            Button temp = (sender as Button);
            int idEmp = int.Parse(temp.CommandArgument);

            var FT = from tblFT in cdc.tbl_FeuilleTemps
                     where tblFT.idEmploye == idEmp
                     && tblFT.approuver == false
                     select tblFT;

            foreach (var FTemp in FT)
            {
                if ((bool)FTemp.approuver)
                    continue;

                if (empConnected.username == "admin" || FTemp.tbl_Projet.idEmployeResp == empConnected.idEmploye) {
                    FTemp.approuver = true;
                    cdc.SubmitChanges();
                    SwitchTypeBHCongés(FTemp);
                }
            }

            Response.Redirect(Request.RawUrl);
        }

        protected void SwitchTypeBHCongés(tbl_FeuilleTemps FT)
        {
                // Si la catégorie de la feuille de temps est une banque d'heure
                // On ajuste la banque d'heure
                // SC = Sous-catégorie
                var SC = from tblSC in cdc.tbl_ProjetCat
                         where tblSC.idProjetCat == FT.idCat
                         select tblSC;
                switch (SC.First().titre)
                {
                    case "Congés fériés":
                        EnleverHeuresBH(2, FT);
                        break;
                    case "Vacances":
                        EnleverHeuresBH(4, FT);
                        break;
                    case "Heures accumulées ou sans solde":
                        EnleverHeuresBH(1, FT);
                        break;
                    case "Congés maladie":
                        EnleverHeuresBH(5, FT);
                        break;
                    case "Congés personnels":
                        EnleverHeuresBH(3, FT);
                        break;
                    default:
                        CheckTempsSupp(FT);
                        break;
                }
        }

        protected void EnleverHeuresBH(int idTypeHeure, tbl_FeuilleTemps FT)
        {
            var BH = from tblBH in cdc.tbl_BanqueHeure
                     where tblBH.idEmploye == FT.idEmploye
                     & tblBH.idTypeHeure == idTypeHeure
                     select tblBH;
            BH.First().nbHeure -= FT.nbHeure;
            cdc.SubmitChanges();
        }

        protected void Rptr_FeuilleTempsNonApprouver_Load(object sender, EventArgs e)
        {

        }

        protected void Rptr_FeuilleTempsNonApprouver_Load1(object sender, EventArgs e)
        {
            Repeater r = (Repeater)sender;
            Control rPar = r.Parent;
        }

        protected void Btn_ApproveEmp_Click1(object sender, EventArgs e)
        {

        }

        protected void Btn_ApproveTout_Click(object sender, EventArgs e)
        {
            var FT = from tblFT in cdc.tbl_FeuilleTemps where tblFT.approuver == false
                     select tblFT;

            foreach (var FTemp in FT)
            {
                //CheckTempsSupp(FTemp);
                FTemp.approuver = true;
                SwitchTypeBHCongés(FTemp);
            }

            /* cdc.tbl_FeuilleTemps.DeleteAllOnSubmit(FT);
             cdc.tbl_FeuilleTemps.InsertAllOnSubmit(FT);*/

            cdc.SubmitChanges();

            Response.Redirect(Request.RawUrl);
        }
        

        protected void btnCloseOpen_Click(object sender, EventArgs e)
        {
            //En pause bouton pour ouvrir

        }

        protected void Btn_Modif_Click1(object sender, ImageClickEventArgs e)
        {
            ImageButton ib = (ImageButton)sender;

            CoecoDataContext ctx = new CoecoDataContext();
            tbl_FeuilleTemps ft = BD.GetFeuilleTemps(ctx, int.Parse(ib.CommandArgument));

            tbl_Employe emp = ft.tbl_Employe;

            List<tbl_ProjetCat> projetCategorie = BD.GetProjetCategorieEmploye(ctx, ft.idProjet, emp.idEmploye);

            if (projetCategorie == null) {
                string valeur = emp.prenom + " " + emp.nom + ";;;" + ft.tbl_ProjetCat.titre + ";;;" + ft.tbl_Projet.titre;
                valeur = valeur.Replace("\'", "\\'").Replace("\"","\\\"");
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "callJS", "MessageErreur(\"" + valeur + "\")", true);
                return;
            }

            Response.Redirect("AjoutFT.aspx?FT=" + ib.CommandArgument);
        }
        

        protected void btn_Filtrer_Click(object sender, EventArgs e)
        {
            string dateMinimal, dateMaximal;

            dateMinimal = Calendar1.Value;
            dateMaximal = Calendar2.Value;

            if (string.IsNullOrWhiteSpace(dateMinimal) || string.IsNullOrWhiteSpace(dateMaximal))
            {
                alert_missingDate.Visible = true;
                return;
            }

            alert_missingDate.Visible = false;

            DateTime dateMin = DateTime.Parse(dateMinimal);
            DateTime dateMax = DateTime.Parse(dateMaximal);

            if (dateMin > dateMax)
            {
                alert_dateOrder.Visible = true;
                return;
            }

            alert_dateOrder.Visible = false;


            RequeryFT(dateMin, dateMax);

        }

        void RequeryFT(DateTime dateMin, DateTime dateMax)
        {
            CoecoDataContext ctx = new CoecoDataContext();

            tbl_Employe empConnected = BD.GetUserConnected(ctx, Session["username"].ToString());

            if (empConnected.username == "admin")
            {

                var queryFTAttente = BD.GetAllEmployeFtFiltered(ctx, dateMin, dateMax, false);

                var queryFTApprouver = BD.GetAllEmployeFtFiltered(ctx, dateMin, dateMax, true);

                Rptr_EmployeNonApprouver.DataSource = null;
                Rptr_EmployeNonApprouver.DataSourceID = null;
                Rptr_EmployeNonApprouver.DataBind();

                Rptr_EmployeNonApprouver.DataSource = queryFTAttente.Distinct();
                Rptr_EmployeNonApprouver.DataBind();

                /*rptr_EmployeApprouver.DataSource = null;
                rptr_EmployeApprouver.DataSourceID = null;
                rptr_EmployeApprouver.DataBind();

                rptr_EmployeApprouver.DataSource = queryFTApprouver.Distinct();
                rptr_EmployeApprouver.DataBind();*/
            }
            else
            {
                var queryFTAttente = BD.GetEmployeFtFiltered(ctx, empConnected.idEmploye, dateMin, dateMax, false);

                var queryFTApprouver = BD.GetEmployeFtFiltered(ctx, empConnected.idEmploye, dateMin, dateMax, true);

                Rptr_EmployeNonApprouver.DataSource = null;
                Rptr_EmployeNonApprouver.DataSourceID = null;
                Rptr_EmployeNonApprouver.DataBind();

                Rptr_EmployeNonApprouver.DataSource = queryFTAttente.Distinct();
                Rptr_EmployeNonApprouver.DataBind();

                /*rptr_EmployeApprouver.DataSource = null;
                rptr_EmployeApprouver.DataSourceID = null;
                rptr_EmployeApprouver.DataBind();

                rptr_EmployeApprouver.DataSource = queryFTApprouver.Distinct();
                rptr_EmployeApprouver.DataBind();*/
            }
        }

        protected string CalculerTotalHeureEmploye(object tblFT)
        {

            System.Data.Linq.EntitySet<tbl_FeuilleTemps> ft = (System.Data.Linq.EntitySet<tbl_FeuilleTemps>)tblFT;

            float totalHeure = 0;

            foreach (var item in ft)
            {
                if (item == null)
                    continue;

                if (ShowFT(item, "Attente"))
                {
                    totalHeure += item.nbHeure;
                }
            }


            return totalHeure + "h";
        }

        protected bool ShowFT(object objetFeuille, string type)
        {
            tbl_FeuilleTemps feuille = (tbl_FeuilleTemps)objetFeuille;
            bool show = true;

            //Pas approuver, on le met pas
            if (string.Compare(type, "Attente") == 0)
            {
                if ((bool)feuille.approuver)
                    return false;
            }
            else if (string.Compare(type, "Approuver") == 0)
            {
                if (!(bool)feuille.approuver)
                    return false;
            }

            string dateMinimal, dateMaximal;

            dateMinimal = Calendar1.Value;
            dateMaximal = Calendar2.Value;


            //Filtre valide
            if (!string.IsNullOrWhiteSpace(dateMinimal) && !string.IsNullOrWhiteSpace(dateMaximal))
            {
                DateTime dateMin = DateTime.Parse(dateMinimal);
                DateTime dateMax = DateTime.Parse(dateMaximal);

                //Filtre valide
                if (dateMin <= dateMax) {
                    if (feuille.dateCreation > dateMax || feuille.dateCreation < dateMin)
                        show = false;
                }
            }

            //alert_missingDate.Visible = false;

            if (empConnected.username == "admin") {
                
            } else {
                if (feuille.tbl_Projet.idEmployeResp == empConnected.idEmploye) {
                    return show;
                } else if (feuille.idEmploye == empConnected.idEmploye) {
                    return show;
                } else {
                    show = false;
                }
            }

            return show;

        }

        protected void btn_ajouterFT_Click(object sender, EventArgs e)
        {
            Response.Redirect("AjoutFT.aspx?FT=New");
        }

        protected void btn_removefilter_Click(object sender, EventArgs e)
        {
            Calendar1.Value = "1/1/1754";
            Calendar2.Value = "1/1/3000";

            RequeryFT(DateTime.Parse(Calendar1.Value), DateTime.Parse(Calendar2.Value));
        }

        protected void chbx_approved_CheckedChanged(object sender, EventArgs e)
        {
            return;
            CheckBox ch = ((CheckBox)sender);

            //rptr_EmployeApprouver.Visible = ch.Checked;
            //lbl_approved.Visible = ch.Checked;

            Rptr_EmployeNonApprouver.Visible = !ch.Checked;
            //lbl_attente.Visible = !ch.Checked;
        }

        protected int GetWeekToYear(DateTime date)
        {
            if (dimanches.Count == 0)
                return -100;

            for (int i = 1; i < dimanches.Count; i++)
            {
                //Si la date voulu vien avant la date du dimanche, l'index est le numéro de semaine
                if (date < dimanches[i].dateDimanche)
                {
                    return i;
                }
            }

            return 0;
        }

        protected List<DateTime> IntervalDateFromWeekNumber(int weekNumber)
        {
            //on commence a 1, pas zéro
            if (weekNumber == 0)
            {
                return null;
            }

            //En dehors de l'array des semainez
            if (weekNumber > dimanches.Count || dimanches.Count == 0)
            {
                return null;
            }

            int indexInList = weekNumber - 1;

            DateTime dateDebutSemaine;
            DateTime dateFinSemaine;

            if (dimanches[indexInList] != null)
            {
                dateDebutSemaine = dimanches[indexInList].dateDimanche;

                dateFinSemaine = dateDebutSemaine.AddDays(6);

                return new List<DateTime>() { dateDebutSemaine, dateFinSemaine };
            }


            return null;
        }

        protected List<tbl_FeuilleTemps> TrierFT(object choses) {
            EntitySet<tbl_FeuilleTemps> maListe = choses as EntitySet<tbl_FeuilleTemps>;

            return maListe.OrderByDescending(ft => ft.dateCreation).ToList();
        }

        protected void CheckTempsSupp(tbl_FeuilleTemps FT)
        {
            // GetWeekToYear = Get Week of year.
            int noSemaine = GetWeekToYear(DateTime.Now);
            


            // Tout les feuilles de temps de la semaine passé
            var querrySemainePrecedente = (from tbl in cdc.tbl_FeuilleTemps
                                           where tbl.idEmploye == FT.idEmploye
                                           & tbl.noSemaine == (noSemaine - 1)
                                           select tbl);


            // Get l'employé associé à la feuille de temps
            var queryEmploye = (from tbl in cdc.tbl_Employe
                                   where tbl.idEmploye == FT.idEmploye
                                   select tbl).First();

            // Get tout les feuilles de temps de la semaine actuel.
            var querrySemaineActuelle = (from tbl in cdc.tbl_FeuilleTemps
                                         where tbl.idEmploye == FT.idEmploye
                                         & tbl.noSemaine == noSemaine
                                         select tbl);

            float nbHeureSemaineEmp = (float)queryEmploye.nbHeureSemaine; //nbHeureSemaine == nombre d'heure max avant que sa tombe en temps sup

            float totalHeuresSemainePrecendante = 0;
            float nbHeureSemaineActuelle = 0;

            // Loop sur chaque feuille de la semaine passé
            foreach (tbl_FeuilleTemps feuilleDeTemps in querrySemainePrecedente)
            {

                // Si la catégorie de la feuille de temps est une banque d'heure
                // On ajuste la banque d'heure
                // SC = Sous-catégorie
                var SC = from tblSC in cdc.tbl_ProjetCat
                         where tblSC.idProjetCat == FT.idCat
                         select tblSC;
                switch (SC.First().titre)
                {
                    case "Congés fériés":
                        break;
                    case "Vacances":
                        break;
                    case "Heures accumuléees ou sans solde":
                        break;
                    case "Congés maladie":
                        break;
                    case "Congés personnels":
                        break;
                    default:
                        // Si le nombre d'heure est du temps sup
                        if (totalHeuresSemainePrecendante > nbHeureSemaineEmp)
                        {
                            totalHeuresSemainePrecendante += (feuilleDeTemps.nbHeure * 1.5f);
                        }
                        else if (totalHeuresSemainePrecendante + feuilleDeTemps.nbHeure > nbHeureSemaineEmp)
                        {
                            float tempsEtDemi = feuilleDeTemps.nbHeure - (nbHeureSemaineEmp - totalHeuresSemainePrecendante);
                            totalHeuresSemainePrecendante = nbHeureSemaineEmp + tempsEtDemi * 1.5f;
                        }
                        else
                        {
                            totalHeuresSemainePrecendante += feuilleDeTemps.nbHeure;
                        }
                        break;
                }

                
            }

            foreach (tbl_FeuilleTemps tbl in querrySemaineActuelle)
            {
                // Si la catégorie de la feuille de temps est une banque d'heure
                // On ajuste la banque d'heure
                // SC = Sous-catégorie
                var SC = from tblSC in cdc.tbl_ProjetCat
                         where tblSC.idProjetCat == tbl.idCat
                         select tblSC;
                switch (SC.First().titre)
                {
                    case "Congés fériés":
                        break;
                    case "Vacances":
                        break;
                    case "Heures accumuléees ou sans solde":
                        break;
                    case "Congés maladie":
                        break;
                    case "Congés personnels":
                        break;
                    default:
                        if (nbHeureSemaineActuelle > nbHeureSemaineEmp)
                        {
                            nbHeureSemaineActuelle += (tbl.nbHeure * 1.5f);
                        }
                        else if (nbHeureSemaineActuelle + tbl.nbHeure > nbHeureSemaineEmp)
                        {
                            float tempsEtDemi = tbl.nbHeure - (nbHeureSemaineEmp - nbHeureSemaineActuelle);
                            nbHeureSemaineActuelle = nbHeureSemaineEmp + tempsEtDemi * 1.5f;
                        }
                        else
                        {
                            nbHeureSemaineActuelle += tbl.nbHeure;
                        }
                        break;
                }

                
            }

            // Avant: 35


            if (totalHeuresSemainePrecendante > nbHeureSemaineEmp)
            {
                var queryTempsSupActuel = from tbl_tempSup in cdc.tbl_TempsSupp
                             where tbl_tempSup.idEmploye == FT.idEmploye
                             & tbl_tempSup.noSemaine == (noSemaine - 1)
                             select tbl_tempSup;


                var queryBanqueHeure = from tbl in cdc.tbl_BanqueHeure
                               where tbl.idTypeHeure == 1
                               & tbl.idEmploye == FT.idEmploye
                               select tbl;

                float nbHeureBH;
                if (queryTempsSupActuel.Count() > 0)
                {
                    nbHeureBH = (float)queryTempsSupActuel.First().tempsSupp;
                    // Si on a besoin d'ajouter du temps dans la banque d'heure
                    if (nbHeureBH < totalHeuresSemainePrecendante)
                    {
                        // Ajoute le nouveau temps supplémentaire
                        queryBanqueHeure.First().nbHeure += totalHeuresSemainePrecendante - nbHeureBH;
                    }

                    cdc.tbl_TempsSupp.DeleteOnSubmit(queryTempsSupActuel.First());
                }
                else
                {
                    queryBanqueHeure.First().nbHeure += totalHeuresSemainePrecendante - nbHeureSemaineEmp;
                }

                tbl_TempsSupp tblTemp = new tbl_TempsSupp();
                tblTemp.idEmploye = FT.idEmploye;
                tblTemp.noSemaine = noSemaine - 1;
                tblTemp.tempsSupp = totalHeuresSemainePrecendante;

                cdc.tbl_TempsSupp.InsertOnSubmit(tblTemp);

                cdc.SubmitChanges();
            }

            if (nbHeureSemaineActuelle > nbHeureSemaineEmp)
            {
                var querry = from tbl in cdc.tbl_TempsSupp
                             where tbl.idEmploye == FT.idEmploye
                             & tbl.noSemaine == noSemaine
                             select tbl;

                float nbHeureBH;

                var querryBH = from tbl in cdc.tbl_BanqueHeure
                               where tbl.idTypeHeure == 1
                               & tbl.idEmploye == FT.idEmploye
                               select tbl;

                if (querry.Count() > 0)
                {
                    nbHeureBH = (float)querry.First().tempsSupp;
                    if (nbHeureBH < nbHeureSemaineActuelle)
                    {
                        querryBH.First().nbHeure += nbHeureSemaineActuelle - nbHeureBH;
                    }

                    cdc.tbl_TempsSupp.DeleteOnSubmit(querry.First());
                }
                else
                {
                    querryBH.First().nbHeure += nbHeureSemaineActuelle - nbHeureSemaineEmp;
                }

                tbl_TempsSupp tblTemp = new tbl_TempsSupp();
                tblTemp.idEmploye = FT.idEmploye;
                tblTemp.noSemaine = noSemaine;
                tblTemp.tempsSupp = nbHeureSemaineActuelle;

                cdc.tbl_TempsSupp.InsertOnSubmit(tblTemp);

                cdc.SubmitChanges();
            }

        }
    }
}


        
    
