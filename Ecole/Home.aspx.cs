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
    public partial class Home : System.Web.UI.Page
    {
        // creer un objet de classe connection
        Connection con = new Connection();
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btn_connecter_Click(object sender, EventArgs e)
        {

            int a = 0; // pour savoire si l'utilisateur est etudiant ou professeur ou admin

            if (email.Value.Contains("@etd.ma"))
            {
                if (con.VeriverLogin("ETUDIANT",email.Value.ToString(), password.Value.ToString()) == true)
                {
                    a = 1;
                }
            }
            else if (email.Value.Contains("@prof.ma"))
            {
                if (con.VeriverLogin("PROFESSEUR", email.Value.ToString(), password.Value.ToString()) == true)
                {
                    a = 2;
                }
            }
            else if (email.Value.Contains("@admin.ma"))
            {
                if (con.VeriverLogin("ADMIN", email.Value.ToString(), password.Value.ToString()) == true)
                {
                    a = 3;
                }
            }

            // crrer un cookie pour savoire l'email de utilisateur
            HttpCookie hc = new HttpCookie("login");
            hc["email"] = email.Value.ToString(); ;
            hc.Expires.Add(new TimeSpan(1, 0, 0));
            Response.Cookies.Add(hc);

            // vider zone de saisir
            email.Value = password.Value = "";

            if (a == 0)
            {
                msg.InnerText = "Email ou Mot de Passe est Incorrecte";
            }
            else if (a == 1)
            {
                Response.Redirect("PageEtudiant.aspx");
            }
            else if (a == 2)
            {
                Response.Redirect("ContentSeanceProf.aspx");
                //Response.Redirect("PageProfesseurs.aspx");
            }
            else if (a == 3)
            {
                Response.Redirect("ContentEtudiant.aspx");
            }
        }
    }
}