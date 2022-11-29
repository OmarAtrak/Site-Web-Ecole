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
    public partial class ContentSeance : System.Web.UI.Page
    {
        Connection con = new Connection();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                con.RemplirSalle(cmbSalle);
            }
        }

        protected void btnValiderSeance_Click(object sender, EventArgs e)
        {

            try
            {
                con.Connecter();
                con.cmd.Connection = con._con();

                // insert les doonnes de table seance
                con.cmd.CommandText = "insert into SEANCE values('" + Convert.ToDateTime(txtDate.Text) + "','" +
                                                                    cmbHeureDebut.Text + "','" +
                                                                    cmbHeureFin.Text + "')";
                con.cmd.ExecuteNonQuery();
                con.cmd.Parameters.Clear();

                // selectionner numero de seance 
                con.cmd.CommandText = "select top(1) ID_SEANCE from SEANCE order by ID_SEANCE desc";
                int seance = int.Parse(con.cmd.ExecuteScalar().ToString());
                con.cmd.Parameters.Clear();

                // selectionner id group
                con.cmd.CommandText = "select dbo.IdGroup('" + cmbGroup.Text + "')";
                int group = int.Parse(con.cmd.ExecuteScalar().ToString());
                con.cmd.Parameters.Clear();

                // insert les donnees de table Detail seance
                con.cmd.CommandText = "insert into DETAIL_SEANCE values('" + seance + "','" +
                                    group + "','" + int.Parse(cmbSalle.SelectedValue) + "','" +
                                    int.Parse(cmbProf.SelectedValue) + "')";
                con.cmd.ExecuteNonQuery();
                con.cmd.Parameters.Clear();

                con.cmd.CommandText = "select ID_SEANCE from DETAIL_SEANCE where ID_SEANCE='"+ seance + "'";
                int test = -1;
                test = int.Parse(con.cmd.ExecuteScalar().ToString());
                con.cmd.Parameters.Clear();
                if (test == -1)
                {
                    con.cmd.CommandText = "delete SEANCE where ID_SEANCE='" + seance + "'";
                    con.cmd.ExecuteNonQuery();
                    msg.Text = "le Professeur ou le Group dans une Seance en ce momant, ou la Salle est pas Disponnible";
                    msg.ForeColor = System.Drawing.Color.Red;
                }
                else
                {
                    msg.Text = "Valdation Seance Effectue";
                    msg.ForeColor = System.Drawing.Color.Green;
                }

                Response.Redirect(Page.Request.RawUrl);
                con.DeConnecter();
            }
            catch (Exception ex)
            {
                if (ex.Message.ToString() == "String was not recognized as a valid DateTime.")
                {
                    msg.Text = "Saisir La Date";
                    msg.ForeColor = System.Drawing.Color.Red;
                }
                else
                {
                    msg.Text = "Vérifier les Donnees";
                    msg.ForeColor = System.Drawing.Color.Red;
                }
}
        }

        protected void ListSeance_SelectedIndexChanged(object sender, EventArgs e)
        {
            cmbGroup.SelectedValue = ListSeance.SelectedRow.Cells[2].Text;
            cmbProf.SelectedValue = ListSeance.SelectedRow.Cells[4].Text;
            cmbSalle.SelectedValue = ListSeance.SelectedRow.Cells[5].Text;
            txtDate.Text = Convert.ToDateTime(ListSeance.SelectedRow.Cells[6].Text).ToString("yyyy-MM-dd");
            cmbHeureDebut.SelectedValue = ListSeance.SelectedRow.Cells[7].Text;
            cmbHeureFin.Items.Clear();
            cmbHeureFin.Items.Add(ListSeance.SelectedRow.Cells[8].Text);
        }

        protected void btnModifier_Click(object sender, EventArgs e)
        {
            con.Connecter();
            con.cmd.Connection = con._con();
            con.cmd.CommandText = "update SEANCE set DATE_SEANCE='" + Convert.ToDateTime(txtDate.Text) +
                                  "',HEURE_DEBUT='" + Convert.ToDateTime(cmbHeureDebut.Text) +
                                  "',HEURE_FIN='" + Convert.ToDateTime(cmbHeureFin.Text) + 
                                  "' where ID_SEANCE='"+ int.Parse(ListSeance.SelectedRow.Cells[1].Text) +"'";
            
            con.cmd.CommandText = "update DETAIL_SEANCE set ID_GROUP='"+ int.Parse(cmbGroup.Text) +
                                  "',NUMERO_SALLE='"+ int.Parse(cmbSalle.Text) +
                                  "',";
            con.DeConnecter();
        }

        protected void btnSupprimer_Click(object sender, EventArgs e)
        {
            con.Connecter();
            con.cmd.Connection = con._con();
            con.cmd.CommandText = "delete DETAIL_SEANCE where ID_SEANCE='"+
                                    int.Parse(ListSeance.SelectedRow.Cells[1].Text)+"'";
            con.cmd.ExecuteNonQuery();
            con.DeConnecter();
            Response.Redirect(Page.Request.RawUrl);
        }

        protected void btnIntialiser_Click(object sender, EventArgs e)
        {
            Response.Redirect(Page.Request.RawUrl);
        }

        protected void cmbHeureDebut_SelectedIndexChanged(object sender, EventArgs e)
        {
            HeureFin();
        }

        public void HeureFin()
        {
            cmbHeureFin.Items.Clear();
            if (cmbHeureDebut.Text == "08:30")
            {
                cmbHeureFin.Items.Add("09:30");
            }
            else if (cmbHeureDebut.Text == "09:30")
            {
                cmbHeureFin.Items.Add("10:30");
            }
            else if (cmbHeureDebut.Text == "10:30")
            {
                cmbHeureFin.Items.Add("11:30");
            }
            else if (cmbHeureDebut.Text == "11:30")
            {
                cmbHeureFin.Items.Add("12:30");
            }
            else if (cmbHeureDebut.Text == "14:30")
            {
                cmbHeureFin.Items.Add("15:30");
            }
            else if (cmbHeureDebut.Text == "15:30")
            {
                cmbHeureFin.Items.Add("16:30");
            }
            else if (cmbHeureDebut.Text == "17:30")
            {
                cmbHeureFin.Items.Add("18:30");
            }
        }
    }
}