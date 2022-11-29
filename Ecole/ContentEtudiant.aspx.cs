using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

namespace Ecoule
{
    public partial class PageContentEtudiant : System.Web.UI.Page
    {
        Connection con = new Connection();
        Boolean etat = true;

        protected void Page_Load(object sender, EventArgs e)
        {
            txtRecherchEtd.Attributes.Add("placeholder", "Recherche Par le Nom ou le Prenom");

            if (!Page.IsPostBack && (etat == true))
            {
                bindgridview();
            }
        }

        private void bindgridview()
        {
            var data = Remplir();
            ListEtudiant.DataSource = data;
            ListEtudiant.DataBind();
        }

        public DataTable Remplir()
        {
            DataTable dt = new DataTable();
            if (dt != null)
            {
                dt.Rows.Clear();
            }
            con.Connecter();
            con.cmd.Connection = con._con();
            con.cmd.CommandText = "select NUMERO_ETUDIANT," +
                "(convert(varchar,NUMERO_SECTION)+'AC'+convert(varchar,NUMERO_GROUP)) as groupEtd,NOM,PRENOM,TELEPHONE," +
                "LEFT(DATENAISSANCE,10) as Date,MOT_PASSE_ETUDIANT,EMAIL,ADRESSE,SEXE from ETUDIANT " +
                "inner join [GROUP] on ETUDIANT.ID_GROUP=[GROUP].ID_GROUP";
            con.da.SelectCommand = con.cmd;
            con.da.Fill(dt);

            // methode exporter XML
            DataSet ds = new DataSet(); 
            con.da.Fill(ds,"ETUDIANT");
            con.DeConnecter();
            ds.WriteXml(@"C:\Users\OMAR\Desktop\Ecoule\XML\TableEtudiant.xml");

            return dt;
        }

