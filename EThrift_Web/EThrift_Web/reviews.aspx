<%@ Page Title="Product Reviews" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="reviews.aspx.cs" Inherits="EThrift_Web.reviews" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .reviews-page { padding-top: 120px; padding-bottom: 50px; }
        .product-preview { background: #f1f1f1; padding: 15px; border-radius: 5px; margin-bottom: 30px; display: flex; align-items: center; }
        .product-preview img { width: 60px; height: 60px; object-fit: cover; margin-right: 15px; border-radius: 5px; }
        
        .review-box { background: #fff; border: 1px solid #eee; padding: 20px; margin-bottom: 15px; border-radius: 5px; }
        .review-user { font-weight: bold; color: #1a6692; }
        .review-stars { color: #f39c12; letter-spacing: 2px; }
        
        .form-area { background: #f9f9f9; padding: 20px; border-radius: 5px; margin-bottom: 40px; border: 1px dashed #ccc; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container reviews-page">
        
        <div class="product-preview">
            <asp:Image ID="imgProduct" runat="server" />
            <div>
                <h4 style="margin:0;"><asp:Label ID="lblProductName" runat="server"></asp:Label></h4>
                <a href="#" id="linkBack" runat="server" class="text-muted"><small>← Back to Product</small></a>
            </div>
        </div>

        <div class="row">

            <div class="col-md-4">
                <div class="form-area">
                    <h5>Write a Review</h5>
                    <hr />

                    <asp:Panel ID="pnlReviewForm" runat="server">
                        <asp:Label ID="lblMessage" runat="server" Visible="false" CssClass="d-block mb-2"></asp:Label>

                        <div class="form-group">
                            <label>Rating</label>
                            <asp:DropDownList ID="dlRating" runat="server" CssClass="form-control">
                                <asp:ListItem Value="5">⭐⭐⭐⭐⭐ (Excellent)</asp:ListItem>
                                <asp:ListItem Value="4">⭐⭐⭐⭐ (Good)</asp:ListItem>
                                <asp:ListItem Value="3">⭐⭐⭐ (Average)</asp:ListItem>
                                <asp:ListItem Value="2">⭐⭐ (Poor)</asp:ListItem>
                                <asp:ListItem Value="1">⭐ (Terrible)</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="form-group">
                            <label>Comment</label>
                            <asp:TextBox ID="txtComment" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control" placeholder="Share your experience..."></asp:TextBox>
                        </div>

                        <asp:Button ID="btnSubmit" runat="server" Text="Post Review" CssClass="filled-button btn-block" OnClick="btnSubmit_Click" />
                    </asp:Panel>

                    <div id="pnlRestricted" runat="server" visible="false" class="text-center text-muted" style="padding: 20px 0;">
                        <i class="fa fa-lock fa-2x mb-3"></i>
                        <p>You must purchase this item to write a review.</p>
                        <a href="products.aspx" class="btn btn-sm btn-outline-secondary">Go Shopping</a>
                    </div>
                </div>
            </div>

            <div class="col-md-8">
                <h4 class="mb-3">Customer Reviews</h4>
                
                <div id="reviewsList" runat="server">
                    <asp:Repeater ID="rptReviews" runat="server">
                        <ItemTemplate>
                            <div class="review-box">
                                <div class="d-flex justify-content-between">
                                    <span class="review-user"><i class="fa fa-user-circle"></i> <%# Eval("UserName") %></span>
                                    <span class="review-stars">
                                        <%# GetStars(Convert.ToInt32(Eval("Rating"))) %>
                                    </span>
                                </div>
                                <hr style="margin: 10px 0;" />
                                <p class="mb-0"><%# Eval("Comment") %></p>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <div id="noReviews" runat="server" visible="false" class="alert alert-info">
                    No reviews yet. Be the first to write one!
                </div>
            </div>

        </div> </div> </asp:Content>