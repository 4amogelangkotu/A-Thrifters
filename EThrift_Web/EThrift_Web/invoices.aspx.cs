using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EThrift_Web.ServiceReference1;

namespace EThrift_Web
{
    public partial class invoices : System.Web.UI.Page
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
                LoadInvoices();
            }
        }

        private void LoadInvoices()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            var invoiceList = client.GetUserInvoices(userId);

            if (invoiceList != null && invoiceList.Length > 0)
            {
                historyContent.Visible = true;
                emptyHistory.Visible = false;

                rptInvoices.DataSource = invoiceList.OrderByDescending(i => i.InvoiceId);
                rptInvoices.DataBind();
            }
            else
            {
                historyContent.Visible = false;
                emptyHistory.Visible = true;
            }
        }

        protected string GetStatusHtml(object statusObj)
        {
            if (statusObj == null || statusObj == DBNull.Value)
            {
                return "<span class='badge-warning'>Pending</span>";
            }

            string status = statusObj.ToString();
            string cssClass = "badge-secondary";

            if (status == "Paid")
                cssClass = "badge-success"; 
            else if (status == "Pending")
                cssClass = "badge-warning";
            else if (status == "Shipped")
                cssClass = "badge-info";
            else if (status == "Delivered")
                cssClass = "badge-success";
            else if (status == "Cancelled")
                cssClass = "badge-danger";

            return $"<span class='{cssClass}'>{status}</span>";
        }
    }
}