using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EThrift_Web.ServiceReference1;

namespace EThrift_Web
{
    public partial class wishlist : System.Web.UI.Page
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
                LoadWishlist();
            }
        }

        private void LoadWishlist()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            var items = client.GetWishlist(userId);

            if (items != null && items.Count() > 0)
            {
                wishlistContent.Visible = true;
                emptyWishlist.Visible = false;
                rptWishlist.DataSource = items;
                rptWishlist.DataBind();
            }
            else
            {
                wishlistContent.Visible = false;
                emptyWishlist.Visible = true;
            }
        }

        protected void rptWishlist_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            int prodId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "AddToCart")
            {
                bool added = client.AddToCart(userId, prodId, 1);

                if (added)
                {
                    client.RemoveFromWishlist(userId, prodId);

                    lblMessage.Text = "Item moved to Cart!";
                    lblMessage.CssClass = "alert alert-success btn-block";
                    lblMessage.Visible = true;
                    LoadWishlist();
                }
            }
            else if (e.CommandName == "Remove")
            {
                client.RemoveFromWishlist(userId, prodId);
                LoadWishlist();
            }
        }
    }
}