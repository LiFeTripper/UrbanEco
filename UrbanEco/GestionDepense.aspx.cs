using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UrbanEco
{
    public partial class ApprobationDepense : System.Web.UI.Page
    {
        List<tbl_Employe> employes = new List<tbl_Employe>();
        

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Authentification.Autorisation(true, true, true))
            {
                Response.Redirect("Login.aspx");
            }

            CoecoDataContext ctx = new CoecoDataContext();

            tbl_Employe empconnected = BD.GetUserConnected(ctx,Request.Cookies["userInfo"]);

            if (empconnected.username == "admin")
            {
                List<tbl_Employe> queryAllEmpFtWaiting = BD.GetAllEmpDepWaiting(ctx);

                if (queryAllEmpFtWaiting != null)

                {
                    Rptr_Emploe.DataSourceID = null;
                    Rptr_Emploe.DataSource = queryAllEmpFtWaiting;
                    Rptr_Emploe.DataBind();
                }

                
            }
            else
            {
                List<tbl_Employe> queryEmpFtWaiting = BD.GetEmpDepWaiting(ctx,empconnected.idEmploye);

                if(queryEmpFtWaiting != null)
                {
                    Rptr_Emploe.DataSourceID = null;
                    Rptr_Emploe.DataSource = queryEmpFtWaiting;
                    Rptr_Emploe.DataBind();
                }
                else
                {
                    var queryEmp = from tbl in ctx.tbl_Employe
                                   where tbl.idEmploye == empconnected.idEmploye
                                   select tbl;

                    Rptr_Emploe.DataSourceID = null;
                    Rptr_Emploe.DataSource = queryEmp;
                    Rptr_Emploe.DataBind();
                }
            }


            
        }

        protected void Rptr_FeuilleTemps_Load(object sender, EventArgs e)
        {

        }

        protected void Btn_Modif_Click(object sender, EventArgs e)
        {
            ImageButton ib = (ImageButton)sender;
            int idDepense = int.Parse(ib.CommandArgument);

            Response.Redirect("AjoutDepense.aspx?Dep=" + idDepense.ToString());
        }

        protected void Btn_Modif_Click1(object sender, ImageClickEventArgs e)
        {

        }

        protected void Btn_Approve_Click(object sender, ImageClickEventArgs e)
        {
            ImageButton btn = ((ImageButton)sender);

            CoecoDataContext ctx = new CoecoDataContext();

            int idDepense = -1;

            int.TryParse(btn.CommandArgument, out idDepense);

            if (idDepense != -1)
            {
                CoecoDataContext context = new CoecoDataContext();

                tbl_Depense depense = BD.GetDepense(ctx,idDepense);

                if(depense != null)
                {
                    depense.approuver = true;
                }

                context.SubmitChanges();

                Response.Redirect(Request.RawUrl);
            }
        }

        protected void btn_ajouter_Click1(object sender, EventArgs e)
        {
            Response.Redirect("AjoutDepense.aspx?Dep=New");
        }

        protected void Rptr_Depense_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {

            Repeater rep = ((Repeater)sender);

            var  item = e.Item;

        }

        protected void Rptr_Depense_Load(object sender, EventArgs e)
        {
        }

        protected void btn_approverEmploye_Click(object sender, EventArgs e)
        {
            Button btn = ((Button)sender);

            int idEmp = -1;

            int.TryParse(btn.CommandArgument,out idEmp);

            if(idEmp != -1)
            {
                CoecoDataContext ctx = new CoecoDataContext();
                var query = from tbl in ctx.tbl_Depense
                            where tbl.idEmploye == idEmp && tbl.approuver == false
                            select tbl;

                if (query.Count() == 0)
                    return;

                foreach (var depense in query.ToList())
                {
                    depense.approuver = true;
                }

                ctx.SubmitChanges();
            }

            Response.Redirect(Request.RawUrl);
        }

        public bool IsAdmin()
        {
            CoecoDataContext ctx = new CoecoDataContext();

            tbl_Employe empconnected = BD.GetUserConnected(ctx, Request.Cookies["userInfo"]);

            return empconnected.username == "admin";
        }
    }
}