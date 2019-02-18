using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace UrbanEco
{
	public class Autorisation2
	{
		/// <summary>
        /// Autorisations
        /// </summary>
        /// <param name="bureau">Bureau</param>
        /// <param name="terrain">Terrain</param>
		public static void Autorisation(bool bureau, bool terrain)
        {
            if (HttpContext.Current.Session["username"] != null)
            {
                string username = HttpContext.Current.Session["username"].ToString();
                int idFonction = int.Parse(HttpContext.Current.Session["fonction"].ToString());

				if(username == "admin")
                {
                    return;
                }

                //1 bureau
                if (idFonction == 1 && bureau)
                {
                    return;
                }

                //2 terrain
                if (idFonction == 2 && terrain)
                {
                    return;
                }

                HttpContext.Current.Response.Redirect("/Login.aspx");
            }
            else
            {
                HttpContext.Current.Response.Redirect("/Login.aspx");
            }
        }
	}
}