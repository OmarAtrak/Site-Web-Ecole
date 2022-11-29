using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;

namespace Ecoule
{
    public partial class PageProf : System.Web.UI.Page
    {
        Connection con = new Connection();
        //Prof professeur = new Prof();

        static int indexRow = 0;
        static int indexRowP = 0;


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

            if (IsPostBack)
            {
                btnTelechargerPdf.Visible = true;
                btnRefecheListParticipation.Visible = true;
                lblnumEtdParticiper.Visible = true;
                NumEtdParticiper.Visible = true;
                lblnumSeance.Visible = true;
                NumSeanceParticiper.Visible = true;
                Present.Visible = true;
                btnPresedentPS.Visible = true;
                btnSuivantPS.Visible = true;
            }
            {
                //Remplir List Note
                //if (ListNotesExame.Rows.Count > 0)
                //{
                //    ListNotesExame.DataSource = ListNotesExameData;
                //}


            
                // list presence
                //if (ListParticipation.Rows.Count<=0)
                //{
                //    btnRefecheListParticipation.Visible = false;
                //    lblnumEtdParticiper.Visible = false;
                //    lblnumSeance.Visible = false;
                //    lblPresence.Visible = false;
                //    NumSeanceParticiper.Visible = false;
                //    NumEtdParticiper.Visible = false;
                //    Present.Visible = false;
                //}
                //else
                //{
                //    btnRefecheListParticipation.Visible = true;
                //    lblnumEtdParticiper.Visible = true;
                //    lblnumSeance.Visible = true;
                //    lblPresence.Visible = true;
                //    NumSeanceParticiper.Visible = true;
                //    NumEtdParticiper.Visible = true;
                //    Present.Visible = true;
                //}
            

                //for (int i = 0; i < ListParticipation.Rows.Count; i++)
                //{
                //    if (VerivierParticipant(int.Parse(ListParticipation.Rows[i].Cells[0].Text), int.Parse(cmbSeance.Text)) == true)
                //    {
                //        ListParticipation.Rows[i].Cells[3].Text = "Present";
                //    }
                //    else
                //    {
                //        ListParticipation.Rows[i].Cells[3].Text = "Absent";
                //    }
                //}
            }

            // pour l'index de deplacement pour participer
            //indexNumEtdPS.InnerText = 
            nbrEtdparGroup.InnerText = ListParticipation.Rows.Count.ToString();
            if (ListParticipation.Rows.Count > 0)
            {
                NumEtdParticiper.Text = ListParticipation.Rows[0].Cells[0].Text;
                NumSeanceParticiper.Text = cmbSeance.Text;
                //if()
            }


            // pour l'index de deplacement pour exame
            //IndexEtudiant();
            numeroEtudiantParGroup.InnerText = ListNotesExame.Rows.Count.ToString();
            if (ListNotesExame.Rows.Count > 0)
            {
                numeroIndex.InnerText = 1.ToString();
                txtExame.Text = cmbExame.Text;
            }

            {
                // remplir la list de group pour participant
                //con.ListeParticiper(int.Parse(cmbGroupSeance.Text.Trim()), ListParticipation);


                // remplir la list de group pour Exame
                //con.ListeExame(int.Parse(cmbExameGroup.Text), int.Parse(cmbExame.Text), ListNotesExame);


                // recherche les group qu'il realiser un seance par cet prof
                //cmbGroup.Items.Add


                // recherche les seance de group qu'il realiser par cet prof




                /*if (!IsPostBack)
                {
                    // remplir dropdownlist de seance
                    DataTable dt4 = new DataTable();
                    dt4 = professeur.Seance(int.Parse(lblNumero.Text));
                    for (int i = 0; i < dt4.Rows.Count; i++)
                    {
                        cmbSeance.Items.Add(dt4.Rows[i][0].ToString());
                    }

                    // remplir dropdownlist de Group
                    DataTable dt5 = new DataTable();
                    dt5 = professeur.Group(lblNumero.Text);
                    for (int i = 0; i < dt5.Rows.Count; i++)
                    {
                        cmbExameGroup.Items.Add(dt5.Rows[i][0].ToString());
                    }

                    professeur.RemplirSalle(cmbSalle);
                }


                professeur.ListeExame(lblNumero.Text, cmbExameGroup.Text, ListNotesExame);

                professeur.ListeParticiper(Convert.ToInt32(lblNumero.Text),Convert.ToInt32(cmbSeance.Text), ListParticipation);

                // pour l'index de deplacement
                IndexEtudiant();
                numeroEtudiantParGroup.InnerText = ListNotesExame.Rows.Count.ToString();
                if (ListNotesExame.Rows.Count > 0)
                {
                    numeroIndex.InnerText = 1.ToString();
                    txtExame.Text = cmbExame.Text;
                }*/
            }
        }

