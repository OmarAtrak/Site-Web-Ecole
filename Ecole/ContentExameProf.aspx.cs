using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace Ecoule
{
    public partial class ContentExameProf : System.Web.UI.Page
    {
        Connection con = new Connection();
        static int NumeroProf;
        static int indexGroup = -1;
        static int indexExame = -1;

        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie hc = Request.Cookies["login"];
            if (hc.Value != null)
            {
                con.Connecter();
                con.cmd.Connection = con._con();
                con.cmd.CommandText = "select MATRICULE from PROFESSEUR where EMAIL='" + hc["email"].ToString() + "'";
                NumeroProf = int.Parse(con.cmd.ExecuteScalar().ToString());
                con.DeConnecter();
            }


            if (!IsPostBack)
            {
                if (indexGroup != -1)
                {
                    cmbExameGroup.SelectedIndex = indexGroup;
                }
                if (indexExame != -1)
                {
                    cmbExame.SelectedIndex = indexExame;
                }

                con.Connecter();
                con.cmd.Connection = con._con();
                con.cmd.CommandText = "select LIBELLE from PROFESSEUR " +
                                      "inner join MODULE on PROFESSEUR.ID_MODULE=MODULE.ID_MODULE " +
                                      "where MATRICULE='" + NumeroProf + "'";
                txtModule.Text = con.cmd.ExecuteScalar().ToString();
                con.DeConnecter();
            }
        }

        protected void btnAjouterExame_Click(object sender, EventArgs e)
        {
            if (txtDateExame.Text != "")
            {
                if (DateTime.Parse(txtDateExame.Text) <= DateTime.Now)
                {
                    con.Connecter();
                    con.cmd.Connection = con._con();
                    con.cmd.CommandText = "select dbo.idModule('" + txtModule.Text + "')";
                    int module = int.Parse(con.cmd.ExecuteScalar().ToString());
                    con.cmd.Parameters.Clear();
                    con.cmd.CommandText = "insert into Exame values('" + module + "','" +
                                                    Convert.ToDateTime(txtDateExame.Text) + "')";
                    con.cmd.ExecuteNonQuery();
                    con.DeConnecter();
                    Response.Redirect(Page.Request.RawUrl);
                }
                else
                {
                    string msg = "La Date de Seance doit etre avant ou la meme de ce Jour";
                    Response.Write("<script language='javascript'>alert('" + msg + "');</script>");
                }
            }
            else
            {
                string msg = "Saisir la Date";
                Response.Write("<script language='javascript'>alert('" + msg + "');</script>");
            }
        }
        
        protected void btnModifierExame_Click(object sender, EventArgs e)
        {
            if (txtDateExame.Text != "")
            {
                if (DateTime.Parse(txtDateExame.Text) <= DateTime.Now)
                {
                    con.Connecter();
                    con.cmd.Connection = con._con();
                    con.cmd.CommandText = "select dbo.idModule('" + txtModule.Text + "')";
                    int module = int.Parse(con.cmd.ExecuteScalar().ToString());
                    con.cmd.Parameters.Clear();


                    con.cmd.CommandText = "update EXAME set ID_MODULE='" + module +
                                          "', DATE_EXAME='" + Convert.ToDateTime(txtDateExame.Text) +
                                          "' where ID_EXAME='" + int.Parse(ListExame.SelectedRow.Cells[1].Text) + "'";
                    con.cmd.ExecuteNonQuery();
                    con.DeConnecter();
                    Response.Redirect(Page.Request.RawUrl);
                }
                else
                {
                    string msg = "La Date de Seance doit etre avant ou la meme de ce Jour";
                    Response.Write("<script language='javascript'>alert('" + msg + "');</script>");
                }
            }
            else
            {
                string msg = "Selectionner une Seance";
                Response.Write("<script language='javascript'>alert('" + msg + "');</script>");
            }
        }

        protected void btnSupprimerExame_Click(object sender, EventArgs e)
        {
            con.Connecter();
            con.cmd.Connection = con._con();
            con.cmd.CommandText = "delete EXAME where ID_EXAME='" + int.Parse(ListExame.SelectedRow.Cells[1].Text) + "'";
            con.cmd.ExecuteNonQuery();
            con.DeConnecter();
            Response.Redirect(Page.Request.RawUrl);
        }

        protected void ListNotesExame_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtNumeroEtd.Text = ListNotesExame.SelectedRow.Cells[1].Text;
            txtExame.Text = cmbExame.Text;
            if (ListNotesExame.SelectedRow.Cells[4].Text == "&nbsp;")
            {
                txtNote.Text = "";
                btnModiferNote.Enabled = false;
                btnValiderNote.Enabled = true;
            }
            else
            {
                txtNote.Text = ListNotesExame.SelectedRow.Cells[4].Text;
                btnModiferNote.Enabled = true;
                btnValiderNote.Enabled = false;

            }
            txtNote.Focus();
        }
        
        protected void btnValiderNote_Click(object sender, EventArgs e)
        {
            if (txtNumeroEtd.Text != "" && txtExame.Text != "" && txtNote.Text != "")
            {
                con.Connecter();
                SqlCommand cmm = new SqlCommand("insert into NOTES (ID_EXAME,NUMERO_ETUDIANT,NOTE) values('" + cmbExame.Text.Trim() + "','" + txtNumeroEtd.Text.Trim() + "','" + txtNote.Text.Trim() + "')", con._con());
                cmm.ExecuteNonQuery();
                indexGroup = cmbExameGroup.SelectedIndex;
                indexExame = cmbExame.SelectedIndex;
                con.DeConnecter();
                Response.Redirect(Page.Request.RawUrl);
            }
        }

        protected void btnModiferNote_Click(object sender, EventArgs e)
        {
            if (txtNumeroEtd.Text != "" && txtExame.Text != "" && txtNote.Text != "")
            {
                con.Connecter();
                con.cmd.Connection = con._con();
                con.cmd.CommandText = "UPDATE NOTES SET NOTE='" + txtNote.Text +
                                             "' WHERE NUMERO_ETUDIANT='" + txtNumeroEtd.Text +
                                             "' AND ID_EXAME='" + txtExame.Text + "'";
                con.cmd.ExecuteNonQuery();
                indexGroup = cmbExameGroup.SelectedIndex;
                indexExame = cmbExame.SelectedIndex;
                con.DeConnecter();
                Response.Redirect(Page.Request.Path);
            }
        }

        protected void btnInitialiser_Click(object sender, EventArgs e)
        {
            indexGroup = cmbExameGroup.SelectedIndex;
            indexExame = cmbExame.SelectedIndex;
            Response.Redirect(Page.Request.RawUrl);
        }

        protected void cmbExameGroup_SelectedIndexChanged(object sender, EventArgs e)
        {
            indexGroup = -1;;
        }

        protected void cmbExame_SelectedIndexChanged(object sender, EventArgs e)
        {
            indexExame = -1;
        }

        protected void ListExame_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtModule.Text = ListExame.SelectedRow.Cells[2].Text;
            cmbExame.SelectedValue = ListExame.SelectedRow.Cells[1].Text;
            txtDateExame.Text = ListExame.SelectedRow.Cells[3].Text;
        }

    }
}