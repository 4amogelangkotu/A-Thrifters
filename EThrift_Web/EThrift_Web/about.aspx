<%@ Page Title="About A-Thrifters" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="about.aspx.cs" Inherits="EThrift_Web.about" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="page-heading about-heading header-text">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="text-content">
                        <h4>sustainable style</h4>
                        <h2>about a-thrifters</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="best-features about-features">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="section-heading">
                        <h2>About This Project</h2>
                    </div>
                </div>
                
                <div class="col-md-6">
                    <div class="right-content">
                        <h4>A-Thrifters: The Project</h4>
                        <p>
                            A-Thrifters is a custom-built e-commerce platform designed to demonstrate modern web application architecture.
                            It simulates a digital marketplace where pre-loved clothing finds a second life.
                            <br /><br />
                            This project was developed individually to showcase full-stack .NET capabilities, moving beyond simple CRUD operations 
                            to include complex features like inventory tracking, role-based security, and transactional checkout flows.
                        </p>
                        <ul class="social-icons">
                            <li><i class="fa fa-code"></i> ASP.NET Web Forms</li>
                            <li><i class="fa fa-server"></i> WCF Service Layer</li>
                            <li><i class="fa fa-database"></i> SQL Server</li>
                            <li><i class="fa fa-mobile"></i> Responsive UI</li>
                        </ul>
                    </div>
                </div>
                
                <div class="col-md-6">
                    <div class="left-content">
                        <h4>About the Developer</h4>
                        <p>
                            Hi, I'm <strong>Amogelang Kotu</strong>, the lead developer behind A-Thrifters.
                            <br /><br />
                            I built this platform to apply Service-Oriented Architecture (SOA) principles to a real-world retail scenario. 
                            The goal was to create a seamless user experience backed by a robust, maintainable codebase.
                        </p>
                        <ul class="featured-list">
                            <li><a href="#">Engineered a custom Shopping Cart & Wishlist engine</a></li>
                            <li><a href="#">Implemented secure Manager Dashboard functionality</a></li>
                            <li><a href="#">Designed a dynamic image upload & stock control system</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="services">
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <div class="service-item">
                        <div class="icon">
                            <i class="fa fa-database"></i>
                        </div>
                        <div class="down-content">
                            <h4>Data Architecture</h4>
                            <p>Built on a normalized SQL Server database using LINQ to SQL for efficient Object-Relational Mapping (ORM) and transaction safety.</p>
                            <a href="#" class="filled-button">Backend</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="service-item">
                        <div class="icon">
                            <i class="fa fa-gears"></i>
                        </div>
                        <div class="down-content">
                            <h4>Service Layer (SOA)</h4>
                            <p>Decoupled business logic using WCF Services, ensuring a scalable architecture that separates the UI from data processing.</p>
                            <a href="#" class="filled-button">Architecture</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="service-item">
                        <div class="icon">
                            <i class="fa fa-lock"></i>
                        </div>
                        <div class="down-content">
                            <h4>Security & Logic</h4>
                            <p>Implemented role-based authentication, secure session management, and real-time stock deduction logic during checkout.</p>
                            <a href="#" class="filled-button">Security</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>