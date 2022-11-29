using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

namespace Ecoule
{
    public partial class PageContentProfesseur : System.Web.UI.Page
    {
        Boolean etat = true;
        Connection con = new Connection();


        protected void Page_Load(object sender, EventArgs e)
        {
            txtRechercheProf.Attributes.Add("placeholder", "Recherche Par le Nom ou le prenom");

            if (!Page.IsPostBack && (etat == true))
            {
                bindgridview();
            }
        }

        private void bindgridview()
        {
            var data = Remplir();
            ListProf.DataSource = data;
            ListProf.DataBind();
        }

        public DataTable Remplir()
        {
            DataTable dt = new DataTable();
            con.Connecter();
            con.cmd.Connection = con._con();
            con.cmd.CommandText = "SELECT MATRICULE,LIBELLE,NOM,PRENOM,TELEPHONE,LEFT(DATENAISSANCE,11) as [Date] ,EMAIL,MOT_PASSE_PROF,SEXE,ADRESSE,SALAIRE,GMAIL FROM [PROFESSEUR] " +
                                  "inner join MODULE on PROFESSEUR.ID_MODULE=MODULE.ID_MODULE";
            con.da.SelectCommand = con.cmd;
            con.da.Fill(dt);
            con.DeConnecter();
            ListProf.DataSource = dt;
            ListProf.DataBind();
            return dt;
        }

