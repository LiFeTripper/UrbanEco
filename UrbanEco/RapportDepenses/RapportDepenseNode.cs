using System.Collections.Generic;

namespace UrbanEco.RapportDepenses
{
    public class RapportDepenseNode
    {
        private float totalDepense;     // Le total de tous les montants
        private string nom;             // Le nom du node (Sois categorie ou employe)
        private List<RapportDepenseNode> childs;

        public RapportDepenseNode(string p_nom)
        {
            this.nom = p_nom;
        }

        /// <summary>
        /// Le nom du node (Sois le nom de la catégorie de dépense ou le nom de l'employe
        /// </summary>
        public string Nom {
            get { return this.nom; }
        }
        /// <summary>
        /// Le total des montants de dépense
        /// </summary>
        public float TotalDepense
        {
            get { return this.totalDepense; }
            set { this.totalDepense = value; }
        }
        public List<RapportDepenseNode> Childs
        {
            get { return this.childs == null ? this.childs = new List<RapportDepenseNode>() : this.childs; }
            set { this.childs = value; }
        }

    }
}