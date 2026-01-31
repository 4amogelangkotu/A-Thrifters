<%@ Page Title="My Order History" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="invoices.aspx.cs" Inherits="EThrift_Web.invoices" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .invoice-page { margin-top: 100px; margin-bottom: 50px; }
        .invoice-table th { background-color: #f7f7f7; color: #1a6692; border-top: none; }
        
        /* --- UPDATED BADGE STYLES --- */
        .badge-success { background-color: #28a745; padding: 8px; color: white; border-radius: 4px; }
        .badge-warning { background-color: #ffc107; padding: 8px; color: black; border-radius: 4px; }
        .badge-info    { background-color: #17a2b8; padding: 8px; color: white; border-radius: 4px; }
        .badge-danger  { background-color: #dc3545; padding: 8px; color: white; border-radius: 4px; }
        .badge-secondary { background-color: #6c757d; padding: 8px; color: white; border-radius: 4px; }
        
        .empty-history { text-align: center; padding: 50px; color: #aaa; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="page-heading about-heading header-text" style="padding: 150px 0px 100px 0px;">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="text-content">
                        <h4>Your Purchase History</h4>
                        <h2>My Invoices</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container invoice-page">
        <div class="row">
            <div class="col-md-12">
                
                <div id="historyContent" runat="server">
                    <div class="table-responsive">
                        <table class="table table-hover invoice-table">
                            <thead>
                                <tr>
                                    <th>Invoice ID</th>
                                    <th>Date Placed</th>
                                    <th>Total Amount</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptInvoices" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td>#<%# Eval("InvoiceId") %></td>
                                            <td><%# Eval("DatePlaced", "{0:dd MMM yyyy HH:mm}") %></td>
                                            <td style="font-weight:bold; color:#007bff;">R <%# Eval("TotalAmount", "{0:0.00}") %></td>
                                            
                                            <td>
                                                <%# GetStatusHtml(Eval("Status")) %>
                                            </td>
                                            
                                            <td>
                                                <a href='invoiceDetails.aspx?id=<%# Eval("InvoiceId") %>' class="btn btn-sm btn-outline-primary">View Items</a>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div id="emptyHistory" runat="server" visible="false" class="empty-history">
                    <i class="fa fa-history fa-4x mb-3"></i>
                    <h3>No orders yet</h3>
                    <p>Once you checkout, your invoices will appear here.</p>
                    <a href="products.aspx" class="filled-button mt-3">Start Shopping</a>
                </div>

            </div>
        </div>
    </div>

</asp:Content>