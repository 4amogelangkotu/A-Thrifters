using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EThrift_Web.ServiceReference1;

namespace EThrift_Web
{
    public partial class checkout : System.Web.UI.Page
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
                CalculateOrderSummary();
            }
        }

        private void CalculateOrderSummary()
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            var cartItems = client.GetCart(userId);

            decimal subtotal = 0;
            if (cartItems != null)
            {
                foreach (var item in cartItems)
                {
                    subtotal += (item.Price * item.Quantity);
                }
            }

            decimal vatRate = 0.15m;
            decimal vatAmount = subtotal * vatRate;
            decimal total = subtotal + vatAmount;

            lblSubtotal.Text = "R " + Math.Round(subtotal, 2);
            lblVat.Text = "R " + Math.Round(vatAmount, 2);
            lblTotal.Text = "R " + Math.Round(total, 2);
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            string totalStr = lblTotal.Text.Replace("R ", "");
            decimal finalTotal = decimal.Parse(totalStr);

            bool success = client.Checkout(userId, finalTotal);

            if (success)
            {
                Response.Redirect("invoices.aspx");
            }
            else
            {
                lblError.Text = "Transaction failed. Please try again.";
                lblError.Visible = true;
            }
        }
    }
}