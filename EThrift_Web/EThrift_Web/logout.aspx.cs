using System;

namespace EThrift_Web
{
    public partial class logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Clear();

            Session.Abandon();

            Response.Redirect("index.aspx");
        }
    }
}