<%@ Page Title="Checkout" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="checkout.aspx.cs" Inherits="EThrift_Web.checkout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .checkout-page { margin-top: 100px; margin-bottom: 50px; }
        .checkout-form { background: #fff; padding: 30px; border: 1px solid #eee; border-radius: 5px; }
        .order-summary { background-color: #f7f7f7; padding: 30px; border-radius: 5px; }
        .order-summary h4 { color: #1a6692; margin-bottom: 20px; }
        .order-summary .total-row {
            font-size: 20px; font-weight: bold; color: #007bff; border-top: 1px solid #ddd; padding-top: 15px; margin-top: 15px;
        }
        .form-section-title { font-size: 18px; color: #1a6692; margin-bottom: 15px; border-bottom: 2px solid #007bff; display: inline-block; padding-bottom: 5px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="page-heading about-heading header-text" style="padding: 150px 0px 100px 0px;">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="text-content">
                        <h4>Almost There</h4>
                        <h2>Checkout</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container checkout-page">
        <div class="row">
            
            <div class="col-md-8">
                <div class="checkout-form">
                    
                    <h5 class="form-section-title">Shipping Details</h5>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label>First Name</label>
                            <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" required=""></asp:TextBox>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label>Last Name</label>
                            <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" required=""></asp:TextBox>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label>Address</label>
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="1234 Main St" required=""></asp:TextBox>
                    </div>
                    <div class="row">
                        <div class="col-md-5 mb-3">
                            <label>City</label>
                            <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" required=""></asp:TextBox>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label>Province</label>
                            <asp:DropDownList ID="dlProvince" runat="server" CssClass="form-control">
                                <asp:ListItem>Gauteng</asp:ListItem>
                                <asp:ListItem>North West</asp:ListItem>
                                <asp:ListItem>Limpopo</asp:ListItem>
                                <asp:ListItem>Eastern Cape</asp:ListItem>
                                <asp:ListItem>Northern Cape</asp:ListItem>
                                <asp:ListItem>Western Cape</asp:ListItem>
                                <asp:ListItem>KZN</asp:ListItem>
                                <asp:ListItem>Mpumalanga</asp:ListItem>
                                <asp:ListItem>Free State</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label>Zip</label>
                            <asp:TextBox ID="txtZip" runat="server" CssClass="form-control" required=""></asp:TextBox>
                        </div>
                    </div>

                    <hr class="mb-4">

                    <h5 class="form-section-title">Payment Information</h5>

                    <div class="alert alert-warning" role="alert" style="border-left: 5px solid #ffc107; background-color: #fff3cd; color: #856404;">
                        <h6 style="font-weight:bold;"><i class="fa fa-exclamation-triangle"></i> DEMO MODE ONLY</h6>
                        <p style="margin-bottom:0; font-size: 14px;">
                            This is for demonstration purposes only. 
                            <strong>No real money will be charged.</strong>
                            <br />
                            Please <u style="color:red;">DO NOT</u> enter real bank card details. 
                            You can use random numbers (e.g., 4242 4242 4242 4242) to test the checkout.
                        </p>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label>Name on Card</label>
                            <input type="text" class="form-control" required="">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label>Card Number</label>
                            <input type="text" class="form-control" placeholder="4242 4242 4242 4242" required="">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3 mb-3">
                            <label>Expiration</label>
                            <input type="text" class="form-control" placeholder="MM/YY" required="">
                        </div>
                        <div class="col-md-3 mb-3">
                            <label>CVV</label>
                            <input type="text" class="form-control" placeholder="123" required="">
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="order-summary">
                    <h4>Order Summary</h4>
                    
                    <div class="d-flex justify-content-between mb-2">
                        <span>Cart Subtotal</span>
                        <asp:Label ID="lblSubtotal" runat="server" Text="R 0.00"></asp:Label>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span>VAT (15%)</span>
                        <asp:Label ID="lblVat" runat="server" Text="R 0.00"></asp:Label>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span>Shipping</span>
                        <span class="text-success">Free</span>
                    </div>
                    <div class="d-flex justify-content-between total-row">
                        <span>Total Pay</span>
                        <asp:Label ID="lblTotal" runat="server" Text="R 0.00"></asp:Label>
                    </div>

                    <hr class="mb-4">
                    <asp:Button ID="btnPlaceOrder" runat="server" Text="Confirm & Pay" CssClass="filled-button btn-block" OnClick="btnPlaceOrder_Click" />
                    
                    <div class="mt-3">
                        <asp:Label ID="lblError" runat="server" CssClass="text-danger" Visible="false"></asp:Label>
                    </div>
                </div>
            </div>
            
        </div>
    </div>

</asp:Content>