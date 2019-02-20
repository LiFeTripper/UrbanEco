using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Deplace_Sous_Cat_2
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Début de l'oppération. Cela peut prendre un peu de temps...");
            MoveCat();
            Console.WriteLine("L'oppération s'est effectuée avec succès!");
            Console.ReadKey();
        }

        private static void MoveCat()
        {
            CoEco_BDDataContext bd = new CoEco_BDDataContext();

            var query_projetMaitre = from tbl in bd.tbl_ProjetCat
                        where tbl.idCatMaitre == null
                        select tbl;
            List<tbl_ProjetCat> lst_projetMaitre = query_projetMaitre.ToList();

            for(int i = 0; i < lst_projetMaitre.Count; i++)
            {
                //vérifier si cette catégorie à un(des) kid(s)
                var query_kids = from tbl in bd.tbl_ProjetCat
                                 where tbl.idCatMaitre == lst_projetMaitre[i].idProjetCat
                                 select tbl;

                List<tbl_ProjetCat> lst_kids = query_kids.ToList();
                if(lst_kids.Count == 0)
                {
                    //On get le projet pour vérifier si une catégorie générale existe
                    var query_Parent = from tbl in bd.tbl_Projet
                                       where tbl.idProjet == lst_projetMaitre[i].idProjet
                                       select tbl;
                    tbl_Projet pro = query_Parent.ToList()[0];

                    //optenir tous les catégories de ce projet
                    var query_Categorie = from tbl in bd.tbl_ProjetCat
                                           where tbl.idProjet == pro.idProjet && tbl.titre == "Général"
                                           select tbl;

                    tbl_ProjetCat catGeneral = null;
                    if (query_Categorie.ToList().Count == 0)
                    {
                        //Aucun Général trouvé, on le crée donc
                        tbl_ProjetCat newCat = new tbl_ProjetCat();
                        newCat.titre = "Général";
                        newCat.idProjet = pro.idProjet;
                        newCat.idCatMaitre = null;

                        bd.tbl_ProjetCat.InsertOnSubmit(newCat);
                        bd.SubmitChanges();

                        var query_newCat = from tbl in bd.tbl_ProjetCat
                                              where tbl.idProjet == pro.idProjet && tbl.titre == "Général"
                                              select tbl;
                        catGeneral = query_newCat.ToList()[0];
                    }
                    else
                    {
                        //Général trouvé
                        catGeneral = query_Categorie.ToList()[0];
                    }

                    //lst_projetMaitre[i].idCatMaitre = catGeneral.idProjetCat;

                    tbl_ProjetCat projetcat = bd.tbl_ProjetCat.Single(f => f.idProjetCat == lst_projetMaitre[i].idProjetCat);
                    projetcat.idCatMaitre = catGeneral.idProjetCat;
                    bd.SubmitChanges();

                    Console.WriteLine(i + ": " + lst_projetMaitre[i].titre + " à été transféré");

                }
            }
        }
    }
}
