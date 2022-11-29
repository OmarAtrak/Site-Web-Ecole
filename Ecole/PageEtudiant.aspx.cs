using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using iTextSharp.text.pdf;
using iTextSharp.text;
using System.IO;
using iTextSharp.text.html.simpleparser;

namespace Ecoule
{
    public partial class PageEtudiant : System.Web.UI.Page
    {
        Connection con = new Connection();
        Etudiant etd = new Etudiant();

        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie hc = Request.Cookies["login"];
            if (hc.Value != null)
            {
                emailEtudiant.Text = hc["email"].ToString();
            }

            
            DataTable dt = new DataTable();
            dt = etd.Recharche((emailEtudiant.Text).ToString());


            lblNumero.Text = dt.Rows[0][0].ToString();
            lblGroup.Text = lblGroup.Text = etd.GroupEtudiant(int.Parse(dt.Rows[0][1].ToString()));
            lblNom.Text = dt.Rows[0][2].ToString();
            lblPrenom.Text = dt.Rows[0][3].ToString();
            lblDateNaissance.Text = dt.Rows[0][5].ToString();
            lblEmail.Text = dt.Rows[0][7].ToString();
            emailEtudiant.Text = dt.Rows[0][7].ToString();


            if (ListExame.Rows.Count == 0)
            {
                VideExame.Visible = true;
            }

            if (ListEmploi.Rows.Count == 0)
            {
                msgEmploi.Visible = true;
            }


            if (!IsPostBack)
            {
                int a=-1;
                con.Connecter();
                con.cmd.Connection = con._con();
                con.cmd.CommandText = "select distinct NOM, PRENOM, GMAIL from PROFESSEUR " +
                    "inner join DETAIL_SEANCE on PROFESSEUR.MATRICULE = DETAIL_SEANCE.PROFESSEUR " +
                    "inner join SEANCE on DETAIL_SEANCE.ID_SEANCE = SEANCE.ID_SEANCE where " +
                    "(ID_GROUP = (select ID_GROUP from ETUDIANT where NUMERO_ETUDIANT = '" + int.Parse(lblNumero.Text) + "')) " +
                    "and " +
                    "(YEAR(DATE_SEANCE) = YEAR(GETDATE()) or YEAR(DATE_SEANCE) = YEAR(DATEADD(year, -1, getdate()))) ";
                con.dr = con.cmd.ExecuteReader();
                while (con.dr.Read())
                {
                    a = 0;
                    contentListProf.InnerHtml += "<table class='tblProf'>" +
                                                "<tr><td>" + con.dr[0].ToString() + "</td>" +
                                                "<td>" + con.dr[1].ToString() + "</td>" +
                                                "<td><a href='mailto:" + con.dr[2].ToString() + "'>" + con.dr[2].ToString() +
                                                "<img src='icons/email.png' height='30px'/></a>" +
                                                "</td></tr><table>";
                }
                con.cmd.Parameters.Clear();
                con.dr.Close();


                //con.cmd.CommandText = "select dbo.MoyenneGeneral('" + lblNumero.Text +
                //                        "','" + Annee.Text +
                //                        "','" + semestre.Text + "')";
                //lblMoyenneEtudiant.InnerText = (float.Parse(con.cmd.ExecuteScalar().ToString()).ToString("#0.00"));

                con.DeConnecter();


                if (a == -1)
                {
                    contentListProf.InnerHtml = "<table class='tblProf'><tr><td>Vous n'avez pas une Seance Avec Professeur</td></tr></table>";
                }
            }

            // si la list des exame est vide
            {
            //    if (ListExame.Rows.Count == 0)
            //    {
            //        DataTable table = new DataTable();


            //        TableCell td = new TableCell();
            //        TableRow tr = new TableRow();
            //        td.Text = "Vous ne Réalisez pas un Exame";
            //        td.ColumnSpan = ListExame.Columns.Count;
            //        tr.Cells.Add(td);
            //        DataTable vide = new DataTable();
            //        vide.Rows.Add(tr);
            //        //vide.Rows[0][0] = vide.Columns.Count;
            //        //vide.Rows[0][0] = "Vous ne Réalisez pas un Exame";
            //        ListExame.DataSource = vide;
            //        ListExame.DataBind();
            //        ListExame.Rows[0].Cells[0].HorizontalAlign = HorizontalAlign.Center;
            //    }
            //    else
            //    {
            //        ListExame.DataSource = DataListExame;
            //    }
            }


            //listProf.DataSource = etd.MesProf(int.Parse(lblNumero.Text.ToString()));
            //listProf.DataBind();
            //lblMoyenneGroup.InnerText = etd.MoyenneGroup(int.Parse(lblNumero.Text), int.Parse(Annee.Text), int.Parse(semestre.Text)).ToString();
            //lblMoyenneEtudiant.InnerText = etd.MoyenneGeneral(int.Parse(lblNumero.Text), int.Parse(Annee.Text), int.Parse(semestre.Text)).ToString();

            /*etd.Connecter();
            etd.DeConnecter();
            etd.cmd.Connection = etd._con();
            etd.cmd.CommandText = "select NOM,PRENOM,GMAIL from PROFESSEUR";
            etd.dr = etd.cmd.ExecuteReader();
            while (etd.dr.Read())
            {
                listMesProf.InnerHtml = "<tr><td>'"+etd.dr[0].ToString()+"'</td><td>'"+etd.dr[1].ToString()+"'</td></tr>";
            }*/
        }

