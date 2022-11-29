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
    public partial class ContentSalle : System.Web.UI.Page
    {
        Connection con = new Connection();

        protected void Page_Load(object sender, EventArgs e)
        {
            DataSet ds = new DataSet();
            con.Connecter();
            con.cmd.Connection = con._con();
            con.cmd.CommandText = "select NUMERO_SALLE,UTILISATION from SALLE";
            con.da.SelectCommand = con.cmd;
            // remplir les donnees de table salle dans data set
            con.da.Fill(ds, "SALLE");
            // remmplacement de ficher xml
            ds.WriteXml(@"C:\Users\OMAR\Desktop\Ecoule\XML\TableSalle.xml");
            // supprimer les donnes dans data set
            ds.Tables.Clear();
            // exporter les donnees de ficher xml a data set
            ds.ReadXml(@"C:\Users\OMAR\Desktop\Ecoule\XML\TableSalle.xml");
            con.DeConnecter();
            //remplir la list de salle a partir de data set
            ListSalle.DataSource = ds.Tables[0];
            ListSalle.DataBind();
        }

        protected void btnAjoutSalle_Click(object sender, EventArgs e)
        {
            if (txtNumero.Text != "" && txtUtilisationSalle.Text != "")
            {
                con.Connecter();
                con.cmd.Connection = con._con();
                int a = 0;
                con.cmd.CommandText = "select NUMERO_SALLE from SALLE where NUMERO_SALLE='" + txtNumero.Text + "'";
                if (con.cmd.ExecuteScalar() != null)
                {
                    a = int.Parse(con.cmd.ExecuteScalar().ToString());
                }
                con.cmd.Parameters.Clear();
                if (a == 0)
                {
                    con.cmd.CommandText = "insert into SALLE values('" + Convert.ToInt32(txtNumero.Text) + "','" +
                                                 txtUtilisationSalle.Text + "')";
                    con.cmd.ExecuteNonQuery();
                    Response.Redirect(Page.Request.Path);
                }
                else
                {
                    lblmsg.Text = "Le Numero de Salle Deja Existant";
                }
                con.DeConnecter();
            }
            else
            {
                lblmsg.Text = "Saisir Le Numero de Salle";
            }
        }

        protected void btnModifierSalle_Click(object sender, EventArgs e)
        {
            if (txtNumero.Text != "" && txtUtilisationSalle.Text != "")
            {
                con.Connecter();
                con.cmd.Connection = con._con();
                
                con.cmd.CommandText = "update SALLE set UTILISATION='" + txtUtilisationSalle.Text +
                                    "' where NUMERO_SALLE='" + Convert.ToInt32(ListSalle.SelectedRow.Cells[1].Text) + "'";
                con.cmd.ExecuteNonQuery();
                con.DeConnecter();
                Response.Redirect(Page.Request.Path);
            }
            else
            {
                lblmsg.Text = "Selectionner une Salle";
            }
        }

        protected void btnSupprimerSalle_Click(object sender, EventArgs e)
        {
            if (txtUtilisationSalle.Text != "")
            {
                con.Connecter();
                con.cmd.Connection = con._con();
                con.cmd.CommandText = "delete SALLE where NUMERO_SALLE='" + Convert.ToInt32(ListSalle.SelectedRow.Cells[1].Text) + "'";
                con.cmd.ExecuteNonQuery();
                con.DeConnecter();
                Response.Redirect(Page.Request.Path);
            }
        }

        protected void btnIstialiser_Click(object sender, EventArgs e)
        {
            Response.Redirect(Page.Request.Path);
        }

        protected void ListSalle_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtNumero.Text = ListSalle.SelectedRow.Cells[1].Text;
            txtNumero.Enabled = false;
            txtUtilisationSalle.Text = ListSalle.SelectedRow.Cells[2].Text;
            lblmsg.Text = "";
        }
    }
}