using FluentScheduler;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UrbanEco
{
    public partial class ParametreAdmin : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            Autorisation2.Autorisation(false, false);
            Page.MaintainScrollPositionOnPostBack = true;

            if (!IsPostBack)
            {
                CoecoDataContext ctx = new CoecoDataContext();

                var queryTypeDepBureau = from tbl in ctx.tbl_TypeDepense
                                         where tbl.idTypeEmploye == 1
                                         select tbl;

                var queryTypeDepTerrain = from tbl in ctx.tbl_TypeDepense
                                          where tbl.idTypeEmploye == 2
                                          select tbl;

                var queryTypeDepGeneral = from tbl in ctx.tbl_TypeDepense
                                          where tbl.idTypeEmploye == null
                                          select tbl;

                //Déplacement KM Hard Code
                /*foreach (var item in queryTypeDepGeneral)
                {
                    ListItem ls = new ListItem(item.nomDepense, (-1).ToString(), true);
                    ls.Attributes.CssStyle.Value = "color : #C0C0C0;";
                    lbx_depBureau.Items.Add(ls);
                    lbx_depTerrain.Items.Add(ls);

                    TypeDepenseTerrainCurrent.Add(ls);
                    TypeDepenseBureauCurrent.Add(ls);
                }*/


                foreach (var item in queryTypeDepBureau.ToList())
                {
                    ListItem ls = new ListItem(item.nomDepense, item.idTypeDepense.ToString(), true);
                    lbx_depBureau.Items.Add(ls);
                }

                foreach (var item in queryTypeDepTerrain.ToList())
                {
                    ListItem ls = new ListItem(item.nomDepense, item.idTypeDepense.ToString(), true);
                    lbx_depTerrain.Items.Add(ls);
                }

                tbl_Kilometrage prixKm = GetPrixKm();

                tbx_camion.Text = prixKm.prixKilometrageCamion.ToString();// + "$";
                tbx_voiture.Text = prixKm.prixKilometrageVoiture.ToString();// + "$";


                //Premier dimanche
                var queryDimanche = from tbl in ctx.tbl_PremierDimanche
                                    select tbl;

                if(queryDimanche.Count() != 0)
                {
                    DateTime date = queryDimanche.First().dateDimanche;
                    tbx_firstDimanche.Value = Layout.ToCalendarDate(date);
                }

                tbl_ConfigAdmin config = ctx.tbl_ConfigAdmin.First();
                cb_jourRappel.Value = config.jourRappel;
                tbx_heureRappel.Value = config.heureRappel.ToString();
                tbx_objet.Value = config.objetRappel;
                ta_contenu.Value = config.contenuRappel;
                ckb_rappelBureau.Checked = (bool)config.statutRappelBureau;
                ckb_rappelTerrain.Checked = (bool)config.statutRappelTerrain;

                tbx_email.Value = config.emailRappel;

                tbx_smtp.Value = config.smtpServer;
                tbx_port.Value = config.smtpPort.ToString();
                chk_ssl.Checked = (bool)config.smtpSSL;
            }
            else
            {
                //Appliquer le style dans les listbox
                foreach (ListItem item in lbx_depBureau.Items)
                {
                    if (item.Value == (-1).ToString())
                    {
                        item.Attributes.CssStyle.Value = "color : #C0C0C0;";
                    }
                    else if (item.Value == (-100).ToString())
                    {
                        item.Attributes.CssStyle.Value = "color : #00BFFF;";
                    }
                }

                //Appliquer le style dans les listbox
                foreach (ListItem item in lbx_depTerrain.Items)
                {
                    if (item.Value == (-1).ToString())
                    {
                        item.Attributes.CssStyle.Value = "color : #C0C0C0;";
                    }
                    else if (item.Value == (-100).ToString())
                    {
                        item.Attributes.CssStyle.Value = "color : #00BFFF;";
                    }
                }
            }
        }

        

        protected tbl_Kilometrage GetPrixKm()
        {
            CoecoDataContext ctx = new CoecoDataContext();

            var queryPrixKm = from tbl in ctx.tbl_Kilometrage
                               select tbl;

            return queryPrixKm.First();
        }

        protected void lbx_depTerrain_SelectedIndexChanged(object sender, EventArgs e)
        {
            ListBox list = ((ListBox)sender);

            if (list.SelectedIndex == -1)
                return;

            var itemSelected = list.Items[list.SelectedIndex];

            if(itemSelected.Value == (-1).ToString())
            {
                list.SelectedIndex = -1;
                return;
            }

            lbx_depBureau.SelectedIndex = -1;
        }

        protected void lbx_depBureau_SelectedIndexChanged(object sender, EventArgs e)
        {
            ListBox list = ((ListBox)sender);

            if (list.SelectedIndex == -1)
                return;

            var itemSelected = list.Items[list.SelectedIndex];

            if (itemSelected.Value == (-1).ToString())
            {
                list.SelectedIndex = -1;
                return;
            }

            lbx_depTerrain.SelectedIndex = -1;

        }

        protected void btn_deleteDepBureau_Click(object sender, EventArgs e)
        {
            if (lbx_depBureau.SelectedIndex != -1) {
                lbx_depBureau.Items.RemoveAt(lbx_depBureau.SelectedIndex);
                lbx_depBureau.SelectedIndex = -1;
            }
        }

        protected void btn_deleteDepTerrain_Click(object sender, EventArgs e)
        {
            if (lbx_depTerrain.SelectedIndex != -1) {
                lbx_depTerrain.Items.RemoveAt(lbx_depTerrain.SelectedIndex);
                lbx_depTerrain.SelectedIndex = -1;
            }
        }

        /// <summary>
        /// Ajouter depense bureau
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btn_depBureau_Click(object sender, EventArgs e)
        {
            string dep = tbx_depBureau.Text;

            if (string.IsNullOrWhiteSpace(dep))
                return;

            //Value = -100, nouvelle entré dans la BD
            ListItem ls = new ListItem(dep, (-100).ToString());
            ls.Attributes.CssStyle.Value = "color:#00BFFF;";

            lbx_depBureau.Items.Add(ls);

            tbx_depBureau.Text = "";
        }

        /// <summary>
        /// Ajouter depense terrain
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btn_depTerrain_Click(object sender, EventArgs e)
        {
            string dep = tbx_depTerrain.Text;

            if (string.IsNullOrWhiteSpace(dep))
                return;          

            //Value = -100, nouvelle entré dans la BD
            ListItem ls = new ListItem(dep, (-100).ToString());
            ls.Attributes.CssStyle.Value = "color:#00BFFF;";

            lbx_depTerrain.Items.Add(ls);

            tbx_depTerrain.Text = "";
        }

        protected void btn_envoyer_Click(object sender, EventArgs e)
        {
            CoecoDataContext monContext = new CoecoDataContext();

            //Sauvegarde des paramètres email
            tbl_ConfigAdmin config = monContext.tbl_ConfigAdmin.First();

            if (config.jourRappel != cb_jourRappel.Value || config.heureRappel != TimeSpan.Parse(tbx_heureRappel.Value)) {
                JobManager.RemoveAllJobs();

                config.jourRappel = cb_jourRappel.Value;
                config.heureRappel = TimeSpan.Parse(tbx_heureRappel.Value);

                DayOfWeek day;
                switch (config.jourRappel) {
                    case "Dimanche":
                        day = DayOfWeek.Sunday;
                        break;
                    case "Lundi":
                        day = DayOfWeek.Monday;
                        break;
                    case "Mardi":
                        day = DayOfWeek.Tuesday;
                        break;
                    case "Mercredi":
                        day = DayOfWeek.Wednesday;
                        break;
                    case "Jeudi":
                        day = DayOfWeek.Thursday;
                        break;
                    case "Vendredi":
                        day = DayOfWeek.Friday;
                        break;
                    case "Samedi":
                        day = DayOfWeek.Saturday;
                        break;
                    default:
                        day = DayOfWeek.Monday;
                        break;
                }

                Registry registry = new Registry();
                RappelJob emailJob = new RappelJob();
                registry.Schedule(() => emailJob.Execute()).ToRunEvery(0).Weeks().On(day).At(config.heureRappel.Hours, config.heureRappel.Minutes);
                JobManager.Initialize(registry);
            }

            config.objetRappel = tbx_objet.Value;
            config.contenuRappel = ta_contenu.Value;
            config.statutRappelBureau = ckb_rappelBureau.Checked;
            config.statutRappelTerrain = ckb_rappelTerrain.Checked;

            config.emailRappel = tbx_email.Value;
            if (!String.IsNullOrEmpty(tbx_mdpEmail.Value)) {
                config.pwdEmailRappel = tbx_mdpEmail.Value;
            }

            config.smtpServer = tbx_smtp.Value;
            config.smtpPort = int.Parse(tbx_port.Value);
            config.smtpSSL = chk_ssl.Checked;

            monContext.SubmitChanges();
            

            //mdp admin
            if (!string.IsNullOrWhiteSpace(tbx_adminMdp.Value))
            {
                CoecoDataContext context = new CoecoDataContext();
                tbl_Employe admin = BD.GetEmployeByName(context,"","Administrateur");

                admin.password = tbx_adminMdp.Value;

                context.SubmitChanges();
            }
            

            float prixKmCamion = -1;
            float prixKmVoiture = -1;

            float.TryParse(tbx_camion.Text, out prixKmCamion);
            float.TryParse(tbx_voiture.Text, out prixKmVoiture);

            
            if(prixKmVoiture == -1 || prixKmCamion == -1)
            {
                //Erreur lors du float.parse
                return;
            }

            CoecoDataContext ctx = new CoecoDataContext();

            //Update prix KM
            var queryKM = (from tbl in ctx.tbl_Kilometrage
                         select tbl).First();

            queryKM.prixKilometrageCamion = prixKmCamion;
            queryKM.prixKilometrageVoiture = prixKmVoiture;

            ctx.SubmitChanges();

            //Delete everything sauf les 2 premieres dépense (KM HARDCODE)
            var queryTypeDepenseToDelete = from tbl in ctx.tbl_TypeDepense
                                 where tbl.idTypeDepense.Equals(null) == false && (tbl.idTypeDepense != 1 && tbl.idTypeDepense != 2)
                                 select tbl;

            foreach (var typeDepenseBureau in queryTypeDepenseToDelete)
            {
                ctx.tbl_TypeDepense.DeleteOnSubmit(typeDepenseBureau);
            }

            ctx.SubmitChanges();

            int idTypeEmployeBureau = 1;
            int idTypeEmployeTerrain = 2;

            //Get le id le plus haut pour faire un identity manuellement (celui de sql ne fonctionnera pas ici)
            int indexTypeDep = ((from tbl in ctx.tbl_TypeDepense
                                select tbl).Count() + 1);

            //Insert les type de dépense du listbox
            foreach (ListItem item in lbx_depBureau.Items)
            {
                tbl_TypeDepense newDepBureau = new tbl_TypeDepense();
                newDepBureau.nomDepense = item.Text;
                newDepBureau.idTypeEmploye = idTypeEmployeBureau;
                newDepBureau.idTypeDepense = indexTypeDep;

                ctx.tbl_TypeDepense.InsertOnSubmit(newDepBureau);

                indexTypeDep++;
            }

            foreach (ListItem item in lbx_depTerrain.Items)
            {
                tbl_TypeDepense newDepTerrain = new tbl_TypeDepense();
                newDepTerrain.nomDepense = item.Text;
                newDepTerrain.idTypeEmploye = idTypeEmployeTerrain;
                newDepTerrain.idTypeDepense = indexTypeDep;

                ctx.tbl_TypeDepense.InsertOnSubmit(newDepTerrain);
                indexTypeDep++;
            }


            ctx.SubmitChanges();

            if(!string.IsNullOrWhiteSpace(tbx_firstDimanche.Value))
            {
                DateTime dateDimanche = DateTime.Parse(tbx_firstDimanche.Value);

                //Get le premier dimanche de la table
                var queryDimanche = (from tbl in ctx.tbl_PremierDimanche
                                     orderby tbl.idPremierDimanche
                                     select tbl);

                if(queryDimanche.Count() > 0)
                {
                    //C'est le meme dimanche, on recalcule pas
                    if(RemoveHours(queryDimanche.First().dateDimanche) == RemoveHours(dateDimanche))
                    {
                        Response.Redirect(Request.RawUrl);
                        return;
                    }

                    //Delete all
                    foreach (var item in queryDimanche)
                    {
                        ctx.tbl_PremierDimanche.DeleteOnSubmit(item);
                    }

                }

                int index = 1;
                int nbSemaine = 53;

                DateTime newDate = dateDimanche;

                while(index <= nbSemaine)
                {
                    tbl_PremierDimanche insert = new tbl_PremierDimanche();
                    insert.idPremierDimanche = index;
                    insert.dateDimanche = RemoveHours(newDate); 

                    ctx.tbl_PremierDimanche.InsertOnSubmit(insert);
                    index++;
                    newDate = newDate.AddDays(7);
                }

                ctx.SubmitChanges();
            }

            Response.Redirect(Request.RawUrl);

        }

        protected DateTime RemoveHours(DateTime time)
        {
            return new DateTime(time.Year, time.Month, time.Day);
        }

        protected void btn_annuler_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }
    }
}