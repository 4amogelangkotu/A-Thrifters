using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

namespace EThrift_Service
{
    public class Service1 : IService1
    {
        DataClasses1DataContext db = new DataClasses1DataContext();

        public Service1()
        {
            db.DeferredLoadingEnabled = false;
        }

        // -----------------------------
        // USER FUNCTIONS
        // -----------------------------
        public UserTable Login(string name, string password)
        {
            string hashedPassword = Secrecy.HashPassword(password);

            var user = (from u in db.UserTables
                        where u.Name.Equals(name) && u.Password.Equals(hashedPassword)
                        select u).FirstOrDefault();
            return user;
        }

        public bool RegisterUser(string name, string password, string userType)
        {
            try
            {
                string hashedPassword = Secrecy.HashPassword(password);

                var newUser = new UserTable
                {
                    Name = name,
                    Password = hashedPassword,
                    UserType = userType,
                    RegDate = DateTime.Now
                };
                db.UserTables.InsertOnSubmit(newUser);
                db.SubmitChanges();
                return true;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error Registering User: " + ex.Message);
                return false;
            }
        }

        public bool UserExists(string name)
        {
            var user = (from u in db.UserTables where u.Name.Equals(name) select u).FirstOrDefault();
            return user != null;
        }

        public bool AddManager(string name, string password)
        {
            try
            {
                var exists = db.UserTables.Any(u => u.Name == name);
                if (exists) return false;

                string hashedPassword = Secrecy.HashPassword(password);

                var newManager = new UserTable
                {
                    Name = name,
                    Password = hashedPassword,
                    UserType = "Manager",
                    RegDate = DateTime.Now
                };

                db.UserTables.InsertOnSubmit(newManager);
                db.SubmitChanges();
                return true;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error Adding Manager: " + ex.Message);
                return false;
            }
        }

        // -----------------------------
        // PRODUCT FUNCTIONS
        // -----------------------------
        public List<Product> GetAllProducts()
        {
            return (from p in db.Products where p.IsActive == true select p).ToList();
        }

        public Product GetProduct(int id)
        {
            return (from p in db.Products where p.ProductId == id select p).FirstOrDefault();
        }

        public List<Product> GetProductsByCategory(string category)
        {
            return (from p in db.Products
                    where p.Category.Contains(category) && p.IsActive == true
                    select p).ToList();
        }

        public List<Product> SortProducts(string sortType)
        {
            var list = db.Products.Where(p => p.IsActive == true);

            switch (sortType)
            {
                case "PriceAsc": return list.OrderBy(p => p.Price).ToList();
                case "PriceDesc": return list.OrderByDescending(p => p.Price).ToList();
                case "Alpha": return list.OrderBy(p => p.Name).ToList();
                default: return list.ToList();
            }
        }

        public List<Product> SearchProducts(string query)
        {
            return db.Products.Where(p => p.Name.Contains(query) || p.Description.Contains(query)).ToList();
        }

        // -----------------------------
        // CART FUNCTIONS
        // -----------------------------
        public bool AddToCart(int userId, int prodId, int quantity)
        {
            try
            {
                var existingItem = (from c in db.Carts
                                    where c.UserId == userId && c.ProductId == prodId
                                    select c).FirstOrDefault();

                if (existingItem != null)
                {
                    existingItem.Quantity += quantity;
                }
                else
                {
                    int newId = db.Carts.Any() ? db.Carts.Max(x => x.CartId) + 1 : 1;

                    var newItem = new Cart
                    {
                        CartId = newId,
                        UserId = userId,
                        ProductId = prodId,
                        Quantity = quantity
                    };
                    db.Carts.InsertOnSubmit(newItem);
                }
                db.SubmitChanges();
                return true;
            }
            catch { return false; }
        }

        public List<CartDisplay> GetCartItems(int userId)
        {
            var list = from c in db.Carts
                       join p in db.Products on c.ProductId equals p.ProductId
                       where c.UserId == userId
                       select new CartDisplay
                       {
                           ProductId = p.ProductId,
                           Name = p.Name,
                           Price = p.Price,
                           Image = p.Image,
                           Category = p.Category,
                           Quantity = (int)c.Quantity
                       };

            return list.ToList();
        }

        public bool UpdateCartQuantity(int cartId, int quantity)
        {
            var item = (from c in db.Carts where c.CartId == cartId select c).FirstOrDefault();
            if (item != null)
            {
                item.Quantity = quantity;
                db.SubmitChanges();
                return true;
            }
            return false;
        }

