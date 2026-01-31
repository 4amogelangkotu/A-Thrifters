<%@ Page Title="Product Details" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="aboutProduct.aspx.cs" Inherits="EThrift_Web.aboutProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .product-details { margin-top: 100px; margin-bottom: 50px; }
        .product-image img { width: 100%; border: 1px solid #eee; }
        .product-info h4 { font-size: 24px; color: #1a6692; margin-bottom: 10px; }
        .product-info h6 { font-size: 20px; color: #007bff; margin-bottom: 20px; }
        .product-info p { margin-bottom: 30px; }
        .qty-input { width: 60px; display: inline-block; margin-right: 10px; }
        
        ul.stars {
            padding: 0;
            margin: 0;
            list-style: none;
            display: inline-block;
        }
        ul.stars li {
            display: inline-block;
            font-size: 14px;
            color: #f39c12;
            margin-right: 2px;
        }

        .review-item { border-bottom: 1px solid #eee; padding: 15px 0; }
        .review-item .author { font-weight: bold; color: #1a6692; }
        .review-item .date { font-size: 12px; color: #aaa; float: right; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="page-heading products-heading header-text">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="text-content">
                        <h4>explore</h4>
                        <h2><asp:Label ID="lblHeaderName" runat="server"></asp:Label></h2>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container product-details">
        <div class="row">
            <div class="col-md-12">
                <asp:Label ID="lblMessage" runat="server" Visible="false" CssClass="alert alert-info btn-block"></asp:Label>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6">
                <div class="product-image">
                    <asp:Image ID="imgProduct" runat="server" ImageUrl="assets/images/product_01.jpg" />
                </div>
            </div>

            <div class="col-md-6">
                <div class="product-info">
                    <asp:Label ID="lblName" runat="server" Text="Product Name" TagName="h4"></asp:Label>
                    
                    <asp:Label ID="lblPrice" runat="server" Text="$0.00" TagName="h6"></asp:Label>
                    
                    <div style="margin-bottom: 20px;">
                        <ul class="stars">
                            <asp:Literal ID="litMainStars" runat="server"></asp:Literal>
                        </ul>
                        <small class="text-muted">(<asp:Label ID="lblReviewCount" runat="server" Text="0"></asp:Label> Reviews)</small>
                    </div>
                    <p>
                        Availability: <asp:Label ID="lblAvailability" runat="server" style="font-weight:bold;"></asp:Label>
                    </p>
                    <p>
                        <strong>Category:</strong> <asp:Label ID="lblCategory" runat="server"></asp:Label><br />
                        <asp:Label ID="lblDescription" runat="server" Text="Description goes here."></asp:Label>
                    </p>
                    
                    <hr />

                    <div class="form-inline">
                        <label style="margin-right: 10px;">Quantity:</label>
                        <asp:TextBox ID="txtQty" runat="server" TextMode="Number" Text="1" CssClass="form-control qty-input" min="1" max="10"></asp:TextBox>
                        
                        <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart" CssClass="filled-button" OnClick="btnAddToCart_Click" />
                        
                        <asp:Button ID="btnWishlist" runat="server" Text="♥" CssClass="btn btn-outline-secondary ml-2" OnClick="btnWishlist_Click" ToolTip="Add to Wishlist" />
                    </div>
                </div>
            </div>
        </div>

        <div class="row" style="margin-top: 60px;">
            <div class="col-md-12">
                <div class="section-heading" style="border-bottom: 1px solid #eee; padding-bottom: 20px; margin-bottom: 20px;">
                    <div class="d-flex justify-content-between align-items-center">
                        <h2>Customer Reviews</h2>
                        <a href='reviews.aspx?id=<%= Request.QueryString["id"] %>' class="filled-button">
                            Write / Read Reviews
                        </a>
                    </div>
                </div>
            </div>

            <div class="col-md-12">
                <div id="noReviewsMsg" runat="server" visible="false" class="alert alert-light">
                    No reviews yet. Click the button above to write the first one!
                </div>

                <asp:Repeater ID="rptReviews" runat="server">
                    <ItemTemplate>
                        <div class="review-item">
                            <span class="author"><i class="fa fa-user"></i> <%# Eval("UserName") %></span>
                            <span class="date">
                                <%# GenerateStars(Convert.ToInt32(Eval("Rating"))) %>
                            </span>
                            <p style="margin-top: 5px;"><%# Eval("Comment") %></p>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>

</asp:Content>