using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace UrbanEco
{
    public partial class Employe : System.Web.UI.Page
    {
        //Bool pour savoir si on affiche les inactifs
        static bool showInactive = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            Autorisation2.Autorisation(false, false);
            Chkbx_Inactif.Checked = showInactive;
        }

        /// <summary>
        /// Order by employe nom, prenom
        /// </summary>
        /// <param name="list"></param>
        /// <returns></returns>
        protected List<tbl_Employe> OrderEmployes(object list)
        {
            System.Data.Linq.EntitySet <tbl_Employe> employes = list as System.Data.Linq.EntitySet<tbl_Employe>;

            var listEmps = employes.ToList<tbl_Employe>();

            List<tbl_Employe> employerTrier = new List<tbl_Employe>();

            foreach (var emp in listEmps.OrderBy(c => c.nom).ThenBy(c => c.prenom))
            {
                employerTrier.Add(emp);
            }

            return employerTrier;
        }

        /// <summary>
        /// Méthode utilisé lors du changement d'état du CheckBox des inactifs
        /// </summary>
        protected void Chkbx_Inactif_CheckedChanged(object sender, EventArgs e)
        {
            showInactive = !showInactive;
            Response.Redirect(Request.RawUrl);
        }

        /// <summary>
        /// Méthode qui redirige vers AjoutEmp sans arguments donc c'est un nouvel employé
        /// </summary>
        protected void Btn_Ajout_Click(object sender, EventArgs e)
        {
            Response.Redirect("AjoutEmp.aspx");
        }

        /// <summary>
        /// Méthode qui redirige vers AjoutEmp avec le ID de l'employé en argument pour modification
        /// </summary>
        protected void Btn_Modif_Click(object sender, ImageClickEventArgs e)
        {
            //Référence au bouton dans l'interface
            ImageButton button = (sender as ImageButton);

            //Ramassage du CommandArgument du bouton
            string commandArgument = button.CommandArgument;

            //Redirige l'adresse vers l'ajout de projet avec le id en argument
            Response.Redirect("AjoutEmp.aspx?Emp=" + commandArgument);
        }
    }
}