        protected void btnAjoutEtd_Click(object sender, EventArgs e)
        {
            if (txtNomEtd.Text != "" && txtPrenomEtd.Text != "" && 
                txtDateEtd.Text != "" && txtTeleEtd.Text != "" && 
                txtMotPasseEtd.Text != "" && txtAdresseEtd.Text != "" && 
                ((sexeEtd.Items[0].Selected == true) || (sexeEtd.Items[1].Selected == true)))
            {
                Regex r = new Regex(@"^[0][5-6-7][0-9]{8}$");
                if (r.IsMatch(txtTeleEtd.Text) && txtTeleEtd.Text.Length == 10)
                {
                    if (txtMotPasseEtd.Text.Length == 10)
                    {
                        try
                        {
                            con.Connecter();
                            con.cmd.Connection = con._con();
                            con.cmd.CommandText = "select top(1) NUMERO_ETUDIANT from ETUDIANT order by NUMERO_ETUDIANT desc";
                            int nbr1 = int.Parse(con.cmd.ExecuteScalar().ToString());
                            con.cmd.Parameters.Clear();
                            con.cmd.CommandText = "select dbo.idGroup('" + txtGroupEtd.Text + "')";
                            int GroupEtd = int.Parse(con.cmd.ExecuteScalar().ToString());
                            con.cmd.Parameters.Clear();
                            Etudiant etd = new Etudiant(GroupEtd, txtNomEtd.Text, txtPrenomEtd.Text, txtTeleEtd.Text, Convert.ToDateTime(txtDateEtd.Text), txtAdresseEtd.Text, sexeEtd.SelectedValue, txtMotPasseEtd.Text);
                            etd.Ajout();
                            con.cmd.CommandText = "select top(1) NUMERO_ETUDIANT from ETUDIANT order by NUMERO_ETUDIANT desc";
                            int nbr2 = int.Parse(con.cmd.ExecuteScalar().ToString());
                            if (nbr1 != nbr2)
                            {
                                lblmsg.Text = "Operation Effectuee";
                                lblmsg.ForeColor = System.Drawing.Color.Green;
                            }
                            con.DeConnecter();
                            Response.Redirect(Page.Request.Path);
                        }
                        catch (Exception ex)
                        {
                            lblmsg.Text = "Vérifier les Donnees";
                            lblmsg.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                    else
                    {
                        lblmsg.Text = "le Nombre de caractere de Mot de Passe doit etre 10 Caracteres";
                        lblmsg.ForeColor = System.Drawing.Color.Red;
                    }
                    
                }
                else
                {
                    lblmsg.Text = "Format de Numero de Telephone est Incorrect";
                    lblmsg.ForeColor = System.Drawing.Color.Red;
                }
            }
            else
            {
                lblmsg.Text = "Remplir les Donnees";
                lblmsg.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnModifier_Click(object sender, EventArgs e)
        {
            string str = "";
            if (txtNomEtd.Text != "" && txtPrenomEtd.Text != "" && txtDateEtd.Text != "" && txtTeleEtd.Text != "" && txtMotPasseEtd.Text != "" && txtAdresseEtd.Text != "" && ((sexeEtd.Items[0].Selected == true) || (sexeEtd.Items[1].Selected == true)))
            {
                con.Connecter();
                con.cmd.Connection = con._con();
                con.cmd.CommandText = "select dbo.idGroup('" + txtGroupEtd.Text + "')";
                int GroupEtd = int.Parse(con.cmd.ExecuteScalar().ToString());
                con.DeConnecter();

                Etudiant etd = new Etudiant();
                Etudiant.Charger(etd, ListEtudiant.SelectedRow.Cells[7].Text);
                etd.Nom = txtNomEtd.Text;
                etd.Prenom = txtPrenomEtd.Text;
                etd.Group = GroupEtd;
                etd.DateNaissance = Convert.ToDateTime(txtDateEtd.Text);
                etd.Tele = txtTeleEtd.Text;
                etd.Mot_passe = txtMotPasseEtd.Text;
                etd.Adresse = txtAdresseEtd.Text;
                etd.Sexe = sexeEtd.SelectedValue;

                etd.Modifer(int.Parse(ListEtudiant.SelectedRow.Cells[1].Text));
                Response.Redirect(Page.Request.RawUrl);
            }
            else
            {
                lblmsg.Text = "Remplir les Donnees";
                lblmsg.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnSupprimer_Click(object sender, EventArgs e)
        {
            string str = "";
            try
            {
                if (txtNomEtd.Text != "" && txtPrenomEtd.Text != "" && txtDateEtd.Text != "" && txtTeleEtd.Text != "" && txtMotPasseEtd.Text != "" && txtAdresseEtd.Text != "" && (sexeEtd.Items[0].Selected == true) || (sexeEtd.Items[1].Selected == true))
                {
                    Etudiant etd = new Etudiant();
                    etd.Supprimer(int.Parse(ListEtudiant.SelectedRow.Cells[1].Text));

                    Response.Redirect(Page.Request.Path);
                }
            }
            catch (Exception ex)
            {
                str = ex.Message;
                Response.Write("<script language='javascript'>alert('" + str + "');</script>");
            }
        }

        protected void btnInsialiser_Click(object sender, EventArgs e)
        {
            Response.Redirect(Page.Request.Path);
        }

        protected void ListEtudiant_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtNomEtd.Text = ListEtudiant.SelectedRow.Cells[3].Text;
            txtPrenomEtd.Text = ListEtudiant.SelectedRow.Cells[4].Text;
            txtGroupEtd.Text = ListEtudiant.SelectedRow.Cells[2].Text;
            txtDateEtd.Text = Convert.ToDateTime(ListEtudiant.SelectedRow.Cells[6].Text).ToString("yyyy-MM-dd");
            txtTeleEtd.Text = ListEtudiant.SelectedRow.Cells[5].Text;
            txtMotPasseEtd.Text = ListEtudiant.SelectedRow.Cells[8].Text;
            txtAdresseEtd.Text = ListEtudiant.SelectedRow.Cells[9].Text;
            if (ListEtudiant.SelectedRow.Cells[10].Text == "M")
            {
                sexeEtd.Items[0].Selected = true;
                sexeEtd.Items[1].Selected = false;
            }
            else if (ListEtudiant.SelectedRow.Cells[10].Text == "F")
            {
                sexeEtd.Items[0].Selected = false;
                sexeEtd.Items[1].Selected = true;
            }
            tblEtudiant.Focus();
        }

        protected void txtRecherchEtd_TextChanged(object sender, EventArgs e)
        {
            //DataTable dt = new DataTable();
            //con.Connecter();
            //con.cmd.Connection = con._con();
            //con.cmd.CommandText = "select NUMERO_ETUDIANT,ID_GROUP,NOM,PRENOM,TELEPHONE,LEFT(DATENAISSANCE,10) as Date,MOT_PASSE_ETUDIANT,EMAIL,ADRESSE,SEXE from ETUDIANT " +
            //    "where NOM like '" + txtRecherchEtd.Text + "%' or PRENOM like '"+ txtRecherchEtd.Text +"%'";
            //con.da.SelectCommand = con.cmd;
            //con.da.Fill(dt);
            //con.DeConnecter();
            //ListEtudiant.DataSource = dt;
            //ListEtudiant.DataBind();
        }

        protected void btnRechercheEtd1_Click(object sender, ImageClickEventArgs e)
        {
            DataTable dt = new DataTable();
            con.Connecter();
            con.cmd.Connection = con._con();
            con.cmd.CommandText = "select NUMERO_ETUDIANT,convert(varchar,NUMERO_SECTION)+'AC'+convert(varchar,NUMERO_GROUP) as groupEtd, NOM,PRENOM,TELEPHONE,LEFT(DATENAISSANCE,10) as Date,MOT_PASSE_ETUDIANT,EMAIL,ADRESSE,SEXE from ETUDIANT " +
                                  "inner join [GROUP] on ETUDIANT.ID_GROUP=[GROUP].ID_GROUP " +
                                  "where NOM like '" + txtRecherchEtd.Text + "%' or PRENOM like '"+ txtRecherchEtd.Text +"%'";
            con.da.SelectCommand = con.cmd;
            con.da.Fill(dt);
            con.DeConnecter();
            ListEtudiant.DataSource = dt;
            ListEtudiant.DataBind();
            etat = false;
            if (ListEtudiant.Rows.Count == 0)
            {
                lblmsgrecherche.Visible = true;
            }
            else
            {
                lblmsgrecherche.Visible = false;
            }
        }

        protected void ListEtudiant_Sorting(object sender, GridViewSortEventArgs e)
        {
            string sortExp = e.SortExpression;
            string dirction = string.Empty;
            if (sortDir==SortDirection.Ascending)
            {
                sortDir = SortDirection.Descending;
                dirction = " DESC";
            }
            else
            {
                sortDir = SortDirection.Ascending;
                dirction = " ASC";
            }
            DataTable dt = Remplir();
            dt.DefaultView.Sort = sortExp + dirction;
            ListEtudiant.DataSource = dt;
            ListEtudiant.DataBind();
        }

        public SortDirection sortDir
        {
            get {
                if (ViewState["sortDir"]==null)
                {
                    ViewState["sortDir"] = SortDirection.Ascending;
                }
                return (SortDirection)ViewState["sortDir"];
            }
            set {
                ViewState["sortDir"] = value;
            }
        }
    }
}