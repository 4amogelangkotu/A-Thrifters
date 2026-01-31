<%@ Page Title="Add New Manager" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="addManager.aspx.cs" Inherits="EThrift_Web.addManager" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .admin-page { padding-top: 120px; padding-bottom: 80px; }
        .form-box { 
            background: #fff; 
            padding: 40px; 
            border-radius: 5px; 
            box-shadow: 0px 0px 15px rgba(0,0,0,0.1); 
            max-width: 500px; 
            margin: 0 auto; 
        }
        .form-box h4 { color: #1a6692; margin-bottom: 25px; text-align: center; }
        .form-control { margin-bottom: 15px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container admin-page">
        <div class="row">
            <div class="col-md-12">
                
                <div class="form-box">
                    <h4><i class="fa fa-user-plus"></i> Add New Manager</h4>
                    
                    <asp:Label ID="lblMessage" runat="server" Visible="false" CssClass="alert alert-danger btn-block mb-3"></asp:Label>

                    <div class="form-group">
                        <label>Email Address</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" TextMode="Email" placeholder="admin@athrifters.com" required=""></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label>Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Set Password" required=""></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label>Confirm Password</label>
                        <asp:TextBox ID="txtConfirmPass" runat="server" CssClass="form-control" TextMode="Password" placeholder="Repeat Password" required=""></asp:TextBox>
                    </div>

                    <hr />

                    <asp:Button ID="btnRegister" runat="server" Text="Create Manager Account" CssClass="filled-button btn-block" OnClick="btnRegister_Click" />
                    
                    <div class="text-center mt-3">
                        <a href="manage.aspx" class="text-muted"><small>← Back to Dashboard</small></a>
                    </div>

                </div>

            </div>
        </div>
    </div>

</asp:Content>