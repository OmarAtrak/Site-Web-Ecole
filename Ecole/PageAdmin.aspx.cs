using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;


namespace Ecoule
{
    public partial class PageAdmin : System.Web.UI.Page
    {
        Connection con = new Connection();
        protected void Page_Load(object sender, EventArgs e)
        {
            //HttpCookie hc = Request.Cookies["login"];
            //if (hc.Value != null)
            //{
            //    emailAdmin.Text = hc["email"].ToString();
            //}
            /*if (!IsPostBack)
            {
                RemplirEtudiant();
            }*/


            if (ListSection.Rows.Count == 3)
            {
                tblSection.Visible = false;
            }


            nbrEtd.InnerText = con.nbrEtd().ToString();
            nbrProf.InnerText = con.nbrProf().ToString();
            nbrGroup.InnerText = con.nbrGroup().ToString();
        }

        void RemplirEtudiant()
        {
            DataTable dt = new DataTable();
            con.Connecter();
            con.cmd.Connection = con._con();
            con.cmd.CommandText = "select NUMERO_ETUDIANT ,NOM,PRENOM,ID_GROUP,LEFT(DATENAISSANCE,10) as DATENAISSANCE,TELEPHONE,EMAIL,MOT_PASSE_ETUDIANT,ADRESSE,SEXE from ETUDIANT ORDER BY ID_GROUP";
            con.da.SelectCommand = con.cmd;
            con.da.Fill(dt);
            con.DeConnecter();
            ListEtudiant.DataSource = dt;
            ListEtudiant.DataBind();
        }

        protected void ListEtudiant_RowEditing(object sender, GridViewEditEventArgs e)
        {

        }

