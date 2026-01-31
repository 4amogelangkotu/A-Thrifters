using System;
using EThrift_Web.ServiceReference1; // Reference to your WCF Service

namespace EThrift_Web
{
    public partial class login : System.Web.UI.Page
    {
        Service1Client client = new Service1Client();

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text;
            string pass = txtPassword.Text;

            // 1. Call the Service to get the User Object
            var user = client.Login(email, pass);

            if (user != null)
            {
                // 2. SAVE ALL THESE SESSION VARIABLES
                Session["UserID"] = user.UserId;

                // CRITICAL: This is what the Master Page checks!
                Session["UserType"] = user.UserType;

                // This is what the Master Page displays in the menu (e.g. the email address)
                Session["UserEmail"] = user.Name;

                // 3. Redirect based on type (Optional, or just go to Home)
                if (user.UserType == "Manager")
                {
                    Response.Redirect("manage.aspx");
                }
                else
                {
                    Response.Redirect("products.aspx");
                }
            }
            else
            {
                lblError.Text = "Invalid Email or Password";
                lblError.Visible = true;
            }
        }
    }
}