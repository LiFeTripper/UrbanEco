using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Deplace_Sous_Cat
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            CoEco_BDDataContext bd = new CoEco_BDDataContext();

            var querry = from cat in bd.tbl_ProjetCat
                         where cat.idCatMaitre == null
                         select cat;
            List<tbl_ProjetCat> lst_projet = querry.ToList();
            for(int i = 0; i < lst_projet.Count; i++)
            {
                bd.PS_ChangeCatMaster(lst_projet[i].idProjetCat);
            }
            button1.Enabled = false;
            
        }
    }
}
