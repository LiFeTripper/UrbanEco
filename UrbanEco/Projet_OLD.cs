using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;

namespace UrbanEco
{
    public class Projet
    {

        int idProjet;
        string titre;
        string description;
        int idStatus;
        int idEmployeResp;
        float tempsAllouer;
        DateTime dateDebut;
        DateTime dateFin;
        bool archiver;

        Employe employeResponsable;

        public Projet(SqlDataReader reader)
        {
            idProjet = reader.GetInt32(0);
            titre = reader.GetString(1);
            description = reader.GetString(2);
            idStatus = reader.GetInt32(3);
            idEmployeResp = reader.GetInt32(4);
            tempsAllouer = reader.GetFloat(5);
            dateDebut = reader.GetDateTime(6);
            dateFin = reader.GetDateTime(7);
            archiver = reader.GetBoolean(8);
        }

        public Employe GetEmployeResponsable()
        {
            return employeResponsable;
        }

    }
}