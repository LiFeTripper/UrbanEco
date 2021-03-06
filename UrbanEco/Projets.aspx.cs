﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UrbanEco
{
    public partial class Projets1 : System.Web.UI.Page
    {
        static bool showInactive = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            Autorisation2.Autorisation(false, false);
            CoecoDataContext context = new CoecoDataContext();

            Chkbx_Inactif.Checked = showInactive;
        }

        protected void Btn_Ajout_Click(object sender, EventArgs e)
        {
            //Redirige l'adresse vers un nouveau projet avec l'projet étoile
            Response.Redirect("AjoutProjets.aspx?Prj=*");
        }

        protected void Chkbx_Inactif_CheckedChanged(object sender, EventArgs e)
        {
            showInactive = !showInactive;

            if (showInactive)
            {
                Rptr_ProjetsInactif.Visible = true;
                Rptr_ProjetsActif.Visible = false;
                Lbl_Titre.Text = "Projets Inactif";
            }
                
            else
            {
                Rptr_ProjetsActif.Visible = true;
                Rptr_ProjetsInactif.Visible = false;
                Lbl_Titre.Text = "Projets Actif";
            }
                
                
            Response.Redirect(Request.RawUrl);
        }

        protected void Btn_Modif_Click(object sender, ImageClickEventArgs e)
        {
            //Référence au bouton dans l'interface
            ImageButton button = (sender as ImageButton);


            //Ramassage du CommandArgument du bouton
            string commandArgument = button.CommandArgument;

            //Redirige l'adresse vers l'ajout de projet avec le id en argument
            Response.Redirect("AjoutProjets.aspx?Prj=" + commandArgument);
        }

        protected void Btn_Cat_Click(object sender, ImageClickEventArgs e)
        {
            //Référence au bouton dans l'interface
            ImageButton button = (sender as ImageButton);

            //Ramassage du CommandArgument du bouton
            string commandArgument = button.CommandArgument;

            //Redirige l'adresse vers l'ajout de projet avec le id en argument
            Response.Redirect("AjoutCategorie.aspx?Prj=" + commandArgument);
            //Response.Redirect("AjoutCategorie.aspx");
        }
    }
}