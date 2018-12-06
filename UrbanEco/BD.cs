using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UrbanEco
{
    public static class BD
    {
        /// <summary>
        /// Retourne l'employé connecter avec le cookie
        /// </summary>
        /// <param name="myCookie"></param>
        /// <returns></returns>
        public static tbl_Employe GetUserConnected(HttpCookie myCookie)
        {
            //return userConnected;
            //User not connected, un peu intule avec le webconfig, mais on sais jamais
            if (myCookie == null || myCookie.Value == null)
            {
                //Response.Redirect("Login.aspx", true);
                return null;
            }

            CoecoDataContext context = new CoecoDataContext();

            string cookieValue = myCookie.Value;

            var query_Employe = from tbl in context.tbl_Employe
                        where tbl.username == cookieValue
                        select tbl;

            if (query_Employe.Count() == 0)
            {
                myCookie.Value = null;
                return null;
            }

            return query_Employe.First();
        }

        /// <summary>
        /// Retourne les projets accessible par cet employé
        /// </summary>
        /// <param name="userConnected"></param>
        /// <returns></returns>
        public static List<tbl_Projet> GetEmployeProject(tbl_Employe userConnected)
        {
            CoecoDataContext context = new CoecoDataContext();

            var query_projets = (from tblProjetCat in context.tbl_ProjetCatEmploye
             join tblProjet in context.tbl_Projet on tblProjetCat.idProjet equals tblProjet.idProjet
             where tblProjetCat.idEmploye == userConnected.idEmploye
             orderby tblProjet.titre
             select tblProjet);

            if(query_projets.Count() == 0)
            {
                return null;
            }

            return query_projets.ToList();
        }

        /// <summary>
        /// Retourne la feuille de temps associer au ID
        /// </summary>
        /// <param name="idFeuilleTemps"></param>
        /// <returns></returns>
        public static tbl_FeuilleTemps GetFeuilleTemps(int idFeuilleTemps)
        {
            CoecoDataContext context = new CoecoDataContext();


            var queryFT = from tbl in context.tbl_FeuilleTemps
                          where tbl.idFeuille == idFeuilleTemps
                          select tbl;

            if(queryFT.Count() == 0)
            {
                return null;
            }

            return queryFT.First();

        }

        /// <summary>
        /// Retourne tous les projets
        /// </summary>
        /// <returns></returns>
        public static List<tbl_Projet> GetAllProjets()
        {
            CoecoDataContext context = new CoecoDataContext();


            var query_Projets = (from tblProjetCat in context.tbl_ProjetCatEmploye
                                 join tblProjet in context.tbl_Projet on tblProjetCat.idProjet equals tblProjet.idProjet
                                 orderby tblProjet.titre
                                 select tblProjet);

            if (query_Projets.Count() == 0)
                return null;


            return query_Projets.ToList();
        }

        /// <summary>
        /// Retourne tous les employés SAUF l'admin
        /// </summary>
        /// <returns></returns>
        public static List<tbl_Employe> GetAllEmployes(bool inactif = false)
        {
            CoecoDataContext context = new CoecoDataContext();

            var allEmployes = from tbl in context.tbl_Employe
                         where tbl.username != "admin"
                         & tbl.inactif == inactif
                         select tbl;

            return allEmployes.ToList();
        }

        /// <summary>
        /// Retourne les liens entre les catégorie de projet et les employés
        /// </summary>
        /// <param name="idProjet"></param>
        /// <param name="idEmploye"></param>
        /// <returns></returns>
        public static List<tbl_ProjetCatEmploye> GetProjetLinkedCategorieEmploye(int idProjet, int idEmploye)
        {
            CoecoDataContext context = new CoecoDataContext();

            var query_projet_categories = from tbl in context.tbl_ProjetCatEmploye
                        where tbl.idProjet == idProjet && tbl.idEmploye == idEmploye
                        select tbl;

            if (query_projet_categories.Count() == 0)
                return null;

            return query_projet_categories.ToList();
        }

        /// <summary>
        /// Retourne les catégorie associé au projet et au employés
        /// </summary>
        /// <param name="idProjet"></param>
        /// <param name="idEmploye"></param>
        /// <returns></returns>
        public static List<tbl_ProjetCat> GetProjetCategorieEmploye(int idProjet, int idEmploye)
        {
            CoecoDataContext context = new CoecoDataContext();

            var query_projet_categories = from tbl in context.tbl_ProjetCat
                                          join tblEmpC in context.tbl_ProjetCatEmploye on idProjet equals tblEmpC.idProjet
                                          where tbl.idProjet == idProjet && tblEmpC.idEmploye == idEmploye
                                          select tbl;

            if (query_projet_categories.Count() == 0)
                return null;

            return query_projet_categories.ToList();
        }

        public static tbl_Employe GetEmploye(int idEmploye)
        {
            CoecoDataContext context = new CoecoDataContext();

            var queryEmp = from tbl in context.tbl_Employe
                           where tbl.idEmploye == idEmploye
                           select tbl;

            if(queryEmp.Count() == 0)
                return null;

            return queryEmp.First();
        }

        public static tbl_ProjetCat GetProjetCategorie(int idProjet)
        {
            CoecoDataContext context = new CoecoDataContext();

            var queryProjet = from tbl in context.tbl_ProjetCat
                         where tbl.idProjet == idProjet
                         select tbl;

            if (queryProjet.Count() == 0)
                return null;

            return queryProjet.First();
        }

    }
}