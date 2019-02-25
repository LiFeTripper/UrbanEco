using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace UrbanEco.Rapports
{
    public class RapportNode
    {
        public string Nom { get; }
        public string Description { get; }
        public TimeSpan? NbHeure { get; set; }
        private List<RapportNode> child;

        public RapportNode() {}

        public RapportNode(string p_nom)
        {
            this.Nom = p_nom;
            this.Description = "";
            this.NbHeure = new TimeSpan(0, 0, 0);
        }

        public RapportNode(string p_nom, string p_description)
        {
            this.Nom = p_nom;
            this.Description = p_description;
            this.NbHeure = new TimeSpan(0, 0, 0);
        }

        public List<RapportNode> Child {
            get => this.child == null ? this.child = new List<RapportNode>() : this.child;
            set => this.child = value;
        }
    }
}