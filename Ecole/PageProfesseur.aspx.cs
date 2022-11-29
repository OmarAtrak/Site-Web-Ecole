using iTextSharp.text;
using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ecoule
{
    public partial class PageProfesseur : System.Web.UI.Page
    {
        Connection con = new Connection();

        static int indexRow = 0;
        //static int indexRowP = 0;


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


            // pour remplir dropdownlist salle
            if (cmbSalle.Items.Count == 0)
            {
                con.RemplirSalle(cmbSalle);
            }

            //txtNote.Attributes.Add("Placeholder", "text of placeholder");



            // problem
            /*for (int i = 0; i < ListParticipation.Rows.Count; i++)
            {
                if (VerivierParticipant(int.Parse(ListParticipation.Rows[i].Cells[0].Text), int.Parse(cmbSeance.Text)) == true)
                {
                    ListParticipation.Rows[i].Cells[3].Text = "Present";
                }
                else
                {
                    ListParticipation.Rows[i].Cells[3].Text = "Absent";
                }
            }*/
        }

        public void RemplirListNote()
        {
            DataTable dt = new DataTable();
            con.Connecter();
            SqlCommand cmd = new SqlCommand("(select ETUDIANT.NUMERO_ETUDIANT,NOM,PRENOM,NOTE from ETUDIANT left join NOTES on ETUDIANT.NUMERO_ETUDIANT=NOTES.NUMERO_ETUDIANT where ID_GROUP = '" + cmbExameGroup.Text + "') except (select ETUDIANT.NUMERO_ETUDIANT,NOM,PRENOM,NOTE from ETUDIANT left join NOTES on ETUDIANT.NUMERO_ETUDIANT = NOTES.NUMERO_ETUDIANT where ID_GROUP = '" + cmbExameGroup.Text + "' and ID_EXAME != '" + cmbExame.Text + "')", con._con());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            con.DeConnecter();
            ListNotesExame.DataSource = dt;
            ListNotesExame.DataBind();
        }

        protected void btn_ChangerMotPasse_Click(object sender, EventArgs e)
        {
            indexRow = 0;
            Response.Redirect("PageChangerMotPasse.aspx");
        }

        protected void btn_exit_Click(object sender, EventArgs e)
        {
            indexRow = 0;
            //indexRowP = 0;
            Response.Redirect("Home.aspx");
        }

        void IndexEtudiant()
        {
            txtNumeroEtd.Text = ListNotesExame.Rows[indexRow].Cells[0].Text;
            txtExame.Text = (cmbExame.Text).ToString();
            if (ListNotesExame.Rows[indexRow].Cells[3].Text == "&nbsp;")
            {
                txtNote.Text = "";
            }
            else
            {
                txtNote.Text = ListNotesExame.Rows[indexRow].Cells[3].Text;
            }
        }

        protected void btnPresedent_Click(object sender, EventArgs e)
        {
            indexRow--;
            if (indexRow < 0)
            {
                indexRow = ListNotesExame.Rows.Count - 1;
            }
            numeroIndex.InnerText = (int.Parse(indexRow.ToString()) + 1).ToString();
            IndexEtudiant();
            //if (VeriverExame() == false)
            //{
            //    btnValiderNote.Enabled = false;
            //}
        }

        protected void btnSuivant_Click(object sender, EventArgs e)
        {
            indexRow++;
            if (indexRow > ListNotesExame.Rows.Count - 1)
            {
                indexRow = 0;
            }
            numeroIndex.InnerText = (int.Parse(indexRow.ToString()) + 1).ToString();
            IndexEtudiant();
            //if (VeriverExame() == false)
            //{
            //    btnValiderNote.Enabled = false;
            //}
        }

        protected void btnValiderNote_Click(object sender, EventArgs e)
        {
            //professeur.ValiderExame(txtNumeroEtd.Text, txtExame.Text, txtNote.Text);
            //professeur.ListeExame(cmbExameGroup.Text, cmbExame.Text, ListNotesExame);
            //numeroIndex.Focus();
        }

        protected void btnModiferNote_Click(object sender, EventArgs e)
        {
            //professeur.Connecter();
            //professeur.cmd.Connection = professeur._con();
            //professeur.cmd.CommandText = "UPDATE NOTES SET NOTE='" + txtNote.Text +
            //                             "' WHERE NUMERO_ETUDIANT='" + txtNumeroEtd.Text +
            //                             "' AND ID_EXAME='" + txtExame.Text + "'";
            //professeur.cmd.ExecuteNonQuery();
            //professeur.DeConnecter();
            //professeur.ListeExame(cmbExameGroup.Text, cmbExame.Text, ListNotesExame);
            //numeroIndex.Focus();
        }

        protected void btnAjoutParticipant_Click(object sender, EventArgs e)
        {

        }

        protected void btnRefecheListParticipation_Click(object sender, ImageClickEventArgs e)
        {
            //RemplirPresence();
            NumEtdParticiper.Focus();
        }

        protected void cmbGroupSeance_SelectedIndexChanged(object sender, EventArgs e)
        {
            //RemplirPresence();
            //indexRowP = 0;
            //indexNumEtdPS.InnerText = indexRowP.ToString();
            nbrEtdparGroup.InnerText = ListParticipation.Rows.Count.ToString();
            NumEtdParticiper.Focus();
        }

        protected void btnTelechargerPdf_Click(object sender, ImageClickEventArgs e)
        {
            PdfPTable pdfTable = new PdfPTable(ListParticipation.HeaderRow.Cells.Count);
            foreach (TableCell headerCell in ListParticipation.HeaderRow.Cells)
            {
                Font font = new Font();
                font.Color = new BaseColor(ListParticipation.HeaderStyle.ForeColor);

                PdfPCell pdfCell = new PdfPCell(new Phrase(headerCell.Text, font));
                pdfCell.BackgroundColor = new BaseColor(ListParticipation.HeaderStyle.BackColor);
                pdfTable.AddCell(pdfCell);
            }
            foreach (GridViewRow gridViewRow in ListParticipation.Rows)
            {
                foreach (TableCell tableCell in gridViewRow.Cells)
                {
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
        }

        protected void txtDate_TextChanged(object sender, EventArgs e)
        {

        }

        protected void btnSuivantPS_Click(object sender, EventArgs e)
        {
            //indexRowP++;
        }
    }
}