        public Boolean VerivierParticipant(int etd, int seance)
        {
            con.Connecter();
            SqlCommand cmm = new SqlCommand("select NUMERO_ETUDIANT from PARTICIPER where NUMERO_ETUDIANT='" + etd +"' and  ID_SEANCE='" + seance +"'", con._con());
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

        public void RemplirPresence()
        {
            for (int i = 0; i < ListParticipation.Rows.Count; i++)
            {
                if (VerivierParticipant(int.Parse(ListParticipation.Rows[i].Cells[0].Text), int.Parse(cmbSeance.Text)) == true)
                {
                    ListParticipation.Rows[i].Cells[3].Text = "Present";
                }
                else
                {
                    ListParticipation.Rows[i].Cells[3].Text = "Absent";
                }
            }
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

        protected void btn_exit_Click(object sender, EventArgs e)
        {
            indexRow = 0;
            Response.Redirect("Home.aspx");
        }

        protected void btn_ChangerMotPasse_Click(object sender, EventArgs e)
        {
            indexRow = 0;
            Response.Redirect("PageChangerMotPasse.aspx");
        }

        // 1
        protected void cmbExameGroup_SelectedIndexChanged(object sender, EventArgs e)
        {
            //con.ListeExame(cmbExameGroup.Text, cmbExame.Text, ListNotesExame);
            indexRow = 0;
            IndexEtudiant();
            btnSuivant.Focus();
        }
        // 2
        protected void cmbExamen_SelectedIndexChanged(object sender, EventArgs e)
        {
            //con.ListeExame(cmbExameGroup.Text, cmbExame.Text, ListNotesExame);
            indexRow = 0;
            IndexEtudiant();
            btnSuivant.Focus();
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

        /**********************  Methode Telecharger Pdf  *************************/
        protected void Button1_Click(object sender, EventArgs e)
        {
            /*Response.ContentType = "Application/pdf";
            Response.AddHeader("Content-Disposition", "attachement;filename=Participants.pdf");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            content_participer_seance.RenderControl(hw);
            Document doc = new Document(PageSize.A4,50f,50f,30f,30f);
            HTMLWorker htw = new HTMLWorker(doc);
            PdfWriter.GetInstance(doc, Response.OutputStream);
            doc.Open();
            StringReader sr = new StringReader(sw.ToString());
            htw.Parse(sr);
            doc.Close();
            Response.Write(doc);
            Response.End();*/

            PdfPTable pdfTable = new PdfPTable(ListParticipation.HeaderRow.Cells.Count);
            foreach (TableCell headerCell in ListParticipation.HeaderRow.Cells)
            {
                Font font = new Font();
                font.Color = new BaseColor(ListParticipation.HeaderStyle.ForeColor);

                PdfPCell pdfCell = new PdfPCell(new Phrase(headerCell.Text,font));
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
            Response.AppendHeader("content-disposition", "attachment;filename=Participation.pdf");
            Response.Write(pdfDocument);
            Response.Flush();
            Response.End();
        }

        protected void cmbGroupSeance_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

        protected void ListParticipation_SelectedIndexChanged(object sender, EventArgs e)
        {
            NumEtdParticiper.Text = ListParticipation.SelectedRow.Cells[0].Text;
            NumSeanceParticiper.Text = cmbSeance.Text;
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
            Response.AppendHeader("content-disposition", "attachment;filename=Participation.pdf");
            Response.Write(pdfDocument);
            Response.Flush();
            Response.End();
        }
    }
}