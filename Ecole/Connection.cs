using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ecoule
{
    public class Connection
    {
        SqlConnection con = new SqlConnection();
        public SqlCommand cmd = new SqlCommand();
        public SqlDataAdapter da = new SqlDataAdapter();
        public SqlDataReader dr;

        public SqlConnection _con()
        {
            return con;
        }

        public void Connecter()
        {
            if (con.State == ConnectionState.Closed || con.State == ConnectionState.Broken)
            {
                con.ConnectionString = "data source=(LocalDB)\\MSSQLLocalDB; AttachDbFilename=|Datadirectory|\\DB_Ecoule.mdf; integrated security=true";
                con.Open();
            }
        }

        public void DeConnecter()
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }

        public void Remplir(string TableName, GridView gv)
        {
            DataTable dt = new DataTable();
            if (dt.Rows != null)
            {
                dt.Rows.Clear();
            }
            Connecter();
            cmd.CommandText = "select * from " + TableName;
            cmd.Connection = con;
            da.SelectCommand = cmd;
            da.Fill(dt);
            cmd.Cancel();
            gv.DataSource = dt;
            gv.DataBind();
            DeConnecter();
        }

        public void RemplirSalle(DropDownList dr)
        {
            DataTable dt = new DataTable();
            dt.Rows.Clear();
            Connecter();
            cmd.CommandText = "select NUMERO_SALLE from SALLE";
            cmd.Connection = con;
            da.SelectCommand = cmd;
            da.Fill(dt);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                dr.Items.Add(dt.Rows[i][0].ToString());
            }
        }

        public Boolean VeriverLogin(string TableName,string email, string motPasse)
        {
            Boolean etat = false;
            Connecter();
            try
            {
                cmd.Connection = con;
                if (TableName == "PROFESSEUR")
                {
                    cmd.CommandText = "select EMAIL,MOT_PASSE_PROF from " + TableName + " where EMAIL='" + email + "'";
                }
                else if (TableName == "ETUDIANT")
                {
                    cmd.CommandText = "select EMAIL,MOT_PASSE_ETUDIANT from " + TableName + " where EMAIL='" + email + "'";
                }
                else if (TableName == "ADMIN")
                {
                    cmd.CommandText = "select EMAIL,MOT_PASSE from [" + TableName + "] where EMAIL='"+ email +"'";
                }
                SqlDataReader dr;
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    if ((dr[0].ToString() == email) && (dr[1].ToString() == motPasse))
                    {
                        etat = true;
                    }
                }
                DeConnecter();
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return etat;
        }

        public string GroupEtudiant(int id_group)
        {
            string group;
            string g;
            string s;
            Connecter();
            cmd.Connection = con;
            cmd.CommandText = "select NUMERO_GROUP,NUMERO_SECTION from [GROUP] where ID_GROUP = '" + id_group + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                g = dr[0].ToString();
                s = dr[1].ToString();
                return group = s + "AC" + g;
            }
            DeConnecter();
            return "";
            
        }

        public void ListeExame(int Group, int Exame, GridView gridView)
        {
            DataTable dt = new DataTable();
            Connecter();
            cmd.Connection = con;
            cmd.CommandText = "select etudiant.NUMERO_ETUDIANT,NOM,PRENOM,EXAME.ID_EXAME from ETUDIANT" +
                              "inner join NOTES on ETUDIANT.NUMERO_ETUDIANT=Notes.NUMERO_ETUDIANT " +
                              "inner join exame on notes.id_exame=exame.id_exame where id_group='"+ Group +"' " +
                              "and notes.id_exame='"+ Exame +"'";
            da.SelectCommand = cmd;
            da.Fill(dt);
            DeConnecter();
            gridView.DataSource = dt;
            gridView.DataBind();
        }

        Boolean VeriverExame(int exame, int etd)
        {
            DataTable dt = new DataTable();
            Connecter();
            cmd.Connection = _con();
            cmd.CommandText = "select NOTES.NUMERO_ETUDIANT from ETUDIANT inner join NOTES on ETUDIANT.NUMERO_ETUDIANT=NOTES.NUMERO_ETUDIANT where ID_EXAME ='" + exame + "' and NOTES.NUMERO_ETUDIANT='" + etd + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            string result = "";
            while (dr.Read())
            {
                result = dr[0].ToString();
            }
            DeConnecter();
            if (result != "")
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public void ListeParticiper(int Group, GridView gridView)
        {
            DataTable dt = new DataTable();
            Connecter();
            cmd.Connection = _con();
            cmd.CommandText = "select etudiant.NUMERO_ETUDIANT,NOM,PRENOM from ETUDIANT " +
                                  "where id_group='" + Group + "' ";
            da.SelectCommand = cmd;
            da.Fill(dt);
            DeConnecter();
            gridView.DataSource = dt;
            gridView.DataBind();
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

        public DataTable RecharcheProf(string email)
        {
            DataTable dt = new DataTable();
            dt.Clear();
            try
            {
                Connecter();
                cmd.Connection = _con();
                cmd.CommandText = "select MATRICULE,NOM,PRENOM,TELEPHONE,LEFT(DATENAISSANCE,11),MOT_PASSE_PROF,EMAIL,ADRESSE,SEXE,LIBELLE from PROFESSEUR " +
                    "inner join MODULE on PROFESSEUR.ID_MODULE=MODULE.ID_MODULE where EMAIL='" + email.ToString() + "'";
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

        public void Group(int prof, DropDownList d)
        {
            d.Items.Clear();
            Connecter();
            cmd.Connection = _con();
            cmd.CommandText = "select distinct convert(varchar, [GROUP].NUMERO_SECTION)+ 'AC' + " +
                                              "convert(varchar,[GROUP].NUMERO_GROUP)" +
                              " as [Group] from[GROUP] inner join DETAIL_SEANCE on[GROUP].ID_GROUP = DETAIL_SEANCE.ID_GROUP" +
                              " inner join MODULE on MODULE.ID_MODULE = DETAIL_SEANCE.ID_MODULE " +
                              "inner join SEANCE on DETAIL_SEANCE.ID_SEANCE = SEANCE.ID_SEANCE " +
                              "inner join PROFESSEUR on DETAIL_SEANCE.PROFESSEUR = PROFESSEUR.MATRICULE " +
                              "where PROFESSEUR.MATRICULE = '"+ prof +"'";
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                d.Items.Add(dr[0].ToString());
            }
            DeConnecter();
        }

        // pour remplir les atributs de l'objet a partir de la base de donnee
        //public static void ChargerProf(Prof p, string email)
        //{
        //    DataTable dt = new DataTable();
        //    try
        //    {
        //        Connection con = new Connection();
        //        con.Connecter();
        //        con.cmd.Connection = con._con();
        //        con.cmd.CommandText = "select * from PROFESSEUR where EMAIL='" + email.ToString() + "'";
        //        con.da.SelectCommand = con.cmd;
        //        con.da.Fill(dt);
        //        con.DeConnecter();
        //        p.Nom = dt.Rows[0][1].ToString();
        //        p.Prenom = dt.Rows[0][2].ToString();
        //        p.DateNaissance = Convert.ToDateTime(dt.Rows[0][3].ToString());
        //        p.Tele = dt.Rows[0][4].ToString();
        //        p.Mot_passe = dt.Rows[0][6].ToString();
        //        p.Sexe = dt.Rows[0][7].ToString();
        //        p.Adresse = dt.Rows[0][8].ToString();
        //        p.Salaire = float.Parse(dt.Rows[0][9].ToString());
        //    }
        //    catch (Exception ex)
        //    {
        //        Console.WriteLine(ex.Message);
        //    }
        //}
        // pour charger les info a partir de la base de donnee

        /*public DataTable Recharche(string TableName, string email)
        {
            DataTable dt = new DataTable();
            try
            {
                Connecter();
                cmd.Connection = con;
                if (TableName == "ETUDIANT")
                {
                    cmd.CommandText = "select NUMERO_ETUDIANT,ID_GROUP,NOM,PRENOM,TELEPHONE,LEFT(DATENAISSANCE,10),MOT_PASSE_ETUDIANT,EMAIL,ADRESSE,SEXE from ETUDIANT where EMAIL='" + email.ToString() + "'";
                }
                else if (TableName == "PROFESSEUR")
                {
                    cmd.CommandText = "select MATRICULE,NOM,PRENOM,TELEPHONE,LEFT(DATENAISSANCE,10),MOT_PASSE_PROF,EMAIL,ADRESSE,SEXE from PROFESSEUR where EMAIL='" + email.ToString() + "'";
                }
                da.SelectCommand = cmd;
                da.Fill(dt);
                DeConnecter();
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return dt;
        }*/

        public void Seance(int prof, int group, DropDownList cmb)
        {
            DataTable dt = new DataTable();
            Connecter();
            cmd.Connection = _con();
            cmd.CommandText = "select ID_SEANCE from DETAIL_SEANCE " +
                                 "where PROFESSEUR = '" + prof + "' and ID_GROUP='"+ group +"'";
            da.SelectCommand = cmd;
            da.Fill(dt);
            DeConnecter();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                cmb.Items.Add(dt.Rows[i][0].ToString());
            }
        }

        public int nbrEtd()
        {
            int nbr = 0;
            Connecter();
            SqlCommand cmm = new SqlCommand("select count(*) from ETUDIANT",_con());
            nbr = int.Parse(cmm.ExecuteScalar().ToString());
            DeConnecter();
            return nbr;
        }

        public int nbrProf()
        {
            int nbr = 0;
            Connecter();
            SqlCommand cmm = new SqlCommand("select count(*) from PROFESSEUR", _con());
            nbr = int.Parse(cmm.ExecuteScalar().ToString());
            DeConnecter();
            return nbr;
        }

        public int nbrGroup()
        {
            int nbr = 0;
            Connecter();
            SqlCommand cmm = new SqlCommand("select count(*) from [GROUP]", _con());
            nbr = int.Parse(cmm.ExecuteScalar().ToString());
            DeConnecter();
            return nbr;
        }

        public int nbrExame()
        {
            int nbr = 0;
            Connecter();
            SqlCommand cmm = new SqlCommand("select count(*) from Exame", _con());
            nbr = int.Parse(cmm.ExecuteScalar().ToString());
            DeConnecter();
            return nbr;
        }

        public int nbrModule()
        {
            int nbr = 0;
            Connecter();
            SqlCommand cmm = new SqlCommand("select count(*) from MODULE", _con());
            nbr = int.Parse(cmm.ExecuteScalar().ToString());
            DeConnecter();
            return nbr;
        }

        public int nbrSalle()
        {
            int nbr = 0;
            Connecter();
            SqlCommand cmm = new SqlCommand("select count(*) from SALLE", _con());
            nbr = int.Parse(cmm.ExecuteScalar().ToString());
            DeConnecter();
            return nbr;
        }

    }
}