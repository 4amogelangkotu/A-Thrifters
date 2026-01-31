using System;
using System.Web.UI.WebControls;
using EThrift_Web.ServiceReference1;

namespace EThrift_Web
{
    public partial class allOrders : System.Web.UI.Page
    {
        Service1Client client = new Service1Client();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserType"] == null || Session["UserType"].ToString() != "Manager")
            {
                Response.Redirect("login.aspx");
            }

            if (!IsPostBack)
            {
                LoadAllOrders();
            }
        }

        private void LoadAllOrders()
        {
            var list = client.GetAllInvoices();
            if (list != null && list.Length > 0)
            {
                rptOrders.DataSource = list;
                rptOrders.DataBind();
                noOrders.Visible = false;
            }
            else
            {
                rptOrders.Visible = false;
                noOrders.Visible = true;
            }
        }

        protected void rptOrders_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "UpdateStatus")
            {
                int invoiceId = Convert.ToInt32(e.CommandArgument);

                DropDownList ddl = (DropDownList)e.Item.FindControl("ddlStatus");
                string newStatus = ddl.SelectedValue;

                bool success = client.UpdateInvoiceStatus(invoiceId, newStatus);

                if (success)
                {
                    LoadAllOrders();
                }
            }
        }
    }
}