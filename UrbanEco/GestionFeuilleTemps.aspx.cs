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
        

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack) { 

            Page.MaintainScrollPositionOnPostBack = true;
        
                List<tbl_Employe> listTable = new List<tbl_Employe>();

                var querry = from tblE in cdc.tbl_Employe
                             join tblFT in cdc.tbl_FeuilleTemps on tblE.idEmploye equals tblFT.idEmploye
                             where tblFT.approuver.Equals(false)
                             select tblE;
                

                foreach(var tbl in querry)
                {
                    bool ajouterTbl = true;
                    var tblTemp = tbl;
                    int idtbl = tbl.idEmploye;

                    foreach(var tblVerif in querry)
                    {
                        if(tblVerif.idEmploye != idtbl)
                        {
                            if(tblTemp == tblVerif)
                            {
                                ajouterTbl = false;
                            }
                        }
                    }

                    foreach(tbl_Employe tb in listTable)
                    {
                        if(tblTemp == tb)
                        {
                            ajouterTbl = false;
                        }
                    }

                    if(ajouterTbl)
                    {
                        
                        listTable.Add(tblTemp);
                    }
                }

                Rptr_EmployeNonApprouver.DataSource = null;
                Rptr_EmployeNonApprouver.DataSourceID = null;

                Rptr_EmployeNonApprouver.DataBind();
                Rptr_EmployeNonApprouver.DataSource = listTable;
                Rptr_EmployeNonApprouver.DataBind();

                List<tbl_Employe> listTableA = new List<tbl_Employe>();

                querry = from tblE in cdc.tbl_Employe
                         join tblFT in cdc.tbl_FeuilleTemps on tblE.idEmploye equals tblFT.idEmploye
                         where tblFT.approuver == true
                         select tblE;

                foreach (var tbl in querry)
                {
                    bool ajouterTbl = true;
                    var tblTemp = tbl;
                    int idtbl = tbl.idEmploye;

                    foreach (var tblVerif in querry)
                    {
                        if (tblVerif.idEmploye != idtbl)
                        {
                            if (tblTemp == tblVerif)
                            {
                                ajouterTbl = false;
                            }
                        }
                    }

                    foreach (tbl_Employe tb in listTableA)
                    {
                        if (tblTemp == tb)
                        {
                            ajouterTbl = false;
                        }
                    }

                    if (ajouterTbl)
                    {
                        listTableA.Add(tblTemp);
                    }
                }

                rptr_EmployeApprouver.DataSource = null;
                rptr_EmployeApprouver.DataSourceID = null;
                rptr_EmployeApprouver.DataBind();
                rptr_EmployeApprouver.DataSource = listTableA;
                rptr_EmployeApprouver.DataBind();
            }

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

            FT.First<tbl_FeuilleTemps>().approuver = true;
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
                FTemp.approuver = true;
            }

            cdc.tbl_FeuilleTemps.DeleteAllOnSubmit(FT);
            cdc.tbl_FeuilleTemps.InsertAllOnSubmit(FT);

            cdc.SubmitChanges();

            Response.Redirect(Request.RawUrl);
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
                FTemp.approuver = true;
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
    }
}