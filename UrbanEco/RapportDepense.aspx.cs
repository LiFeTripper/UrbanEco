using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using UrbanEco.RapportDepenses;

namespace UrbanEco
{
    public partial class RapportDepense : System.Web.UI.Page
    {
        //static private List<tbl_Depense> lstDepense = new List<tbl_Depense>();  // La liste de tous les dépenses à afficher
        //static private List<tbl_Employe> lstEmploye = new List<tbl_Employe>();  // La liste de tous les employés à afficher

        protected void Page_Load(object sender, EventArgs e)
        {
            // Auth
            Autorisation2.Autorisation(false, false);

            if (!IsPostBack)
            {
                // Init les dates
                date_debut.Value = Layout.ToCalendarDate(DateTime.Today);
                date_fin.Value = Layout.ToCalendarDate(DateTime.Today);
            

                // Data Binds
                CoecoDataContext ctx = new CoecoDataContext();
                List<tbl_TypeDepense> lstTypeDepenses = (from dep in ctx.tbl_TypeDepense
                                                        select dep).ToList();

                List<tbl_Employe> lstEmploye = (from emp in ctx.tbl_Employe
                                                orderby emp.nom
                                                orderby emp.prenom
                                                where emp.idTypeEmpl != 1
                                                select emp).ToList();

                repeaterTypeDepense.DataSource = lstTypeDepenses;
                repeaterTypeDepense.DataBind();

                repeaterEmploye.DataSource = lstEmploye;
                repeaterEmploye.DataBind();
            }
        }

        /// <summary>
        /// Retourne la liste de ID pour un champ multiselect
        /// </summary>
        /// <param name="p_inputControl">le HTMLInput du multiselect</param>
        /// <returns></returns>
        private List<int> getSelectedIdFor(System.Web.UI.HtmlControls.HtmlInputControl p_inputControl)
        {
            List<int> selectedIds = new List<int>();

            // For each string values in input
            foreach (var idString in p_inputControl.Value.Split(','))
            {
                int id = -1;

                if (string.IsNullOrWhiteSpace(idString))
                    continue;

                if (int.TryParse(idString, out id) && id <= -1)
                    continue;

                selectedIds.Add(id);
            }

            return selectedIds;
        }

        /// <summary>
        /// Génère le rapport avec les informations selectionés dans le HTML
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void GenererRapport(object sender, EventArgs e)
        {
            List<int> selectedIdTypeCategorie = this.getSelectedIdFor(hiddenFieldTypeDepense);
            List<int> selectedIdEmploye = this.getSelectedIdFor(hiddenFieldEmploye);

            // Get tous les type de categories et employes selectionés dans le HTML
            CoecoDataContext ctx = new CoecoDataContext();
            var selectedTypeCategorie = ctx.tbl_TypeDepense.Select(tc => tc)
                                                            .Where(tc => selectedIdTypeCategorie.Count > 0 ?
                                                                        selectedIdTypeCategorie.Contains(tc.idTypeDepense):
                                                                        true)
                                                            .ToList();

            // Crée l'arbre de rapport
            RapportDepenseNode rapport = new RapportDepenseNode("Rapport");
            foreach (var typeCategorie in selectedTypeCategorie)
            {
                RapportDepenseNode typeCategorieNode = new RapportDepenseNode(typeCategorie.nomDepense);

                var depenses = ctx.tbl_Depense.Where(d => d.typeDepense == typeCategorie.nomDepense)
                                                .Where(d => selectedIdEmploye.Count > 0 ? 
                                                                selectedIdEmploye.Contains(d.idEmploye):
                                                                true)
                                                .Where(d => d.approuver)
                                                .Where(d => d.dateDepense <= DateTime.Parse(date_fin.Value))
                                                .Where(d => d.dateDepense >= DateTime.Parse(date_debut.Value))
                                                .OrderBy(d => d.dateDepense)
                                                .ToList();

                foreach (var depense in depenses)
                {
                    // Si la dépense est un montant de 0, on ne l'ajoute pas
                    if (depense.montant == null) continue;

                    RapportDepenseNode depenseNode = new RapportDepenseNode(string.Format("{0} {1}", depense.tbl_Employe.prenom, depense.tbl_Employe.nom));
                    depenseNode.Date = ((DateTime)depense.dateDepense).Date;
                    depenseNode.TotalDepense = (float)depense.montant;
                    depenseNode.TitreCategorie = depense.tbl_ProjetCat.titre;
                    depenseNode.TitreProjet = depense.tbl_ProjetCat.tbl_Projet.titre;

                    typeCategorieNode.TotalDepense += (float)depense.montant;
                    typeCategorieNode.Childs.Add(depenseNode);
                }

                if (typeCategorieNode.TotalDepense > 0)
                {
                    rapport.TotalDepense += typeCategorieNode.TotalDepense;
                    rapport.Childs.Add(typeCategorieNode);
                }
            }

            Session["rapportNode"] = rapport;
            Session["dateDebut"] = DateTime.Parse(date_debut.Value);
            Session["dateFin"] = DateTime.Parse(date_fin.Value);
            Response.Redirect("RapportDepensePage.aspx");
        }
    }
}