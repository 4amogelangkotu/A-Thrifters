using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EThrift_Web.ServiceReference1;

namespace EThrift_Web
{
    public partial class cart : System.Web.UI.Page
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
                LoadCart();
            }
        }

        private void LoadCart()
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            var cartItems = client.GetCartItems(userId);

            if (cartItems != null && cartItems.Count() > 0)
            {
                cartContent.Visible = true;
                emptyCart.Visible = false;

                rptCart.DataSource = cartItems;
                rptCart.DataBind();

                double total = 0;
                foreach (var item in cartItems)
                {
                    total += (double)item.Price * item.Quantity;
                }

                lblSubtotal.Text = "R " + Math.Round(total, 2);
                lblGrandTotal.Text = "R " + Math.Round(total, 2);
            }
            else
            {
                cartContent.Visible = false;
                emptyCart.Visible = true;
            }
        }

        protected void rptCart_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Remove")
            {
                int userId = Convert.ToInt32(Session["UserID"]);
                int prodId = Convert.ToInt32(e.CommandArgument);

                bool success = client.RemoveFromCart(userId, prodId);

                if (success)
                {
                    LoadCart();
                    lblMessage.Text = "Item removed.";
                    lblMessage.CssClass = "alert alert-success btn-block";
                    lblMessage.Visible = true;
                }
                else
                {
                    lblMessage.Text = "Could not remove item.";
                    lblMessage.CssClass = "alert alert-danger btn-block";
                    lblMessage.Visible = true;
                }
            }
        }
    }
}