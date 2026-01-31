<%@ Page Title="A-Thrifters - Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="EThrift_Web.index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="banner header-text">
      <div class="owl-banner owl-carousel">
        <div class="banner-item-01">
          <div class="text-content">
            <h4>Best Offer</h4>
            <h2>New Arrivals On Sale</h2>
          </div>
        </div>
          <%--
              <div class="banner-item-02">
          <div class="text-content">
            <h4>Flash Deals</h4>
            <h2>Get your best products</h2>
          </div>
        </div>
        <div class="banner-item-03">
          <div class="text-content">
            <h4>Last Minute</h4>
            <h2>Grab last minute deals</h2>
          </div>
        </div>
          --%>
        
      </div>
    </div>

    <div class="latest-products">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <div class="section-heading">
              <h2>Latest Products</h2>
              <a href="products.aspx">view all products <i class="fa fa-angle-right"></i></a>
            </div>
          </div>

            <div class="col-md-12">
    <asp:Label ID="lblError" runat="server" CssClass="text-danger" Visible="false"></asp:Label>
</div>
          
          <asp:Repeater ID="rptLatestProducts" runat="server">
              <ItemTemplate>
                  <div class="col-md-4">
                    <div class="product-item">
                      <a href="aboutProduct.aspx?id=<%# Eval("ProductId") %>">
                          <img src='<%# Eval("Image") %>' alt="" style="height:250px; object-fit:cover;">
                      </a>
                      <div class="down-content">
                        <a href="aboutProduct.aspx?id=<%# Eval("ProductId") %>">
                            <h4><%# Eval("Name") %></h4>
                        </a>
                        
                        <p><%# Eval("Description").ToString().Length > 50 ? Eval("Description").ToString().Substring(0, 50) + "..." : Eval("Description") %></p>
                        
                        <ul class="stars">
                           <%# GetStarRatingHtml(Eval("ProductId")) %>
                        </ul>
                        <h6>R <%# Eval("Price", "{0:0.00}") %></h6>

                        <a href="aboutProduct.aspx?id=<%# Eval("ProductId") %>" class="btn btn-sm btn-primary" style="margin-top:10px;">View Details</a> 
                      </div>
                    </div>
                  </div>
              </ItemTemplate>
          </asp:Repeater>
          </div>
      </div>
    </div>

    <script language = "text/Javascript"> 
      cleared[0] = cleared[1] = cleared[2] = 0; 
      function clearField(t){ 
      if(! cleared[t.id]){ 
          cleared[t.id] = 1; 
          t.value=''; 
          t.style.color='#fff';
          }
      }
    </script>

</asp:Content>