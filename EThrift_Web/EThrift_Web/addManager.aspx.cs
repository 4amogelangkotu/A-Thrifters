using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EThrift_Web.ServiceReference1;

namespace EThrift_Web
{
    public partial class addManager : System.Web.UI.Page
    {
        Service1Client client = new Service1Client();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserType"] == null || Session["UserType"].ToString() != "Manager")
            {
                Response.Redirect("index.aspx");
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string name = txtName.Text;
            string pass = txtPassword.Text;
            string confirm = txtConfirmPass.Text;

            if (pass != confirm)
            {
                lblMessage.Text = "Passwords do not match.";
                lblMessage.CssClass = "alert alert-danger btn-block mb-3";
                lblMessage.Visible = true;
                return;
            }

            bool success = client.AddManager(txtName.Text, txtPassword.Text);
            if (success)
            {
                lblMessage.Text = "New Manager registered successfully!";
                lblMessage.CssClass = "alert alert-success btn-block mb-3";
                lblMessage.Visible = true;

                txtName.Text = "";
            }
            else
            {
                lblMessage.Text = "Registration failed. Email might already exist.";
                lblMessage.CssClass = "alert alert-danger btn-block mb-3";
                lblMessage.Visible = true;
            }
        }
    }
}