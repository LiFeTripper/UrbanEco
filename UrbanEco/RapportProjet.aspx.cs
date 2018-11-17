using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UrbanEco
{
    public partial class RapportProjet : System.Web.UI.Page
    {
        static List<tbl_ProjetCat> sortedCats = new List<tbl_ProjetCat>();

        static List<tbl_ProjetCat> SelectedCategories = new List<tbl_ProjetCat>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                tbx_categorie.Items.Add("Sélectionner un projet pour avoir accès au sous-catégorie");

                //Query pour les projet non-archiver
                CoecoDataContext context = new CoecoDataContext();

                var query = from tbl in context.tbl_Projet
                            //where tbl.archiver == false
                            orderby tbl.titre
                            select tbl;

                lst_projet.DataSource = query;
                lst_projet.DataBind();

                lst_projet.Items.Insert(0, "Veuillez sélectionner le projet");
                lst_projet.SelectedIndex = 0;

            }
        }

        protected void btn_annuler_Click(object sender, EventArgs e)
        {

        }

        protected void btn_envoyer_Click(object sender, EventArgs e)
        {

        }

        protected void lst_projet_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Reset les catégories
            if (!tbx_categorie.Enabled)
                tbx_categorie.Enabled = true;


            tbx_categorie.DataSource = null;
            tbx_categorie.DataSourceID = null;

            //Aucun projet choisi
            if (lst_projet.SelectedIndex == 0)
            {
                tbx_categorie.Enabled = false;
                tbx_categorie.Items.Clear();
                tbx_categorie.Items.Add("Sélectionner un projet pour avoir accès au sous-catégorie");

                return;
            }

            //Obtenir les catégorie
            CoecoDataContext context = new CoecoDataContext();
            int projectID = int.Parse(lst_projet.Items[lst_projet.SelectedIndex].Value);

            var allCategories = from tbl in context.tbl_ProjetCat
                        where tbl.idProjet == projectID                        
                        select tbl;

            var masterCategories = from tbl in context.tbl_ProjetCat
                            where tbl.idProjet == projectID && tbl.idCatMaitre == null
                            select tbl;


            List<tbl_ProjetCat> allCats = new List<tbl_ProjetCat>();
            allCats = allCategories.ToList();

            List<tbl_ProjetCat> masterCats = new List<tbl_ProjetCat>();
            masterCats = masterCategories.ToList();

            sortedCats = TrierList(allCats, masterCats);


            tbx_categorie.SelectionMode = ListSelectionMode.Multiple;
            tbx_categorie_selected.SelectionMode = ListSelectionMode.Multiple;
            
            tbx_categorie.DataSource = ProjetCatToListItem(masterCats);
            tbx_categorie.DataBind();

            tbx_categorie.Items.Insert(0, "Toutes les sous-catégories");
        }

        private List<ListItem> ProjetCatToListItem (List<tbl_ProjetCat> lst)
        {
            List<ListItem> result = new List<ListItem>();

            foreach (var item in lst)
            {
                if (item.idCatMaitre == null)
                    result.Add(new ListItem(item.titre, item.idProjetCat.ToString()));
                else
                    result.Add(new ListItem(HttpUtility.HtmlDecode("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;") + item.titre, item.idProjetCat.ToString()));
            }

            return result;
        }

        private List<tbl_ProjetCat> TrierList(List<tbl_ProjetCat> p_list, List<tbl_ProjetCat> p_listMaster)
        {
            List<tbl_ProjetCat> result = new List<tbl_ProjetCat>();

            int idParent = -1;

            foreach (var parent in p_listMaster)
            {
                idParent = parent.idProjetCat;

                result.Add(parent);

                foreach (var cat in p_list)
                {
                    if(cat.idCatMaitre != idParent)
                    {
                        continue;
                    }

                    ListItem l = new ListItem(HttpUtility.HtmlDecode("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;") + cat.titre, cat.idProjetCat.ToString());
                    

                    result.Add(cat);
                    //result.Add(new ListItem("", cat.idProjetCat.ToString()));

                }


            }

            return result;
        }

        protected void SelectCat_Click(object sender, EventArgs e)
        {
            List<ListItem> selectedCat = new List<ListItem>();

            bool SelectAll = false;

            foreach (ListItem item in tbx_categorie.Items)
            {
                if (item.Selected || SelectAll)
                {
                    int idProjetCat = ConvertValueToInt(item.Value);

                    //Invalid ID
                    if (idProjetCat < -1)
                        continue;

                    //Select all categorie
                    if (idProjetCat == 0)
                    {
                        SelectAll = true;
                        continue;
                    }
                    
                    selectedCat.Add(item);                   
                }
            }

            //Sa marche
            if(SelectAll)
            {
                tbx_categorie_selected.DataSource = selectedCat;
                tbx_categorie_selected.DataBind();

                tbx_categorie.Items.Clear();

                return;
            }

            foreach (var item in selectedCat)
            {
                tbx_categorie_selected.Items.Add(item);

                tbx_categorie.Items.Remove(item);
            }

        }

        private bool CategorieSelected(tbl_ProjetCat cat)
        {
            foreach (var item in SelectedCategories)
            {
                if (item.idProjetCat == cat.idProjetCat)
                    return true;
            }

            return false;
        }

        private int ConvertValueToInt(string value)
        {
            int result = int.MinValue;

            int.TryParse(value, out result);

            return result;
        }

        protected void DeSelectCat_Click(object sender, EventArgs e)
        {
            List<ListItem> selectedCat = new List<ListItem>();

            foreach (ListItem item in tbx_categorie_selected.Items)
            {
                if (item.Selected)
                {
                    int idProjetCat = ConvertValueToInt(item.Value);

                    //Invalid ID
                    if (idProjetCat < -1)
                        continue;

                    selectedCat.Add(item);
                }
            }

            foreach (var item in selectedCat)
            {
                tbx_categorie.Items.Add(item);

                tbx_categorie_selected.Items.Remove(item);
            }

        }
    }
}