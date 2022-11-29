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
    public partial class PageChangerMotPasse : System.Web.UI.Page
    {
        Connection con = new Connection();

        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie hc = Request.Cookies["login"];
            if (hc.Value != null)
            {
                lblEmail.Text = hc["email"].ToString();
            }

        }

        protected void btnUpdateMotPasse_Click(object sender, EventArgs e)
        {
            try
            {

                con.Connecter();
                con.cmd.Connection = con._con();
                if (lblEmail.Text.Contains("@etd.ma"))
                {
                    if (txtPassword.Text.Length == 10 && txtPassword1.Text.Length == 10 && txtPassword2.Text.Length == 10)
                    {
                        con.cmd.CommandText = "select MOT_PASSE_ETUDIANT from ETUDIANT where EMAIL='" + lblEmail.Text + "'";
                        string motPasse = (con.cmd.ExecuteScalar()).ToString();

                        if (motPasse.ToString() == txtPassword.Text)
                        {
                            if (txtPassword1.Text == txtPassword2.Text)
                            {
                                con.cmd.CommandText = "update ETUDIANT set MOT_PASSE_ETUDIANT='" + txtPassword1.Text + "' where EMAIL='" + lblEmail.Text + "'";
                                con.cmd.ExecuteNonQuery();

                                msgErrorUpdate.InnerText = "Operation Succés";
                                msgErrorUpdate.Style.Add(HtmlTextWriterStyle.Color, "green");
                            }
                            else
                            {
                                msgErrorUpdate.InnerText = "Les Mots de Passe sont Déffirent";
                                msgErrorUpdate.Style.Add(HtmlTextWriterStyle.Color, "red");
                            }
                        }
                        else
                        {
                            msgErrorUpdate.InnerText = "Mot de Passe Incorrecte";
                            msgErrorUpdate.Style.Add(HtmlTextWriterStyle.Color, "red");
                        }
                    }
                    else
                    {
                        msgErrorUpdate.InnerText = "Le Nombre de Caractere doit etre 10 Caractere";
                        msgErrorUpdate.Style.Add(HtmlTextWriterStyle.Color, "red");
                    }
                }
                else if (lblEmail.Text.Contains("@prof.ma"))
                {
                    con.cmd.CommandText = "select MOT_PASSE_PROF from PROFESSEUR where EMAIL='" + lblEmail.Text + "'";
                    string mot_passe = (con.cmd.ExecuteScalar()).ToString();
                    //lblEmail.Text = mot_passe;
                    if (txtPassword.Text.Length == 10 && txtPassword1.Text.Length == 10 && txtPassword2.Text.Length == 10)
                    {
                        if (mot_passe == txtPassword.Text)
                        {
                            if (txtPassword1.Text == txtPassword2.Text)
                            {
                                con.cmd.CommandText = "update PROFESSEUR set MOT_PASSE_PROF='" + txtPassword1.Text + "' where EMAIL='" + lblEmail.Text + "'";
                                con.cmd.ExecuteNonQuery();

                                msgErrorUpdate.InnerText = "Operation Succés";
                                msgErrorUpdate.Style.Add(HtmlTextWriterStyle.Color, "green");
                            }
                            else
                            {
                                msgErrorUpdate.InnerText = "Les Mots de Passe sont Déffirent";
                                msgErrorUpdate.Style.Add(HtmlTextWriterStyle.Color, "red");
                            }
                        }
                        else
                        {
                            msgErrorUpdate.InnerText = "Mot de Passe Incorrecte";
                            msgErrorUpdate.Style.Add(HtmlTextWriterStyle.Color, "red");
                        }
                    }
                    else
                    {
                        msgErrorUpdate.InnerText = "Le Nombre de Caractere doit etre 10 Caractere";
                        msgErrorUpdate.Style.Add(HtmlTextWriterStyle.Color, "red");
                    }
                }
                else if (lblEmail.Text.Contains("@admin.ma"))
                {
                    con.cmd.CommandText = "select MOT_PASSE from [ADMIN] where EMAIL='" + lblEmail.Text + "'";
                    string mot_passe = (con.cmd.ExecuteScalar()).ToString();
                    //lblEmail.Text = mot_passe;
                    if (txtPassword.Text.Length == 10 && txtPassword1.Text.Length == 10 && txtPassword2.Text.Length == 10)
                    {
                        if (mot_passe == txtPassword.Text)
                        {
                            if (txtPassword1.Text == txtPassword2.Text)
                            {
                                con.cmd.CommandText = "update [ADMIN] set MOT_PASSE='" + txtPassword1.Text + "' where EMAIL='" + lblEmail.Text + "'";
                                con.cmd.ExecuteNonQuery();

                                msgErrorUpdate.InnerText = "Operation Succés";
                                msgErrorUpdate.Style.Add(HtmlTextWriterStyle.Color, "green");
                            }
                            else
                            {
                                msgErrorUpdate.InnerText = "Les Mots de Passe sont Déffirent";
                                msgErrorUpdate.Style.Add(HtmlTextWriterStyle.Color, "red");
                            }
                        }
                        else
                        {
                            msgErrorUpdate.InnerText = "Mot de Passe Incorrecte";
                            msgErrorUpdate.Style.Add(HtmlTextWriterStyle.Color, "red");
                        }
                    }
                    else
                    {
                        msgErrorUpdate.InnerText = "Le Nombre de Caractere doit etre 10 Caractere";
                        msgErrorUpdate.Style.Add(HtmlTextWriterStyle.Color, "red");
                    }
                }
                con.DeConnecter();
            }
            catch (Exception ex)
            {
            }
        }

        protected void btnReteur_Click(object sender, EventArgs e)
        {
            if (lblEmail.Text.Contains("@etd.ma"))
            {
                Response.Redirect("PageEtudiant.aspx");
            }
            else if (lblEmail.Text.Contains("@prof.ma"))
            {
                Response.Redirect("ContentSeanceProf.aspx");
            }
            else if (lblEmail.Text.Contains("@admin.ma"))
            {
                Response.Redirect("ContentEtudiant.aspx");
            }
        }
    }
}