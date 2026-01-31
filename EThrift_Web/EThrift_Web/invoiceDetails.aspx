<%@ Page Title="Invoice Details" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="invoiceDetails.aspx.cs" Inherits="EThrift_Web.invoiceDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .details-page { padding-top: 120px; padding-bottom: 50px; }
        .invoice-header { background: #f7f7f7; padding: 20px; border-radius: 5px; margin-bottom: 30px; }
        .invoice-header h4 { margin: 0; color: #1a6692; }
        .invoice-header span { float: right; font-weight: bold; color: #007bff; }
        .item-row img { width: 60px; border-radius: 5px; margin-right: 15px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="container details-page">
        
        <div class="invoice-header">
            <h4>
                Invoice #<asp:Label ID="lblInvoiceId" runat="server"></asp:Label>
            </h4>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Item</th>
                                <th>Price (Sold At)</th>
                                <th>Quantity</th>
                                <th>Subtotal</th>
                                <th>Action</th> </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptItems" runat="server">
                                <ItemTemplate>
                                    <tr class="item-row">
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <img src='<%# Eval("Image") %>' alt="img">
                                                <span><%# Eval("Name") %></span>
                                            </div>
                                        </td>
                                        <td>R <%# Eval("Price", "{0:0.00}") %></td>
                                        <td>x <%# Eval("Quantity") %></td>
                                        <td>R <%# Convert.ToDouble(Eval("Price")) * Convert.ToInt32(Eval("Quantity")) %></td>
                                        
                                        <td>
                                            <a href='reviews.aspx?id=<%# Eval("ProductId") %>' class="btn btn-sm btn-outline-primary">
                                                <i class="fa fa-star"></i> Review Item
                                            </a>
                                        </td>

                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="row mt-4">
            <div class="col-md-6">
                <a href="invoices.aspx" class="btn btn-outline-secondary">← Back to History</a>
            </div>
            <div class="col-md-6 text-right">
                <span id="lblDate" runat="server" style="font-size:16px; color:#666; display:block; margin-bottom:5px;"></span>
                <h4>Total Paid: <asp:Label ID="lblTotal" runat="server" CssClass="text-primary"></asp:Label></h4>
            </div>
        </div>

    </div>
</asp:Content>