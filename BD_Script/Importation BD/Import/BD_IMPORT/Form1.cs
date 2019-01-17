using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BD_IMPORT
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void btn_import_Click(object sender, EventArgs e)
        {
            AncienneBDDataContext old_BD = new AncienneBDDataContext();
            BDMARCDataContext new_BD = new BDMARCDataContext();

            var querry_Old = from tableEMP in old_BD.tblemploye
                         select tableEMP;
            List<tblemploye> tblEmp = old_BD.tblemploye.ToList();


            foreach (tblemploye emp in tblEmp)
            {

                tbl_Employe t_new = new tbl_Employe();
                t_new.
                t_new.idEmploye = emp.id;
                t_new.prenom = emp.prenom;
                t_new.nom = emp.nom;
                t_new.email = emp.email;
                t_new.idTypeEmpl = 2; //Terrain
                t_new.inactif = (emp.status == 1) ? false : true; //à vérifié
                t_new.username = t_new.prenom.ToLower() + t_new.idEmploye;
                t_new.password = "";
                t_new.nbHeureSemaine = 0;

                new_BD.tbl_Employe.InsertOnSubmit(t_new);

            }
            new_BD.SubmitChanges();
            btn_import.Text = "YAY";
            btn_import.Enabled = false;
        }
    }
}
