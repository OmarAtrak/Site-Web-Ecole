using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using iTextSharp.text.pdf;
using iTextSharp.text;

namespace Ecoule
{
    public partial class PageProfesseurs : System.Web.UI.Page
    {
        
        Connection con = new Connection();
        static int numExame;

        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie hc = Request.Cookies["login"];
            if (hc.Value != null)
            {
                emailProf.Text = hc["email"].ToString();
            }

            // rechercher les donnees a partir d'email
            DataTable infos = new DataTable();
            infos = con.RecharcheProf(emailProf.Text);
            lblNumero.Text = infos.Rows[0][0].ToString();
            lblNom.Text = infos.Rows[0][1].ToString();
            lblPrenom.Text = infos.Rows[0][2].ToString();
            lblDateNaissance.Text = infos.Rows[0][4].ToString();
            lblEmail.Text = infos.Rows[0][6].ToString();
            lblTele.Text = infos.Rows[0][3].ToString();

            if (cmbSalle.Items.Count == 0)
            {
                con.RemplirSalle(cmbSalle);
            }

            //if (!IsPostBack)
            //{
            //    con.Group(int.Parse(lblNumero.Text), cmbGroup);
            //}

            numExame = con.nbrExame() + 1;
        }

        int nbrEtd()
        {
            return ListParticipation.Rows.Count;
        }

        protected void btn_ChangerMotPasse_Click(object sender, EventArgs e)
        {
            Response.Redirect("PageChangerMotPasse.aspx");
        }

