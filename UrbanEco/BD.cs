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
        public static tbl_Employe GetUserConnected(CoecoDataContext ctx, HttpCookie myCookie)
        {
            //return userConnected;
            //User not connected, un peu inutile avec le webconfig, mais on sais jamais
            if (myCookie == null || myCookie.Value == null)
            {
                //Response.Redirect("Login.aspx", true);
                return null;
            }

            CoecoDataContext context = ctx;

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
        public static List<tbl_Projet> GetEmployeProjet(CoecoDataContext ctx, tbl_Employe userConnected)
        {
            CoecoDataContext context = ctx;

            var query_projets = (from tblProjetCat in context.tbl_ProjetCatEmploye
                                 join tblProjet in context.tbl_Projet on tblProjetCat.idProjet equals tblProjet.idProjet
                                 where tblProjetCat.idEmploye == userConnected.idEmploye
                                 orderby tblProjet.titre
                                 select tblProjet);

            if(query_projets.Count() == 0)
            {
                return null;
            }

            return query_projets.Distinct().ToList();
        }

        public static List<tbl_BanqueHeure> GetBanqueHeure(CoecoDataContext ctx, int idEmploye)
        {
            CoecoDataContext context = ctx;

            var queryBanqueHeure = from tblBH in context.tbl_BanqueHeure
                    where tblBH.idEmploye == idEmploye
                    select tblBH;

            if (queryBanqueHeure.Count() == 0)
                return null;

            return queryBanqueHeure.ToList();
        }

        /// <summary>
        /// Retourne tous les employés avec des FT non-approuver
        /// </summary>
        /// <returns></returns>
        public static List<tbl_Employe> GetAllEmpDepWaiting(CoecoDataContext ctx, bool approuver = false)
        {
            CoecoDataContext context = ctx;

            var query = from tblEmp in context.tbl_Employe
                        join tblDep in context.tbl_Depense on tblEmp.idEmploye equals tblDep.idEmploye
                        where tblDep.approuver == approuver
                        select tblEmp;

            if (query.Count() == 0)
                return null;

            return query.Distinct().ToList();
        }


        /// <summary>
        /// Retourne l'employés employés avec des FT non-approuver
        /// </summary>
        /// <returns></returns>
        public static List<tbl_Employe> GetEmpDepWaiting(CoecoDataContext ctx, int idEmploye, bool approuver = false)
        {
            CoecoDataContext context = ctx;

            var query = from tblEmp in context.tbl_Employe
                        join tblDep in context.tbl_Depense on tblEmp.idEmploye equals tblDep.idEmploye
                        where tblDep.approuver == approuver
                        & tblEmp.idEmploye == idEmploye
                        select tblEmp;

            if (query.Count() == 0)
                return null;

            return query.Distinct().ToList();
        }


        public static List<tbl_Employe> GetAllEmployeFtFiltered(CoecoDataContext ctx, DateTime dateMin, DateTime dateMax, bool approuver)
        {

            CoecoDataContext context = ctx;

            var query = from tblE in context.tbl_Employe
                        join tblFT in context.tbl_FeuilleTemps on tblE.idEmploye equals tblFT.idEmploye
                        where tblFT.approuver == approuver
                        & (tblFT.dateCreation >= dateMin)
                        & (tblFT.dateCreation <= dateMax)
                        orderby tblFT.dateCreation descending
                        select tblE;

            if (query.Count() == 0)
                return null;

            return query.Distinct().ToList();

        }

        public static List<tbl_Employe> GetEmployeFtFiltered(CoecoDataContext ctx, int idEmploye, DateTime dateMin, DateTime dateMax, bool approuver)
        {

            CoecoDataContext context = ctx;

            var queryEmployes = from tblE in context.tbl_Employe
                        join tblFT in context.tbl_FeuilleTemps on tblE.idEmploye equals tblFT.idEmploye
                        where tblFT.approuver == approuver
                        & (tblFT.dateCreation >= dateMin)
                        & (tblFT.dateCreation <= dateMax)
                        & tblE.idEmploye == idEmploye
                        orderby tblFT.dateCreation descending
                        select tblE;

            if (queryEmployes.Count() == 0)
                return null;

            return queryEmployes.Distinct().ToList();

        }

        /// <summary>
        /// Retourne l'employé par son nom
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        public static tbl_Employe GetEmployeByName(CoecoDataContext ctx, string nom, string prenom)
        {
            CoecoDataContext context = ctx;

            var query = from tbl in context.tbl_Employe
                        where tbl.prenom.Equals(prenom) && tbl.nom.Equals(nom)
                        select tbl;

            if (query.Count() == 0)
                return null;

            return query.First();
        }

        /// <summary>
        /// Retourne le projet selon le ID
        /// </summary>
        /// <param name="idProjet"></param>
        /// <returns></returns>
        public static tbl_Projet GetProjet(CoecoDataContext ctx, int idProjet)
        {
            CoecoDataContext context = ctx;

            var queryProjet = (from tbl in context.tbl_Projet
                               where tbl.idProjet == idProjet
                               select tbl);

            if (queryProjet.Count() == 0)
                return null;

            return queryProjet.First();

        }

        public static tbl_Depense GetDepense(CoecoDataContext ctx, int idDepense)
        {
            CoecoDataContext context = new CoecoDataContext();

            var query = from tbl in context.tbl_Depense
                        where tbl.idDepense == idDepense
                        select tbl;

            if (query.Count() == 0)
                return null;

            return query.First();
        }

        /// <summary>
        /// Retourne la feuille de temps associer au ID
        /// </summary>
        /// <param name="idFeuilleTemps"></param>
        /// <returns></returns>
        public static tbl_FeuilleTemps GetFeuilleTemps(CoecoDataContext ctx,int idFeuilleTemps)
        {
            CoecoDataContext context = ctx;

            var queryFT = from tbl in context.tbl_FeuilleTemps
                          where tbl.idFeuille == idFeuilleTemps
                          select tbl;

            if(queryFT.Count() == 0)
            {
                return null;
            }

            return queryFT.First();

        }

        public static tbl_Kilometrage GetDeplacementPrice(CoecoDataContext ctx)
        {
            CoecoDataContext context = ctx;

            var query = from tbl in context.tbl_Kilometrage
                        select tbl;

            return query.First();
        }

        public static List<tbl_TypeDepense> GetDepenseDeplacement(CoecoDataContext ctx)
        {
            CoecoDataContext context = ctx;

            var queryKm = from tbl in context.tbl_TypeDepense
                    where tbl.idTypeEmploye.Equals(null) == true
                    select tbl;

            return queryKm.Distinct().ToList();
        }


        /// <summary>
        /// Retourne les types de dépenses selon le type d'employés
        /// </summary>
        /// <param name="idTypeEmpl"></param>
        /// <returns></returns>
        public static List<tbl_TypeDepense> GetTypeDepense(CoecoDataContext ctx, int idTypeEmpl)
        {
            CoecoDataContext context = ctx;

            var queryTypeDepense = from tbl in context.tbl_TypeDepense
                                   where tbl.idTypeEmploye == idTypeEmpl
                                   select tbl;

            if (queryTypeDepense.Count() == 0)
                return null;

            return queryTypeDepense.Distinct().ToList();
        }

        /// <summary>
        /// Retourne les catégories master du projet
        /// </summary>
        /// <param name="idprojet"></param>
        /// <returns></returns>
        public static List<tbl_ProjetCat> GetMasterCategorieProjet(CoecoDataContext ctx, int idprojet)
        {
            CoecoDataContext context = ctx;

            var query = from tblCat in context.tbl_ProjetCat
                        join tblP in context.tbl_Projet on tblCat.idProjet equals tblP.idProjet
                        where tblP.idProjet.Equals(idprojet) && tblCat.idCatMaitre.Equals(null)
                        select tblCat;

            //if (query.Count() == 0)
            //    return null;

            return query.Distinct().ToList();
        }

        /// <summary>
        /// Retourne tous les projets
        /// </summary>
        /// <returns></returns>
        public static List<tbl_Projet> GetAllProjets(CoecoDataContext ctx)
        {
            CoecoDataContext context = ctx;


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
        public static List<tbl_Employe> GetAllEmployes(CoecoDataContext ctx, bool inactif = false)
        {
            CoecoDataContext context = ctx;

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
        public static List<tbl_ProjetCatEmploye> GetProjetLinkedCategorieEmploye(CoecoDataContext ctx, int idProjet, int idEmploye)
        {
            CoecoDataContext context = ctx;

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
        public static List<tbl_ProjetCat> GetProjetCategorieEmploye(CoecoDataContext ctx, int idProjet, int idEmploye)
        {
            CoecoDataContext context = ctx;

            var query_projet_categories = from tbl in context.tbl_ProjetCat
                                          join tblEmpC in context.tbl_ProjetCatEmploye on idProjet equals tblEmpC.idProjet
                                          where tbl.idProjet == idProjet && tblEmpC.idEmploye == idEmploye
                                          select tbl;

            if (query_projet_categories.Count() == 0)
                return null;

            return query_projet_categories.ToList();
        }

        public static tbl_Employe GetEmploye(CoecoDataContext ctx, int idEmploye)
        {
            CoecoDataContext context = ctx;

            var queryEmp = from tbl in context.tbl_Employe
                           where tbl.idEmploye == idEmploye
                           select tbl;

            if(queryEmp.Count() == 0)
                return null;

            return queryEmp.First();
        }

        public static tbl_ProjetCat GetProjetCategorie(CoecoDataContext ctx, int idProjet)
        {
            CoecoDataContext context = ctx;

            var queryProjet = from tbl in context.tbl_ProjetCat
                         where tbl.idProjet == idProjet
                         select tbl;

            if (queryProjet.Count() == 0)
                return null;

            return queryProjet.First();
        }

    }
}