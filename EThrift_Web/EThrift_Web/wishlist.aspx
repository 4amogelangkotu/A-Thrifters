<%@ Page Title="My Wishlist" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wishlist.aspx.cs" Inherits="EThrift_Web.wishlist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .wishlist-page { padding-top: 120px; padding-bottom: 50px; }
        .table img { width: 80px; border-radius: 5px; }
        .empty-wishlist { text-align: center; padding: 50px; color: #aaa; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="page-heading about-heading header-text">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="text-content">
                        <h4>Saved Items</h4>
                        <h2>My Wishlist</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container wishlist-page">
        
        <asp:Label ID="lblMessage" runat="server" Visible="false" CssClass="alert alert-success btn-block"></asp:Label>

        <div id="wishlistContent" runat="server">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Product</th>
                            <th>Price</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptWishlist" runat="server" OnItemCommand="rptWishlist_ItemCommand">
                            <ItemTemplate>
                                <tr>
                                    <td style="vertical-align: middle;">
                                        <div class="d-flex align-items-center">
                                            <a href='aboutProduct.aspx?id=<%# Eval("ProductId") %>'>
                                                <img src='<%# Eval("Image") %>' alt="img">
                                            </a>
                                            <div class="ml-3">
                                                <h5 class="mb-0"><%# Eval("Name") %></h5>
                                                <small class="text-muted"><%# Eval("Category") %></small>
                                            </div>
                                        </div>
                                    </td>
                                    <td style="vertical-align: middle; font-weight: bold; color: #007bff;">
                                        <%# Eval("Price", "{0:C}") %>
                                    </td>
                                    <td style="vertical-align: middle;">
                                        
                                        <asp:LinkButton ID="btnAddToCart" runat="server" CommandName="AddToCart" CommandArgument='<%# Eval("ProductId") %>' CssClass="btn btn-sm btn-success">
                                            <i class="fa fa-shopping-cart"></i> Add to Cart
                                        </asp:LinkButton>

                                        <asp:LinkButton ID="btnRemove" runat="server" CommandName="Remove" CommandArgument='<%# Eval("ProductId") %>' CssClass="btn btn-sm btn-danger ml-2" ToolTip="Remove">
                                            <i class="fa fa-trash"></i>
                                        </asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
        </div>

        <div id="emptyWishlist" runat="server" visible="false" class="empty-wishlist">
            <i class="fa fa-heart-o fa-4x mb-3"></i>
            <h3>Your wishlist is empty</h3>
            <p>Save items you love here for later.</p>
            <a href="products.aspx" class="filled-button mt-3">Browse Products</a>
        </div>

    </div>

</asp:Content>