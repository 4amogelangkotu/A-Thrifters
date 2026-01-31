using System;
using System.Linq;
using System.Web.UI;
using EThrift_Web.ServiceReference1;

namespace EThrift_Web
{
    public partial class products : System.Web.UI.Page
    {
        Service1Client client = new Service1Client();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string cat = Request.QueryString["cat"];
                if (!string.IsNullOrEmpty(cat))
                {
                    LoadProducts(cat);
                }
                else
                {
                    LoadProducts();
                }
            }
        }

        private void LoadProducts(string search = "")
        {
            try
            {
                dynamic productList;

                if (string.IsNullOrEmpty(search))
                {
                    productList = client.GetAllProducts();
                }
                else
                {
                    productList = client.SearchProducts(search);
                }

                var listArray = (dynamic[])productList;

                if (listArray != null && listArray.Length > 0)
                {
                    rptProducts.DataSource = productList;
                    rptProducts.DataBind();
                    lblNoResults.Visible = false;
                }
                else
                {
                    rptProducts.DataSource = null;
                    rptProducts.DataBind();
                    lblNoResults.Visible = true;
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Error: " + ex.Message;
                lblError.Visible = true;
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string query = txtSearch.Text.Trim();
            LoadProducts(query);
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            LoadProducts();
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