<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="EThrift_Web.register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .auth-wrapper {
            background-color: #f7f7f7;
            min-height: 80vh;
            padding-top: 150px;
            padding-bottom: 50px;
        }
        .auth-card {
            background: #fff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0px 0px 20px rgba(0,0,0,0.1);
            max-width: 500px;
            margin: 0 auto;
        }
        .auth-header h4 {
            color: #1a6692;
            font-weight: 700;
            margin-bottom: 10px;
            text-transform: uppercase;
        }
        .form-control {
            border-radius: 5px;
            height: 50px;
            margin-bottom: 15px;
        }
        .btn-auth {
            background-color: #007bff; 
            color: white;
            font-weight: 600;
            border-radius: 5px;
            padding: 12px;
            transition: 0.3s;
        }
        .btn-auth:hover {
            background-color: #0056b3;
            color: white;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="auth-wrapper">
        <div class="container">
            <div class="auth-card">
                
                <div class="auth-header text-center">
                    <h4>Create Account</h4>
                    <p style="color:#aaa; font-size:14px; margin-bottom:30px;">Join A-Thrifters today!</p>
                </div>

                <asp:Label ID="lblMessage" runat="server" CssClass="alert alert-danger btn-block text-center" Visible="false"></asp:Label>

                <div class="form-group">
                    <label>Email Address</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="name@example.com" required=""></asp:TextBox>
                </div>

                <div class="form-row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Password</label>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" required=""></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Confirm</label>
                            <asp:TextBox ID="txtConfirm" runat="server" CssClass="form-control" TextMode="Password" required=""></asp:TextBox>
                        </div>
                    </div>
                </div>

                <div class="form-group" id="divUserType" runat="server" visible="false">
                    <label class="text-danger font-weight-bold">Account Type (Manager Access)</label>
                    <asp:DropDownList ID="dlUserType" runat="server" CssClass="form-control">
                        <asp:ListItem Value="Customer">Customer</asp:ListItem>
                        <asp:ListItem Value="Manager">Manager</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="form-group mt-4">
                    <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn btn-auth btn-block" OnClick="btnRegister_Click" />
                </div>

                <div class="text-center mt-3">
                    <p>Already have an account? <a href="login.aspx" style="color: #007bff; font-weight:600;">Login here</a></p>
                </div>

            </div>
        </div>
    </div>

</asp:Content>