using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace UrbanEco
{
    public partial class Home : System.Web.UI.Page
    {

        SqlConnection connection = new SqlConnection(@"Server=localhost;Database=BD_Coeco;User Id=WEB_USER;Password=1234;Integrated Security=True");

        string lastError = "";

        protected void Page_Load(object sender, EventArgs e)
        {


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
                                int idClient = reader.GetInt32(0);


                               /*string nomClient = reader.GetString(1);
                                string prenomClient = reader.GetString(2);
                                string telephone = reader.GetString(3);
                                string adresse = reader.GetString(4);
                                string ville = reader.GetString(5);
                                string courriel = reader.GetString(6);

                                client = new Clients(prenomClient, nomClient, courriel, telephone, adresse, ville);

                                client.SetID(idClient);

                                if (client != null)
                                {
                                    result.Add(client);
                                }*/
                            }
                        }
                        else
                        {
                            lastError = "Aucun Employe disponnible";
                        }

                        reader.Close();
                        connection.Close();

                        //MessageBox.Show(result);

                    }
                }
                catch (Exception ex)
                {
                    lastError = ex.Message;
                }

            }
            
        }
    }
}