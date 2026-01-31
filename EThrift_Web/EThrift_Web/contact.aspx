<%@ Page Title="A-Thrifters - Contact Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="contact.aspx.cs" Inherits="EThrift_Web.contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="page-heading contact-heading header-text">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="text-content">
                        <h4>contact us</h4>
                        <h2>let’s get in touch</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="find-us">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="section-heading">
                        <h2>Our Location on Maps</h2>
                    </div>
                </div>
                <div class="col-md-8">
                    <div id="map">
    <iframe src="https://maps.google.com/maps?q=Pretoria,South%20Africa&t=&z=13&ie=UTF8&iwloc=&output=embed" width="100%" height="330px" frameborder="0" style="border:0" allowfullscreen></iframe>
</div>
                </div>
                <div class="col-md-4">
                    <div class="left-content">
                        <h4>About our office</h4>
                        <p>We are located in the heart of the city, making it easy for you to drop by and check out our exclusive thrift collection in person.</p>
                        <ul class="social-icons">
                            <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                            <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                            <li><a href="#"><i class="fa fa-linkedin"></i></a></li>
                            <li><a href="#"><i class="fa fa-behance"></i></a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="send-message">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="section-heading">
                        <h2>Send us a Message</h2>
                    </div>
                </div>
                
                <div class="col-md-8">
                    <div class="contact-form">
                        
                        <div class="row">
                            <div class="col-md-12">
                                <asp:Label ID="lblMessage" runat="server" Visible="false" CssClass="alert alert-success btn-block"></asp:Label>
                                <br />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12">
                                <fieldset>
                                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Full Name" required=""></asp:TextBox>
                                </fieldset>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12">
                                <fieldset>
                                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="E-Mail Address" required=""></asp:TextBox>
                                </fieldset>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12">
                                <fieldset>
                                    <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" placeholder="Subject" required=""></asp:TextBox>
                                </fieldset>
                            </div>
                            <div class="col-lg-12">
                                <fieldset>
                                    <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Rows="6" CssClass="form-control" placeholder="Your Message" required=""></asp:TextBox>
                                </fieldset>
                            </div>
                            <div class="col-lg-12">
                                <fieldset>
                                    <asp:Button ID="btnSubmit" runat="server" Text="Send Message" CssClass="filled-button" OnClick="btnSubmit_Click" />
                                </fieldset>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <ul class="accordion">
                        <li>
                            <a>Order Status</a>
                            <div class="content">
                                <p>You can track your order status in the "My History" tab once you are logged in.</p>
                            </div>
                        </li>
                        <li>
                            <a>Returns & Exchanges</a>
                            <div class="content">
                                <p>We accept returns within 7 days of purchase if the item is in its original condition.</p>
                            </div>
                        </li>
                        <li>
                            <a>Shipping Info</a>
                            <div class="content">
                                <p>We ship nationwide. Standard delivery takes 3-5 business days.</p>
                            </div>
                        </li>
                        <li>
                            <a>Sell with A-Thrifters</a>
                            <div class="content">
                                <p>Want to sell your clothes? Contact us via the form to become a supplier.</p>
                            </div>
                        </li>
                    </ul>
                </div>

            </div>
        </div>
    </div>

</asp:Content>