using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace UrbanEco
{
    public partial class Home : System.Web.UI.Page
    {

        static List<tbl_Employe> tbl_Employes = new List<tbl_Employe>();

        static List<tbl_PremierDimanche> dimanches = new List<tbl_PremierDimanche>();
        static List<DateTime> weekInterval = new List<DateTime>();


        public struct Distinct
        {
            public int idProjet;
            public int idEmploye;
            public string nomEmploye;
            public string totalHeure;
        }

        static List<Distinct> distinct = new List<Distinct>();

        protected void Page_Load(object sender, EventArgs e)
        {

            Page.MaintainScrollPositionOnPostBack = true;

            if(!IsPostBack)
            {
                CoecoDataContext ctx = new CoecoDataContext();

                //Premier dimanche
                var queryDimanche = from tbl in ctx.tbl_PremierDimanche
                                    select tbl;

                if (queryDimanche.Count() > 0)
                {
                    dimanches = queryDimanche.ToList();
                }


                tbl_Employe empConnected = BD.GetUserConnected(ctx, Request.Cookies["userInfo"]);

                //tbl_Employe empConnected = BD.GetEmploye(ctx, 8);

                if(empConnected.nom == "" || empConnected.nom == null)
                {
                    Lbl_HelloUser.InnerText = "Bonjour " + empConnected.prenom;
                }
                else
                {
                    Lbl_HelloUser.InnerText = "Bonjour " + empConnected.prenom + " " + empConnected.nom;
                }
                
                


                DateTime today = DateTime.Today;

                int weekNB = GetWeekToYear(today);

                if (weekNB != -100)
                {
                    if (weekNB > 0)
                        weekNB--;

                    weekInterval = IntervalDateFromWeekNumber(weekNB);

                    //lbl_resume.InnerText = "Résumé de la semaine du " + Layout.GetDateFormated(weekInterval[0]) + " au " + Layout.GetDateFormated(today);
                }
                else
                {
                    

                    //Admin connecté
                    if (empConnected.username.Equals("admin"))
                        {
                        if (dimanches.Count == 0)
                        {
                            alert_danger_sunday.Visible = true;
                        }
                        else if (today >= dimanches[dimanches.Count - 1].dateDimanche)
                        {
                            alert_danger_sunday.Visible = true;
                        }
                        //Décembre ou Janvier
                        else if (today.Month == 12 || today.Month == 1)
                        {
                            alert_warning_sunday.Visible = true;
                        }
                    }
                }
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

               // if ()
                {
                    totalHeure += item.nbHeure;
                }
            }


            return totalHeure + "h";
        }

        protected string CalculerTotalHeureEmploye(object idEmp, object idProjet)
        {

            tbl_Employe emp = null;

            foreach (var item in tbl_Employes)
            {
                if (item.idEmploye == (int)idEmp)
                    emp = item;
            }

            if (emp == null)
                return "";

            List<tbl_FeuilleTemps> ft = new List<tbl_FeuilleTemps>();

            foreach (var item in emp.tbl_FeuilleTemps)
            {
                if(item.idProjet == (int)idProjet)
                {
                    ft.Add(item);
                }
            }

            Distinct dist = new Distinct();
            dist.idProjet = (int)idProjet;
            dist.idEmploye = (int)idEmp;

            foreach (var item in distinct)
            {
                if(dist.idEmploye == item.idEmploye && dist.idProjet == item.idProjet)
                {
                    return "";
                }
            }

            distinct.Add(dist);

            float totalHeure = 0;

            foreach (var item in ft)
            {
                if (item == null)
                    continue;


                if(weekInterval != null && weekInterval.Count == 0)
                {

                    DateTime today = DateTime.Today;

                    int weekNB = GetWeekToYear(today);

                    if (weekNB != -100)
                    {
                        if (weekNB > 0)
                            weekNB--;

                        weekInterval = IntervalDateFromWeekNumber(weekNB);
                        if (weekInterval == null)
                            return null;
                        
                    }
                }
                if(weekInterval != null && weekInterval.Count == 0)
                {
                    totalHeure += item.nbHeure;
                }
                else if (weekInterval != null && item.dateCreation > weekInterval[0])
                {
                    totalHeure += item.nbHeure;
                }
            }


            return totalHeure + "h";
        }

        protected bool InList(object idEmp, object idProjet)
        {
            foreach (var item in distinct)
            {
                if (item.idEmploye == (int)idEmp && item.idProjet == (int)idProjet)
                    return false;
            }

            return true;
        }

        protected string GetEmployeName(object idEmp)
        {
            int id = (int)idEmp;

            foreach (var item in tbl_Employes)
            {
                if (item.idEmploye == id)
                    return item.nom + " " + item.prenom;
            }

            return "";
        }

        protected string formatRemoveHour(object date)
        {
            DateTime dt = (DateTime)date;
            return dt.ToString().Split(' ')[0];

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

        protected void btn_download_Click(object sender, EventArgs e)
        {
            Response.ContentType = "application/pdf";
            Response.AppendHeader("Content-Disposition", "attachment; filename=Documents_Formation_Utilisateur.pdf");
            Response.TransmitFile(Server.MapPath("~/Resources/Documents_Formation_Utilisateur.pdf"));
            Response.End();
        }
    }
}