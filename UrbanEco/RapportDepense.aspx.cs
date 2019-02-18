using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
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
            if (!Authentification.Autorisation(true, false, false))
            {
                Response.Redirect("Login.aspx");
            }

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

        private List<int> getSelectedIdFor(System.Web.UI.HtmlControls.HtmlInputControl p_inputControl)
        {
            List<int> selectedIds = new List<int>();

            foreach (var idString in p_inputControl.Value.Split(','))
            {
                int id = -1;

                if (string.IsNullOrWhiteSpace(idString))
                    continue;

                bool idConverted = int.TryParse(idString, out id);

                if (idConverted && id <= -1)
                    continue;

                selectedIds.Add(id);
            }

            return selectedIds;
        }

        protected void GenererRapport(object sender, EventArgs e)
        {
            List<int> selectedIdTypeCategorie = this.getSelectedIdFor(hiddenFieldTypeDepense);
            List<int> selectedIdEmploye = this.getSelectedIdFor(hiddenFieldEmploye);

            CoecoDataContext ctx = new CoecoDataContext();
            var selectedTypeCategorie = ctx.tbl_TypeDepense.Select(tc => tc)
                                                            .Where(tc => selectedIdTypeCategorie.Contains(tc.idTypeDepense))
                                                            .ToList();

            var selectedEmploye = ctx.tbl_Employe.Where(emp => selectedIdEmploye.Contains(emp.idEmploye))
                                                    .ToList();

            RapportDepenseNode rapport = new RapportDepenseNode("Rapport");
            foreach (var typeCategorie in selectedTypeCategorie)
            {
                RapportDepenseNode typeCategorieNode = new RapportDepenseNode(typeCategorie.nomDepense);

                var depenses = ctx.tbl_Depense.Where(d => d.typeDepense == typeCategorie.nomDepense)
                                                .Where(d => selectedIdEmploye.Contains(d.idEmploye))
                                                .Where(d => d.approuver)
                                                .Where(d => d.dateDepense < DateTime.Parse(date_fin.Value))
                                                .Where(d => d.dateDepense > DateTime.Parse(date_debut.Value))
                                                .ToList();

                foreach (var depense in depenses)
                {
                    if (depense.montant == null) continue;

                    var employe = ctx.tbl_Employe.Where(emp => emp.idEmploye == depense.idEmploye).First();

                    RapportDepenseNode depenseNode = new RapportDepenseNode(string.Format("{0} {1}", employe.prenom, employe.nom));
                    depenseNode.TotalDepense = (float)depense.montant;

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