using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EThrift_Web.ServiceReference1;

namespace EThrift_Web
{
    public partial class invoiceDetails : System.Web.UI.Page
    {
        Service1Client client = new Service1Client();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                string idStr = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(idStr))
                {
                    int invId = int.Parse(idStr);

                    var invoice = client.GetInvoiceHeader(invId);

                    if (invoice != null)
                    {
                        int currentUserId = Convert.ToInt32(Session["UserID"]);
                        string userType = Session["UserType"] != null ? Session["UserType"].ToString() : "Customer";

                        if (invoice.UserId == currentUserId || userType == "Manager")
                        {
                            LoadDetails(invId);
                        }
                        else
                        {
                            Response.Redirect("products.aspx");
                        }
                    }
                    else
                    {
                        Response.Redirect("products.aspx");
                    }
                }
                else
                {
                    Response.Redirect("products.aspx");
                }
            }
        }

        private void LoadDetails(int invId)
        {
            // 1. Get Header Info
            var inv = client.GetInvoiceDetails(invId); // You added this method earlier
            if (inv != null)
            {
                lblInvoiceId.Text = inv.InvoiceId.ToString();
                lblDate.InnerText = inv.DatePlaced.ToString("dd MMM yyyy");
                lblTotal.Text = "R " + Math.Round(inv.TotalAmount, 2);

                // 2. Get Items
                var items = client.GetInvoiceItems(invId); // New method
                rptItems.DataSource = items;
                rptItems.DataBind();
            }
        }
    }
}