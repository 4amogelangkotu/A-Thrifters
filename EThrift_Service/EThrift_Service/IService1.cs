using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

namespace EThrift_Service
{
    [ServiceContract]
    public interface IService1
    {
        // --- USER AUTHENTICATION ---
        [OperationContract]
        UserTable Login(string name, string password);

        [OperationContract]
        bool RegisterUser(string name, string password, string userType);

        [OperationContract]
        bool UserExists(string name);

        [OperationContract]
        bool AddManager(string name, string password);

        // --- PRODUCTS ---
        [OperationContract]
        List<Product> GetAllProducts();

        [OperationContract]
        Product GetProduct(int id);

        [OperationContract]
        List<Product> GetProductsByCategory(string category);

        [OperationContract]
        List<Product> SortProducts(string sortType);

        [OperationContract]
        List<Product> SearchProducts(string query);

        // --- SHOPPING CART ---
        [OperationContract]
        bool AddToCart(int userId, int prodId, int quantity);

        [OperationContract]
        List<CartDisplay> GetCartItems(int userId);

        [OperationContract]
        bool UpdateCartQuantity(int cartId, int quantity);

        [OperationContract]
        bool RemoveFromCart(int userId, int prodId);

        [OperationContract]
        decimal GetCartTotal(int userId);

        [OperationContract]
        bool Checkout(int userId, decimal totalAmount);

        [OperationContract]
        List<CartDisplay> GetCart(int userId);

        // --- INVOICES ---
        [OperationContract]
        List<Invoice> GetUserInvoices(int userId);

        [OperationContract]
        Invoice GetInvoiceDetails(int invoiceId);

        [OperationContract]
        List<CartDisplay> GetInvoiceItems(int invoiceId);

        [OperationContract]
        List<InvoiceDisplay> GetAllInvoices();

        [OperationContract]
        Invoice GetInvoiceHeader(int invoiceId);

        [OperationContract]
        bool UpdateInvoiceStatus(int invoiceId, string newStatus);

        // --- REVIEWS ---
        [OperationContract]
        bool AddReview(int userId, int prodId, int rating, string comment);

        [OperationContract]
        List<ReviewDisplay> GetProductReviews(int prodId);

        [OperationContract]
        bool HasUserPurchasedItem(int userId, int prodId);

        // --- WISHLIST ---
        [OperationContract]
        bool AddToWishlist(int userId, int prodId);

        [OperationContract]
        List<CartDisplay> GetWishlist(int userId);

        [OperationContract]
        bool RemoveFromWishlist(int userId, int prodId);

        // --- MANAGER FUNCTIONS ---
        [OperationContract]
        bool AddProduct(string name, string desc, decimal price, string category, string image, bool active, int stock);

        [OperationContract]
        bool UpdateProduct(int id, string name, string desc, decimal price, string category, string image, bool active, int stock);

        [OperationContract]
        bool DeleteProduct(int id);

        [OperationContract]
        DashboardStats GetDashboardStats();


    }

    [DataContract]
    public class CartDisplay
    {
        [DataMember] 
        public int CartId { get; set; }

        [DataMember]
        public int ProductId { get; set; }

        [DataMember]
        public string Name { get; set; }

        [DataMember]
        public decimal Price { get; set; }

        [DataMember]
        public string Image { get; set; }

        [DataMember]
        public string Category { get; set; }

        [DataMember]
        public int Quantity { get; set; }
    }

    [DataContract]
    public class ReviewDisplay
    {
        [DataMember] 
        public string UserName { get; set; }

        [DataMember] 
        public int Rating { get; set; }

        [DataMember] 
        public string Comment { get; set; }
    }

    [DataContract]
    public class InvoiceDisplay
    {
        [DataMember] 
        public int InvoiceId { get; set; }

        [DataMember] 
        public string CustomerName { get; set; }

        [DataMember] 
        public DateTime DatePlaced { get; set; }

        [DataMember] 
        public decimal TotalAmount { get; set; }

        [DataMember] 
        public string Status { get; set; }
    }

    [DataContract]
    public class DashboardStats
    {
        [DataMember] 
        public decimal TotalRevenue { get; set; }

        [DataMember] 
        public int TotalOrders { get; set; }

        [DataMember] 
        public int TotalUsers { get; set; }

        [DataMember] 
        public int TotalProducts { get; set; }
    }
}