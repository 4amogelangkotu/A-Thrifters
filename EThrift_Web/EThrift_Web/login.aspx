<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="EThrift_Web.login" %>

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
        .auth-header p {
            color: #aaa;
            font-size: 14px;
            margin-bottom: 30px;
        }
        .form-control {
            border-radius: 5px;
            height: 50px;
            margin-bottom: 20px;
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
                    <h4>Welcome Back</h4>
                    <p>Login to manage your account</p>
                </div>

                <asp:Label ID="lblError" runat="server" CssClass="alert alert-danger btn-block text-center" Visible="false"></asp:Label>

                <div class="form-group">
                    <label>Email Address</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="name@example.com"></asp:TextBox>
                </div>
                
                <div class="form-group">
                    <label>Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="•••••••"></asp:TextBox>
                </div>

                <div class="form-group mt-4">
                    <asp:Button ID="btnLogin" runat="server" Text="Login Now" CssClass="btn btn-auth btn-block" OnClick="btnLogin_Click" />
                </div>

                <div class="text-center mt-3">
                    <p>Don't have an account? <a href="register.aspx" style="color: #007bff; font-weight:600;">Sign Up</a></p>
                </div>

            </div>
        </div>
    </div>

</asp:Content>