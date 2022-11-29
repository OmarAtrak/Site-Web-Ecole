using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace Ecoule
{
    public class Etudiant : Personne
    {
        // l'attribut d'etudiant
        private int group;

        
        // les proprietes
        public int Group { get => group; set => group = value; }


        // constrecture d'initialisation
        public Etudiant() { }


        // constrecture d'initialisation
        public Etudiant(int group, string nom, string prenom, string tele, DateTime dateNaissance,
                        string adresse, string sexe, string mot_passe)
            : base(nom, prenom, tele, dateNaissance, adresse, sexe, mot_passe)
        {
            this.Group = group;
        }


        public void Ajout()
        {
            Connecter();
            SqlCommand cmm = new SqlCommand("insert into ETUDIANT (ID_GROUP,NOM,PRENOM,TELEPHONE,DATENAISSANCE,MOT_PASSE_ETUDIANT,ADRESSE,SEXE) values('" +
                            Group + "','" +
                            Nom + "','" +
                            Prenom + "','" +
                            Tele + "','" +
                            DateNaissance + "','" +
                            Mot_passe + "','" +
                            Adresse + "','" +
                            Sexe + "')", _con());
            cmm.ExecuteNonQuery();
            DeConnecter();
            //Connecter();
            //SqlCommand cmm = new SqlCommand("insert into ETUDIANT valeus('"+ Group +"','"+ Nom +"','"+ Prenom +"','"+ Tele +"','"+ DateNaissance +"','"+ Mot_passe +"','"+ Adresse +"','"+ Sexe +"')",_con());
            //cmm.ExecuteNonQuery();
            //DeConnecter();
        }

        // pour modifer les informations d'etudiant
        public void Modifer(int Numero)
        {
            try
            {
                Connecter();
                SqlCommand cmm = new SqlCommand("update ETUDIANT set NOM='" + Nom + "',PRENOM='" + Prenom +
                                                "',ID_GROUP='" + Group + "',TELEPHONE='" + Tele +
                                                "',DATENAISSANCE='" + Convert.ToDateTime(DateNaissance) +
                                                "',MOT_PASSE_ETUDIANT='" + Mot_passe +
                                                "',ADRESSE='" + Adresse +
                                                "',SEXE='" + Sexe +
                                                "' where NUMERO_ETUDIANT='" + Numero + "'", _con());
                cmm.ExecuteNonQuery();
                DeConnecter();
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
        }

        // pour supprimer un etudiant
        public void Supprimer(int Numero)
        {
            try
            {
                Connecter();
                SqlCommand cmd = new SqlCommand("delete ETUDIANT where NUMERO_ETUDIANT='" + Numero + "'", _con());
                cmd.ExecuteNonQuery();
                DeConnecter();
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
        }

        // pour changer mot de passe
        public void ChangerMotPasse(int Numero)
        {
            try
            {
                Connecter();
                cmd.Connection = _con();
                cmd.CommandText = "update ETUDIANT set MOT_PASSE_ETUDIANT='" + Mot_passe +
                         "'where NUMERO_ETUDIANT='" + int.Parse(Numero.ToString()) + "'";
                cmd.ExecuteNonQuery();
                DeConnecter();
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
                cmd.CommandText = "select NUMERO_ETUDIANT,ID_GROUP,NOM,PRENOM,TELEPHONE,LEFT(DATENAISSANCE,10),MOT_PASSE_ETUDIANT,EMAIL,ADRESSE,SEXE from ETUDIANT where EMAIL='" + email.ToString() + "'";
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


        // pour remplir les atributs de l'objet a partir de la base de donnee
        public static void Charger(Etudiant e, string email)
        {
            DataTable dt = new DataTable();
            try
            {
                Connection con = new Connection();
                con.Connecter();
                con.cmd.Connection = con._con();
                con.cmd.CommandText = "select * from ETUDIANT where EMAIL='" + email.ToString() + "'";
                con.da.SelectCommand = con.cmd;
                con.da.Fill(dt);                
                con.DeConnecter();

                e.Group = int.Parse(dt.Rows[0][1].ToString());
                e.Nom = dt.Rows[0][2].ToString();
                e.Prenom = dt.Rows[0][3].ToString();
                e.Tele = dt.Rows[0][4].ToString();
                e.DateNaissance = Convert.ToDateTime(dt.Rows[0][5].ToString());
                e.Adresse = dt.Rows[0][8].ToString();
                e.Sexe = dt.Rows[0][9].ToString();
                e.Mot_passe = dt.Rows[0][6].ToString();
                //Etudiant e = new Etudiant(int.Parse(dt.Rows[0][1].ToString()), dt.Rows[0][2].ToString(), dt.Rows[0][3].ToString(), dt.Rows[0][4].ToString(), Convert.ToDateTime(dt.Rows[0][5].ToString()), dt.Rows[0][8].ToString(), dt.Rows[0][9].ToString(), dt.Rows[0][6].ToString());
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

        /*public float MoyenneGroup(int num, int annee, int semetre)
        {
            float i = 0;
            Connecter();
            cmd.Connection = _con();
            cmd.CommandText = "select dbo.MoyenneGroup('" + int.Parse(num.ToString()) + "','" + int.Parse(annee.ToString()) + "','" + int.Parse(semetre.ToString()) + "')";
            SqlDataReader dr;
            dr = cmd.ExecuteNonQuery();
            i = float.Parse(dr[0].ToString());
            DeConnecter();
            return i;
        }*/

        public float MoyenneGeneral(int num, int annee, int semetre)
        {
            float i = 0;
            Connecter();
            cmd.Connection = _con();
            cmd.CommandText = "exec dbo.MoyenneGroup(11,2022,1)";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            i = float.Parse(dr[0].ToString());
            DeConnecter();
            return i;
        }

        public DataTable MesProf(int num)
        {
            DataTable dt = new DataTable();
            Connecter();
            cmd.Connection = _con();
            cmd.CommandText = "select NOM,PRENOM,GMAIL from PROFESSEUR";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                dt.Rows.Add(dr[0].ToString(),dr[1].ToString(), "<a href='mailto:'"+dr[2].ToString()+"''>Contact mon Prof</a>");
            }
            dr.Close();
            DeConnecter();
            return dt;
        }
    }
}