<%@ Page Title="A-Thrifters - Products" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="products.aspx.cs" Inherits="EThrift_Web.products" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="page-heading products-heading header-text">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="text-content">
                        <h4>new arrivals</h4>
                        <h2>A-Thrifters products</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="products">
        <div class="container">
            <div class="row">
                
                <div class="col-md-12 mb-5">
                    <div class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search for products (e.g. Shorts, Tee)..." style="height: 50px; border-radius: 0;"></asp:TextBox>
                        <div class="input-group-append">
                            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btnSearch_Click" style="border-radius: 0; padding: 0 30px; background-color:#007bff;" />
                        </div>
                         <div class="input-group-append ml-2">
                             <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-outline-secondary" OnClick="btnClear_Click" style="border-radius: 0;" />
                        </div>
                    </div>
                </div>

                <div class="col-md-12">
                    <div class="filters">
                        <ul>
                            <li class="active" data-filter="*">All Products</li>
                            <li data-filter=".Tops">Tops</li>
                            <li data-filter=".Bottoms">Bottoms</li>
                            <li data-filter=".Footwear">Footwear</li>
                            <li data-filter=".Accessories">Accessories</li>
                        </ul>
                    </div>
                </div>

                <div class="col-md-12">
                    <div class="filters-content">
                        <div class="row grid">
                            
                            <asp:Repeater ID="rptProducts" runat="server">
                                <ItemTemplate>
                                    <div class="col-lg-4 col-md-4 all <%# Eval("Category") %>">
                                        <div class="product-item">
                                            <a href='aboutProduct.aspx?id=<%# Eval("ProductId") %>'>
                                                <img src='<%# Eval("Image") %>' alt="" style="height:250px; object-fit:cover;">
                                            </a>
                                            <div class="down-content">
                                                <a href='aboutProduct.aspx?id=<%# Eval("ProductId") %>'>
                                                    <h4><%# Eval("Name") %></h4>
                                                </a>
                                                <h6>R <%# Eval("Price", "{0:0.00}") %></h6>
                                                
                                                <p><%# Eval("Description").ToString().Length > 80 ? Eval("Description").ToString().Substring(0, 80) + "..." : Eval("Description") %></p>
                                                
                                                <ul class="stars">
                                                   <%# GetStarRatingHtml(Eval("ProductId")) %>
                                                </ul>
                                                <a href="aboutProduct.aspx?id=<%# Eval("ProductId") %>" class="filled-button" style="padding: 10px; font-size:12px;">View Details</a>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>

                            <asp:Label ID="lblNoResults" runat="server" Text="No products found." Visible="false" CssClass="alert alert-warning col-md-12 text-center"></asp:Label>

                        </div>
                    </div>
                </div>
                
            </div>
        </div>
    </div>
    
    <div class="container">
        <asp:Label ID="lblError" runat="server" CssClass="text-danger" Visible="false"></asp:Label>
    </div>

</asp:Content>