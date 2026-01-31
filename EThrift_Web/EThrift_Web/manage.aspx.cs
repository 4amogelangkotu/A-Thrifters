using System;
using System.Web.UI;
using EThrift_Web.ServiceReference1;

namespace EThrift_Web
{
    public partial class manage : System.Web.UI.Page
    {
        Service1Client client = new Service1Client();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserType"] == null || Session["UserType"].ToString() != "Manager")
            {
                Response.Redirect("login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadStats();
            }
        }

        private void LoadStats()
        {
            try
            {
                var stats = client.GetDashboardStats();

                if (stats != null)
                {
                    hRevenue.InnerText = "R " + stats.TotalRevenue.ToString("N2");
                    hOrders.InnerText = stats.TotalOrders.ToString();
                    hUsers.InnerText = stats.TotalUsers.ToString();
                    hProducts.InnerText = stats.TotalProducts.ToString();
                }
            }
            catch (Exception)
            {
            }
        }
    }
}