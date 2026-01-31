using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EThrift_Web.ServiceReference1;
using System.IO;

namespace EThrift_Web
{
    public partial class manageProducts : System.Web.UI.Page
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
                LoadProducts();
            }
        }

        private void LoadProducts()
        {
            gvProducts.DataSource = client.GetAllProducts();
            gvProducts.DataBind();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                string name = txtName.Text;
                string desc = txtDescription.Text;
                string cat = dlCategory.SelectedValue;
                bool isActive = chkActive.Checked;

                string priceInput = txtPrice.Text.Replace("R", "").Replace(" ", "").Replace(",", ".").Trim();

                decimal price = 0;
                if (!decimal.TryParse(priceInput, System.Globalization.NumberStyles.Any, System.Globalization.CultureInfo.InvariantCulture, out price))
                {
                    lblMessage.Text = "Error: Invalid Price format. Please enter a valid number (e.g., 150.00).";
                    lblMessage.CssClass = "text-danger d-block";
                    lblMessage.Visible = true;
                    return;
                }

                int stock = 0;
                if (!int.TryParse(txtStock.Text, out stock))
                {
                    lblMessage.Text = "Error: Invalid Stock Quantity. Please enter a whole number.";
                    lblMessage.CssClass = "text-danger d-block";
                    lblMessage.Visible = true;
                    return;
                }

                string imagePath = hfCurrentImage.Value;

                if (fuImage.HasFile)
                {
                    string filename = Path.GetFileName(fuImage.FileName);
                    string uniqueName = DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + filename;
                    string folderPath = Server.MapPath("~/assets/images/");

                    if (!Directory.Exists(folderPath))
                    {
                        Directory.CreateDirectory(folderPath);
                    }

                    string savePath = Path.Combine(folderPath, uniqueName);
                    fuImage.SaveAs(savePath);

                    imagePath = "assets/images/" + uniqueName;
                }

                if (string.IsNullOrEmpty(imagePath))
                {
                    imagePath = "assets/images/product_01.jpg";
                }

                bool success = false;

                if (string.IsNullOrEmpty(hfProductId.Value))
                {
                    success = client.AddProduct(name, desc, price, cat, imagePath, isActive, stock);
                }
                else
                {
                    int id = int.Parse(hfProductId.Value);
                    success = client.UpdateProduct(id, name, desc, price, cat, imagePath, isActive, stock);
                }

                if (success)
                {
                    LoadProducts();
                    ClearForm();
                    lblMessage.Text = "Saved successfully!";
                    lblMessage.CssClass = "text-success d-block";
                    lblMessage.Visible = true;
                }
                else
                {
                    lblMessage.Text = "Error saving product. Database did not accept the change.";
                    lblMessage.CssClass = "text-danger d-block";
                    lblMessage.Visible = true;
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
                lblMessage.CssClass = "text-danger d-block";
                lblMessage.Visible = true;
            }
        }
        protected void gvProducts_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "EditProd")
            {
                var p = client.GetProduct(id);
                if (p != null)
                {
                    hfProductId.Value = p.ProductId.ToString();
                    txtName.Text = p.Name;
                    txtDescription.Text = p.Description;
                    txtPrice.Text = Math.Round(p.Price, 2).ToString();
                    txtStock.Text = p.Stock.ToString();
                    dlCategory.SelectedValue = p.Category;

                    hfCurrentImage.Value = p.Image;
                    lblCurrentImage.Text = p.Image;

                    chkActive.Checked = p.IsActive; 

                    btnSave.Text = "Update Product";
                    lblMessage.Visible = false;
                }
            }
            else if (e.CommandName == "DeleteProd")
            {
                bool deleted = client.DeleteProduct(id);
                if (deleted)
                {
                    LoadProducts();
                    ClearForm();
                }
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        private void ClearForm()
        {
            hfProductId.Value = "";
            txtName.Text = "";
            txtDescription.Text = "";
            txtPrice.Text = "";

            hfCurrentImage.Value = "";
            lblCurrentImage.Text = "None";

            dlCategory.SelectedIndex = 0;
            chkActive.Checked = true;
            btnSave.Text = "Save Product";
            lblMessage.Visible = false;
        }
    }
}