        protected void btnAjoutProf_Click(object sender, EventArgs e)
        {
            if ( txtNomProf.Text != "" && txtPrenomProf.Text != "" && txtDateProf.Text != "" &&
                txtTeleProf.Text != "" && txtMotPasseProf.Text != "" && txtAdresseProf.Text != "" && txtSalaireProf.Text != "" &&
                txtGmailProf.Text != "" && (sexeProf.Items[0].Selected == true) || (sexeProf.Items[1].Selected == true))
            {
                Regex r = new Regex(@"^[0][5-6-7][0-9]{8}$");
                if (r.IsMatch(txtTeleProf.Text) && txtTeleProf.Text.Length==10)
                {
                    if (txtMotPasseProf.Text.Length == 10)
                    {
                        if (Convert.ToDouble(txtSalaireProf.Text) >= 5000 && Convert.ToDouble(txtSalaireProf.Text) <= 10000)
                        {
                            if (txtGmailProf.Text.Contains("@gmail.com"))
                            {
                                try
                                {
                                    con.Connecter();
                                    con.cmd.Connection = con._con();
                                    con.cmd.CommandText = "select dbo.idModule('" + cmbModule.Text + "')";
                                    int module = int.Parse(con.cmd.ExecuteScalar().ToString());
                                    con.cmd.Parameters.Clear();
                                    con.cmd.CommandText = "insert into PROFESSEUR (ID_MODULE,NOM,PRENOM,DATENAISSANCE,TELEPHONE,MOT_PASSE_PROF,SEXE,ADRESSE,SALAIRE,GMAIL) values('" + module + "','" + txtNomProf.Text.ToString() + "','" + txtPrenomProf.Text + "','" + Convert.ToDateTime(txtDateProf.Text) + "','" + txtTeleProf.Text + "','" + txtMotPasseProf.Text + "','" + sexeProf.SelectedValue.ToString() + "','" + txtAdresseProf.Text + "','" + float.Parse(txtSalaireProf.Text) + "','" + txtGmailProf.Text + "')";
                                    con.cmd.ExecuteNonQuery();
                                    con.DeConnecter();
                                    Response.Redirect(Page.Request.RawUrl);
                                }
                                catch (Exception ex)
                                {
                                    lblmssgProf.Text = "Vérifier Les Donnees";
                                    lblmssgProf.ForeColor = System.Drawing.Color.Red;
                                }
                            }
                            else
                            {
                                lblmssgProf.Text = "Saisir votre Adresse Gmail exemple: exempl4@gmail.com";
                                lblmssgProf.ForeColor = System.Drawing.Color.Red;
                            }
                        }
                        else
                        {
                            lblmssgProf.Text = "le Salaire doit etre Entre 5000 DH et 10000 DH";
                            lblmssgProf.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                    else
                    {
                        lblmssgProf.Text = "le Nombre de caractere de Mot de Passe doit etre 10 Caracteres";
                        lblmssgProf.ForeColor = System.Drawing.Color.Red;
                    }
                    
                }
                else
                {
                    lblmssgProf.Text = "Format de Numero de Telephone est Incorrect";
                    lblmssgProf.ForeColor = System.Drawing.Color.Red;
                }
            }
            else
            {
                lblmssgProf.Text = "Remplir tout Les Donnees";
                lblmssgProf.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnModiferProf_Click(object sender, EventArgs e)
        {
            if (txtNomProf.Text != "" && txtPrenomProf.Text != "" && txtDateProf.Text != "" &&
                txtTeleProf.Text != "" && txtMotPasseProf.Text != "" && txtAdresseProf.Text != "" && txtSalaireProf.Text != "" &&
                txtGmailProf.Text != "" && (sexeProf.Items[0].Selected == true) || (sexeProf.Items[1].Selected == true))
            {
                con.Connecter();

                con.cmd.Connection = con._con();
                con.cmd.CommandText = "select dbo.idModule('" + cmbModule.SelectedValue + "')";
                int ModuleProf = int.Parse(con.cmd.ExecuteScalar().ToString());

                con.cmd.Connection = con._con();
                con.cmd.CommandText = "update PROFESSEUR set NOM='" + txtNomProf.Text +"'," +
                                  "ID_MODULE='"+ ModuleProf +"',"+ 
                                  "PRENOM='"+ txtPrenomProf.Text + "'," +
                                  "TELEPHONE='"+ txtTeleProf.Text +"'," +
                                  "DATENAISSANCE='"+ Convert.ToDateTime(txtDateProf.Text) +"'," +
                                  "MOT_PASSE_PROF='"+ txtMotPasseProf.Text +"'," +
                                  "SEXE='"+ sexeProf.SelectedValue + "'," +
                                  "ADRESSE='"+ txtAdresseProf.Text +"'," +
                                  "SALAIRE='"+ txtSalaireProf.Text +"'," +
                                  "GMAIL='"+ txtGmailProf.Text +"'" +
                                  "where MATRICULE='" + int.Parse(ListProf.SelectedRow.Cells[1].Text) + "'";
                con.cmd.ExecuteNonQuery();
                Response.Redirect(Page.Request.RawUrl);
                con.DeConnecter();
            }
        }

        protected void btnSupprimerProf_Click(object sender, EventArgs e)
        {
            if (txtNomProf.Text != "" && txtPrenomProf.Text != "" && txtDateProf.Text != "" &&
                txtTeleProf.Text != "" && txtMotPasseProf.Text != "" && txtAdresseProf.Text != "" && txtSalaireProf.Text != "" &&
                txtGmailProf.Text != "" && (sexeProf.Items[0].Selected == true) || (sexeProf.Items[1].Selected == true))
            {
                con.Connecter();
                con.cmd.Connection = con._con();
                con.cmd.CommandText = "delete PROFESSEUR where MATRICULE='" + int.Parse(ListProf.SelectedRow.Cells[1].Text) + "'";
                con.cmd.ExecuteNonQuery();
                Response.Redirect(Page.Request.RawUrl);
                con.DeConnecter();
            }
        }

        protected void ListProf_SelectedIndexChanged(object sender, EventArgs e)
        {
            cmbModule.SelectedValue = ListProf.SelectedRow.Cells[4].Text.Trim();
            txtNomProf.Text = ListProf.SelectedRow.Cells[2].Text.Trim();
            txtPrenomProf.Text = ListProf.SelectedRow.Cells[3].Text.Trim();
            txtDateProf.Text = Convert.ToDateTime(ListProf.SelectedRow.Cells[6].Text).ToString("yyyy-MM-dd");
            txtTeleProf.Text = ListProf.SelectedRow.Cells[5].Text;
            txtMotPasseProf.Text = ListProf.SelectedRow.Cells[8].Text;
            txtAdresseProf.Text = ListProf.SelectedRow.Cells[10].Text;
            txtSalaireProf.Text = ListProf.SelectedRow.Cells[11].Text;
            txtGmailProf.Text = ListProf.SelectedRow.Cells[12].Text;
            if (ListProf.SelectedRow.Cells[9].Text == "M")
            {
                sexeProf.Items[0].Selected = true;
                sexeProf.Items[1].Selected = false;
            }
            else if (ListProf.SelectedRow.Cells[9].Text == "F")
            {
                sexeProf.Items[0].Selected = false;
                sexeProf.Items[1].Selected = true;
            }
            tblEtd.Focus();
        }

        protected void btnInitialiser_Click(object sender, EventArgs e)
        {
            Response.Redirect(Page.Request.Path);
        }

        protected void btnRechercheEtd1_Click(object sender, ImageClickEventArgs e)
        {

        }

        protected void btnRecherche_Click(object sender, ImageClickEventArgs e)
        {
            DataTable dt = new DataTable();
            if (dt != null)
            {
                dt.Rows.Clear();
            }
            con.Connecter();
            con.cmd.Connection = con._con();
            con.cmd.CommandText = "SELECT MATRICULE,LIBELLE,NOM,PRENOM,TELEPHONE,LEFT(DATENAISSANCE,11) as [Date] ,EMAIL,MOT_PASSE_PROF,SEXE,ADRESSE,SALAIRE,GMAIL FROM [PROFESSEUR] " +
                                  "inner join MODULE on PROFESSEUR.ID_MODULE=MODULE.ID_MODULE "+
                                    "where NOM like '" + txtRechercheProf.Text + "%' or PRENOM like '" + txtRechercheProf.Text + "%'";
            con.da.SelectCommand = con.cmd;
            con.da.Fill(dt);
            con.DeConnecter();
            ListProf.DataSource = dt;
            ListProf.DataBind();
            etat = false;
            if (ListProf.Rows.Count == 0)
            {
                lblmsg.Visible = true;
            }
            else
            {
                lblmsg.Visible = false;
            }
        }

        protected void ListProf_Sorting(object sender, GridViewSortEventArgs e)
        {
            string sortExp = e.SortExpression;
            string dirction = string.Empty;
            if (sortDir == SortDirection.Ascending)
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
            ListProf.DataSource = dt;
            ListProf.DataBind();

            etat = false;
        }

        public SortDirection sortDir
        {
            get
            {
                if (ViewState["sortDir"] == null)
                {
                    ViewState["sortDir"] = SortDirection.Ascending;
                }
                return (SortDirection)ViewState["sortDir"];
            }
            set
            {
                ViewState["sortDir"] = value;
            }
        }
    }
}