        protected void ListEtudiant_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("Add"))
            {
                con.Connecter();
                con.cmd.Connection = con._con();
                con.cmd.CommandText = "insert into ETUDIANT values('" +
                    (ListEtudiant.FooterRow.FindControl("txtGroupFooter") as TextBox).Text.Trim() + "','" +
                    (ListEtudiant.FooterRow.FindControl("txtNomFooter") as TextBox).Text.Trim() + "','" +
                    (ListEtudiant.FooterRow.FindControl("txtPrenomFooter") as TextBox).Text.Trim() + "','" +
                    (ListEtudiant.FooterRow.FindControl("txtTelephoneFooter") as TextBox).Text.Trim() + "','" +
                    (ListEtudiant.FooterRow.FindControl("txtDateNaissanceFooter") as TextBox).Text.Trim() + "','" +
                    (ListEtudiant.FooterRow.FindControl("txtMotPasseFooter") as TextBox).Text.Trim() + "','" +
                    (ListEtudiant.FooterRow.FindControl("txtAdresseFooter") as DropDownList).Text.Trim() + "','" +
                    (ListEtudiant.FooterRow.FindControl("cmbSexeFooter") as DropDownList).Text.Trim() + "','";
                //con.cmd.CommandText = query;
                //con.cmd.Parameters.AddWithValue("@group", (int)((ListEtudiant.FooterRow.FindControl("txtGroupFooter") as TextBox).Text.Trim()));
                //con.cmd.Parameters.AddWithValue("@nom", (ListEtudiant.FooterRow.FindControl("txtNomFooter") as TextBox).Text.Trim());
                //con.cmd.Parameters.AddWithValue("@prenom", (ListEtudiant.FooterRow.FindControl("txtPrenomFooter") as TextBox).Text.Trim());
                //con.cmd.Parameters.AddWithValue("@tele", (ListEtudiant.FooterRow.FindControl("txtTelephoneFooter") as TextBox).Text.Trim());
                //con.cmd.Parameters.AddWithValue("@date", Convert.ToDateTime((ListEtudiant.FooterRow.FindControl("txtDateNaissanceFooter") as TextBox).Text.Trim()));
                //con.cmd.Parameters.AddWithValue("@motPasse", (ListEtudiant.FooterRow.FindControl("txtMotPasseFooter") as TextBox).Text.Trim());
                //con.cmd.Parameters.AddWithValue("@adresse", (ListEtudiant.FooterRow.FindControl("txtAdresseFooter") as DropDownList).Text.Trim());
                //con.cmd.Parameters.AddWithValue("@sexe", (ListEtudiant.FooterRow.FindControl("cmbSexeFooter") as DropDownList).Text.Trim());
                con.cmd.ExecuteNonQuery();
                RemplirEtudiant();
                con.DeConnecter();

            }
        }

        protected void btn_UpdateMotPasse_Click(object sender, EventArgs e)
        {
            Response.Redirect("PageChangerMotPasse.aspx");
        }

        protected void btn_exit_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }

        protected void ListEtudiant_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtNomEtd.Text = ListEtudiant.SelectedRow.Cells[3].Text;
            txtPrenomEtd.Text = ListEtudiant.SelectedRow.Cells[4].Text;
            txtGroupEtd.Text = ListEtudiant.SelectedRow.Cells[2].Text;
            txtDateEtd.Text = Convert.ToDateTime(ListEtudiant.SelectedRow.Cells[6].Text).ToString("yyyy-MM-dd");
            txtTeleEtd.Text = ListEtudiant.SelectedRow.Cells[5].Text;
            txtMotPasseEtd.Text = ListEtudiant.SelectedRow.Cells[7].Text;
            txtAdresseEtd.Text = ListEtudiant.SelectedRow.Cells[9].Text;
            if (ListEtudiant.SelectedRow.Cells[10].Text == "M")
            {
                sexeEtd.Items[0].Selected = true;
                sexeEtd.Items[1].Selected = false;
            }
            else if (ListEtudiant.SelectedRow.Cells[10].Text == "F")
            {
                sexeEtd.Items[0].Selected = false;
                sexeEtd.Items[1].Selected = true;
            }
            sexeEtd.Focus();
        }

        protected void btnAjoutEtd_Click(object sender, EventArgs e)
        {
            string str;
            try
            {
                if (txtNomEtd.Text != "" && txtPrenomEtd.Text != "" && txtDateEtd.Text != "" && txtTeleEtd.Text != "" && txtMotPasseEtd.Text != "" && txtAdresseEtd.Text != "" && (sexeEtd.Items[0].Selected == true) || (sexeEtd.Items[1].Selected == true))
                {
                    Etudiant etd = new Etudiant(int.Parse(txtGroupEtd.Text), txtNomEtd.Text, txtPrenomEtd.Text, txtTeleEtd.Text, Convert.ToDateTime(txtDateEtd.Text), txtAdresseEtd.Text, sexeEtd.SelectedValue, txtMotPasseEtd.Text);
                    etd.Ajout();

                    Response.Redirect(Page.Request.Path);
                    lblmsg.Focus();
                }
            }
            catch (Exception ex)
            {
                    str = ex.Message;
                    Response.Write("<script language='javascript'>alert('" + str + "');</script>");
            }
        }

        protected void btnSupprimer_Click(object sender, EventArgs e)
        {
            string str = "";
            try
            {
                if (txtNomEtd.Text != "" && txtPrenomEtd.Text != "" && txtDateEtd.Text != "" && txtTeleEtd.Text != "" && txtMotPasseEtd.Text != "" && txtAdresseEtd.Text != "" && (sexeEtd.Items[0].Selected == true) || (sexeEtd.Items[1].Selected == true))
                {
                    Etudiant etd = new Etudiant();
                    etd.Supprimer(int.Parse(ListEtudiant.SelectedRow.Cells[1].Text));
                    Response.Redirect(Page.Request.Path);
                    lblmsg.Focus();
                }                
            }
            catch (Exception ex)
            {
                str = ex.Message;
                Response.Write("<script language='javascript'>alert('" + str + "');</script>");
            }
        }

        protected void btnModifier_Click(object sender, EventArgs e)
        {
            string str = "";
            try
            {
                if (txtNomEtd.Text != "" && txtPrenomEtd.Text != "" && txtDateEtd.Text != "" && txtTeleEtd.Text != "" && txtMotPasseEtd.Text != "" && txtAdresseEtd.Text != "" && (sexeEtd.Items[0].Selected == true) || (sexeEtd.Items[1].Selected == true))
                {

                    Etudiant etd = new Etudiant();
                    Etudiant.Charger(etd, ListEtudiant.SelectedRow.Cells[8].Text);
                    etd.Nom = txtNomEtd.Text;
                    etd.Prenom = txtPrenomEtd.Text;
                    etd.Group = int.Parse(txtGroupEtd.Text);
                    etd.DateNaissance = DateTime.Parse(txtDateEtd.Text);
                    etd.Tele = txtTeleEtd.Text;
                    etd.Mot_passe = txtMotPasseEtd.Text;
                    etd.Adresse = txtAdresseEtd.Text;
                    etd.Sexe = sexeEtd.SelectedValue;
                    etd.Modifer(int.Parse(ListEtudiant.SelectedRow.Cells[1].Text));
                    Response.Redirect(Page.Request.Path);
                    lblmsg.Focus();
                }
            }
            catch (Exception ex)
            {
                str = ex.Message;
                Response.Write("<script language='javascript'>alert('" + str + "');</script>");
            }
        }






        protected void btnAjoutProf_Click(object sender, EventArgs e)
        {
            string str;
            try
            {
                con.Connecter();
                //con.cmd.CommandText = "insert into PROFESSEUR (NOM,PRENOM,DATENAISSANCE,TELEPHONE,MOT_PASSE_PROF,SEXE,ADRESSE,SALAIRE,GMAIL) values('" + txtNomProf.Text.Trim() + "','" + txtPrenomProf.Text.Trim() + "','" + Convert.ToDateTime(txtDateProf.Text) + "','" + txtTeleProf.Text + "','" + txtMotPasseProf.Text + "','" + sexeProf.SelectedValue.ToString() + "','" + txtAdresseProf.Text + "','" + float.Parse(txtSalaireProf.Text) + "','" + txtGmailProf.Text + "')";
                SqlCommand cmd = new SqlCommand("insert into PROFESSEUR (MATRICULE,NOM,PRENOM,DATENAISSANCE,TELEPHONE,MOT_PASSE_PROF,SEXE,ADRESSE,SALAIRE,GMAIL) values('"+ int.Parse(txtNumeroProf.Text) + "','" + txtNomProf.Text + "','" + txtPrenomProf.Text + "','" + Convert.ToDateTime(txtDateProf.Text) + "','" + txtTeleProf.Text + "','" + txtMotPasseProf.Text + "','" + sexeProf.SelectedValue.ToString() + "','" + txtAdresseProf.Text + "','"+ float.Parse(txtSalaireProf.Text) +"','"+ txtGmailProf.Text +"')", con._con());
                cmd.ExecuteNonQuery();
                con.DeConnecter();
                str = "Ajout Professeur Efectuee";
                Response.Redirect(Page.Request.Path);
                Response.Write("<script language='javascript'>alert('" + str + "');</script>");
                lblmssgProf.Focus();
            }
            catch (Exception ex)
            {
                str = ex.Message;
                Response.Write("<script language='javascript'>alert('" + str + "');</script>");
            }
        }

        protected void btnModiferProf_Click(object sender, EventArgs e)
        {
            string str;
            try
            {
                con.Connecter();
                SqlCommand cmd = new SqlCommand("update PROFESSEUR set NOM='" + txtNomProf.Text.Trim() + 
                                            "',PRENOM='" + txtPrenomProf.Text.Trim() +
                                            "',TELEPHONE='" + txtTeleProf.Text +
                                            "',DATENAISSANCE='" + Convert.ToDateTime(txtDateProf.Text) +
                                            "',MOT_PASSE_PROF='" + txtMotPasseProf.Text +
                                            "',ADRESSE='" + txtAdresseProf.Text +
                                            "',SEXE='" + sexeProf.SelectedValue.ToString() +
                                            "',SALAIRE='" + float.Parse(txtSalaireProf.Text) +
                                            "' where MATRICULE='" + int.Parse(ListProf.SelectedRow.Cells[1].Text) + "'", con._con());
                cmd.ExecuteNonQuery();
                con.DeConnecter();
                str = "Modifier Professeur Efectuee";
                Response.Redirect(Page.Request.Path);
                Response.Write("<script language='javascript'>alert('" + str + "');</script>");
                lblmssgProf.Focus();
            }
            catch (Exception ex)
            {
                str = ex.Message;
                Response.Write("<script language='javascript'>alert('" + str + "');</script>");
            }

        }

        protected void btnSupprimerProf_Click(object sender, EventArgs e)
        {
            string str = "";
            try
            {
                con.Connecter();
                SqlCommand cmd = new SqlCommand("delete PROFESSEUR where MATRICULE='" + int.Parse(ListProf.SelectedRow.Cells[1].Text.Trim()) + "'", con._con());
                cmd.ExecuteNonQuery();
                con.DeConnecter();
                Response.Redirect(Page.Request.Path);
                str = "Suprimer Professeur Efectuee";
                Response.Write("<script language='javascript'>alert('" + str + "');</script>");
                sexeProf.Focus();
            }
            catch (Exception ex)
            {
                str = ex.Message;
                Response.Write("<script language='javascript'>alert('" + str + "');</script>");
            }
        }

        protected void ListProf_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtNumeroProf.Text = ListProf.SelectedRow.Cells[1].Text;
            txtNomProf.Text = ListProf.SelectedRow.Cells[2].Text.Trim();
            txtPrenomProf.Text = ListProf.SelectedRow.Cells[3].Text.Trim();
            txtDateProf.Text = Convert.ToDateTime(ListProf.SelectedRow.Cells[4].Text).ToString();
            txtTeleProf.Text = ListProf.SelectedRow.Cells[5].Text;
            txtMotPasseProf.Text = ListProf.SelectedRow.Cells[7].Text;
            txtAdresseProf.Text = ListProf.SelectedRow.Cells[9].Text;
            txtSalaireProf.Text = ListProf.SelectedRow.Cells[10].Text;
            txtGmailProf.Text = ListProf.SelectedRow.Cells[11].Text;
            if (ListProf.SelectedRow.Cells[8].Text == "M")
            {
                sexeProf.Items[0].Selected = true;
                sexeProf.Items[1].Selected = false;
            }
            else if (ListProf.SelectedRow.Cells[8].Text == "F")
            {
                sexeProf.Items[0].Selected = false;
                sexeProf.Items[1].Selected = true;
            }
            sexeProf.Focus();
        }

        protected void btnAjoutSection_Click(object sender, EventArgs e)
        {
            string str = "";
            try
            {
                if (ListSection.Rows.Count <= 0)
                {
                    txtNumeroSection.Text = 1.ToString();
                }
                else
                {
                    txtNumeroSection.Text = ((int.Parse(ListSection.Rows[ListSection.Rows.Count - 1].Cells[1].Text)) + 1).ToString();
                }
                con.Connecter();
                SqlCommand cmd = new SqlCommand("insert into SECTION value('" + Convert.ToInt32(txtNumeroSection.Text) + "')", con._con());
                cmd.ExecuteNonQuery();
                con.DeConnecter();
                Response.Redirect(Page.Request.Path);
                str = "Ajout Section Efectuee";
                Response.Write("<script language='javascript'>alert('" + str + "');</script>");
            }
            catch (Exception ex)
            {
                str = ex.Message;
                Response.Write("<script language='javascript'>alert('" + str + "');</script>");
            }
        }

        protected void btnModifierSection_Click(object sender, EventArgs e) { }

        protected void btnSuprimerSection_Click(object sender, EventArgs e)
        {
            string str = "";
            try
            {
                con.Connecter();
                SqlCommand cmd = new SqlCommand("delete SECTION where NUMERO_SECTION='" + int.Parse(ListSection.SelectedRow.Cells[1].Text) + "'", con._con());
                cmd.ExecuteNonQuery();
                con.DeConnecter();
                Response.Redirect(Page.Request.Path);
                str = "Suprimer Section Efectuee";
                Response.Write("<script language='javascript'>alert('" + str + "');</script>");
            }
            catch (Exception ex)
            {
                str = ex.Message;
                Response.Write("<script language='javascript'>alert('" + str + "');</script>");
            }
        }

        protected void ListSection_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtNumeroSection.Text = ListSection.SelectedRow.Cells[1].Text;
        }

        protected void ListGroup_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtIDGroup.Text = ListGroup.SelectedRow.Cells[1].Text;
            txtSectionGroup.Text = ListGroup.SelectedRow.Cells[2].Text;
            txtNumeroGroup.Text = ListGroup.SelectedRow.Cells[3].Text;
        }

        protected void btnAjoutGroup_Click(object sender, EventArgs e)
        {
            string str = "";
            try
            {
                con.Connecter();
                SqlCommand cmd = new SqlCommand("insert into [GROUP] values('" + Convert.ToInt32(txtIDGroup.Text) + "','"+ Convert.ToInt32(txtSectionGroup.SelectedValue) +"','"+ Convert.ToInt32(txtNumeroGroup.Text) +"')", con._con());
                cmd.ExecuteNonQuery();
                con.DeConnecter();
                Response.Redirect(Page.Request.Path);
                str = "Ajout Group Efectuee";
                Response.Write("<script language='javascript'>alert('" + str + "');</script>");
            }
            catch (Exception ex)
            {
                str = ex.Message;
                Response.Write("<script language='javascript'>alert('" + str + "');</script>");
            }
        }

        protected void btnModifierGroup_Click(object sender, EventArgs e)
        {
            string str;
            try
            {
                con.Connecter();
                SqlCommand cmd = new SqlCommand("update [GROUP] set NUMERO_SECTION='" + Convert.ToInt32(txtSectionGroup.SelectedValue) +
                                            "',NUMERO_GROUP='" + Convert.ToInt32(txtNumeroGroup.Text) +
                                            "' where ID_GROUP='" + int.Parse(ListGroup.SelectedRow.Cells[1].Text) + "'", con._con());
                cmd.ExecuteNonQuery();
                con.DeConnecter();
                str = "Modifier Group Efectuee";
                Response.Redirect(Page.Request.Path);
                Response.Write("<script language='javascript'>alert('" + str + "');</script>");
                lblmssgProf.Focus();
            }
            catch (Exception ex)
            {
                str = ex.Message;
                Response.Write("<script language='javascript'>alert('" + str + "');</script>");
            }
        }

        protected void btnSupprimerGroup_Click(object sender, EventArgs e)
        {
            string str = "";
            try
            {
                con.Connecter();
                SqlCommand cmd = new SqlCommand("delete [GROUP] where ID_GROUP='" + int.Parse(ListGroup.SelectedRow.Cells[1].Text.Trim()) + "'", con._con());
                cmd.ExecuteNonQuery();
                con.DeConnecter();
                Response.Redirect(Page.Request.Path);
                str = "Suprimer Group Efectuee";
                Response.Write("<script language='javascript'>alert('" + str + "');</script>");
                sexeProf.Focus();
            }
            catch (Exception ex)
            {
                str = ex.Message;
                Response.Write("<script language='javascript'>alert('" + str + "');</script>");
            }
        }

        protected void ListModule_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtIdModule.Text = ListModule.SelectedRow.Cells[1].Text;
            txtLibelleModule.Text = ListModule.SelectedRow.Cells[2].Text;
        }

        protected void btnAjoutModule_Click(object sender, EventArgs e)
        {
            string str = "";
            try
            {
                con.Connecter();
                SqlCommand cmd = new SqlCommand("insert into MODULE values('" + Convert.ToInt32(txtIdModule.Text) + "','" +
                                                 txtLibelleModule.Text + "')", con._con());
                cmd.ExecuteNonQuery();
                con.DeConnecter();
                Response.Redirect(Page.Request.Path);
                str = "Ajout Module Efectuee";
                Response.Write("<script language='javascript'>alert('" + str + "');</script>");
            }
            catch (Exception ex)
            {
                str = ex.Message;
                Response.Write("<script language='javascript'>alert('" + str + "');</script>");
            }
        }

        protected void btnModifierModule_Click(object sender, EventArgs e)
        {
            string str;
            try
            {
                con.Connecter();
                SqlCommand cmd = new SqlCommand("update MODULE set LIBELLE='" + txtLibelleModule.Text +
                                                "' where ID_MODULE='" + int.Parse(ListModule.SelectedRow.Cells[1].Text) + "'", con._con());
                cmd.ExecuteNonQuery();
                con.DeConnecter();
                str = "Modifier Module Efectuee";
                Response.Redirect(Page.Request.Path);
                Response.Write("<script language='javascript'>alert('" + str + "');</script>");
                lblmssgProf.Focus();
            }
            catch (Exception ex)
            {
                str = ex.Message;
                Response.Write("<script language='javascript'>alert('" + str + "');</script>");
            }
        }

        protected void btnSupprimerModule_Click(object sender, EventArgs e)
        {
            string str = "";
            try
            {
                con.Connecter();
                SqlCommand cmd = new SqlCommand("delete MODULE where ID_MODULE='" + int.Parse(ListModule.SelectedRow.Cells[1].Text.Trim()) + "'", con._con());
                cmd.ExecuteNonQuery();
                con.DeConnecter();
                Response.Redirect(Page.Request.Path);
                str = "Suprimer Module Efectuee";
                Response.Write("<script language='javascript'>alert('" + str + "');</script>");
                sexeProf.Focus();
            }
            catch (Exception ex)
            {
                str = ex.Message;
                Response.Write("<script language='javascript'>alert('" + str + "');</script>");
            }
        }

        protected void ChangerMotPasse_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("PageChangerMotPasse.aspx");
        }

        protected void btnImgDeconnecter_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("Home.aspx");
        }

        protected void btnInsialiser_Click(object sender, EventArgs e)
        {
            txtNomEtd.Text = txtPrenomEtd.Text = txtDateEtd.Text = txtTeleEtd.Text = "";
            txtAdresseEtd.Text = txtMotPasseEtd.Text = "";
            txtGroupEtd.Items[0].Selected = true;
            sexeEtd.Items[0].Selected = false;
            sexeEtd.Items[1].Selected = false;
        }
    }
}