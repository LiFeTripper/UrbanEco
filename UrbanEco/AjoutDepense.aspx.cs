using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UrbanEco
{
    public partial class AjoutDepense : System.Web.UI.Page
    {
       static bool DepenseAjouter = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            //Calendar.Value = DateTime.Today.ToShortDateString();

            if (!IsPostBack)
            {
                DepenseAjouter = false;

                tbx_categorie.Items.Add("-----");

                CoecoDataContext context = new CoecoDataContext();

                var query = from tbl in context.tbl_Projet
                            orderby tbl.titre
                            select tbl;

                tbx_projet.DataSource = query;
                tbx_projet.DataBind();


                tbx_projet.Items.Insert(0,"Veuillez sélectionner le projet");
                tbx_projet.SelectedIndex = 0;
                Calendar.Value = DateTime.Today.ToShortDateString();

                tbx_typeDepense.SelectedIndex = 0;
            }

            UpdateRecapitulatif();
        }

        protected void date_changed(object sender, EventArgs e)
        {
            int i = 0;
        }

        protected void btn_envoyer_Click(object sender, EventArgs e)
        {
            try
            {
                if (DepenseAjouter)
                {
                    alert_success.Visible = false;
                    alert_warning.Visible = true;
                    return;
                }


                tbl_Depense dep = new tbl_Depense();
                tbl_Employe empConnected = Layout.GetUserConnected();

                int idTypeDepense = tbx_typeDepense.SelectedIndex + 1;

                dep.idEmploye = empConnected.idEmploye;
                dep.idTypeDepense = idTypeDepense;
                dep.montant = float.Parse(tbx_montant.Text);
                dep.idProjetCat = int.Parse(tbx_categorie.Items[tbx_categorie.SelectedIndex].Value);
                dep.note = tbx_note.Text;

                DateTime date = DateTime.Parse(Calendar.Value);
                dep.dateDepense = date;

                CoecoDataContext context = new CoecoDataContext();
                context.tbl_Depense.InsertOnSubmit(dep);
                context.SubmitChanges();

                alert_success.Visible = true;
                DepenseAjouter = true;
            }
            catch (Exception ex)
            {
                alert_failed.Visible = true;
                DepenseAjouter = false;
            }

        }

        protected void tbx_projet_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(!tbx_categorie.Enabled)
                tbx_categorie.Enabled = true;

            rep_categorie.InnerText = tbx_categorie.Items[tbx_categorie.SelectedIndex].Text;
            rep_date.InnerText = Calendar.Value.ToString();
            rep_montant.InnerText = tbx_montant.Text;
            rep_nomEmployer.InnerText = Layout.GetUserConnected().nom + ", " + Layout.GetUserConnected().prenom;
            rep_projet.InnerText = tbx_projet.Items[tbx_projet.SelectedIndex].Text;

            tbx_categorie.DataSource = null;
            tbx_categorie.DataSourceID = null;

            if (tbx_projet.SelectedIndex == 0)
            {
                tbx_categorie.Enabled = false;
                tbx_categorie.Items.Clear();
                tbx_categorie.Items.Add("-----");

                return;
            }

            CoecoDataContext context = new CoecoDataContext();
            int projectID = int.Parse(tbx_projet.Items[tbx_projet.SelectedIndex].Value);

            var query = from tbl in context.tbl_ProjetCat
                        where tbl.idProjet == projectID
                        select tbl;


            tbx_categorie.DataSource = query;
            tbx_categorie.DataBind();      
        }

        void UpdateRecapitulatif()
        {
            rep_categorie.InnerText = tbx_categorie.Items[tbx_categorie.SelectedIndex].Text;
            rep_date.InnerText = Calendar.Value.ToString();
            rep_montant.InnerText = tbx_montant.Text + "$";
            if(Layout.GetUserConnected() != null)
                rep_nomEmployer.InnerText = Layout.GetUserConnected().nom + ", " + Layout.GetUserConnected().prenom;
            rep_projet.InnerText = tbx_projet.Items[tbx_projet.SelectedIndex].Text;

            if(tbx_typeDepense.SelectedIndex != -1)
                rep_typeDepense.InnerText = tbx_typeDepense.Items[tbx_typeDepense.SelectedIndex].Text;
        }


    }
}