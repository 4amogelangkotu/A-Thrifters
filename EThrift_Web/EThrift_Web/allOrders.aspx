<%@ Page Title="All Orders" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="allOrders.aspx.cs" Inherits="EThrift_Web.allOrders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .orders-page { padding-top: 120px; padding-bottom: 50px; }
        .table thead th { border-top: none; background: #f8f9fa; color: #1a6692; }
        .badge-paid { background: #d4edda; color: #155724; padding: 5px 10px; border-radius: 20px; font-size: 0.85em; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container orders-page">
        <div class="row mb-4">
            <div class="col-md-12">
                <h2><i class="fa fa-list-alt"></i> All Customer Orders</h2>
                <p class="text-muted">Manage and view all incoming orders.</p>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Customer Name</th>
                                <th>Date Placed</th>
                                <th>Total</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptOrders" runat="server" OnItemCommand="rptOrders_ItemCommand">
    <ItemTemplate>
        <tr>
            <td>#<%# Eval("InvoiceId") %></td>
            
            <td style="font-weight: bold;"><%# Eval("CustomerName") %></td>
            
            <td><%# Eval("DatePlaced", "{0:dd MMM yyyy HH:mm}") %></td>
            <td>R <%# Eval("TotalAmount", "{0:N2}") %></td>
            
            <td>
                <div class="d-flex align-items-center">
                    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control form-control-sm mr-2" 
                        SelectedValue='<%# Eval("Status") %>' Width="110px">
                        <asp:ListItem Value="Paid">Paid</asp:ListItem>
                        <asp:ListItem Value="Shipped">Shipped</asp:ListItem>
                        <asp:ListItem Value="Delivered">Delivered</asp:ListItem>
                        <asp:ListItem Value="Cancelled">Cancelled</asp:ListItem>
                    </asp:DropDownList>

                    <asp:LinkButton ID="btnUpdate" runat="server" CommandName="UpdateStatus" 
                        CommandArgument='<%# Eval("InvoiceId") %>' CssClass="btn btn-sm btn-success"
                        ToolTip="Update Status">
                        <i class="fa fa-check"></i>
                    </asp:LinkButton>
                </div>
            </td>
            
            <td>
                <a href='invoiceDetails.aspx?id=<%# Eval("InvoiceId") %>' class="btn btn-sm btn-outline-primary">
                    View Items
                </a>
            </td>
        </tr>
    </ItemTemplate>
</asp:Repeater>
                        </tbody>
                    </table>
                </div>

                <div id="noOrders" runat="server" visible="false" class="alert alert-info text-center">
                    No orders have been placed yet.
                </div>

            </div>
        </div>
    </div>

</asp:Content>