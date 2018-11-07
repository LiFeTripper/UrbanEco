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
            if(!IsPostBack)
            {

                tbl_BH.Enabled = true;
                List<string> listEmp = new List<string>();

                var tblEmp = from tbl in cdc.tbl_Employe
                             where tbl.username != "admin"
                             select tbl;

                if (listEmp.Count == 0)
                {
                    foreach (var n in tblEmp)
                    {
                        listEmp.Add(n.nom + "," + n.prenom);
                    }

                    ddl_empBH.DataSource = listEmp;
                    ddl_empBH.DataBind();
                }
            }
            
        }

        protected void btn_modifBH_Click(object sender, EventArgs e)
        {
            if(ddl_empBH.Text != "")
            {
                if(btn_modifBH.Text == "Activer la modification" )
                {
                    tbl_BH.Enabled = true;
                    btn_modifBH.Text = "Désactiver la modification";
                }
                else
                {
                    Update_BH();
                    tbl_BH.Enabled = false;
                    btn_modifBH.Text = "Activer la modification";
                }
            }
        }
        

        protected void load_BHemp(string nomEmp)
        {
            int idInt = GetIDEmp(nomEmp);

            var BH = from tblBH in cdc.tbl_BanqueHeure
                     where tblBH.idEmploye == idInt
                     select tblBH;

            tbl_BH.Enabled = true;

            foreach (var heureBH in BH)
            {

                switch (heureBH.idTypeHeure)
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
            tbl_BH.Enabled = false;
        }

        protected void ddl_empBH_SelectedIndexChanged(object sender, EventArgs e)
        {
            load_BHemp(ddl_empBH.Text);
        }

        protected void Update_BH()
        {
            int idInt = GetIDEmp(ddl_empBH.Text);

            var BH = from tblBH in cdc.tbl_BanqueHeure
                     where tblBH.idEmploye == idInt
                     select tblBH;

            List<tbl_BanqueHeure> listHeure = new List<tbl_BanqueHeure>();

            foreach (var heure in BH)
            {
                listHeure.Add(heure);
            }


            foreach (var heureBH in listHeure)
            {

                switch (heureBH.idTypeHeure)
                {
                    case 1:
                        heureBH.nbHeure = float.Parse(tbx_nbHeureBanque.Text);
                        break;
                    case 2:
                        heureBH.nbHeure = float.Parse(tbx_nbHeureJourFerie.Text);
                        break;
                    case 3:
                        heureBH.nbHeure = float.Parse(tbx_nbHeureCongePerso.Text);
                        break;
                    case 4:
                        heureBH.nbHeure = float.Parse(tbx_nbHeureVacance.Text);
                        break;
                    case 5:
                        heureBH.nbHeure = float.Parse(tbx_nbHeureCongeMaladie.Text);
                        break;
                }


            }

            foreach (var heureBH in listHeure)
            {
                cdc.tbl_BanqueHeure.DeleteOnSubmit(heureBH);
                cdc.tbl_BanqueHeure.InsertOnSubmit(heureBH);
            }


            cdc.SubmitChanges();

        }

        protected int GetIDEmp(string nomEmp)
        {
            string[] nomEmpArray = nomEmp.Split(',');

            var id = from tblEmp in cdc.tbl_Employe
                     where tblEmp.nom == nomEmpArray[0]
                     where tblEmp.prenom == nomEmpArray[1]
                     select tblEmp.idEmploye;

            return id.First();
        }
    }
}