using System;
using System.Collections.Generic;
using System.Linq;
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
                string username = reader.Value;
                bool isAdmin = false;

                //Optien l'employé connecté
                CoecoDataContext bd = new CoecoDataContext();
                tbl_Employe emp = bd.tbl_Employe.Single(f => f.username == username);
                bd.Dispose();

                if(emp.inactif == true)
                {
                    HttpContext.Current.Response.Redirect("Login.aspx", true);
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