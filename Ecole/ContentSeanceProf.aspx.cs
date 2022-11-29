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
    public partial class ContentSeanceProf : System.Web.UI.Page
    {
        Connection con = new Connection();
        static int NumeroProf;
        static int etat;

        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie hc = Request.Cookies["login"];
            if (hc.Value != null)
            {
                con.Connecter();
                con.cmd.Connection = con._con();
                con.cmd.CommandText = "select MATRICULE from PROFESSEUR where EMAIL='" + hc["email"].ToString() + "'";
                NumeroProf = int.Parse(con.cmd.ExecuteScalar().ToString());
                con.DeConnecter();
            }

            if (!IsPostBack)
            {
                con.RemplirSalle(cmbSalle);

                con.Connecter();
                con.cmd.Connection = con._con();
                con.cmd.CommandText = "select LIBELLE from PROFESSEUR " +
                                      "inner join MODULE on PROFESSEUR.ID_MODULE=MODULE.ID_MODULE " +
                                      "where MATRICULE='"+NumeroProf+"'";
                txtModule.Text = con.cmd.ExecuteScalar().ToString();
                con.DeConnecter();
            }
            if (etat == 1)
            {
                string msg = "Operation Effectuee";
                Response.Write("<script language='javascript'>alert('" + msg + "');</script>");
                etat = 0;
            }
        }

        protected void btnValiderSeance_Click(object sender, EventArgs e)
        {
            if (txtDate.Text != "")
            {
                if (DateTime.Parse(txtDate.Text).Date <= DateTime.Now.Date)
                {
                    con.Connecter();
                    con.cmd.Connection = con._con();
                    try
                    {
                        // insert les doonnes de table seance
                        con.cmd.CommandText = "insert into SEANCE values('" + Convert.ToDateTime(txtDate.Text) + "','" +
                                                                            cmbHeureDebut.Text + "','" +
                                                                            cmbHeureFin.Text + "')";
                        con.cmd.ExecuteNonQuery();
                        con.cmd.Parameters.Clear();

                        // selectionner numero de seance
                        con.cmd.CommandText = "select top(1) ID_SEANCE from SEANCE order by ID_SEANCE desc";
                        int seance = int.Parse(con.cmd.ExecuteScalar().ToString());
                        con.cmd.Parameters.Clear();

                        // selectionner id group
                        con.cmd.CommandText = "select dbo.IdGroup('" + cmbGroup.SelectedValue.Trim() + "')";
                        int group = int.Parse(con.cmd.ExecuteScalar().ToString());
                        con.cmd.Parameters.Clear();

                        // selectionner id module
                        con.cmd.CommandText = "select dbo.idModule('" + txtModule.Text.Trim() + "')";
                        int module = int.Parse(con.cmd.ExecuteScalar().ToString());
                        con.cmd.Parameters.Clear();

                        // insert les donnees de table Detail seance
                        con.cmd.CommandText = "insert into DETAIL_SEANCE (ID_SEANCE,ID_GROUP,NUMERO_SALLE,PROFESSEUR) " +
                                            "values('" + seance + "','" + group + "','" +
                                            int.Parse(cmbSalle.SelectedValue) + "','" + NumeroProf + "')";
                        con.cmd.ExecuteNonQuery();
                        con.cmd.Parameters.Clear();

                        con.cmd.CommandText = "select top(1) ID_SEANCE from DETAIL_SEANCE order by ID_SEANCE desc";
                        int seance1 = int.Parse(con.cmd.ExecuteScalar().ToString());
                        if (seance == seance1)
                        {
                            etat = 1;
                            Response.Redirect(Page.Request.Path);
                        }
                        else
                        {
                            con.cmd.CommandText = "delete SEANCE where ID_SEANCE='"+ seance +"'";
                            con.cmd.ExecuteNonQuery();
                            lblmsg.Text = "Le Professeur ou Le Group dans une Seance, ou La Salle est pas Disponible en ce moment";
                            lblmsg.ForeColor = System.Drawing.Color.Red;
                            etat = 0;
                        }
                    }
                    catch (Exception ex)
                    {
                        lblmsg.Text = "Verivier les Donnees";
                        lblmsg.ForeColor = System.Drawing.Color.Red;
                    }
                    finally
                    {
                        con.DeConnecter();
                    }
                }
                else
                {
                    string msg = "La Date de Seance doit etre avant ou la meme de ce Jour";
                    Response.Write("<script language='javascript'>alert('" + msg + "');</script>");
                }
            }
            else
            {
                string msg = "Saisir la Date";
                Response.Write("<script language='javascript'>alert('"+msg+"');</script>");
            }
        }

        protected void btnModifier_Click(object sender, EventArgs e)
        {
            //if (txtDate.Text != "")
            //{
            //    if (DateTime.Parse(txtDate.Text) <= DateTime.Now)
            //    {
            //        con.Connecter();
            //        SqlCommand cmm = new SqlCommand();
            //        cmm.Connection = con._con();

            //        // insert les doonnes de table seance
            //        cmm.CommandText = "insert into SEANCE values('" + Convert.ToDateTime(txtDate.Text) + "','" +
            //                                                            cmbHeureDebut.Text + "','" +
            //                                                            cmbHeureFin.Text + "')";
            //        cmm.ExecuteNonQuery();
                    


            //        cmm.CommandText = "select ID_SEANCE from DETAIL_SEANCE where ID_SEANCE='" + int.Parse(ListSeance.SelectedRow.Cells[0].Text) + "'";
            //        string test = "";
            //        SqlDataReader dr;
            //        dr = cmm.ExecuteReader();
            //        while (dr.Read())
            //        {
            //            test = dr[0].ToString();
            //        }

            //        if (test != "")
            //        {
            //            string msg = "Operation Efectuee";
            //            Response.Write("<script language='javascript'>alert('" + msg + "');</script>");
            //        }
            //        else
            //        {
            //            string msg = "Le Professeur ou Le Group dans une Seance, ou La Salle est pas Disponible en ce moment";
            //            Response.Write("<script language='javascript'>alert('" + msg + "');</script>");
            //        }

            //        con.DeConnecter();
            //        Response.Redirect(Page.Request.RawUrl);
            //    }
            //    else
            //    {
            //        string msg = "La Date de Seance doit etre avant ou la meme de ce Jour";
            //        Response.Write("<script language='javascript'>alert('" + msg + "');</script>");
            //    }
            //}
            //else
            //{
            //    string msg = "Saisir la Date";
            //    Response.Write("<script language='javascript'>alert('" + msg + "');</script>");
            //}
        }

        protected void btnSupprimer_Click(object sender, EventArgs e)
        {
            try
            {
                con.Connecter();
                con.cmd.Connection = con._con();
                con.cmd.CommandText = "delete from DETAIL_SEANCE where ID_SEANCE='" + int.Parse(ListSeance.SelectedRow.Cells[0].Text) + "'";
                con.cmd.ExecuteNonQuery();
                con.cmd.Parameters.Clear();
                con.DeConnecter();

                //lblmsg.Text = "Operation Effectuee";
                //lblmsg.ForeColor = System.Drawing.Color.Green;
                etat = 1;
            }
            catch (Exception ex)
            {
                if (ex.Message == "Object reference not set to an instance of an object.")
                {
                    //lblmsg.Text = "Selectionner un Etudiant";
                    //lblmsg.ForeColor = System.Drawing.Color.Red;
                    string msg = "Selectionner un Etudiant";
                    Response.Write("<script language='javascript'>alert('" + msg + "');</script>");
                }

            }
            Response.Redirect(Page.Request.Path);
        }

        protected void ListSeance_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtModule.Text = ListSeance.SelectedRow.Cells[1].Text;
            cmbGroup.Text = ListSeance.SelectedRow.Cells[2].Text;
            cmbSalle.Text = ListSeance.SelectedRow.Cells[3].Text;
            txtDate.Text = ListSeance.SelectedRow.Cells[4].Text;
            cmbHeureDebut.Text = ListSeance.SelectedRow.Cells[5].Text;
            cmbHeureFin.Items.Clear();
            cmbHeureFin.Items.Add(ListSeance.SelectedRow.Cells[6].Text);
        }

        protected void cmbHeureDebut_SelectedIndexChanged(object sender, EventArgs e)
        {
            HeureFin();
        }

        protected void btnInitialiser_Click(object sender, EventArgs e)
        {
            Response.Redirect(Page.Request.RawUrl);
        }

        public void HeureFin()
        {
            cmbHeureFin.Items.Clear();
            if (cmbHeureDebut.Text == "08:30")
            {
                cmbHeureFin.Items.Add("09:30");
            }
            else if (cmbHeureDebut.Text == "09:30")
            {
                cmbHeureFin.Items.Add("10:30");
            }
            else if (cmbHeureDebut.Text == "10:30")
            {
                cmbHeureFin.Items.Add("11:30");
            }
            else if (cmbHeureDebut.Text == "11:30")
            {
                cmbHeureFin.Items.Add("12:30");
            }
            else if (cmbHeureDebut.Text == "14:30")
            {
                cmbHeureFin.Items.Add("15:30");
            }
            else if (cmbHeureDebut.Text == "15:30")
            {
                cmbHeureFin.Items.Add("16:30");
            }
            else if (cmbHeureDebut.Text == "16:30")
            {
                cmbHeureFin.Items.Add("17:30");
            }
            else if (cmbHeureDebut.Text == "17:30")
            {
                cmbHeureFin.Items.Add("18:30");
            }
        }
    }
}