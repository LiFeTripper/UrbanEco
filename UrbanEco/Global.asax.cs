using FluentScheduler;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace UrbanEco
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e) {
            CoecoDataContext ctx = new CoecoDataContext();
            tbl_ConfigAdmin config = ctx.tbl_ConfigAdmin.First();
            Registry registry = new Registry();

            DayOfWeek day = DayOfWeek.Friday;
            switch (config.jourRappel) {
                case "Dimanche":
                    day = DayOfWeek.Sunday;
                    break;
                case "Lundi":
                    day = DayOfWeek.Monday;
                    break;
                case "Mardi":
                    day = DayOfWeek.Tuesday;
                    break;
                case "Mercredi":
                    day = DayOfWeek.Wednesday;
                    break;
                case "Jeudi":
                    day = DayOfWeek.Thursday;
                    break;
                case "Vendredi":
                    day = DayOfWeek.Friday;
                    break;
                case "Samedi":
                    day = DayOfWeek.Saturday;
                    break;
                default:
                    day = DayOfWeek.Monday;
                    break;
            }
            RappelJob rappel = new RappelJob();
            rappel.Execute();
            //registry.Schedule(() => rappel).ToRunEvery(0).Weeks().On(DayOfWeek.Wednesday).At(9, 53);
            //registry.Schedule(() => new RappelJob()).ToRunEvery(0).Weeks().On(day).At(config.heureRappel.Hours, config.heureRappel.Minutes);
            JobManager.Initialize(registry);
        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}