        public bool RemoveFromCart(int userId, int prodId)
        {
            var item = db.Carts.FirstOrDefault(c => c.UserId == userId && c.ProductId == prodId);
            if (item != null)
            {
                db.Carts.DeleteOnSubmit(item);
                db.SubmitChanges();
                return true;
            }
            return false;
        }

        public decimal GetCartTotal(int userId)
        {
            var total = (from c in db.Carts
                         join p in db.Products on c.ProductId equals p.ProductId
                         where c.UserId == userId
                         select c.Quantity * p.Price).Sum();
            return total;
        }

        public bool Checkout(int userId, decimal totalAmount)
        {
            try
            {
                var cartItems = (from c in db.Carts
                                 join p in db.Products on c.ProductId equals p.ProductId
                                 where c.UserId == userId
                                 select new { c, p}).ToList();

                if (cartItems.Count == 0) return false;

                var newInvoice = new Invoice
                {
                    UserId = userId,
                    DatePlaced = DateTime.Now,
                    TotalAmount = totalAmount
                };
                db.Invoices.InsertOnSubmit(newInvoice);
                db.SubmitChanges();

                foreach (var item in cartItems)
                {
                    if (item.p.Stock < item.c.Quantity)
                    {
                        return false;
                    }

                    item.p.Stock -= item.c.Quantity;

                    var invoiceItem = new InvoiceItem
                    {
                        InvoiceId = newInvoice.InvoiceId,
                        ProductId = item.p.ProductId,
                        Quantity = item.c.Quantity,
                        Price = item.p.Price 
                    };
                    db.InvoiceItems.InsertOnSubmit(invoiceItem);
                }

                var itemsToDelete = db.Carts.Where(c => c.UserId == userId);
                db.Carts.DeleteAllOnSubmit(itemsToDelete);

                db.SubmitChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public List<CartDisplay> GetCart(int userId)
        {
            var list = from c in db.Carts
                       join p in db.Products on c.ProductId equals p.ProductId
                       where c.UserId == userId
                       select new CartDisplay
                       {
                           CartId = c.CartId,
                           ProductId = c.ProductId,
                           Name = p.Name,
                           Price = p.Price,
                           Quantity = c.Quantity,
                           Image = p.Image
                       };

            return list.ToList();
        }

        // -----------------------------
        // INVOICES & REVIEWS
        // -----------------------------
        public List<Invoice> GetUserInvoices(int userId)
        {
            return (from i in db.Invoices
                    where i.UserId == userId
                    orderby i.DatePlaced descending
                    select i).ToList();
        }

        public Invoice GetInvoiceDetails(int invoiceId)
        {
            return (from i in db.Invoices where i.InvoiceId == invoiceId select i).FirstOrDefault();
        }

        public List<CartDisplay> GetInvoiceItems(int invoiceId)
        {
            var list = from i in db.InvoiceItems
                       join p in db.Products on i.ProductId equals p.ProductId
                       where i.InvoiceId == invoiceId
                       select new CartDisplay
                       {
                           ProductId = p.ProductId,
                           Name = p.Name,
                           Image = p.Image,
                           Price = i.Price,
                           Quantity = i.Quantity
                       };

            return list.ToList();
        }

        public List<InvoiceDisplay> GetAllInvoices()
        {
            var list = from i in db.Invoices
                       join u in db.UserTables on i.UserId equals u.UserId
                       orderby i.DatePlaced descending
                       select new InvoiceDisplay
                       {
                           InvoiceId = i.InvoiceId,
                           CustomerName = u.Name,
                           DatePlaced = (DateTime)i.DatePlaced,
                           TotalAmount = (decimal)i.TotalAmount,
                           Status = i.Status ?? "Paid"
                       };

            return list.ToList();
        }

        public Invoice GetInvoiceHeader(int invoiceId)
        {
            return db.Invoices.FirstOrDefault(i => i.InvoiceId == invoiceId);
        }

        public bool AddReview(int userId, int prodId, int rating, string comment)
        {
            try
            {
                int newId = db.Reviews.Any() ? db.Reviews.Max(x => x.ReviewId) + 1 : 1;

                var newReview = new Review
                {
                    ReviewId = newId,
                    UserId = userId,
                    ProductId = prodId,
                    Rating = rating,
                    Comment = comment
                };
                db.Reviews.InsertOnSubmit(newReview);
                db.SubmitChanges();
                return true;
            }
            catch { return false; }
        }

        public List<ReviewDisplay> GetProductReviews(int prodId)
        {
            var list = from r in db.Reviews
                       join u in db.UserTables on r.UserId equals u.UserId
                       where r.ProductId == prodId
                       orderby r.ReviewId descending
                       select new ReviewDisplay
                       {
                           UserName = u.Name,
                           Rating = (int)r.Rating,
                           Comment = r.Comment
                       };

            return list.Take(5).ToList();
        }

        public bool HasUserPurchasedItem(int userId, int prodId)
        {
            var purchased = (from i in db.InvoiceItems
                             join inv in db.Invoices on i.InvoiceId equals inv.InvoiceId
                             where inv.UserId == userId && i.ProductId == prodId
                             select i).Any();

            return purchased;
        }

        public bool UpdateInvoiceStatus(int invoiceId, string newStatus)
        {
            try
            {
                var invoice = db.Invoices.FirstOrDefault(i => i.InvoiceId == invoiceId);
                if (invoice != null)
                {
                    invoice.Status = newStatus;
                    db.SubmitChanges();
                    return true;
                }
                return false;
            }
            catch
            {
                return false;
            }
        }

        // -----------------------------
        // UPGRADED WISHLIST FUNCTIONS
        // -----------------------------

        public bool AddToWishlist(int userId, int prodId)
        {
            try
            {
                var exists = (from w in db.Wishlists
                              where w.UserId == userId && w.ProductId == prodId
                              select w).Any();

                if (exists) return false;

                var item = new Wishlist
                {
                    UserId = userId,
                    ProductId = prodId,
                    DateAdded = DateTime.Now
                };
                db.Wishlists.InsertOnSubmit(item);
                db.SubmitChanges();
                return true;
            }
            catch { return false; }
        }

        public List<CartDisplay> GetWishlist(int userId)
        {
            var list = from w in db.Wishlists
                       join p in db.Products on w.ProductId equals p.ProductId
                       where w.UserId == userId
                       select new CartDisplay
                       {
                           ProductId = p.ProductId,
                           Name = p.Name,
                           Price = p.Price,
                           Image = p.Image,
                           Category = p.Category,
                           Quantity = 1
                       };

            return list.ToList();
        }

        public bool RemoveFromWishlist(int userId, int prodId)
        {
            var item = (from w in db.Wishlists
                        where w.UserId == userId && w.ProductId == prodId
                        select w).FirstOrDefault();

            if (item != null)
            {
                db.Wishlists.DeleteOnSubmit(item);
                db.SubmitChanges();
                return true;
            }
            return false;
        }
        // -----------------------------
        // MANAGER FUNCTIONS
        // -----------------------------
        public bool AddProduct(string name, string desc, decimal price, string category, string image, bool active, int stock)
        {
            try
            {
                var p = new Product
                {
                    Name = name,
                    Description = desc,
                    Price = price,
                    Category = category,
                    Image = image,
                    IsActive = active,
                    Stock = stock
                };
                db.Products.InsertOnSubmit(p);
                db.SubmitChanges();
                return true;
            }
            catch { return false; }
        }

        public bool UpdateProduct(int id, string name, string desc, decimal price, string category, string image, bool active, int stock)
        {
            var p = (from prod in db.Products where prod.ProductId == id select prod).FirstOrDefault();
            if (p != null)
            {
                p.Name = name;
                p.Description = desc;
                p.Price = price;
                p.Category = category;
                p.Image = image;
                p.IsActive = active;
                p.Stock = stock;
                db.SubmitChanges();
                return true;
            }
            return false;
        }

        public bool DeleteProduct(int id)
        {
            var p = (from prod in db.Products where prod.ProductId == id select prod).FirstOrDefault();
            if (p != null)
            {
                p.IsActive = false;
                db.SubmitChanges();
                return true;
            }
            return false;
        }

        public DashboardStats GetDashboardStats()
        {
            var stats = new DashboardStats();

            try
            {
                stats.TotalRevenue = db.Invoices.Any() ? (decimal)db.Invoices.Sum(i => i.TotalAmount) : 0;

                stats.TotalOrders = db.Invoices.Count();

                stats.TotalUsers = db.UserTables.Count(u => u.UserType != "Manager");

                stats.TotalProducts = db.Products.Count();
            }
            catch
            {

            }

            return stats;
        }
    }
}