using System;
using EThrift_Web.ServiceReference1;

namespace EThrift_Web
{
    public partial class register : System.Web.UI.Page
    {
        Service1Client client = new Service1Client();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserType"] != null && Session["UserType"].ToString() == "Manager")
                {
                    divUserType.Visible = true;
                }
                else
                {
                    divUserType.Visible = false;
                }
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (txtPassword.Text != txtConfirm.Text)
            {
                lblMessage.Text = "Passwords do not match.";
                lblMessage.Visible = true;
                return;
            }

            if (client.UserExists(txtEmail.Text))
            {
                lblMessage.Text = "User already exists.";
                lblMessage.Visible = true;
                return;
            }

            string userType = "Customer";
            if (divUserType.Visible && dlUserType.SelectedValue == "Manager")
            {
                userType = "Manager";
            }

            bool success = client.RegisterUser(txtEmail.Text, txtPassword.Text, userType);

            if (success)
            {
                Response.Redirect("login.aspx");
            }
            else
            {
                lblMessage.Text = "Registration failed. Please try again.";
                lblMessage.Visible = true;
            }
        }
    }
}