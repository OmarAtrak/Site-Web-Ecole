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
    public partial class PageProfesseur1 : System.Web.UI.MasterPage
    {
        Connection con = new Connection();

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
            lblModule.Text = infos.Rows[0][9].ToString();
        }

        protected void btnSeance_Click(object sender, EventArgs e)
        {
            Response.Redirect("ContentSeanceProf.aspx");
        }

        protected void btnPresence_Click(object sender, EventArgs e)
        {
            Response.Redirect("ContentPresenceProf.aspx");
        }

        protected void btnExame_Click(object sender, EventArgs e)
        {
            Response.Redirect("ContentExameProf.aspx");
        }

        protected void btn_ChangerMotPasse_Click(object sender, EventArgs e)
        {
            Response.Redirect("PageChangerMotPasse.aspx");
        }

        protected void btn_exit_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }
    }
}