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
            Console.WriteLine("Cette oppération peut prendre un certain temps...");
            CreateLinks(191);
            CreateLinks(192);
            CreateLinks(193);
            CreateLinks(194);
            CreateLinks(255);
            AjouterBH();
            Console.WriteLine("Oppération terminé sans erreur! Appuyer sur une touche pour continuer");
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

        private static void AjouterBH()
        {
            CoEco_BDDataContext bd = new CoEco_BDDataContext();

            List<tbl_Employe> listEmp = bd.tbl_Employe.ToList();

            foreach (tbl_Employe emp in listEmp)
            {
                for(int i = 1; i < 6; i++)
                {
                    tbl_BanqueHeure bh = new tbl_BanqueHeure();
                    bh.idEmploye = emp.idEmploye;
                    bh.idTypeHeure = i;
                    bh.nbHeure = 0;
                    bh.nbHeureInitial = 0;
                    bd.tbl_BanqueHeure.InsertOnSubmit(bh);
                    bd.SubmitChanges();
                }
            }
            bd.Dispose();
        }
    }
}
