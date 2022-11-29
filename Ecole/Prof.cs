using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ecoule
{
    public class Prof : Personne
    {
        /* les attributs
        private double salaire;

        public double Salaire { get => salaire; set => salaire = value; }


        // constrecture par defaut
        public Prof() { }


        // constrecture d'initialisation
        public Prof(double salaire, string nom, string prenom, string tele, DateTime dateNaissance,
                    string adresse, string sexe, string mot_passe)
            : base(nom, prenom, tele, dateNaissance, adresse, sexe, mot_passe)
        {
            this.Salaire = salaire;
        }

        public void Modifer()
        {
            try
            {

            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
        }

        public void Supprimer()
        {
            try
            {

            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);

            }
        }

        // pour charger les info a partir de la base de donnee
        public DataTable Recharche(string email)
        {
            DataTable dt = new DataTable();
            try
            {
                Connecter();
                cmd.Connection = _con();
                cmd.CommandText = "select MATRICULE,NOM,PRENOM,TELEPHONE,LEFT(DATENAISSANCE,11),MOT_PASSE_PROF,EMAIL,ADRESSE,SEXE from PROFESSEUR where EMAIL='" + email.ToString() + "'";
                da.SelectCommand = cmd;
                da.Fill(dt);
                DeConnecter();
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return dt;
        }

        public DataTable Seance(int num)
        {
            DataTable dt = new DataTable();
            Connecter();
            cmd.Connection = _con();
            cmd.CommandText = "select ID_SEANCE from DETAIL_SEANCE " +
                                 "where PROFESSEUR = '" + int.Parse(num.ToString()) + "'";
            da.SelectCommand = cmd;
            da.Fill(dt);
            DeConnecter();
            return dt;
        }

        public DataTable Group(string num)
        {
            DataTable dt = new DataTable();
            Connecter();
            cmd.Connection = _con();
            cmd.CommandText = "select distinct ID_GROUP from DETAIL_SEANCE " +
                                 "where PROFESSEUR = '" + num + "'";
            da.SelectCommand = cmd;
            da.Fill(dt);
            DeConnecter();
            return dt;
        }

        public DataTable Exame(int num)
        {
            DataTable dt = new DataTable();
            Connecter();
            cmd.Connection = _con();
            cmd.CommandText = "select ID_EXAME from EXAME inner join MODULE on EXAME.ID_MODULE=MODULE.ID_MODULE inner join DETAIL_SEANCE on MODULE.ID_MODULE=DETAIL_SEANCE.ID_MODULE  " +
                                 "where PROFESSEUR = '" + num + "'";
            da.SelectCommand = cmd;
            da.Fill(dt);
            DeConnecter();
            return dt;
        }

        public void ListeExame(string Group, string Exame, GridView gridView)
        {
            DataTable dt = new DataTable();
            Connecter();
            cmd.Connection = _con();
            cmd.CommandText = "(select ETUDIANT.NUMERO_ETUDIANT,NOM,PRENOM,NOTE from ETUDIANT " +
                              "left join NOTES on ETUDIANT.NUMERO_ETUDIANT=NOTES.NUMERO_ETUDIANT " +
                              "where ID_GROUP = '" + Group + "')" +
                              "except" +
                              "(select ETUDIANT.NUMERO_ETUDIANT,NOM,PRENOM,NOTE from ETUDIANT " +
                              "left join NOTES on ETUDIANT.NUMERO_ETUDIANT = NOTES.NUMERO_ETUDIANT " +
                              "where ID_GROUP = '" + Group + "' and ID_EXAME != '" + Exame + "')";
            da.SelectCommand = cmd;
            da.Fill(dt);
            DeConnecter();
            gridView.DataSource = dt;
            gridView.DataBind();
        }

        public void ValiderSeance()
        {
            
        }

        public void ValiderExame(string etd, string exame, string note)
        {
            Connecter();
            cmd.Connection = _con();
            cmd.CommandText = "insert into NOTES (ID_EXAME,NUMERO_ETUDIANT,NOTE) values('" + int.Parse(exame) + "','" + int.Parse(etd) + "','" + float.Parse(note) + "')";
            cmd.ExecuteNonQuery();
            DeConnecter();
        }

        // pour remplir les atributs de l'objet a partir de la base de donnee
        public static void Charger(Prof p, string email)
        {
            DataTable dt = new DataTable();
            try
            {
                Connection con = new Connection();
                con.Connecter();
                con.cmd.Connection = con._con();
                con.cmd.CommandText = "select * from PROFESSEUR where EMAIL='" + email.ToString() + "'";
                con.da.SelectCommand = con.cmd;
                con.da.Fill(dt);
                con.DeConnecter();
                p.Nom = dt.Rows[0][1].ToString();
                p.Prenom = dt.Rows[0][2].ToString();
                p.DateNaissance = Convert.ToDateTime(dt.Rows[0][3].ToString());
                p.Tele = dt.Rows[0][4].ToString();
                p.Mot_passe = dt.Rows[0][6].ToString();
                p.Sexe = dt.Rows[0][7].ToString();
                p.Adresse = dt.Rows[0][8].ToString();
                p.Salaire = float.Parse(dt.Rows[0][9].ToString());
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }*/
    }
}