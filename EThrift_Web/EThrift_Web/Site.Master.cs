using System;
using System.Web.UI;

namespace EThrift_Web
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                UpdateNavigation();
            }
        }

        private void UpdateNavigation()
        {
            navGuest.Visible = false;
            navCustomer.Visible = false;
            navManager.Visible = false;

            if (Session["UserType"] != null)
            {
                string userType = Session["UserType"].ToString();
                string userEmail = Session["UserEmail"] != null ? Session["UserEmail"].ToString() : "User";

                if (userType == "Manager")
                {
                    navManager.Visible = true;
                    lblManEmail.Text = userEmail;
                }
                else if (userType == "Customer")
                {
                    navCustomer.Visible = true;
                    lblCustEmail.Text = userEmail;
                }
            }
            else
            {
                navGuest.Visible = true;
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("login.aspx");
        }
    }
}