using FluentScheduler;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Web;

namespace UrbanEco {
    public class RappelJob : IJob {
        public void Execute() {
            CoecoDataContext ctx = new CoecoDataContext();
            tbl_ConfigAdmin config = ctx.tbl_ConfigAdmin.First();

            DateTime lastWeek = DateTime.Now.AddDays(-7);

            var heuresLastWeek = from heure in ctx.tbl_FeuilleTemps
                                    where heure.dateCreation > lastWeek
                                    select heure;

            var emailBureau = from employe in ctx.tbl_Employe
                                join heure in heuresLastWeek on employe.idEmploye equals heure.idEmploye into joined
                                from eh in joined.DefaultIfEmpty()
                                where eh == null && !(bool)employe.inactif && employe.idTypeEmpl == 1
                                select employe.email;

            var emailTerrain = from employe in ctx.tbl_Employe
                               join heure in heuresLastWeek on employe.idEmploye equals heure.idEmploye into joined
                               from eh in joined.DefaultIfEmpty()
                               where eh == null && !(bool)employe.inactif && employe.idTypeEmpl == 2
                               select employe.email;

            /*if ((bool)config.statutRappelBureau) {
                foreach (string email in emailBureau.ToList()) {
                    if (!String.IsNullOrEmpty(email)) {
                        Courriel courriel = new Courriel(email, config);
                        courriel.Send();
                    }
                }
            }

            if ((bool)config.statutRappelTerrain) {
                foreach (string email in emailTerrain.ToList()) {
                    if (!String.IsNullOrEmpty(email)) {
                        Courriel courriel = new Courriel(email, config);
                        courriel.Send();
                    }
                }
            }*/
        }
    }

    public class Courriel {
        private List<string> destinataires;

        private tbl_ConfigAdmin config;

        public Courriel(List<string> p_Destinaires, tbl_ConfigAdmin p_config) {
            destinataires = p_Destinaires;
            config = p_config;
        }

        public Courriel(string p_Destinaires, tbl_ConfigAdmin p_config) {
            destinataires = new List<string>() { p_Destinaires };
            config = p_config;
        }

        public void Send() {
            SmtpClient smtp = new SmtpClient(config.smtpServer);
            smtp.Port = config.smtpPort;
            smtp.Credentials = new System.Net.NetworkCredential(config.emailRappel, config.pwdEmailRappel);
            smtp.EnableSsl = (bool)config.smtpSSL;

            MailMessage mail = new MailMessage();
            mail.From = new MailAddress(config.emailRappel);

            foreach (string destinataire in destinataires) {
                mail.To.Add(destinataire);
            }

            mail.Subject = config.objetRappel;
            mail.Body = config.contenuRappel;

            smtp.Send(mail);
        }
    }
}