using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace UrbanEco.Rapports
{
    public class RapportNode
    {
        private string nom;
        private TimeSpan? nbHeure;
        private List<RapportNode> child;

        public RapportNode() {}

        public RapportNode(string p_nom)
        {
            this.nom = p_nom;
            this.nbHeure = new TimeSpan(0, 0, 0);
        }

        public string Nom { get => this.nom; }
        public TimeSpan? NbHeure { get => this.nbHeure; set => this.nbHeure = value; }

        public List<RapportNode> Child {
            get => this.child == null ? new List<RapportNode>() : this.child;
            set => this.child = value;
        }
    }
}