using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;

namespace UrbanEco
{
    public static class BD
    {
        static SqlConnection connection = new SqlConnection(@"Server=localhost;Database=BD_Coeco;User Id=WEB_USER;Password=1234;Integrated Security=True");

        public static string lastError = "";

        public static List<Employe> GetEmployes()
        {
            List<Employe> employes = new List<Employe>();

            using (SqlCommand cmd = connection.CreateCommand())
            {

                cmd.CommandText = "SELECT * FROM tbl_employe";

                if (connection.State == System.Data.ConnectionState.Closed)
                    connection.Open();

                try
                {

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {


                            while (reader.Read())
                            {
                                Employe emp = new Employe(reader);

                                if (emp != null)
                                {
                                    employes.Add(emp);
                                }
                            }
                        }
                        else
                        {
                            lastError = "Aucun Employe disponnible";
                        }

                        reader.Close();
                        connection.Close();


                    }
                }
                catch (Exception ex)
                {
                    lastError = ex.Message;
                }

            }

            return employes;
        }

        public static List<Projet> GetProjets()
        {
            List<Projet> projets = new List<Projet>();

            using (SqlCommand cmd = connection.CreateCommand())
            {

                cmd.CommandText = "SELECT [idProjet],[titre],[description],[p].[idStatus],[idEmployeResp],[tempsAllouer],[dateDebut],[dateFin],[archiver],[s].[nomStatus] FROM[BD_Coeco].[dbo].[tbl_Projet] AS p JOIN tbl_Status AS s ON p.idStatus = s.idStatus";

                if (connection.State == System.Data.ConnectionState.Closed)
                    connection.Open();

                try
                {

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {


                            while (reader.Read())
                            {
                                Projet projet = new Projet(reader);

                                if (projet != null)
                                {
                                    projets.Add(projet);
                                }
                            }
                        }
                        else
                        {
                            lastError = "Aucun Projet disponnible";
                        }

                        reader.Close();
                        connection.Close();


                    }
                }
                catch (Exception ex)
                {
                    lastError = ex.Message;
                }

            }

            return projets;
        }
    }
}