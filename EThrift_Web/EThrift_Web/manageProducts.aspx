<%@ Page Title="Manage Products" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="manageProducts.aspx.cs" Inherits="EThrift_Web.manageProducts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .page-spacer { padding-top: 120px; padding-bottom: 50px; }
        .form-box { background: #f7f7f7; padding: 25px; border-radius: 5px; }
        .form-box h4 { margin-bottom: 20px; color: #1a6692; border-bottom: 2px solid #ddd; padding-bottom: 10px; }
        .table img { width: 50px; height: 50px; object-fit: cover; border-radius: 4px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container page-spacer">
        <div class="row mb-3">
            <div class="col-md-12">
                <a href="manage.aspx" class="btn btn-outline-secondary"><i class="fa fa-arrow-left"></i> Back to Dashboard</a>
            </div>
        </div>

        <div class="row">
            
            <div class="col-md-4">
                <div class="form-box">
                    <h4>Product Manager</h4>
                    
                    <asp:HiddenField ID="hfProductId" runat="server" />

                    <div class="form-group">
                        <label>Product Name</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="e.g. Vintage Jacket"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label>Description</label>
                        <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label>Price (R)</label>
                        <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" placeholder="0.00"></asp:TextBox>
                    </div>

                    <div class="form-group">
    <label>Stock Quantity</label>
    <asp:TextBox ID="txtStock" runat="server" CssClass="form-control" TextMode="Number" Text="1"></asp:TextBox>
</div>

                    <div class="form-group">
                        <label>Category</label>
                        <asp:DropDownList ID="dlCategory" runat="server" CssClass="form-control">
                            <asp:ListItem Value="Tops">Tops</asp:ListItem>
                            <asp:ListItem Value="Bottoms">Bottoms</asp:ListItem>
                            <asp:ListItem Value="Footwear">Footwear</asp:ListItem>
                            <asp:ListItem Value="Accessories">Accessories</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                   <div class="form-group">
    <label>Product Image</label>
    
    <asp:FileUpload ID="fuImage" runat="server" CssClass="form-control-file border p-1" />
    
    <asp:HiddenField ID="hfCurrentImage" runat="server" />
    
    <small class="text-muted">Current: 
        <asp:Label ID="lblCurrentImage" runat="server" Text="None"></asp:Label>
    </small>
</div>

                    <div class="form-group form-check">
                        <asp:CheckBox ID="chkActive" runat="server" CssClass="form-check-input" Checked="true" />
                        <label class="form-check-label">Is Active (Visible in Store)</label>
                    </div>

                    <div class="mt-3">
                        <asp:Button ID="btnSave" runat="server" Text="Save Product" CssClass="btn btn-success btn-block" OnClick="btnSave_Click" />
                        <asp:Button ID="btnClear" runat="server" Text="Cancel / Clear" CssClass="btn btn-secondary btn-block" OnClick="btnClear_Click" />
                    </div>
                    
                    <div class="mt-3">
                        <asp:Label ID="lblMessage" runat="server" Visible="false"></asp:Label>
                    </div>

                </div>
            </div>

            <div class="col-md-8">
                <div class="table-responsive">
                    <asp:GridView ID="gvProducts" runat="server" CssClass="table table-hover table-bordered" 
                        AutoGenerateColumns="False" DataKeyNames="ProductId" 
                        OnRowCommand="gvProducts_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="ProductId" HeaderText="ID" ItemStyle-Width="50px" />
                            
                            <asp:TemplateField HeaderText="Img">
                                <ItemTemplate>
                                    <img src='<%# Eval("Image") %>' alt="img" />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField DataField="Name" HeaderText="Name" />
                            <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C}" />
                            
                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditProd" CommandArgument='<%# Eval("ProductId") %>' CssClass="btn btn-sm btn-primary">
                                        <i class="fa fa-pencil"></i>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteProd" CommandArgument='<%# Eval("ProductId") %>' CssClass="btn btn-sm btn-danger" OnClientClick="return confirm('Delete this item?');">
                                        <i class="fa fa-trash"></i>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>

        </div>
    </div>

</asp:Content>