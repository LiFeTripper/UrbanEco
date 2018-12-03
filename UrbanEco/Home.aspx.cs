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
            distinct = new List<Distinct>();
            Page.MaintainScrollPositionOnPostBack = true;

            if(!IsPostBack)
            {
                string username = Request.Cookies["userinfo"].Value;

                CoecoDataContext ctx = new CoecoDataContext();

                var emp = (from tbl in ctx.tbl_Employe
                           where tbl.username.Equals(username)
                           select tbl).First();


                Lbl_HelloUser.InnerText = "Bonjour " + emp.nom + " " + emp.prenom;

                tbl_Employes = (from tbl in ctx.tbl_Employe
                                    select tbl).ToList();


                var queryProjetResponsable = from tbl in ctx.tbl_Projet
                                             where tbl.idEmployeResp == emp.idEmploye || (emp.username.Equals("admin"))
                                             select tbl;

                if (queryProjetResponsable.Count() == 0)
                {
                    rpt_employe.Visible = false;
                    return;
                }

                List<int> idProjetsResp = new List<int>();

                foreach (var item in queryProjetResponsable.ToList())
                {
                    idProjetsResp.Add(item.idProjet);
                }

                //Feuille de temps en attente et contenu dans la liste de l'employé responsable
                var queryFT = from tbl in ctx.tbl_FeuilleTemps
                              where tbl.approuver.Equals(false) && idProjetsResp.Contains(tbl.idProjet)
                              select tbl;

                List<int> idEmpFt = new List<int>();

                foreach (var item in queryFT.ToList())
                {
                    if(!idEmpFt.Contains(item.idEmploye))
                    {
                        idEmpFt.Add(item.idEmploye);
                    }                  
                }

                var queryEmp = (from tbl in ctx.tbl_Employe
                                where idEmpFt.Contains(tbl.idEmploye)
                                select tbl).Distinct();


               

                rpt_employe.DataSource = queryProjetResponsable;
                rpt_employe.DataBind();
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

                //if (ShowFT(item.approuver, item.dateCreation, "Attente"))
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
                    totalHeure += item.nbHeure;
                
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
    }
}