using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AddLinkVancances
{
    class Program
    {
        const int idProjet = 38;

        static void Main(string[] args)
        {
            //191-194 inclu et 255
            CreateLinks(191);
            CreateLinks(192);
            CreateLinks(193);
            CreateLinks(194);
            CreateLinks(255);
            Console.ReadKey();
        }

        private static void CreateLinks(int idCategorie)
        {
            CoEco_BDDataContext bd = new CoEco_BDDataContext();

            List<tbl_Employe> listeEmp = bd.tbl_Employe.ToList();

            var querry = from tbl in bd.tbl_ProjetCatEmploye
                         where tbl.idCategorie == idCategorie
                         select tbl;

            List<tbl_ProjetCatEmploye> liste_projetCatEmp = querry.ToList();

            for (int i = 0; i < listeEmp.Count(); i++)
            {
                try
                {
                    tbl_ProjetCatEmploye t = liste_projetCatEmp.Single(f => f.idEmploye == listeEmp[i].idEmploye);
                }
                catch
                {
                    //Ajouter la liaison
                    tbl_ProjetCatEmploye newLink = new tbl_ProjetCatEmploye();
                    newLink.idProjet = 38;
                    newLink.idCategorie = idCategorie;
                    newLink.idEmploye = listeEmp[i].idEmploye;
                    bd.tbl_ProjetCatEmploye.InsertOnSubmit(newLink);
                    bd.SubmitChanges();
                }
                
            }
            bd.Dispose();
        }
    }
}
