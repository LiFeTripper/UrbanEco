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
            if(!IsPostBack)
            {

                Page.MaintainScrollPositionOnPostBack = true;

                //Premier dimanche
                var queryDimanche = from tbl in cdc.tbl_PremierDimanche
                                    select tbl;

                if (queryDimanche.Count() > 0)
                {
                    dimanches = queryDimanche.ToList();                   
                }

                List < tbl_Employe > listTable = new List<tbl_Employe>();

                Calendar1.Value = "1/1/1754";
                Calendar2.Value = "1/1/3000";
                

                if (Layout.GetUserConnected().username == "admin")
                {


                    var queryFTAttente = from tblE in cdc.tbl_Employe
                                         join tblFT in cdc.tbl_FeuilleTemps on tblE.idEmploye equals tblFT.idEmploye
                                         where tblFT.approuver.Equals(false)
                                         & (tblFT.dateCreation > DateTime.Parse(Calendar1.Value))
                                         & (tblFT.dateCreation < DateTime.Parse(Calendar2.Value))
                                         orderby tblFT.dateCreation descending

                                         select tblE;

                    var queryFTApprouver = from tblE in cdc.tbl_Employe
                                           join tblFT in cdc.tbl_FeuilleTemps on tblE.idEmploye equals tblFT.idEmploye
                                           where tblFT.approuver == true
                                           & (tblFT.dateCreation > DateTime.Parse(Calendar1.Value))
                                           & (tblFT.dateCreation < DateTime.Parse(Calendar2.Value))
                                           orderby tblFT.dateCreation descending
                                           select tblE;

                    Rptr_EmployeNonApprouver.DataSource = null;
                    Rptr_EmployeNonApprouver.DataSourceID = null;
                    Rptr_EmployeNonApprouver.DataBind();

                    Rptr_EmployeNonApprouver.DataSource = queryFTAttente.Distinct();
                    Rptr_EmployeNonApprouver.DataBind();

                    List<tbl_Employe> listTableA = new List<tbl_Employe>();



                    rptr_EmployeApprouver.DataSource = null;
                    rptr_EmployeApprouver.DataSourceID = null;
                    rptr_EmployeApprouver.DataBind();

                    rptr_EmployeApprouver.DataSource = queryFTApprouver.Distinct();
                    rptr_EmployeApprouver.DataBind();
                }
                else
                {
                    var queryFTAttente = from tblE in cdc.tbl_Employe
                                         join tblFT in cdc.tbl_FeuilleTemps on tblE.idEmploye equals tblFT.idEmploye
                                         where tblFT.approuver.Equals(false)
                                         & (tblFT.dateCreation > DateTime.Parse(Calendar1.Value))
                                         & (tblFT.dateCreation < DateTime.Parse(Calendar2.Value))
                                         & tblE.idEmploye == Layout.GetUserConnected().idEmploye
                                         orderby tblFT.dateCreation descending

                                         select tblE;

                    var queryFTApprouver = from tblE in cdc.tbl_Employe
                                           join tblFT in cdc.tbl_FeuilleTemps on tblE.idEmploye equals tblFT.idEmploye
                                           where tblFT.approuver == true
                                           & (tblFT.dateCreation > DateTime.Parse(Calendar1.Value))
                                           & (tblFT.dateCreation < DateTime.Parse(Calendar2.Value))
                                           & tblE.idEmploye == Layout.GetUserConnected().idEmploye
                                           orderby tblFT.dateCreation descending
                                           select tblE;

                    Rptr_EmployeNonApprouver.DataSource = null;
                    Rptr_EmployeNonApprouver.DataSourceID = null;
                    Rptr_EmployeNonApprouver.DataBind();

                    Rptr_EmployeNonApprouver.DataSource = queryFTAttente.Distinct();
                    Rptr_EmployeNonApprouver.DataBind();

                    List<tbl_Employe> listTableA = new List<tbl_Employe>();



                    rptr_EmployeApprouver.DataSource = null;
                    rptr_EmployeApprouver.DataSourceID = null;
                    rptr_EmployeApprouver.DataBind();

                    rptr_EmployeApprouver.DataSource = queryFTApprouver.Distinct();
                    rptr_EmployeApprouver.DataBind();

                    

                    
                    

                }

                
                
            }
        }

        public bool isVisible()
        {
            if(Layout.GetUserConnected().username == "admin")
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
            ImageButton temp = (sender as ImageButton);
            int idFeuille = int.Parse(temp.CommandArgument);

            var FT = from tblFT in cdc.tbl_FeuilleTemps
                     where tblFT.idFeuille == idFeuille
                     select tblFT;

            CheckTempsSupp(FT.First().idEmploye);

            FT.First<tbl_FeuilleTemps>().approuver = true;
            SwitchTypeBHCongés(FT.First());

            cdc.tbl_FeuilleTemps.DeleteOnSubmit(FT.First<tbl_FeuilleTemps>());
            cdc.tbl_FeuilleTemps.InsertOnSubmit(FT.First<tbl_FeuilleTemps>());

            cdc.SubmitChanges();

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

            foreach(var FTemp in FT)
            {
                CheckTempsSupp(FTemp.idEmploye);
                FTemp.approuver = true;
                SwitchTypeBHCongés(FTemp);


                }

            cdc.tbl_FeuilleTemps.DeleteAllOnSubmit(FT);
            cdc.tbl_FeuilleTemps.InsertAllOnSubmit(FT);

            cdc.SubmitChanges();

            Response.Redirect(Request.RawUrl);
        }

        protected void SwitchTypeBHCongés(tbl_FeuilleTemps FT)
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
                CheckTempsSupp(FTemp.idEmploye);
                FTemp.approuver = true;
                SwitchTypeBHCongés(FTemp);
            }

            cdc.tbl_FeuilleTemps.DeleteAllOnSubmit(FT);
            cdc.tbl_FeuilleTemps.InsertAllOnSubmit(FT);

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

            if(string.IsNullOrWhiteSpace(dateMinimal) || string.IsNullOrWhiteSpace(dateMaximal))
            {
                alert_missingDate.Visible = true;
                return;
            }

            alert_missingDate.Visible = false;

            DateTime dateMin = DateTime.Parse(dateMinimal);
            DateTime dateMax = DateTime.Parse(dateMaximal);

            if(dateMin > dateMax)
            {
                alert_dateOrder.Visible = true;
                return;
            }

            alert_dateOrder.Visible = false;


            RequeryFT(dateMin, dateMax);
           
        }

        void RequeryFT(DateTime dateMin, DateTime dateMax)
        {
            if (Layout.GetUserConnected().username == "admin")
            {

                var queryFTAttente = from tblE in cdc.tbl_Employe
                                     join tblFT in cdc.tbl_FeuilleTemps on tblE.idEmploye equals tblFT.idEmploye
                                     where tblFT.approuver.Equals(false)
                                     & (tblFT.dateCreation >= dateMin)
                                     & (tblFT.dateCreation <= dateMax)
                                     orderby tblFT.dateCreation descending

                                     select tblE;

                var queryFTApprouver = from tblE in cdc.tbl_Employe
                                       join tblFT in cdc.tbl_FeuilleTemps on tblE.idEmploye equals tblFT.idEmploye
                                       where tblFT.approuver == true
                                       & (tblFT.dateCreation >= dateMin)
                                 & (tblFT.dateCreation <= dateMax)
                                       orderby tblFT.dateCreation descending
                                       select tblE;

                Rptr_EmployeNonApprouver.DataSource = null;
                Rptr_EmployeNonApprouver.DataSourceID = null;
                Rptr_EmployeNonApprouver.DataBind();

                Rptr_EmployeNonApprouver.DataSource = queryFTAttente.Distinct();
                Rptr_EmployeNonApprouver.DataBind();

                List<tbl_Employe> listTableA = new List<tbl_Employe>();



                rptr_EmployeApprouver.DataSource = null;
                rptr_EmployeApprouver.DataSourceID = null;
                rptr_EmployeApprouver.DataBind();

                rptr_EmployeApprouver.DataSource = queryFTApprouver.Distinct();
                rptr_EmployeApprouver.DataBind();
            }
            else
            {
                var queryFTAttente = from tblE in cdc.tbl_Employe
                                     join tblFT in cdc.tbl_FeuilleTemps on tblE.idEmploye equals tblFT.idEmploye
                                     where tblFT.approuver.Equals(false)
                                     & (tblFT.dateCreation >= dateMin)
                                 & (tblFT.dateCreation <= dateMax)
                                     & tblE.idEmploye == Layout.GetUserConnected().idEmploye
                                     orderby tblFT.dateCreation descending

                                     select tblE;

                var queryFTApprouver = from tblE in cdc.tbl_Employe
                                       join tblFT in cdc.tbl_FeuilleTemps on tblE.idEmploye equals tblFT.idEmploye
                                       where tblFT.approuver == true
                                       & (tblFT.dateCreation >= dateMin)
                                 & (tblFT.dateCreation <= dateMax)
                                       & tblE.idEmploye == Layout.GetUserConnected().idEmploye
                                       orderby tblFT.dateCreation descending
                                       select tblE;

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

                if (ShowFT(item.approuver, item.dateCreation, "Attente"))
                {
                    totalHeure += item.nbHeure;
                }
            }

 
            return totalHeure + "h";
        }

        protected bool ShowFT(object approuver, object date, string type)
        {
            //Pas approuver, on le met pas
            if(string.Compare(type, "Attente") == 0)
            {
                if ((bool)approuver)
                    return false;
            }
            else if (string.Compare(type, "Approuver") == 0)
            {
                if (!(bool)approuver)
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

            if ((DateTime)date > dateMax || (DateTime)date < dateMin)
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
                if(date < dimanches[i].dateDimanche)
                {
                    return i;
                }
            }

            return 0;
        }

        protected List<DateTime> IntervalDateFromWeekNumber(int weekNumber)
        {
            //on commence a 1, pas zéro
            if(weekNumber == 0)
            {
                return null;
            }

            //En dehors de l'array des semainez
            if(weekNumber > dimanches.Count || dimanches.Count == 0)
            {
                return null;
            }

            int indexInList = weekNumber - 1;

            DateTime dateDebutSemaine;
            DateTime dateFinSemaine;

            if(dimanches[indexInList] != null)
            {
                dateDebutSemaine = dimanches[indexInList].dateDimanche;

                dateFinSemaine = dateDebutSemaine.AddDays(6);

                return new List<DateTime>() { dateDebutSemaine, dateFinSemaine };
            }


            return null;
        }


        protected void CheckTempsSupp(int idEmp)
        {
            int noSemaine = GetWeekToYear(DateTime.Now);

            var querrySemainePrecedente = (from tbl in cdc.tbl_FeuilleTemps
                          where tbl.idEmploye == idEmp
                          & tbl.noSemaine == (noSemaine - 1)
                          select tbl);

            var querrySemaineActuelle = (from tbl in cdc.tbl_FeuilleTemps
                                           where tbl.idEmploye == idEmp
                                           & tbl.noSemaine == noSemaine
                                           select tbl);


            float nbHeureSemainePrecedente = 0;
            float nbHeureSemaineActuelle = 0;

            foreach (tbl_FeuilleTemps tbl in querrySemainePrecedente)
            {
                nbHeureSemainePrecedente += tbl.nbHeure;
            }

            foreach (tbl_FeuilleTemps tbl in querrySemaineActuelle)
            {
                nbHeureSemaineActuelle += tbl.nbHeure;
            }

            if (nbHeureSemainePrecedente > 35)
            {
                var querry = from tbl in cdc.tbl_TempsSupp
                             where tbl.idEmploye == idEmp
                             & tbl.noSemaine == (noSemaine - 1)
                             select tbl;

                float nbHeureBH;

                var querryBH = from tbl in cdc.tbl_BanqueHeure
                               where tbl.idTypeHeure == 1
                               & tbl.idEmploye == idEmp
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
                    querryBH.First().nbHeure += nbHeureSemainePrecedente - 35;
                }

                tbl_TempsSupp tblTemp = new tbl_TempsSupp();
                tblTemp.idEmploye = idEmp;
                tblTemp.noSemaine = noSemaine - 1;
                tblTemp.tempsSupp = nbHeureSemainePrecedente;

                cdc.tbl_TempsSupp.InsertOnSubmit(tblTemp);

                cdc.SubmitChanges();
            }

            if (nbHeureSemaineActuelle > 35)
            {
                var querry = from tbl in cdc.tbl_TempsSupp
                             where tbl.idEmploye == idEmp
                             & tbl.noSemaine == noSemaine
                             select tbl;

                float nbHeureBH;

                var querryBH = from tbl in cdc.tbl_BanqueHeure
                               where tbl.idTypeHeure == 1
                               & tbl.idEmploye == idEmp
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
                    querryBH.First().nbHeure += nbHeureSemaineActuelle - 35;
                }

                tbl_TempsSupp tblTemp = new tbl_TempsSupp();
                tblTemp.idEmploye = idEmp;
                tblTemp.noSemaine = noSemaine;
                tblTemp.tempsSupp = nbHeureSemaineActuelle;

                cdc.tbl_TempsSupp.InsertOnSubmit(tblTemp);

                cdc.SubmitChanges();
            }

        }


        
    }
}