using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UrbanEco
{
    public partial class GestionFeuilleTemps : System.Web.UI.Page
    {
        CoecoDataContext cdc = new CoecoDataContext();

        static List<tbl_PremierDimanche> dimanches = new List<tbl_PremierDimanche>();

        protected string formatRemoveHour(object date)
        {
            DateTime dt = (DateTime)date;
            return dt.ToString().Split(' ')[0];

        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CoecoDataContext ctx = new CoecoDataContext();
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

                tbl_Employe empConnected = BD.GetUserConnected(ctx, Request.Cookies["userInfo"]);

                DateTime dateMin = DateTime.Parse(Calendar1.Value);
                DateTime dateMax = DateTime.Parse(Calendar2.Value);

                if (empConnected.username == "admin")
                {
                    var queryFTAttente = BD.GetAllEmployeFtFiltered(ctx, dateMin, dateMax, false);

                    var queryFTApprouver = BD.GetAllEmployeFtFiltered(ctx, dateMin, dateMax, true);

                    Rptr_EmployeNonApprouver.DataSource = null;
                    Rptr_EmployeNonApprouver.DataSourceID = null;
                    Rptr_EmployeNonApprouver.DataBind();

                    Rptr_EmployeNonApprouver.DataSource = queryFTAttente;
                    Rptr_EmployeNonApprouver.DataBind();


                    rptr_EmployeApprouver.DataSource = null;
                    rptr_EmployeApprouver.DataSourceID = null;
                    rptr_EmployeApprouver.DataBind();

                    rptr_EmployeApprouver.DataSource = queryFTApprouver;
                    rptr_EmployeApprouver.DataBind();
                }
                else
                {
                    var queryFTAttente = BD.GetEmployeFtFiltered(ctx, empConnected.idEmploye, dateMin, dateMax, false);

                    var queryFTApprouver = BD.GetEmployeFtFiltered(ctx, empConnected.idEmploye, dateMin, dateMax, true);

                    Rptr_EmployeNonApprouver.DataSource = null;
                    Rptr_EmployeNonApprouver.DataSourceID = null;
                    Rptr_EmployeNonApprouver.DataBind();

                    Rptr_EmployeNonApprouver.DataSource = queryFTAttente;
                    Rptr_EmployeNonApprouver.DataBind();

                    rptr_EmployeApprouver.DataSource = null;
                    rptr_EmployeApprouver.DataSourceID = null;
                    rptr_EmployeApprouver.DataBind();

                    rptr_EmployeApprouver.DataSource = queryFTApprouver;
                    rptr_EmployeApprouver.DataBind();

                }
            }
        }

        public bool isVisible()
        {
            CoecoDataContext ctx = new CoecoDataContext();
            tbl_Employe user = BD.GetUserConnected(ctx, Request.Cookies["userInfo"]);
            if (user.username == "admin")
            {
                return true;
            }

            return false;
        }

        protected void Btn_Modif_Click(object sender, EventArgs e)
        {

        }

        protected void Btn_Approve_Click(object sender, EventArgs e)
        {
            CoecoDataContext ctx = new CoecoDataContext();

            ImageButton temp = (sender as ImageButton);
            int idFeuille = int.Parse(temp.CommandArgument);

            tbl_FeuilleTemps FT = BD.GetFeuilleTemps(ctx, idFeuille);

            CheckTempsSupp(FT);

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
                     select tblFT;

            foreach (var FTemp in FT)
            {
                CheckTempsSupp(FTemp);
                FTemp.approuver = true;
                cdc.SubmitChanges();
                SwitchTypeBHCongés(FTemp);
            }

            Response.Redirect(Request.RawUrl);
        }

        protected void SwitchTypeBHCongés(tbl_FeuilleTemps FT)
        {
            try
            {

                var SC = from tblSC in cdc.tbl_ProjetCat
                         where tblSC.idProjetCat == FT.idCat
                         select tblSC;
                switch (SC.First().titre)
                {
                    case "Congé fériés":
                        EnleverHeuresBH(2, FT);
                        break;
                    case "Congé vacances":
                        EnleverHeuresBH(4, FT);
                        break;
                    case "Temps supplémentaires":
                        EnleverHeuresBH(1, FT);
                        break;
                    case "Congés maladies":
                        EnleverHeuresBH(5, FT);
                        break;
                    case "Congé personnelle":
                        EnleverHeuresBH(3, FT);
                        break;
                    default:
                        break;
                }
            }
            catch (Exception e)
            {

            }
        }

        protected void EnleverHeuresBH(int idTypeHeure, tbl_FeuilleTemps FT)
        {
            var BH = from tblBH in cdc.tbl_BanqueHeure
                     where tblBH.idEmploye == FT.idEmploye
                     & tblBH.idTypeHeure == idTypeHeure
                     select tblBH;
            BH.First().nbHeure -= FT.nbHeure;
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
            var FT = from tblFT in cdc.tbl_FeuilleTemps
                     select tblFT;

            foreach (var FTemp in FT)
            {
                CheckTempsSupp(FTemp);
                FTemp.approuver = true;
                SwitchTypeBHCongés(FTemp);
            }

            /* cdc.tbl_FeuilleTemps.DeleteAllOnSubmit(FT);
             cdc.tbl_FeuilleTemps.InsertAllOnSubmit(FT);*/

            cdc.SubmitChanges();

            Response.Redirect(Request.RawUrl);
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

        }

        protected void btnCloseOpen_Click(object sender, EventArgs e)
        {
            //En pause bouton pour ouvrir

        }

        protected void btnOpen_Click(object sender, EventArgs e)
        {

        }

        protected void btnOpenTest_Click(object sender, EventArgs e)
        {

        }

        protected void Btn_Modif_Click1(object sender, ImageClickEventArgs e)
        {
            ImageButton ib = (ImageButton)sender;

            Response.Redirect("AjoutFT.aspx?FT=" + ib.CommandArgument);
        }

        protected void Btn_ApproveTout_Click1(object sender, EventArgs e)
        {

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

            tbl_Employe empConnected = BD.GetUserConnected(ctx, Request.Cookies["userInfo"]);

            if (empConnected.username == "admin")
            {

                var queryFTAttente = BD.GetAllEmployeFtFiltered(ctx, dateMin, dateMax, false);

                var queryFTApprouver = BD.GetAllEmployeFtFiltered(ctx, dateMin, dateMax, true);

                Rptr_EmployeNonApprouver.DataSource = null;
                Rptr_EmployeNonApprouver.DataSourceID = null;
                Rptr_EmployeNonApprouver.DataBind();

                Rptr_EmployeNonApprouver.DataSource = queryFTAttente.Distinct();
                Rptr_EmployeNonApprouver.DataBind();

                rptr_EmployeApprouver.DataSource = null;
                rptr_EmployeApprouver.DataSourceID = null;
                rptr_EmployeApprouver.DataBind();

                rptr_EmployeApprouver.DataSource = queryFTApprouver.Distinct();
                rptr_EmployeApprouver.DataBind();
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

                rptr_EmployeApprouver.DataSource = null;
                rptr_EmployeApprouver.DataSourceID = null;
                rptr_EmployeApprouver.DataBind();

                rptr_EmployeApprouver.DataSource = queryFTApprouver.Distinct();
                rptr_EmployeApprouver.DataBind();
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

            //Filtre non valide
            if (string.IsNullOrWhiteSpace(dateMinimal) || string.IsNullOrWhiteSpace(dateMaximal))
            {
                //alert_missingDate.Visible = true;
                return true;
            }

            //alert_missingDate.Visible = false;

            DateTime dateMin = DateTime.Parse(dateMinimal);
            DateTime dateMax = DateTime.Parse(dateMaximal);

            //Filtre non valide encore
            if (dateMin > dateMax)
            {
                return true;
            }

            if (feuille.dateCreation > dateMax || feuille.dateCreation < dateMin)
                return false;

            return true;
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
            CheckBox ch = ((CheckBox)sender);

            rptr_EmployeApprouver.Visible = ch.Checked;
            lbl_approved.Visible = ch.Checked;

            Rptr_EmployeNonApprouver.Visible = !ch.Checked;
            lbl_attente.Visible = !ch.Checked;
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


        protected void CheckTempsSupp(tbl_FeuilleTemps FT)
        {
            int noSemaine = GetWeekToYear(DateTime.Now);

            //float tempsSupp;

            //  int noSemaine = GetWeekToYear(DateTime.Now);

            //var querryTempsSupp = from tbl in cdc.tbl_TempsSupp
            //                      where tbl.idEmploye == FT.idEmploye
            //                      & tbl.noSemaine == noSemaine
            //                      select tbl;

            //if (querryTempsSupp.Count() > 0)
            //{
            //    tempsSupp = float.Parse(querryTempsSupp.First().tempsSupp.ToString());
            //    querryTempsSupp.First().tempsSupp += FT.nbHeure;

            //}
            //else
            //{
            //    tbl_TempsSupp tb = new tbl_TempsSupp();
            //    tb.noSemaine = noSemaine;
            //    tb.idEmploye = FT.idEmploye;
            //    tb.tempsSupp = FT.nbHeure;
            //    cdc.tbl_TempsSupp.InsertOnSubmit(tb);
            //}

            //cdc.SubmitChanges();





            var querrySemainePrecedente = (from tbl in cdc.tbl_FeuilleTemps
                                           where tbl.idEmploye == FT.idEmploye
                                           & tbl.noSemaine == (noSemaine - 1)
                                           select tbl);



            var querryNbSemaine = (from tbl in cdc.tbl_Employe
                                   where tbl.idEmploye == FT.idEmploye
                                   select tbl).First();

            var querrySemaineActuelle = (from tbl in cdc.tbl_FeuilleTemps
                                         where tbl.idEmploye == FT.idEmploye
                                         & tbl.noSemaine == noSemaine
                                         select tbl);

            float nbHeureSemaineEmp = 0;

            if (querryNbSemaine.idTypeEmpl == 1)
            {
                nbHeureSemaineEmp = (float)querryNbSemaine.nbHeureSemaine;
            }
            if (querryNbSemaine.idTypeEmpl == 2)
            {
                nbHeureSemaineEmp = 40;
            }


            float nbHeureSemainePrecedente = 0;
            float nbHeureSemaineActuelle = 0;

            foreach (tbl_FeuilleTemps tbl in querrySemainePrecedente)
            {
                if (nbHeureSemainePrecedente + tbl.nbHeure > nbHeureSemaineEmp)
                {
                    float tempsEtDemi = tbl.nbHeure - (nbHeureSemaineEmp - nbHeureSemainePrecedente);
                    nbHeureSemainePrecedente = nbHeureSemaineEmp + tempsEtDemi * 1.5f;
                }
                else if (nbHeureSemainePrecedente > nbHeureSemaineEmp)
                {
                    nbHeureSemainePrecedente += (tbl.nbHeure * 1.5f);
                }
                else
                {
                    nbHeureSemainePrecedente += tbl.nbHeure;
                }
            }

            foreach (tbl_FeuilleTemps tbl in querrySemaineActuelle)
            {
                if (nbHeureSemaineActuelle + tbl.nbHeure > nbHeureSemaineEmp)
                {
                    float tempsEtDemi = tbl.nbHeure - (nbHeureSemaineEmp - nbHeureSemaineActuelle);
                    nbHeureSemaineActuelle = nbHeureSemaineEmp + tempsEtDemi * 1.5f;
                }
                else if (nbHeureSemaineActuelle > nbHeureSemaineEmp)
                {
                    nbHeureSemaineActuelle += (tbl.nbHeure * 1.5f);
                }
                else
                {
                    nbHeureSemaineActuelle += tbl.nbHeure;
                }
            }

            if (nbHeureSemainePrecedente > nbHeureSemaineEmp)
            {
                var querry = from tbl in cdc.tbl_TempsSupp
                             where tbl.idEmploye == FT.idEmploye
                             & tbl.noSemaine == (noSemaine - 1)
                             select tbl;

                float nbHeureBH;

                var querryBH = from tbl in cdc.tbl_BanqueHeure
                               where tbl.idTypeHeure == 1
                               & tbl.idEmploye == FT.idEmploye
                               select tbl;

                if (querry.Count() > 0)
                {
                    nbHeureBH = (float)querry.First().tempsSupp;
                    if (nbHeureBH < nbHeureSemainePrecedente)
                    {
                        querryBH.First().nbHeure += nbHeureSemainePrecedente - nbHeureBH;
                    }

                    cdc.tbl_TempsSupp.DeleteOnSubmit(querry.First());
                }
                else
                {
                    querryBH.First().nbHeure += nbHeureSemainePrecedente - nbHeureSemaineEmp;
                }

                tbl_TempsSupp tblTemp = new tbl_TempsSupp();
                tblTemp.idEmploye = FT.idEmploye;
                tblTemp.noSemaine = noSemaine - 1;
                tblTemp.tempsSupp = nbHeureSemainePrecedente;

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


        
    
