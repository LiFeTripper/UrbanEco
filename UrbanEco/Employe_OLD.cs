using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;

namespace UrbanEco
{
    public class Employe
    {
        public int idEmploye;
        public string prenom;
        public string nom;
        public int idTypeEmpl;
        public string noTel;
        public string email;
        public string username;
        public string password;
        public bool inactif;

        public Employe(SqlDataReader reader)
        {
            idEmploye = reader.GetInt32(0);
            prenom = reader.GetString(1);
            nom = reader.GetString(2);
            idTypeEmpl = reader.GetInt32(3);
            noTel = reader.GetString(4);
            email = reader.GetString(5);
            username = reader.GetString(6);
            password = reader.GetString(7);
            inactif = reader.GetBoolean(8);
        }

        public string GetFullName()
        {
            return string.Format("{0} {1}", prenom, nom);
        }
    }
}