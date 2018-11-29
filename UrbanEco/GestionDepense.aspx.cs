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
            CoecoDataContext context = new CoecoDataContext();

            if (Layout.GetUserConnected().username == "admin")
            {
                IQueryable<tbl_Employe> query = from tblEmp in context.tbl_Employe
                                                join tblDep in context.tbl_Depense on tblEmp.idEmploye equals tblDep.idEmploye

                                                where tblDep.approuver == false
                                                select tblEmp;

                Rptr_Emploe.DataSourceID = null;
                Rptr_Emploe.DataSource = query.Distinct();
                Rptr_Emploe.DataBind();
            }
            else
            {
                IQueryable<tbl_Employe> query = from tblEmp in context.tbl_Employe
                                                join tblDep in context.tbl_Depense on tblEmp.idEmploye equals tblDep.idEmploye
                                                where tblDep.approuver == false
                                                & tblEmp.idEmploye == Layout.GetUserConnected().idEmploye
                                                select tblEmp;

                Rptr_Emploe.DataSourceID = null;
                Rptr_Emploe.DataSource = query.Distinct();
                Rptr_Emploe.DataBind();
            }


            
        }

        protected void Rptr_FeuilleTemps_Load(object sender, EventArgs e)
        {

        }

        protected void Btn_Modif_Click(object sender, EventArgs e)
        {

        }

        protected void Btn_Modif_Click1(object sender, ImageClickEventArgs e)
        {

        }

        protected void Btn_Approve_Click(object sender, ImageClickEventArgs e)
        {
            ImageButton btn = ((ImageButton)sender);

            int idDepense = -1;

            int.TryParse(btn.CommandArgument, out idDepense);

            if (idDepense != -1)
            {
                CoecoDataContext context = new CoecoDataContext();

                var query = (from tbl in context.tbl_Depense
                             where tbl.idDepense == idDepense
                             select tbl);

                if(query.First() != null)
                {
                    query.First().approuver = true;
                }

                context.SubmitChanges();

                Response.Redirect(Request.RawUrl);
            }
        }

        protected void btn_ajouter_Click1(object sender, EventArgs e)
        {
            Response.Redirect("AjoutDepense.aspx");
        }

        protected void Rptr_Depense_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {

            Repeater rep = ((Repeater)sender);

            var  item = e.Item;

        }

        protected void Rptr_Depense_Load(object sender, EventArgs e)
        {
            /*Repeater rep = ((Repeater)sender);

            var par = rep.Parent;


            CoecoDataContext cdc = new CoecoDataContext();

            var query = from tbl in cdc.tbl_Depense
                        where tbl.approuver == false
                        select tbl;



            rep.DataSource = query;
            rep.DataBind();*/
        }
    }
}