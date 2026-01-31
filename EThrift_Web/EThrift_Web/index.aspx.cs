using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EThrift_Web.ServiceReference1;

namespace EThrift_Web
{
    public partial class index : System.Web.UI.Page
    {
        Service1Client client = new Service1Client();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dynamicPopulate();
            }
        }

        private void dynamicPopulate()
        {
            try
            {
                var allProducts = client.GetAllProducts();

                var latestProducts = allProducts.Take(6).ToList();

                rptLatestProducts.DataSource = latestProducts;
                rptLatestProducts.DataBind();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error fetching products: " + ex.Message);

                lblError.Text = "Error: " + ex.Message;
                lblError.Visible = true;
            }

            
        }
        protected string GetStarRatingHtml(object productIdObj)
        {
            try
            {
                int productId = Convert.ToInt32(productIdObj);

                var reviews = client.GetProductReviews(productId);

                double averageRating = 0;

                if (reviews != null && reviews.Length > 0)
                {
                    averageRating = reviews.Average(r => r.Rating);
                }

                int roundedRating = (int)Math.Round(averageRating);

                string html = "";

                for (int i = 1; i <= 5; i++)
                {
                    if (i <= roundedRating)
                    {
                        html += "<li><i class='fa fa-star'></i></li>";
                    }
                    else
                    {
                        html += "<li><i class='fa fa-star' style='color:#ccc;'></i></li>";
                    }
                }

                return html;
            }
            catch
            {
                return "<li><i class='fa fa-star' style='color:#ccc;'></i></li><li><i class='fa fa-star' style='color:#ccc;'></i></li><li><i class='fa fa-star' style='color:#ccc;'></i></li><li><i class='fa fa-star' style='color:#ccc;'></i></li><li><i class='fa fa-star' style='color:#ccc;'></i></li>";
            }
        }
    }
}