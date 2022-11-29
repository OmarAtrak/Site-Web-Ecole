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
    public partial class ContentModule : System.Web.UI.Page
    {
        Connection con = new Connection();
        static int s = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // remplir dropdownlist numero section
                con.Connecter();
                con.cmd.Connection = con._con();
                con.cmd.CommandText = "select NUMERO_SECTION from SECTION order by NUMERO_SECTION";
                con.dr = con.cmd.ExecuteReader();
                while (con.dr.Read())
                {
                    cmbSection.Items.Add(con.dr[0].ToString());
                }
                con.cmd.Parameters.Clear();
                con.dr.Close();

                // remplir dropdownlist id module
                con.cmd.CommandText = "select LIBELLE from MODULE order by LIBELLE";
                con.dr = con.cmd.ExecuteReader();
                while (con.dr.Read())
                {
                    cmbModule.Items.Add(con.dr[0].ToString());
                }
                con.DeConnecter();
            }
        }

        protected void btnAjoutModule_Click(object sender, EventArgs e)
        {
            if (txtLibelleModule.Text != "")
            {
                con.Connecter();
                con.cmd.Connection = con._con();
                int a = 0;
                con.cmd.CommandText = "select ID_MODULE from MODULE where LIBELLE='"+ txtLibelleModule.Text +"'";
                if (con.cmd.ExecuteScalar() != null)
                {
                    a = int.Parse(con.cmd.ExecuteScalar().ToString());
                }
                con.cmd.Parameters.Clear();
                if (a == 0)
                {
                    con.cmd.CommandText = "insert into MODULE values('" + txtLibelleModule.Text + "')";
                    con.cmd.ExecuteNonQuery();
                    con.DeConnecter();
                    Response.Redirect(Page.Request.Path);
                }
                else
                {
                    lblmsg.Text = "Cette Module Deja Existant";
                    lblmsg.ForeColor = System.Drawing.Color.Red;
                }
            }
            else
            {
                lblmsg.Text = "Saisir Libelle de Module";
                lblmsg.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnModifierModule_Click(object sender, EventArgs e)
        {
            if (txtLibelleModule.Text != "")
            {
                con.Connecter();
                con.cmd.Connection = con._con();
                int a = 0;
                con.cmd.CommandText = "select ID_MODULE from MODULE where LIBELLE='" + txtLibelleModule.Text + "'";
                if (con.cmd.ExecuteScalar() != null)
                {
                    a = int.Parse(con.cmd.ExecuteScalar().ToString());
                }
                if (a == 0)
                {
                    con.cmd.Parameters.Clear();
                    con.cmd.CommandText = "update MODULE set LIBELLE='" + txtLibelleModule.Text +
                                                    "' where ID_MODULE='" + int.Parse(ListModule.SelectedRow.Cells[1].Text) + "'";
                    con.cmd.ExecuteNonQuery();
                    con.DeConnecter();
                    Response.Redirect(Page.Request.Path);
                }
                else
                {
                    lblmsg.Text = "Cette Module Deja Existant";
                    lblmsg.ForeColor = System.Drawing.Color.Red;
                }
            }
            else
            {
                lblmsg.Text = "Selectionner une Module";
                lblmsg.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnSupprimerModule_Click(object sender, EventArgs e)
        {
            if (txtLibelleModule.Text != "")
            {
                con.Connecter();
                con.cmd.Connection = con._con();
                con.cmd.CommandText = "delete MODULE where ID_MODULE='" + int.Parse(ListModule.SelectedRow.Cells[1].Text.Trim()) + "'";
                con.cmd.ExecuteNonQuery();
                con.DeConnecter();
                Response.Redirect(Page.Request.Path);
            }
        }

        protected void btnIstialiser_Click(object sender, EventArgs e)
        {
            Response.Redirect(Page.Request.RawUrl);
        }

        protected void ListModule_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnAjoutModule.Enabled = false;
            txtLibelleModule.Text = ListModule.SelectedRow.Cells[2].Text;
            lblmsg.Text = "";
        }

        protected void btnAjoutCoef_Click(object sender, EventArgs e)
        {
            con.Connecter();
            con.cmd.Connection = con._con();
            con.cmd.CommandText = "select dbo.idModule('"+ cmbModule.SelectedValue.ToString() + "')";
            int module;
            module = int.Parse(con.cmd.ExecuteScalar().ToString());
            con.cmd.Parameters.Clear();
            int a = 0;
            con.cmd.CommandText = "select NUMERO_SECTION from APPRENDRE " +
                    "where NUMERO_SECTION='" + int.Parse(cmbSection.SelectedValue) + "' and ID_MODULE='"+ module +"'";
            if (con.cmd.ExecuteScalar() != null)
            {
                a = int.Parse(con.cmd.ExecuteScalar().ToString());
            }
            con.cmd.Parameters.Clear();
            if (a == 0)
            {
                con.cmd.CommandText = "insert into APPRENDRE values('"+ Convert.ToInt32(cmbSection.SelectedValue) +
                                      "','" + module + 
                                      "' ,'"+ Convert.ToInt32(coeficiant.SelectedValue) +"')";
                con.cmd.ExecuteNonQuery();
                Response.Redirect(Page.Request.Path);
            }
            else
            {
                lblmsgC.Text = "Deja Existant";
                lblmsgC.ForeColor = System.Drawing.Color.Red;
            }
            con.DeConnecter();
        }

        protected void btnModifierCoef_Click(object sender, EventArgs e)
        {
            if (s == 1)
            {
                con.Connecter();
                con.cmd.Connection = con._con();
                con.cmd.CommandText = "select dbo.idModule('" + cmbModule.SelectedValue.ToString() + "')";
                int module;
                module = int.Parse(con.cmd.ExecuteScalar().ToString());
                con.cmd.Parameters.Clear();

                int a = 0;
                con.cmd.CommandText = "select ID_MODULE from APPRENDRE where NUMERO_SECTION='" + cmbSection.SelectedValue +
                                    "' and ID_MODULE='" + module + "'";
                if (con.cmd.ExecuteScalar() != null)
                {
                    a = int.Parse(con.cmd.ExecuteScalar().ToString());
                }
                con.cmd.Parameters.Clear();
                con.cmd.CommandText = "update APPRENDRE set COEFFICIANT='" + Convert.ToInt32(coeficiant.SelectedValue) +
                                        "' where NUMERO_SECTION='" + Convert.ToInt32(cmbSection.SelectedValue) +
                                        "' and ID_MODULE='" + module + "'";
                con.cmd.ExecuteNonQuery();
                con.DeConnecter();
                s = 0;
                Response.Redirect(Page.Request.Path);
            }
            else
            {
                lblmsgC.Text = "Selectionner Une ligne";
                lblmsgC.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnSupprimerCoef_Click(object sender, EventArgs e)
        {
            con.Connecter();
            con.cmd.Connection = con._con();
            con.cmd.CommandText = "select dbo.idModule('" + cmbModule.SelectedValue.ToString() + "')";
            int module;
            module = int.Parse(con.cmd.ExecuteScalar().ToString());
            con.cmd.CommandText = "delete APPRENDRE where NUMERO_SECTION='"+ Convert.ToInt32(cmbSection.SelectedValue) +
                                    "' and ID_MODULE='" + module + "'";
            con.cmd.ExecuteNonQuery();
            con.DeConnecter();
            Response.Redirect(Page.Request.Path);
        }

        protected void btnIntialiserCoef_Click(object sender, EventArgs e)
        {
            Response.Redirect(Page.Request.RawUrl);
        }

        protected void listCoefficiant_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnAjoutCoef.Enabled = false;
            cmbSection.SelectedValue = listCoefficiant.SelectedRow.Cells[1].Text;
            cmbModule.SelectedValue = listCoefficiant.SelectedRow.Cells[2].Text;
            coeficiant.SelectedValue = listCoefficiant.SelectedRow.Cells[3].Text;
            lblmsgC.Text = "";
            s = 1;
        }
    }
}