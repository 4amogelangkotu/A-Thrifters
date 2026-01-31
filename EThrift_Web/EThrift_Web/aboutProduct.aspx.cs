using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EThrift_Web.ServiceReference1;

namespace EThrift_Web
{
    public partial class aboutProduct : System.Web.UI.Page
    {
        Service1Client client = new Service1Client();


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string idStr = Request.QueryString["id"];

                if (!string.IsNullOrEmpty(idStr))
                {
                    int pId = int.Parse(idStr);
                    LoadProductDetails(pId);
                }
                else
                {
                    Response.Redirect("products.aspx");
                }
            }
        }

        private void LoadProductDetails(int id)
        {
            var product = client.GetProduct(id);

            if (product != null)
            {
                imgProduct.ImageUrl = product.Image;
                lblName.Text = product.Name;
                lblPrice.Text = "R " + Math.Round(product.Price, 2);
                lblCategory.Text = product.Category;
                lblDescription.Text = product.Description;
                lblHeaderName.Text = product.Name;

                var reviews = client.GetProductReviews(id);

                if (reviews != null && reviews.Length > 0)
                {
                    rptReviews.DataSource = reviews;
                    rptReviews.DataBind();
                    rptReviews.Visible = true;
                    noReviewsMsg.Visible = false;

                    double avgRating = reviews.Average(r => r.Rating);
                    int roundedRating = (int)Math.Round(avgRating);

                    lblReviewCount.Text = reviews.Length.ToString();

                    string html = "";
                    for (int i = 1; i <= 5; i++)
                    {
                        if (i <= roundedRating)
                            html += "<li><i class='fa fa-star'></i></li>";
                        else
                            html += "<li><i class='fa fa-star' style='color:#ccc;'></i></li>";
                    }
                    litMainStars.Text = html;
                }
                else
                {
                    rptReviews.Visible = false;
                    noReviewsMsg.Visible = true;

                    lblReviewCount.Text = "0";
                    litMainStars.Text = "<li><i class='fa fa-star' style='color:#ccc;'></i></li><li><i class='fa fa-star' style='color:#ccc;'></i></li><li><i class='fa fa-star' style='color:#ccc;'></i></li><li><i class='fa fa-star' style='color:#ccc;'></i></li><li><i class='fa fa-star' style='color:#ccc;'></i></li>";
                }

                if (product.Stock > 0)
                {
                    lblAvailability.Text = "In Stock (" + product.Stock + " available)";
                    lblAvailability.ForeColor = System.Drawing.Color.Green;

                    btnAddToCart.Enabled = true;
                    btnAddToCart.Text = "Add to Cart";
                    txtQty.Attributes["max"] = product.Stock.ToString();
                }
                else
                {
                    lblAvailability.Text = "Out of Stock";
                    lblAvailability.ForeColor = System.Drawing.Color.Red;

                    btnAddToCart.Enabled = false;
                    btnAddToCart.Text = "Sold Out";
                    btnAddToCart.CssClass = "btn btn-secondary";
                    txtQty.Enabled = false;
                }
            }
        }

        public string GenerateStars(int rating)
        {
            string s = "";
            for (int i = 0; i < rating; i++) s += "★";
            for (int i = rating; i < 5; i++) s += "☆";
            return "<span style='color:#f39c12;'>" + s + "</span>";
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }

            int userId = Convert.ToInt32(Session["UserID"]);
            int prodId = int.Parse(Request.QueryString["id"]);
            int qty = int.Parse(txtQty.Text);

            bool success = client.AddToCart(userId, prodId, qty);

            if (success)
            {
                lblMessage.Text = "Item added to cart successfully!";
                lblMessage.CssClass = "alert alert-success btn-block";
                lblMessage.Visible = true;
            }
            else
            {
                lblMessage.Text = "Failed to add item. Try again.";
                lblMessage.CssClass = "alert alert-danger btn-block";
                lblMessage.Visible = true;
            }
        }

        protected void btnWishlist_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }

            int userId = Convert.ToInt32(Session["UserID"]);
            int prodId = int.Parse(Request.QueryString["id"]);

            bool success = client.AddToWishlist(userId, prodId);

            if (success)
            {
                lblMessage.Text = "Added to Wishlist!";
                lblMessage.CssClass = "alert alert-success btn-block";
            }
            else
            {
                lblMessage.Text = "Item already in Wishlist.";
                lblMessage.CssClass = "alert alert-warning btn-block";
            }
            lblMessage.Visible = true;
        }
    }
}