        protected void btn_UpdateMotPasse_Click(object sender, EventArgs e)
        {
            // pour afficher page PageUpdateMotPasse pour modifer mot de passe 
            Response.Redirect("PageChangerMotPasse.aspx");
        }

        protected void btn_exit_Click(object sender, EventArgs e)
        {
            // pour fermer la page etudiant et ouvrire la page home
            Response.Redirect("Home.aspx");
        }

        protected void btnTelecharger_Click(object sender, EventArgs e)
        {
            for (int i = 0; i < ListNotes.Rows.Count; i++)
            {
                for (int j = 1; j < ListNotes.Columns.Count; j++)
                {
                    if (ListNotes.Rows[i].Cells[j].Text == "&nbsp;")
                    {
                        ListNotes.Rows[i].Cells[j].Text = "";
                    }
                }
            }
            PdfPTable pdfTable = new PdfPTable(ListNotes.HeaderRow.Cells.Count);
            foreach (TableCell headerCell in ListNotes.HeaderRow.Cells)
            {
                Font font = new Font();
                font.Color = new BaseColor(ListNotes.HeaderStyle.ForeColor);

                PdfPCell pdfCell = new PdfPCell(new Phrase(headerCell.Text, font));
                pdfCell.BackgroundColor = new BaseColor(ListNotes.HeaderStyle.BackColor);
                pdfTable.AddCell(pdfCell);
            }
            foreach (GridViewRow gridViewRow in ListNotes.Rows)
            {
                foreach (TableCell tableCell in gridViewRow.Cells)
                {
                    Font font = new Font();
                    font.Color = new BaseColor(ListNotes.RowStyle.ForeColor);

                    PdfPCell pdfCell = new PdfPCell(new Phrase(tableCell.Text));
                    pdfCell.BackgroundColor = new BaseColor(ListNotes.RowStyle.BackColor);
                    pdfTable.AddCell(pdfCell);
                }
            }
            Document pdfDocument = new Document(PageSize.A4, 10f, 10f, 10f, 10f);
            PdfWriter.GetInstance(pdfDocument, Response.OutputStream);
            pdfDocument.Open();
            pdfDocument.Add(pdfTable);
            pdfDocument.Close();
            Response.ContentType = "application/pdf";
            Response.AppendHeader("content-disposition", "attachment;filename="+ lblNom.Text +" "+ lblPrenom.Text +" Notes.pdf");
            Response.Write(pdfDocument);
            Response.Flush();
            Response.End();
            {
                /*PdfTable pdfTable = new PdfTable(ListNotes.HeaderRow.Cells.Count);
                foreach (GridView gridView in ListNotes.Rows)
                {
                    foreach (TableCell tableCell in ListNotes.Columns)
                    {
                        PdfCell pdfCell = new PdfCell(new Phrase(tableCell.Text));
                        pdfTable.AddCell(pdfCell);
                    }
                }
                Document pdfDocument = new Document(PageSize.A4, 10f, 10f, 10f, 10f);
                PdfWriter.GetInstance(pdfDocument, Response.OutputStream);

                pdfDocument.Open();
                pdfDocument.Add(pdfTable);
                pdfDocument.Close();

                Response.ContentType = "application/pdf";
                Response.AppendHeader("Downloads", "attachment;filename=Notes.pdf");
                Response.Write(pdfDocument);
                Response.Flush();
                Response.End();*/
            }
        }

        protected void btnTelecharger_Click1(object sender, ImageClickEventArgs e)
        {
            PdfPTable pdfTable = new PdfPTable(ListNotes.HeaderRow.Cells.Count);
            for (int i = 0; i < ListNotes.HeaderRow.Cells.Count; i++)
            {
                TableCell headerCell = new TableCell();
                headerCell.Text = ListNotes.HeaderRow.Cells[i].Text;
                Font font = new Font();
                font.Color = new BaseColor(ListNotes.HeaderStyle.ForeColor);

                PdfPCell pdfCell = new PdfPCell(new Phrase(headerCell.Text, font));
                pdfCell.BackgroundColor = new BaseColor(ListNotes.HeaderStyle.BackColor);
                pdfTable.AddCell(pdfCell);
            }
            for (int i = 0; i < ListNotes.Rows.Count; i++)
            {
                for (int j = 0; j < ListNotes.Rows[i].Cells.Count; j++)
                {
                    TableCell tableCell = new TableCell();
                    tableCell.Text = ListNotes.Rows[i].Cells[j].Text;
                    Font font = new Font();
                    font.Color = new BaseColor(ListNotes.RowStyle.ForeColor);

                    PdfPCell pdfCell = new PdfPCell(new Phrase(tableCell.Text));
                    pdfCell.BackgroundColor = new BaseColor(ListNotes.RowStyle.BackColor);
                    pdfTable.AddCell(pdfCell);
                }
            }
            Document pdfDocument = new Document(PageSize.A4, 10f, 10f, 10f, 10f);
            PdfWriter.GetInstance(pdfDocument, Response.OutputStream);
            pdfDocument.Open();
            pdfDocument.Add(pdfTable);
            pdfDocument.Close();
            Response.ContentType = "application/pdf";
            Response.AppendHeader("content-disposition", "attachment;filename=" + lblNom.Text + " " + lblPrenom.Text + ".pdf");
            Response.Write(pdfDocument);
            Response.Flush();
            Response.End();
        }

        public override void VerifyRenderingInServerForm(Control control){}
    }
}