﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;

namespace UrbanEco
{
    public class Authentification
    {
        //Classe pour l'authentification à chaque page

        /// <summary>
        /// Défini les autorisations pour les pages
        /// </summary>
        /// <param name="adm">Autorisation Adm</param>
        /// <param name="bureau">Autorisation Bureau</param>
        /// <param name="terrain">Autorisation Terrain</param>
        /// <returns></returns>
        public static bool Autorisation(bool adm, bool bureau, bool terrain)
        {
            HttpCookie reader = HttpContext.Current.Request.Cookies["userinfo"];
            if(reader != null)
            {
                byte[] cookieName = Encoding.Default.GetBytes(reader.Value);
                string username = Encoding.UTF8.GetString(cookieName);

                bool isAdmin = false;

                //Optien l'employé connecté
                CoecoDataContext bd = new CoecoDataContext();
                tbl_Employe emp = bd.tbl_Employe.Where(e => e.username == username).First();
                bd.Dispose();


                if (emp.inactif == true)
                {
                    HttpContext.Current.Response.Redirect("Login.aspx", true);
                    reader.Expires = DateTime.Now.AddDays(-10);
                    return false;
                }

                int typeEmp = emp.idTypeEmpl;
                if (emp.username == "admin")
                {
                    isAdmin = true;
                }
                //1 = Bureau
                //2 = Terrain

                //Partie Adm
                if (adm == true && isAdmin == true)
                {
                    return true;
                }
                //Partie bureau
                if (bureau && typeEmp == 1)
                {
                    return true;
                }
                //Partie terrain
                if (terrain && typeEmp == 2)
                {
                    return true;
                }
            }
            HttpContext.Current.Response.Redirect("Login.aspx", true);
            return false;
        }
    }
}