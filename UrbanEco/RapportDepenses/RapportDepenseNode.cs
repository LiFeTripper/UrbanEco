using System;
using System.Collections.Generic;

namespace UrbanEco.RapportDepenses
{
    public class RapportDepenseNode
    {
        public string Nom { get; }                  // Le nom du node (Sois categorie ou employe)
        public float TotalDepense { get; set; }     // Le total de touts les depenses
        public DateTime Date { get; set; }        // La date des affaires pi sa
        private List<RapportDepenseNode> childs;

        public RapportDepenseNode(string p_nom)
        {
            this.Nom = p_nom;
        }

        public List<RapportDepenseNode> Childs
        {
            get { return this.childs == null ? this.childs = new List<RapportDepenseNode>() : this.childs; }
            set { this.childs = value; }
        }
    }
}