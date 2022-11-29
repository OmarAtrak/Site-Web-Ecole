using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ecoule
{
    public partial class ContentSectionGroup : System.Web.UI.Page
    {
        Connection con = new Connection();
        static int id=0;

        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (ListSection.Rows.Count <= 3)
            {
                tblSection.Visible = false;
                ListSection.AutoGenerateSelectButton = false;
            }


            if (!Page.IsPostBack)
            {
                RempliSection();
                RemplirGroup();
            }

            
        }

        DataTable RempliSection()
        {
            DataTable dt = new DataTable();
            if (dt != null)
            {
                dt.Rows.Clear();
            }
            con.Connecter();
            con.cmd.Connection = con._con();
            con.cmd.CommandText = "SELECT * FROM [SECTION] order by NUMERO_SECTION";
            con.da.SelectCommand = con.cmd;
            con.da.Fill(dt);
            con.DeConnecter();
            ListSection.DataSource = dt;
            ListSection.DataBind();
            return dt;
        }

        DataTable RemplirGroup()
        {
            DataTable dt1 = new DataTable();
            if (dt1 != null)
            {
                dt1.Rows.Clear();
            }
            con.Connecter();
            con.cmd.Connection = con._con();
            con.cmd.CommandText = "SELECT * FROM [GROUP] order by NUMERO_SECTION";
            con.da.SelectCommand = con.cmd;
            con.da.Fill(dt1);
            con.DeConnecter();
            ListGroup.DataSource = dt1;
            ListGroup.DataBind();
            return dt1;
        }

        protected void btnAjoutSection_Click(object sender, EventArgs e)
        {
            string str;
            if (ListSection.Rows.Count <= 0)
            {
                txtNumeroSection.Text = 1.ToString();
            }
            else
            {
                txtNumeroSection.Text = ((int.Parse(ListSection.Rows[ListSection.Rows.Count - 1].Cells[1].Text)) + 1).ToString();
            }
            con.Connecter();
            con.cmd.Connection = con._con();
            con.cmd.CommandText = "insert into SECTION value('" + Convert.ToInt32(txtNumeroSection.Text) + "')";
            con.cmd.ExecuteNonQuery();
            con.DeConnecter();
            Response.Redirect(Page.Request.Path);
        }

        protected void btnSuprimerSection_Click(object sender, EventArgs e)
        {

        }

        protected void btnAjoutGroup_Click(object sender, EventArgs e)
        {
            if (txtNumeroGroup.Text != "")
            {
                if (Convert.ToInt32(txtNumeroGroup.Text) > 0)
                {
                    con.Connecter();
                    con.cmd.Connection = con._con();
                    int a = 0;
                    con.cmd.CommandText = "select ID_GROUP from [GROUP] where NUMERO_SECTION='"+int.Parse(txtSectionGroup.Text)+
                                        "' and NUMERO_GROUP='"+ int.Parse(txtNumeroGroup.Text) +"'";
                    if (con.cmd.ExecuteScalar() != null)
                    {
                        a = int.Parse(con.cmd.ExecuteScalar().ToString());
                    }
                    con.cmd.Parameters.Clear();
                    if (a == 0)
                    {
                        con.cmd.CommandText = "insert into [GROUP] values('" + Convert.ToInt32(txtSectionGroup.SelectedValue) + "','" + Convert.ToInt32(txtNumeroGroup.Text) + "')";
                        con.cmd.ExecuteNonQuery();
                        con.DeConnecter();
                        Response.Redirect(Page.Request.Path);
                    }
                    else
                    {
                        lblmsg.Text = "Cet Group Deja Existant";
                        lblmsg.ForeColor = System.Drawing.Color.Red;
                    }
                }
                else
                {
                    lblmsg.Text = "Saisir un Numero positive";
                    lblmsg.ForeColor = System.Drawing.Color.Red;
                }
            }
            else
            {
                lblmsg.Text = "Saisir le Numero de Group";
                lblmsg.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnModifierGroup_Click(object sender, EventArgs e)
        {
            if (id != 0)
            {
                if (txtNumeroGroup.Text != "")
                {
                    if (Convert.ToInt32(txtNumeroGroup.Text) > 0)
                    {
                        con.Connecter();
                        con.cmd.Connection = con._con();
                        con.cmd.CommandText = "update [GROUP] set NUMERO_SECTION='" + Convert.ToInt32(txtSectionGroup.SelectedValue) +
                                                    "',NUMERO_GROUP='" + Convert.ToInt32(txtNumeroGroup.Text) +
                                                    "' where ID_GROUP='" + Convert.ToInt32(ListGroup.SelectedRow.Cells[1].Text) + "'";
                        con.cmd.ExecuteNonQuery();
                        con.DeConnecter();
                        id = 0;
                        Response.Redirect(Page.Request.Path);
                    }
                    else
                    {
                        lblmsg.Text = "Saisir un Numero Positive";
                        lblmsg.ForeColor = System.Drawing.Color.Red;
                    }
                }
            }
            else
            {
                lblmsg.Text = "Selectionner un Group";
                lblmsg.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnSupprimerGroup_Click(object sender, EventArgs e)
        {
            if (id != 0)
            {
                con.Connecter();
                con.cmd.Connection = con._con();
                con.cmd.CommandText = "delete [GROUP] where ID_GROUP='" + int.Parse(ListGroup.SelectedRow.Cells[1].Text.Trim()) + "'";
                con.cmd.ExecuteNonQuery();
                con.DeConnecter();

                id = 0;
                Response.Redirect(Page.Request.Path);
            }
        }

        protected void ListGroup_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (id == 0)
            {
                id = Convert.ToInt32(ListGroup.SelectedRow.Cells[1].Text);
            }
            txtNumeroSection.Text = ListGroup.SelectedRow.Cells[2].Text;
            txtNumeroGroup.Text = ListGroup.SelectedRow.Cells[3].Text;
            tblGroup.Focus();
            lblmsg.Text = "";
        }

        protected void bntIntialiser_Click(object sender, EventArgs e)
        {
            Response.Redirect(Page.Request.Path);
        }

        protected void btnRechercheGroup_Click(object sender, ImageClickEventArgs e)
        {

        }

        protected void ListGroup_Sorting(object sender, GridViewSortEventArgs e)
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
            DataTable dt = RemplirGroup();
            dt.DefaultView.Sort = sortExp + dirction;
            ListGroup.DataSource = dt;
            ListGroup.DataBind();
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

        protected void ListSection_Sorting(object sender, GridViewSortEventArgs e)
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
            DataTable dt = RempliSection();
            dt.DefaultView.Sort = sortExp + dirction;
            ListSection.DataSource = dt;
            ListSection.DataBind();
        }

    }
}