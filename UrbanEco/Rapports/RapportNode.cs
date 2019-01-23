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
        private RapportNode[] child;

        public RapportNode() {}

        public RapportNode(string p_nom, TimeSpan p_nbHeure, RapportNode[]p_child)
        {
            this.nom = p_nom;
            this.nbHeure = p_nbHeure;
            this.child = p_child;
        }

        public string Nom { get => this.nom; }
        public TimeSpan? NbHeure { get => this.nbHeure; }
        public RapportNode[] Child { get => this.child; }
    }
}