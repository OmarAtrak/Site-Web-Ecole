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
    public partial class PageAdmin1 : System.Web.UI.MasterPage
    {
        Connection con = new Connection();
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie hc = Request.Cookies["login"];
            if (hc.Value != null)
            {
                emailAdmin.Text = hc["email"].ToString();
            }
            if (!IsPostBack)
            {
                DataTable dt = new DataTable();
                dt = Infos();
                lblNumero.Text = dt.Rows[0][0].ToString();
                lblNom.Text = dt.Rows[0][1].ToString();
                lblPrenom.Text = dt.Rows[0][2].ToString();
                lblDate.Text = dt.Rows[0][3].ToString();
                lblTele.Text = dt.Rows[0][4].ToString();
                lblEmail.Text = dt.Rows[0][5].ToString();
            }


            nbrEtd.InnerText = con.nbrEtd().ToString();
            nbrProf.InnerText = con.nbrProf().ToString();
            nbrGroup.InnerText = con.nbrGroup().ToString();
        }

        DataTable Infos()
        {
            DataTable dt = new DataTable();
            if (dt != null)
            {
                dt.Rows.Clear();
            }
            con.Connecter();
            con.cmd.Connection = con._con();
            con.cmd.CommandText = "select NUMERO,NOM,PRENOM,LEFT(DATENAISSANCE,10),TELEPHONE,EMAIL from ADMIN";
            con.da.SelectCommand = con.cmd;
            con.da.Fill(dt);
            con.DeConnecter();
            return dt;
        }

        protected void ChangerMotPasse_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("PageChangerMotPasse.aspx");
        }

        protected void btnImgDeconnecter_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("Home.aspx");
        }

        protected void btnEtudiant_Click(object sender, EventArgs e)
        {
            Response.Redirect("ContentEtudiant.aspx");
        }

        protected void Button1_Click(object sender, EventArgs e){}

        protected void btnProf_Click(object sender, EventArgs e)
        {
            Response.Redirect("ContentProfesseur.aspx");
        }

        protected void btnSection_Click(object sender, EventArgs e)
        {
            Response.Redirect("ContentSectionGroup.aspx");
        }

        protected void btnModule_Click(object sender, EventArgs e)
        {
            Response.Redirect("ContentModule.aspx");
        }

        protected void btnSalle_Click(object sender, EventArgs e)
        {
            Response.Redirect("ContentSalle.aspx");
        }

        protected void btnSeance_Click(object sender, EventArgs e)
        {
            Response.Redirect("ContentSeance.aspx");
        }
    }
}