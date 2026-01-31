using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EThrift_Web.ServiceReference1;

namespace EThrift_Web
{
    public partial class reviews : System.Web.UI.Page
    {
        Service1Client client = new Service1Client();
        int prodId = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] != null)
            {
                prodId = int.Parse(Request.QueryString["id"]);
            }
            else
            {
                Response.Redirect("products.aspx");
            }

            if (!IsPostBack)
            {
                LoadProductInfo();
                LoadReviews();
                CheckPurchaseStatus();
            }
        }

        private void LoadProductInfo()
        {
            var p = client.GetProduct(prodId);
            if (p != null)
            {
                lblProductName.Text = p.Name;
                imgProduct.ImageUrl = p.Image;
                linkBack.HRef = "aboutProduct.aspx?id=" + prodId;
            }
        }

        private void LoadReviews()
        {
            var list = client.GetProductReviews(prodId);

            if (list != null && list.Count() > 0)
            {
                rptReviews.DataSource = list;
                rptReviews.DataBind();
                reviewsList.Visible = true;
                noReviews.Visible = false;
            }
            else
            {
                reviewsList.Visible = false;
                noReviews.Visible = true;
            }
        }

        private void CheckPurchaseStatus()
        {
            if (Session["UserID"] == null)
            {
                pnlReviewForm.Visible = false;
                pnlRestricted.Visible = true;
                pnlRestricted.InnerHtml = "<p>Please <a href='login.aspx'>login</a> to write a review.</p>";
                return;
            }

            int userId = Convert.ToInt32(Session["UserID"]);

            bool bought = client.HasUserPurchasedItem(userId, prodId);

            if (bought)
            {
                pnlReviewForm.Visible = true;
                pnlRestricted.Visible = false;
            }
            else
            {
                pnlReviewForm.Visible = false;
                pnlRestricted.Visible = true;
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }

            int userId = Convert.ToInt32(Session["UserID"]);
            int rating = int.Parse(dlRating.SelectedValue);
            string comment = txtComment.Text;

            bool success = client.AddReview(userId, prodId, rating, comment);

            if (success)
            {
                lblMessage.Text = "Review posted!";
                lblMessage.CssClass = "text-success";
                lblMessage.Visible = true;
                txtComment.Text = "";
                LoadReviews();
            }
            else
            {
                lblMessage.Text = "Error posting review.";
                lblMessage.CssClass = "text-danger";
                lblMessage.Visible = true;
            }
        }

        public string GetStars(int rating)
        {
            string stars = "";
            for (int i = 0; i < rating; i++) stars += "★";
            for (int i = rating; i < 5; i++) stars += "☆";
            return stars;
        }
    }
}