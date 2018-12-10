﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UrbanEco
{
    public partial class Login : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            //Sur chargement, vérification de l'authentification du user avec le cookie
            if (User.Identity.IsAuthenticated)
                Response.Redirect("/Home.aspx");
        }

        protected void Btn_Signin_Click(object sender, EventArgs e)
        {
            ValidateUser();
        }

        protected void ValidateUser()
        {
            //Connexion a la base de donnée
            CoecoDataContext context = new CoecoDataContext();

            //Insertion dans des variables des données entrées par l'utilisateur
            string user = Tbx_InputUsername.Text;
            string password = Tbx_InputPassword.Value;

            try
            {
                //Query du premier utilisateur dont le username est identique a celui entré
                var query = (from tbl in context.tbl_Employe
                             where tbl.username == Tbx_InputUsername.Text
                             select tbl).First();

                //Vérification du mot de passe entré avec celui de l'utilisateur trouvé dans la BD
                if (query.password == Tbx_InputPassword.Value)
                {
                    //Si le mot de passe est trouvé, le user est authentifié
                    //Persist crée un cookie persistant 
                    FormsAuthentication.RedirectFromLoginPage
                            (Tbx_InputUsername.Text, Persist.Checked);

                    //Création du cookie de sécurité maximale avec le user en clair dedans
                    Response.Cookies["userInfo"].Value = Tbx_InputUsername.Text.ToString();
                    //Si le cookie est persistant, il est enregistrer sur l'ordi
                    //Ici, son expiration est de 1 journée
                    Response.Cookies["userInfo"].Expires = DateTime.Now.AddDays(1);

                    //Redirection vers le Home
                    Response.Redirect("/Home.aspx");
                }
                ////En cas d'échec de trouver un mot de passe 
                else
                {
                    AlertDiv.Visible = true;
                }
            }

            //En cas d'échec de trouver un utilisateur
            catch (Exception)
            {
                AlertDiv.Visible = true;
            }
        }
    }
}