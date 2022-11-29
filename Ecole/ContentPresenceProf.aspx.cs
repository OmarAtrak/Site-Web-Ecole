using iTextSharp.text;
using iTextSharp.text.pdf;
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
    public partial class ContentPresenceProf : System.Web.UI.Page
    {
        Connection con = new Connection();
        static string indexGroup = "-1";
        static string indexSeance = "-1";
        static int NumeroProf;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HttpCookie hc = Request.Cookies["login"];
                if (hc.Value != null)
                {
                    con.Connecter();
                    con.cmd.Connection = con._con();
                    con.cmd.CommandText = "select MATRICULE from PROFESSEUR where EMAIL='" + hc["email"].ToString() + "'";
                    con.dr = con.cmd.ExecuteReader();
                    while (con.dr.Read())
                    {
                        NumeroProf = int.Parse(con.dr[0].ToString());
                    }
                    con.DeConnecter();
                }
                
               RemplirSeance();


                if (indexGroup != "-1")
                {
                    txtGroup.Text = indexGroup;
                }
                else
                {
                    try
                    {
                        txtGroup.Text = listSeance.Rows[0].Cells[1].Text;
                    }
                    catch (Exception ex)
                    {
                        txtGroup.Text = "";
                        btnTelechargerPdf.Visible = false;
                    }
                }
                if (indexSeance != "-1")
                {
                    txtSeance.Text = indexSeance;
                }
                else
                {
                    try
                    {
                        txtSeance.Text = listSeance.Rows[0].Cells[0].Text;
                    }
                    catch (Exception ex)
                    {
                        txtSeance.Text = "";
                        btnTelechargerPdf.Visible = false;
                    }
                }
            }            
        }

        private void bindgridview()
        {
            var data = RemplirSeance();
            listSeance.DataSource = data;
            listSeance.DataBind();
        }

        public DataTable RemplirSeance()
        {
            //cmbSeance.Items.Clear();
            DataTable dt = new DataTable();
            con.Connecter();
            con.cmd.Connection = con._con();
            con.cmd.CommandText = "select DETAIL_SEANCE.ID_SEANCE as Seance," +
                        "convert(varchar,[GROUP].NUMERO_SECTION)+'AC'+convert(varchar,[GROUP].NUMERO_GROUP) as [Group]," +
                        "left(DATE_SEANCE,10) as [Date] from [GROUP] " +
                        "inner join DETAIL_SEANCE on [GROUP].ID_GROUP=DETAIL_SEANCE.ID_GROUP " +
                        "inner join SEANCE on DETAIL_SEANCE.ID_SEANCE=SEANCE.ID_SEANCE " +
                        "inner join PROFESSEUR on DETAIL_SEANCE.PROFESSEUR=PROFESSEUR.MATRICULE " +
                        "where PROFESSEUR.MATRICULE='" + NumeroProf + "' order by DETAIL_SEANCE.ID_SEANCE desc ";
            con.da.SelectCommand = con.cmd;
            con.da.Fill(dt);
            listSeance.DataSource = dt;
            listSeance.DataBind();
            return dt;
            //con.dr = con.cmd.ExecuteReader();
            //while (con.dr.Read())
            //{
            //    cmbSeance.Items.Add(con.dr[0].ToString());
            //    NumEtdParticiper.Text = con.dr[0].ToString();
            //}
            
            
            /*con.cmd.CommandText = "SELECT ID_SEANCE FROM DETAIL_SEANCE " +
                              "WHERE (PROFESSEUR = @prof) AND (ID_GROUP = (SELECT ID_GROUP FROM [GROUP] " +
                              "WHERE (NUMERO_SECTION = LEFT (@group, 1)) " +
                              "AND " +
                              "(NUMERO_GROUP = RIGHT (@group, 1))))";
            con.cmd.Parameters.AddWithValue("@prof",NumeroProf);
            con.cmd.Parameters.AddWithValue("@group",cmbGroupSeance.Text);*/
            //string s = "";
            //con.dr = cmd.ExecuteReader();
            //while (con.dr.Read())
            //{
            //    group = int.Parse(con.dr[0].ToString());
            //    s = con.dr[0].ToString();

            //}
            //cmd.Parameters.Clear();
            //con.dr.Close();

            //cmd.CommandText = "select ID_SEANCE from DETAIL_SEANCE where PROFESSEUR='" + NumeroProf + 
            //    "' and ID_GROUP='" + group + "'";
            //con.dr = cmd.ExecuteReader();
            //while (con.dr.Read())
            //{
            //    cmbSeance.Items.Add(con.dr[0].ToString());
            //}
            //con.da.SelectCommand = con.cmd;
            //con.da.Fill(dt);
            //cmbSeance.DataSource = dt;
            //cmbSeance.DataBind();
            //for (int i = 0; i < dt.Rows.Count; i++)
            //{
            //    cmbSeance.Items.Add(dt.Rows[i][0].ToString());
            //}
            //NumEtdParticiper.Text = group.ToString();
            //NumSeanceParticiper.Text = s;
            con.DeConnecter();
        }

        protected void ListParticipation_SelectedIndexChanged(object sender, EventArgs e)
        {
            NumEtdParticiper.Text = ListParticipation.SelectedRow.Cells[0].Text;
            NumSeanceParticiper.Text = txtSeance.Text;
            if (ListParticipation.SelectedRow.Cells[3].Text == "Present")
            {
                Present.Checked = true;
            }
            else
            {
                Present.Checked = false;
            }
            Present.Focus();
            msg.Text = "";
        }

        protected void Present_CheckedChanged(object sender, EventArgs e)
        {
            if (NumEtdParticiper.Text != "" && NumSeanceParticiper.Text != "")
            {
                con.Connecter();
                con.cmd.Connection = con._con();
                if (Present.Checked == true)
                {
                    con.cmd.CommandText = "insert into PARTICIPER values('" + int.Parse(NumEtdParticiper.Text) + "','" +
                                                                        int.Parse(NumSeanceParticiper.Text) + "')";
                    con.cmd.ExecuteNonQuery();
                }
                else
                {
                    con.cmd.CommandText = "delete PARTICIPER where NUMERO_ETUDIANT='" + int.Parse(NumEtdParticiper.Text) +
                                                             "' and ID_SEANCE='" + int.Parse(NumSeanceParticiper.Text) + "'";
                    con.cmd.ExecuteNonQuery();
                }
                con.DeConnecter();
                indexGroup = txtGroup.Text;
                indexSeance = txtSeance.Text;
                //NumSeanceParticiper.Text = cmbSeance.Text;
                Response.Redirect(Request.Url.AbsoluteUri);
            }
            else
            {
                msg.Text = "Selectionner un Etudiant";
                msg.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnTelechargerPdf_Click(object sender, ImageClickEventArgs e)
        {
            PdfPTable pdfTable = new PdfPTable(listGroup.HeaderRow.Cells.Count);
            foreach (GridViewRow gridViewRow in GridView1.Rows)
            {
                foreach (TableCell tableCell in gridViewRow.Cells)
                {
                    Font font = new Font();
                    font.Color = new BaseColor(GridView1.RowStyle.ForeColor);
                    PdfPCell pdfCell = new PdfPCell(new Phrase(tableCell.Text));
                    pdfCell.Padding = 10f ;
                    pdfCell.BackgroundColor = new BaseColor(System.Drawing.Color.LightBlue);
                    pdfTable.AddCell(pdfCell);
                }
            }
            foreach (GridViewRow gridViewRow in listGroup.Rows)
            {
                foreach (TableCell tableCell in gridViewRow.Cells)
                {
                    Font font = new Font();
                    font.Color = new BaseColor(listGroup.RowStyle.ForeColor);

                    PdfPCell pdfCell = new PdfPCell(new Phrase(tableCell.Text));
                    pdfCell.BackgroundColor = new BaseColor(listGroup.RowStyle.BackColor);
                    pdfTable.AddCell(pdfCell);
                }
            }
            Document pdfDocument = new Document(PageSize.A4, 10f, 10f, 10f, 10f);
            PdfWriter.GetInstance(pdfDocument, Response.OutputStream);
            pdfDocument.Open();
            pdfDocument.Add(pdfTable);
            pdfDocument.Close();
            Response.ContentType = "application/pdf";
            Response.AppendHeader("content-disposition", "attachment;filename=Participation Group " + txtGroup.Text + " Seance " + txtSeance.Text + ".pdf");
            Response.Write(pdfDocument);
            Response.Flush();
            Response.End();
        }

        protected void cmbSeance_SelectedIndexChanged(object sender, EventArgs e)
        {
            //msg.Text = "";
            //indexSeance = "-1;
            //cmbSeance.Text = cmbSeance.SelectedValue;
        }

        protected void cmbGroupSeance_SelectedIndexChanged(object sender, EventArgs e)
        {
            //msg.Text = "";
            //indexGroup = -1;
            //cmbGroupSeance.Text = cmbGroupSeance.SelectedValue;
        }

        protected void listSeance_SelectedIndexChanged(object sender, EventArgs e)
        {
            indexSeance = listSeance.SelectedRow.Cells[0].Text;
            indexGroup = listSeance.SelectedRow.Cells[1].Text;
            Response.Redirect(Page.Request.Path);
        }

        protected void listSeance_Sorting(object sender, GridViewSortEventArgs e)
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
            DataTable dt = RemplirSeance();
            dt.DefaultView.Sort = sortExp + dirction;
            listSeance.DataSource = dt;
            listSeance.DataBind();
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