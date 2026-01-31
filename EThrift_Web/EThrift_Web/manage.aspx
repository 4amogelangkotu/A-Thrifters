<%@ Page Title="Manager Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="manage.aspx.cs" Inherits="EThrift_Web.manage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .dashboard-page { padding-top: 120px; padding-bottom: 50px; }
        
        .stat-card {
            background: #fff;
            border-radius: 8px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            border-left: 5px solid #007bff;
            margin-bottom: 30px;
            transition: transform 0.3s;
        }
        .stat-card:hover { transform: translateY(-5px); }
        
        .stat-card .icon { font-size: 40px; color: #e0e0e0; float: right; }
        .stat-card h3 { font-size: 28px; font-weight: 700; color: #1a6692; margin: 0; }
        .stat-card p { font-size: 14px; color: #888; margin: 5px 0 0 0; text-transform: uppercase; font-weight: 600; }

        .manage-actions .btn { margin-right: 15px; margin-bottom: 15px; padding: 15px 25px; font-size: 16px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container dashboard-page">
        
        <div class="row mb-4">
            <div class="col-md-12">
                <h2><i class="fa fa-tachometer-alt"></i> Dashboard Overview</h2>
                <p class="text-muted">Welcome back, Manager.</p>
            </div>
        </div>

        <div class="row">
            <div class="col-md-3">
                <div class="stat-card" style="border-left-color: #28a745;">
                    <i class="fa fa-money-bill-wave icon"></i>
                    <h3 id="hRevenue" runat="server">R 0.00</h3>
                    <p>Total Revenue</p>
                </div>
            </div>

            <div class="col-md-3">
                <div class="stat-card" style="border-left-color: #007bff;">
                    <i class="fa fa-shopping-bag icon"></i>
                    <h3 id="hOrders" runat="server">0</h3>
                    <p>Total Orders</p>
                </div>
            </div>

            <div class="col-md-3">
                <div class="stat-card" style="border-left-color: #17a2b8;">
                    <i class="fa fa-users icon"></i>
                    <h3 id="hUsers" runat="server">0</h3>
                    <p>Customers</p>
                </div>
            </div>

            <div class="col-md-3">
                <div class="stat-card" style="border-left-color: #ffc107;">
                    <i class="fa fa-tshirt icon"></i>
                    <h3 id="hProducts" runat="server">0</h3>
                    <p>Active Products</p>
                </div>
            </div>
        </div>

        <hr class="my-5" />

        <div class="row">
            <div class="col-md-12">
                <h4 class="mb-4">Management Tools</h4>
                <div class="manage-actions">
                    <a href="manageProducts.aspx" class="btn btn-primary filled-button">
                        <i class="fa fa-edit"></i> Manage Products
                    </a>
                    
                    <a href="allOrders.aspx" class="btn btn-outline-primary">
                        <i class="fa fa-list"></i> View All Orders
                    </a>
                    
                    <a href="addManager.aspx" class="btn btn-outline-secondary">
                        <i class="fa fa-user-plus"></i> Add New Manager
                    </a>
                </div>
            </div>
        </div>

    </div>

</asp:Content>