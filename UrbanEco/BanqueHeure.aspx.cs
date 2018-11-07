using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Linq;

namespace UrbanEco
{
    public partial class BanqueHeure : System.Web.UI.Page
    {
        CoecoDataContext cdc = new CoecoDataContext();
        

        protected void Page_Load(object sender, EventArgs e)
        {
            List<string> listEmp = new List<string>();

            var tblEmp = from tbl in cdc.tbl_Employe
                         where tbl.username != "admin"
                         select tbl;

            foreach(var n in tblEmp)
            {
                listEmp.Add(n.nom + "," + n.prenom);
            }

            ddl_empBH.DataSource = listEmp;
            ddl_empBH.DataBind();
            
        }

        protected void btn_modifBH_Click(object sender, EventArgs e)
        {
            if(ddl_empBH.Text != "")
            {
                if(tbl_BH.Enabled == false)
                {
                    tbl_BH.Enabled = true;
                    btn_modifBH.Text = "Désactiver la modification";
                }
                else
                {
                    tbl_BH.Enabled = false;
                    btn_modifBH.Text = "Activer la modification";
                }
            }
        }
        

        protected void load_BHemp(string nomEmp)
        {
            string[] nomEmpArray = nomEmp.Split(',');

            var id = from tblEmp in cdc.tbl_Employe
                     where tblEmp.nom == nomEmpArray[0]
                     where tblEmp.prenom == nomEmpArray[1]
                     select tblEmp.idEmploye;

            int idInt = id.First();

            var BH = from tblBH in cdc.tbl_BanqueHeure
                     where tblBH.idEmploye == idInt
                     select tblBH;

            foreach(var heureBH in BH)
            {
                switch(heureBH.idTypeHeure)
                {
                    case 1: tbx_nbHeureBanque.Text = heureBH.nbHeure.ToString();
                        break;
                    case 2:
                        tbx_nbHeureJourFerie.Text = heureBH.nbHeure.ToString();
                        break;
                    case 3:
                        tbx_nbHeureCongePerso.Text = heureBH.nbHeure.ToString();
                        break;
                    case 4:
                        tbx_nbHeureVacance.Text = heureBH.nbHeure.ToString();
                        break;
                    case 5:
                        tbx_nbHeureCongeMaladie.Text = heureBH.nbHeure.ToString();
                        break;
                }
            }
        }

        protected void ddl_empBH_SelectedIndexChanged(object sender, EventArgs e)
        {
            load_BHemp(ddl_empBH.Text);
        }
    }
}