        protected void btn_exit_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }

        protected void btnValiderSeance_Click(object sender, EventArgs e)
        {
            if (cmbGroup.Text != "" && cmbModule.Text != "" && txtDate.Text != "" 
                && cmbHeureDebut.Text != "" && cmbHeureFin.Text != "" && cmbSalle.Text != "")
            {
                con.Connecter();
                SqlCommand cmm = new SqlCommand();
                cmm.Connection = con._con();

                // insert les doonnes de table seance
                cmm.CommandText = "insert into SEANCE values('" + Convert.ToDateTime(txtDate.Text) + "','" +
                                                                    cmbHeureDebut.Text + "','" + 
                                                                    cmbHeureFin.Text + "')";
                cmm.ExecuteNonQuery();
                cmm.Parameters.Clear();
                
                // selectionner numero de seance 
                cmm.CommandText = "select top(1) ID_SEANCE from SEANCE order by ID_SEANCE desc";
                int seance = int.Parse(cmm.ExecuteScalar().ToString());
                cmm.Parameters.Clear();

                // insert les donnees de table Detail seance
                cmm.CommandText = "insert into DETAIL_SEANCE values('" + seance + "','" + int.Parse(cmbModule.SelectedValue) +
                                    "','" + int.Parse(cmbGroup.SelectedValue) + "','" + int.Parse(cmbSalle.SelectedValue) + "','" +
                                    int.Parse(lblNumero.Text) + "')";
                cmm.ExecuteNonQuery();
                Response.Redirect(Page.Request.RawUrl);
                con.DeConnecter();
            }
        }

        protected void btnTelechargerPdf_Click(object sender, ImageClickEventArgs e)
        {
            //ListParticipation.AutoGenerateSelectButton = false;

            PdfPTable pdfTable = new PdfPTable(ListParticipation.HeaderRow.Cells.Count);
            //foreach (TableCell headerCell in ListParticipation.HeaderRow.Cells)
            //{
            //    Font font = new Font();
            //    font.Color = new BaseColor(ListParticipation.HeaderStyle.ForeColor);

            //    PdfPCell pdfCell = new PdfPCell(new Phrase(headerCell.Text, font));
            //    pdfCell.BackgroundColor = new BaseColor(ListParticipation.HeaderStyle.BackColor);
            //    pdfTable.AddCell(pdfCell);
            //}
            //foreach (GridViewRow gridViewRow in ListParticipation.Rows)
            //{
            //    foreach (TableCell tableCell in gridViewRow.Cells)
            //    {
            //        Font font = new Font();
            //        font.Color = new BaseColor(ListParticipation.RowStyle.ForeColor);

            //        PdfPCell pdfCell = new PdfPCell(new Phrase(tableCell.Text));
            //        pdfCell.BackgroundColor = new BaseColor(ListParticipation.RowStyle.BackColor);
            //        pdfTable.AddCell(pdfCell);
            //    }
            //}
            for (int i = 1; i < ListParticipation.HeaderRow.Cells.Count; i++)
            {
                TableCell headerCell = new TableCell();
                headerCell.Text = ListParticipation.HeaderRow.Cells[i].Text;
                Font font = new Font();
                font.Color = new BaseColor(ListParticipation.HeaderStyle.ForeColor);

                PdfPCell pdfCell = new PdfPCell(new Phrase(headerCell.Text, font));
                pdfCell.BackgroundColor = new BaseColor(ListParticipation.HeaderStyle.BackColor);
                pdfTable.AddCell(pdfCell);
            }
            for (int i = 0; i < ListParticipation.Rows.Count; i++)
            {
                for (int j = 0; j < ListParticipation.Rows[i].Cells.Count; j++)
                {
                    TableCell tableCell = new TableCell();
                    tableCell.Text = ListParticipation.Rows[i].Cells[j].Text;
                    Font font = new Font();
                    font.Color = new BaseColor(ListParticipation.RowStyle.ForeColor);

                    PdfPCell pdfCell = new PdfPCell(new Phrase(tableCell.Text));
                    pdfCell.BackgroundColor = new BaseColor(ListParticipation.RowStyle.BackColor);
                    pdfTable.AddCell(pdfCell);
                }
            }
            Document pdfDocument = new Document(PageSize.A4, 10f, 10f, 10f, 10f);
            PdfWriter.GetInstance(pdfDocument, Response.OutputStream);
            pdfDocument.Open();
            pdfDocument.Add(pdfTable);
            pdfDocument.Close();
            Response.ContentType = "application/pdf";
            Response.AppendHeader("content-disposition", "attachment;filename=Participation Group "+ cmbGroupSeance.Text +" Seance "+ cmbSeance.Text +".pdf");
            Response.Write(pdfDocument);
            Response.Flush();
            Response.End();

            //ListParticipation.AutoGenerateSelectButton = false;
        }

        protected void ListParticipation_SelectedIndexChanged(object sender, EventArgs e)
        {
            NumEtdParticiper.Text = ListParticipation.SelectedRow.Cells[1].Text;
            NumSeanceParticiper.Text = cmbSeance.Text;
            if (ListParticipation.SelectedRow.Cells[4].Text == "Present")
            {
                Present.Checked = true;
            }
            else
            {
                Present.Checked = false;
            }
            Present.Focus();
        }

        public Boolean VerivierParticipant(int etd, int seance)
        {
            con.Connecter();
            SqlCommand cmm = new SqlCommand("select NUMERO_ETUDIANT from PARTICIPER where NUMERO_ETUDIANT='" + etd + "' and  ID_SEANCE='" + seance + "'", con._con());
            SqlDataReader dr = cmm.ExecuteReader();
            string t = "";
            while (dr.Read())
            {
                t = dr[0].ToString();
            }
            con.DeConnecter();
            if (t != "")
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        protected void Present_CheckedChanged(object sender, EventArgs e)
        {
            con.Connecter();
            SqlCommand cmm = new SqlCommand("",con._con());
            if (NumEtdParticiper.Text != "" && NumSeanceParticiper.Text != "")
            {
                if (Present.Checked == true)
                {
                    cmm.CommandText = "insert into PARTICIPER values('" + int.Parse(NumEtdParticiper.Text) + "','" +
                                                                        int.Parse(NumSeanceParticiper.Text) + "')";
                    cmm.ExecuteNonQuery();
                }
                else
                {
                    cmm.CommandText = "delete PARTICIPER where NUMERO_ETUDIANT='" + int.Parse(NumEtdParticiper.Text) +
                                                             "' and ID_SEANCE='" + int.Parse(NumSeanceParticiper.Text) + "'";
                    cmm.ExecuteNonQuery();
                }
            }
            Response.Redirect(Page.Request.RawUrl);
            con.DeConnecter();
        }

        Boolean VerivierExame(int exame, int etd)
        {
            con.Connecter();
            SqlCommand cmm = new SqlCommand("select NUMERO_ETUDIANT from NOTES where NUMERO_ETUDIANT='" + etd + "' and  ID_EXAME='" + exame + "'", con._con());
            SqlDataReader dr = cmm.ExecuteReader();
            string t = "";
            while (dr.Read())
            {
                t = dr[0].ToString();
            }
            con.DeConnecter();
            if (t != "")
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        protected void btnValiderNote_Click(object sender, EventArgs e)
        {
            if (txtNumeroEtd.Text != "" && txtExame.Text != "" && txtNote.Text != "")
            {
                con.Connecter();
                SqlCommand cmm = new SqlCommand("insert into NOTES (ID_EXAME,NUMERO_ETUDIANT,NOTE) values('" + cmbExame.Text.Trim() + "','" + txtNumeroEtd.Text.Trim() + "','" + txtNote.Text.Trim() + "')", con._con());
                cmm.ExecuteNonQuery();
                Response.Redirect(Page.Request.Path);
                con.DeConnecter();
                txtNote.Focus();
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
                con.DeConnecter();
                Response.Redirect(Page.Request.Path);
                txtNote.Focus();
            }
        }

        protected void ListNotesExame_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtNumeroEtd.Text = ListNotesExame.SelectedRow.Cells[1].Text;
            txtExame.Text = cmbExame.Text;
            if (ListNotesExame.SelectedRow.Cells[4].Text == "&nbsp;")
            {
                txtNote.Text = "";
            }
            else
            {
                txtNote.Text = ListNotesExame.SelectedRow.Cells[4].Text;
            }
            if (ListNotesExame.SelectedRow.Cells[4].Text != "&nbsp;")
            {
                btnValiderNote.Enabled = false;
                btnModiferNote.Enabled = true;
            }
            else
            {
                btnValiderNote.Enabled = true;
                btnModiferNote.Enabled = false;
            }
            txtNote.Focus();
        }

        protected void btnAjouterExame_Click(object sender, EventArgs e)
        {
            if (cmbModuleExame.Text != "" && txtDateExame.Text != "")
            {
                con.Connecter();
                SqlCommand cmm = new SqlCommand("insert into Exame values('" + numExame + "','" + int.Parse(cmbModuleExame.Text) + "','" +
                                                Convert.ToDateTime(txtDateExame.Text) + "')", con._con());
                cmm.ExecuteNonQuery();
                con.DeConnecter();
            }
        }

        protected void ListSeance_SelectedIndexChanged(object sender, EventArgs e)
        {
            cmbSalle.DataSourceID = null;
            //cmbGroup.Text = ListSeance.SelectedRow.Cells[2].Text;
            txtDate.Text = ListSeance.SelectedRow.Cells[4].Text;
            cmbHeureDebut.Text = ListSeance.SelectedRow.Cells[5].Text;
            cmbHeureFin.Text = ListSeance.SelectedRow.Cells[6].Text;
            //cmbSalle.Text = ListSeance.SelectedRow.Cells[3].Text.Trim();
        }

        protected void cmbGroup_SelectedIndexChanged(object sender, EventArgs e)
        {
            Present.Focus();
        }

        protected void cmbModuleExame_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}