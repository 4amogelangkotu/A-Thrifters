<%@ Page Title="My Cart" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="cart.aspx.cs" Inherits="EThrift_Web.cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .cart-page { margin-top: 100px; margin-bottom: 50px; }
        .table img { width: 80px; border-radius: 5px; }
        .cart-summary {
            background-color: #f7f7f7;
            padding: 30px;
            border-radius: 5px;
        }
        .cart-summary h4 { margin-bottom: 20px; color: #1a6692; }
        .cart-summary .total-row {
            font-size: 20px;
            font-weight: bold;
            color: #007bff;
            border-top: 1px solid #ddd;
            padding-top: 15px;
            margin-top: 15px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="page-heading about-heading header-text" style="padding: 150px 0px 100px 0px;">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="text-content">
                        <h4>Your Shopping Bag</h4>
                        <h2>My Cart</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container cart-page">
        
        <asp:Label ID="lblMessage" runat="server" Visible="false" CssClass="alert alert-info btn-block"></asp:Label>

        <div id="cartContent" runat="server">
            <div class="row">
                <div class="col-md-8">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Product</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Total</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptCart" runat="server" OnItemCommand="rptCart_ItemCommand">
                                    <ItemTemplate>
                                        <tr>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <img src='<%# Eval("Image") %>' alt="img">
                                                    <div class="ml-3">
                                                        <h6 class="mb-0"><%# Eval("Name") %></h6>
                                                        <small class="text-muted"><%# Eval("Category") %></small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>R <%# Eval("Price", "{0:0.00}") %></td>
                                            <td>
                                                <span class="badge badge-light" style="font-size:14px; border:1px solid #ddd;"><%# Eval("Quantity") %></span>
                                            </td>
                                            <td>R <%# Convert.ToDouble(Eval("Price")) * Convert.ToInt32(Eval("Quantity")) %></td>
                                            <td>
                                                <asp:LinkButton ID="btnRemove" runat="server" CommandName="Remove" CommandArgument='<%# Eval("ProductId") %>' CssClass="text-danger">
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

                <div class="col-md-4">
                    <div class="cart-summary">
                        <h4>Order Summary</h4>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Subtotal</span>
                            <asp:Label ID="lblSubtotal" runat="server" Text="R 0.00"></asp:Label>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Shipping</span>
                            <span>Free</span>
                        </div>
                        <div class="d-flex justify-content-between total-row">
                            <span>Total</span>
                            <asp:Label ID="lblGrandTotal" runat="server" Text="R 0.00"></asp:Label>
                        </div>

                        <hr />
                        <a href="checkout.aspx" class="filled-button btn-block text-center">Proceed to Checkout</a>
                        <a href="products.aspx" class="btn btn-outline-secondary btn-block mt-2">Continue Shopping</a>
                    </div>
                </div>
            </div>
        </div>

        <div id="emptyCart" runat="server" visible="false" class="text-center py-5">
            <i class="fa fa-shopping-cart fa-4x text-muted mb-3"></i>
            <h3>Your cart is empty</h3>
            <p class="text-muted">Looks like you haven't added anything yet.</p>
            <a href="products.aspx" class="filled-button mt-3">Start Shopping</a>
        </div>

    </div>

</asp:Content>