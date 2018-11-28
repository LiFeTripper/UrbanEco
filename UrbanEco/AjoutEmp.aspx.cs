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

        protected void Page_Load(object sender, EventArgs e)
        {
            insert = false;
            //Recherche de l'argument dans l'adresse
            argument = Request.QueryString["Emp"];

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
                            CoecoDataContext context = new CoecoDataContext();

                            int id = int.Parse(argument);

                            var query = (from tbl in context.tbl_Employe
                                         where tbl.idEmploye == id
                                         select tbl).First();

                            lbl_Top.Text = query.nom + ", " + query.prenom;

                            Tbx_Prenom.Text = query.prenom;
                            Tbx_Nom.Text = query.nom;
                            Ddl_TypeEmp.SelectedIndex = (int)query.idTypeEmpl - 1;
                            Tbx_noTel.Text = query.noTel;
                            Tbx_email.Text = query.email;
                            Tbx_username.Text = query.username;
                            Tbx_password.Text = query.password;

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
            CoecoDataContext context = new CoecoDataContext();

            //Insertion dans la base de données
            if (insert == true)
            {
                //Objet de ma table Projet
                tbl_Employe tableEmp = new tbl_Employe();

                //Remplissage des champs de la table temporaire avec les contrôles
                tableEmp.prenom = Tbx_Prenom.Text;
                tableEmp.nom = Tbx_Nom.Text;
                tableEmp.noTel = Tbx_noTel.Text;
                tableEmp.email = Tbx_email.Text;
                tableEmp.idTypeEmpl = int.Parse(Ddl_TypeEmp.SelectedValue);
                tableEmp.username = Tbx_username.Text;
                tableEmp.password = Tbx_password.Text;
                tableEmp.inactif = Chkbx_Inactif.Checked;

                context.tbl_Employe.InsertOnSubmit(tableEmp);
            }
            //Modification dans la base de données
            else
            {
                int id = int.Parse(argument);

                var query = (from tbl in context.tbl_Employe
                             where tbl.idEmploye == id
                             select tbl).First();

                query.prenom = Tbx_Prenom.Text;
                query.nom = Tbx_Nom.Text;
                query.noTel = Tbx_noTel.Text;
                query.email = Tbx_email.Text;
                query.idTypeEmpl = int.Parse(Ddl_TypeEmp.SelectedValue);
                query.username = Tbx_username.Text;
                query.password = Tbx_password.Text;
                query.inactif = Chkbx_Inactif.Checked;

                var queryVerifTypeEmp = (from tbl in context.tbl_ProjetCatEmploye
                                        where tbl.idEmploye == id
                                        & tbl.idCategorie == 12
                                        select tbl);
                
                if(query.idTypeEmpl == 2)
                {
                    if(queryVerifTypeEmp.Count() != 0)
                    {
                        context.tbl_ProjetCatEmploye.DeleteOnSubmit(queryVerifTypeEmp.First());
                    }
                }
                else if(query.idTypeEmpl == 1)
                {
                    if(queryVerifTypeEmp.Count() == 0)
                    {
                        tbl_ProjetCatEmploye pceTemp = new tbl_ProjetCatEmploye();

                        pceTemp.idProjet = 4;
                        pceTemp.idEmploye = query.idEmploye;
                        pceTemp.idCategorie = 12;
                        context.tbl_ProjetCatEmploye.InsertOnSubmit(pceTemp);
                    }
                }
            }

            //Étape finale SUBMIT CHANGES
            context.SubmitChanges();

            if(insert == true)
            {
                int indexCat = 10;

                if ((from tbl in context.tbl_Employe
                     orderby tbl.idEmploye descending
                     select tbl).First().idTypeEmpl == 1)
                {
                    tbl_ProjetCatEmploye[] pceTemp = new tbl_ProjetCatEmploye[5];
                    for (int i = 0; i < 5; i++)
                    {
                        pceTemp[i] = new tbl_ProjetCatEmploye();

                        pceTemp[i].idProjet = 4;
                        pceTemp[i].idEmploye = (from tbl in context.tbl_Employe
                                                orderby tbl.idEmploye descending
                                                select tbl).First().idEmploye;
                        pceTemp[i].idCategorie = indexCat;

                        indexCat++;

                        context.tbl_ProjetCatEmploye.InsertOnSubmit(pceTemp[i]);
                        context.SubmitChanges();
                    }
                }
                else
                {
                    tbl_ProjetCatEmploye[] pceTemp = new tbl_ProjetCatEmploye[4];
                    for (int i = 0; i < 4; i++)
                    {
                        pceTemp[i] = new tbl_ProjetCatEmploye();

                        pceTemp[i].idProjet = 4;
                        pceTemp[i].idEmploye = (from tbl in context.tbl_Employe
                                                orderby tbl.idEmploye descending
                                                select tbl).First().idEmploye;
                        pceTemp[i].idCategorie = indexCat;

                        indexCat++;

                        //Pour skip la catégorie Temps Supplémentaires
                        if (indexCat == 12)
                            indexCat++;

                        context.tbl_ProjetCatEmploye.InsertOnSubmit(pceTemp[i]);
                        context.SubmitChanges();
                    }
                }
            }




            //Redirection vers la page employés
            Response.Redirect("Employe.aspx");

    }

        protected void btn_annuler_Click(object sender, EventArgs e)
        {
            Response.Redirect("Employe.aspx");
        }
    }
}
