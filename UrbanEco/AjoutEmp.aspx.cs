using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UrbanEco
{
    public partial class AjoutEmp : System.Web.UI.Page
    {
        bool insert;
        string argument;

        private int idProjetVacance = 38;
        private int idCategorieTempsSupp = 194;

        private int[] idCategoriesProjetVacance = new int[5] { 191, 192, 193, 194, 255 };

        protected void Page_Load(object sender, EventArgs e)
        {
            //Redirection si l'utilisateur a été autorisé (Admin, Bureau, Terrain)

            if (!Authentification.Autorisation(true, false, false))
            {
                Response.Redirect("Login.aspx");
            }

            //A la base, on assume que ce n'est pas un nouvel employé
            insert = false;
            //Recherche de l'projet dans l'adresse
            argument = Request.QueryString["Emp"];
            CoecoDataContext ctx = new CoecoDataContext();
            //Choix entre un projet ou un nouveau projet
            switch (argument)
            {
                case "*":
                case null:
                    {
                        lbl_Top.Text = "Nouvel Employé";

                        insert = true;
                        break;
                    }

                default:
                    {
                        if (!IsPostBack)
                        {
                            int idemploye = int.Parse(argument);

                            //Query de recherche des données de l'employé

                            var query = BD.GetEmploye(ctx, idemploye);

                            lbl_Top.Text = query.nom + ", " + query.prenom;
                            Tbx_Prenom.Text = query.prenom;
                            Tbx_Nom.Text = query.nom;
                            Ddl_TypeEmp.SelectedIndex = (int)query.idTypeEmpl - 1;
                            Tbx_email.Text = query.email;
                            Tbx_username.Text = query.username;
                            Tbx_password.Text = query.password;

                            //Checkbox Inactif
                            if (query.inactif == true)
                                Chkbx_Inactif.Checked = true;
                            else
                                Chkbx_Inactif.Checked = false;

                            insert = false;
                        }
                        break;
                    }
            }
        }

        protected void Btn_Enregistrer_Click(object sender, EventArgs e)
        {
            CoecoDataContext ctx = new CoecoDataContext();

            if (verifEntree(ctx, insert))
            {

                //Insertion dans la base de données
                if (insert == true)
                {

                    //Objet de ma table Projet
                    tbl_Employe employeAjouter = new tbl_Employe();

                    //Remplissage des champs de la table temporaire avec les contrôles
                    employeAjouter.prenom = Tbx_Prenom.Text;
                    employeAjouter.nom = Tbx_Nom.Text;
                    employeAjouter.email = Tbx_email.Text;
                    employeAjouter.idTypeEmpl = int.Parse(Ddl_TypeEmp.SelectedValue);
                    employeAjouter.username = Tbx_username.Text;
                    employeAjouter.password = Tbx_password.Text;
                    employeAjouter.inactif = Chkbx_Inactif.Checked;
                    employeAjouter.nbHeureSemaine = 0;

                    ctx.tbl_Employe.InsertOnSubmit(employeAjouter);
                    ctx.SubmitChanges();

                    //Init banque heure
                    for (int i = 0; i < 5; i++)
                    {
                        tbl_BanqueHeure bh = new tbl_BanqueHeure();
                        bh.idEmploye = employeAjouter.idEmploye;
                        bh.idTypeHeure = i + 1;
                        bh.nbHeure = bh.nbHeureInitial = 0;
                        ctx.tbl_BanqueHeure.InsertOnSubmit(bh);
                    }

                    for (int i = 0; i < idCategoriesProjetVacance.Length; i++)
                    {
                        //Employer terrain, ne pas ajouter temps supp
                        if (employeAjouter.idTypeEmpl == 2 && idCategoriesProjetVacance[i] == idCategorieTempsSupp)
                            continue;

                        tbl_ProjetCatEmploye pceTemp = new tbl_ProjetCatEmploye();

                        //Vancance projet
                        pceTemp.idProjet = idProjetVacance;
                        pceTemp.idEmploye = (from tbl in ctx.tbl_Employe
                                                orderby tbl.idEmploye descending
                                                select tbl).First().idEmploye;

                        pceTemp.idCategorie = idCategoriesProjetVacance[i];

                        ctx.tbl_ProjetCatEmploye.InsertOnSubmit(pceTemp);
                        ctx.SubmitChanges();
                    }


                    ctx.SubmitChanges();
                }
                //Modification dans la base de données
                else
                {
                    int idEmploye = int.Parse(argument);

                    var employeModifier = BD.GetEmploye(ctx, idEmploye);


                    employeModifier.prenom = Tbx_Prenom.Text;
                    employeModifier.nom = Tbx_Nom.Text;
                    employeModifier.email = Tbx_email.Text;
                    employeModifier.idTypeEmpl = int.Parse(Ddl_TypeEmp.SelectedValue);
                    employeModifier.username = Tbx_username.Text;
                    employeModifier.password = Tbx_password.Text;
                    employeModifier.inactif = Chkbx_Inactif.Checked;

                    if (verifEntree(ctx, insert))
                    {

                        //Insertion dans la base de données
                        if (insert == true)
                        {

                            //Objet de ma table Projet
                            tbl_Employe tableEmp = new tbl_Employe();

                            //Remplissage des champs de la table temporaire avec les contrôles
                            tableEmp.prenom = Tbx_Prenom.Text;
                            tableEmp.nom = Tbx_Nom.Text;
                            //tableEmp.noTel = Tbx_noTel.Text;
                            tableEmp.email = Tbx_email.Text;
                            tableEmp.idTypeEmpl = int.Parse(Ddl_TypeEmp.SelectedValue);
                            tableEmp.username = Tbx_username.Text;
                            tableEmp.password = Tbx_password.Text;
                            tableEmp.inactif = Chkbx_Inactif.Checked;
                            tableEmp.nbHeureSemaine = 0;

                            ctx.tbl_Employe.InsertOnSubmit(tableEmp);
                            ctx.SubmitChanges();

                            //Init la banque d'heure
                            for (int i = 0; i < 5; i++)
                            {
                                tbl_BanqueHeure bh = new tbl_BanqueHeure();
                                bh.idEmploye = tableEmp.idEmploye;
                                bh.idTypeHeure = i + 1;
                                bh.nbHeure = bh.nbHeureInitial = 0;
                                ctx.tbl_BanqueHeure.InsertOnSubmit(bh);
                            }

                            ctx.SubmitChanges();
                        }
                        //Modification d'un employé existant
                        else
                        {
                            idEmploye = int.Parse(argument);

                            employeModifier = BD.GetEmploye(ctx, idEmploye);


                            employeModifier.prenom = Tbx_Prenom.Text;
                            employeModifier.nom = Tbx_Nom.Text;
                            employeModifier.email = Tbx_email.Text;
                            employeModifier.idTypeEmpl = int.Parse(Ddl_TypeEmp.SelectedValue);
                            employeModifier.username = Tbx_username.Text;
                            employeModifier.password = Tbx_password.Text;
                            employeModifier.inactif = Chkbx_Inactif.Checked;

                            var queryVerifTypeEmp = (from tbl in ctx.tbl_ProjetCatEmploye
                                                     where tbl.idEmploye == idEmploye
                                                     & tbl.idCategorie == idCategorieTempsSupp
                                                     select tbl);
                            //Terrain
                            if (employeModifier.idTypeEmpl == 2)
                            {
                                //Surpprimer le lien de l'employé au temps supp
                                if (queryVerifTypeEmp.Count() != 0)
                                {
                                    ctx.tbl_ProjetCatEmploye.DeleteOnSubmit(queryVerifTypeEmp.First());
                                }
                            }
                            //Bureau
                            else if (employeModifier.idTypeEmpl == 1)
                            {
                                //Ajouter le lien de l'employé au temps supp
                                if (queryVerifTypeEmp.Count() == 0)
                                {
                                    tbl_ProjetCatEmploye pceTemp = new tbl_ProjetCatEmploye();

                                    pceTemp.idProjet = idProjetVacance;
                                    pceTemp.idEmploye = employeModifier.idEmploye;
                                    pceTemp.idCategorie = idCategorieTempsSupp;
                                    ctx.tbl_ProjetCatEmploye.InsertOnSubmit(pceTemp);
                                }
                            }

                            var BanqueHeureEmpl = from tbl in ctx.tbl_BanqueHeure
                                                  where tbl.idEmploye == employeModifier.idEmploye
                                                  select tbl;


                            if(BanqueHeureEmpl.Count() != 5)
                            {
                                //Init la banque d'heure
                                for (int i = 0; i < 5; i++)
                                {
                                    tbl_BanqueHeure bh = new tbl_BanqueHeure();
                                    bh.idEmploye = employeModifier.idEmploye;
                                    bh.idTypeHeure = i + 1;
                                    bh.nbHeure = bh.nbHeureInitial = 0;
                                    ctx.tbl_BanqueHeure.InsertOnSubmit(bh);
                                }

                                ctx.SubmitChanges();
                            }
                        }

                        //Étape finale SUBMIT CHANGES
                        ctx.SubmitChanges();

                        /*
                            Contient du hardcode pour les catégorie de congé
                        */


                        if (insert == true)
                        {

                            //Si employé bureau
                            if ((from tbl in ctx.tbl_Employe
                                 orderby tbl.idEmploye descending
                                 select tbl).First().idTypeEmpl == 1)
                            {
                                tbl_ProjetCatEmploye[] pceTemp = new tbl_ProjetCatEmploye[5];
                                for (int i = 0; i < idCategoriesProjetVacance.Length; i++)
                                {
                                    pceTemp[i] = new tbl_ProjetCatEmploye();

                                    //Vancance projet
                                    pceTemp[i].idProjet = idProjetVacance;
                                    pceTemp[i].idEmploye = (from tbl in ctx.tbl_Employe
                                                            orderby tbl.idEmploye descending
                                                            select tbl).First().idEmploye;

                                    pceTemp[i].idCategorie = idCategoriesProjetVacance[i];

                                    ctx.tbl_ProjetCatEmploye.InsertOnSubmit(pceTemp[i]);
                                    ctx.SubmitChanges();
                                }
                            }

                            else //Employé terrain
                            {

                                tbl_ProjetCatEmploye[] pceTemp = new tbl_ProjetCatEmploye[4];
                                for (int i = 0; i < 4; i++)
                                {
                                    //Skip la catégorie temps supp pour les emp terrain
                                    if (idCategoriesProjetVacance[i] == idCategorieTempsSupp)
                                        continue;

                                    pceTemp[i] = new tbl_ProjetCatEmploye();

                                    pceTemp[i].idProjet = idProjetVacance;
                                    pceTemp[i].idEmploye = (from tbl in ctx.tbl_Employe
                                                            orderby tbl.idEmploye descending
                                                            select tbl).First().idEmploye;

                                    pceTemp[i].idCategorie = idCategoriesProjetVacance[i];


                                    ctx.tbl_ProjetCatEmploye.InsertOnSubmit(pceTemp[i]);
                                    ctx.SubmitChanges();
                                }

                            }
                        }

                        //Redirection vers la page employés une fois terminé
                        Response.Redirect("Employe.aspx");
                    }
                }
                //Redirection vers la page employés une fois terminé
                Response.Redirect("Employe.aspx");
            }
        }

        //Redirection vers la page Employe.aspx
        protected void btn_annuler_Click(object sender, EventArgs e)
        {
            Response.Redirect("Employe.aspx");
        }


        bool verifEntree(CoecoDataContext ctx, bool insert)
        {

            lb_erreurUsername.Visible = false;
            lb_erreurPrenom.Visible = false;
            lb_erreurNom.Visible = false;
            lb_erreurUsername.Visible = false;

            if (string.IsNullOrWhiteSpace(Tbx_Prenom.Text))
            {
                lb_erreurPrenom.Visible = true;
                return false;
            }
            if (string.IsNullOrWhiteSpace(Tbx_Nom.Text))
            {
                lb_erreurNom.Visible = true;
                return false;
            }
            if (string.IsNullOrWhiteSpace(Tbx_username.Text))
            {
                lb_erreurUsername.Visible = true;
                return false;
            }

            List<tbl_Employe> listeEmploye = BD.GetAllEmployes(ctx);

            if (insert)
            {

                foreach (tbl_Employe emp in listeEmploye)
                {
                    if (string.Compare(emp.username, Tbx_username.Text) == 0)
                    {
                        lb_erreurUsername.Visible = true;
                        lb_erreurUsername.Text = "Le nom d'utilisateur existe déjà";
                        return false;
                    }
                }
            }
            else
            {
                int idEmp = int.Parse(argument);
                foreach (tbl_Employe emp in listeEmploye)
                {
                    if (string.Compare(emp.username, Tbx_username.Text) == 0 && emp.idEmploye != idEmp)
                    {
                        lb_erreurUsername.Visible = true;
                        lb_erreurUsername.Text = "Le nom d'utilisateur existe déjà";
                        return false;
                    }
                }
            }

            return true;
        }

    }
}
