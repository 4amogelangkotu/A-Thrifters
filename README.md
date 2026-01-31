# A-Thrifters | E-Commerce Platform

![.NET](https://img.shields.io/badge/.NET-5C2D91?style=for-the-badge&logo=.net&logoColor=white)
![C#](https://img.shields.io/badge/C%23-239120?style=for-the-badge&logo=c-sharp&logoColor=white)
![Bootstrap](https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white)
![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)

> **Modern. Sustainable. Scalable.**
> A full-stack .NET e-commerce solution simulating a circular economy marketplace.

---

## 📖 About The Project

**A-Thrifters** is a robust e-commerce platform designed to demonstrate modern web application architecture. Unlike simple CRUD apps, this project simulates a real-world retail environment with complex business logic, including real-time stock tracking, transactional checkout flows, and role-based security.

The system is built on a **Service-Oriented Architecture (SOA)**, separating the frontend (ASP.NET Web Forms) from the business logic (WCF Service), ensuring scalability and maintainability.

---

## 📸 Application Preview

### 🛍️ Dynamic Storefront
Users can browse a catalog of unique items with category filtering (Tops, Bottoms, Footwear) and real-time search functionality.
![Products Page](https://github.com/4amogelangkotu/A-Thrifters/blob/main/EThrift_Web/EThrift_Web/assets/images/products_page.png)

### 🛒 Smart Shopping Cart
A session-based cart system that calculates totals, manages quantities, and persists user choices across the site.
![Shopping Cart](https://github.com/4amogelangkotu/A-Thrifters/blob/main/EThrift_Web/EThrift_Web/assets/images/cart_page.png)

### 💼 Manager Dashboard
Secure administrative portal for inventory control. Managers can update stock levels, prices, and product details in real-time.
![Manager Dashboard](https://github.com/4amogelangkotu/A-Thrifters/blob/main/EThrift_Web/EThrift_Web/assets/images/manager_dashboard.png)

---

## 🚀 Key Features

### 🛒 Customer Experience
* **Dynamic Catalog:** Browse products with category filtering and search functionality.
* **Smart Shopping Cart:** Session-based cart management that persists navigation.
* **Secure Checkout:** Integrated transactional engine that calculates VAT, verifies stock levels in real-time, and generates invoices.
* **User Accounts:** Registration, Login, and Order History tracking with status updates (Pending -> Shipped).

### 💼 Manager Dashboard
* **Inventory Control:** Add, edit, and delete products with image upload functionality.
* **Order Management:** View customer orders and update shipping statuses dynamically.
* **Analytics:** Visual overview of total revenue, active products, and order counts.

### ⚙️ Technical Highlights
* **Service-Oriented Architecture (SOA):** Decoupled **WCF Service** layer handles all data access and business rules.
* **Data Integrity:** **LINQ to SQL** ensures type-safe database interactions.
* **State Management:** Complex use of `Session` and `ViewState` to handle user journeys.
* **Security:** Role-based authentication (Customer vs. Manager) protecting sensitive admin routes.

---

## 🛠️ Tech Stack

* **Frontend:** ASP.NET Web Forms (.NET Framework 4.7.2), Bootstrap 4, jQuery
* **Backend:** C#, WCF (Windows Communication Foundation)
* **Database:** Microsoft SQL Server (LocalDB), LINQ to SQL (ORM)
* **Tools:** Visual Studio 2019, IIS Express

---

## 📦 Getting Started

To run this project locally, follow these steps:

### Prerequisites
* Visual Studio 2019 or newer (with "ASP.NET and web development" workload).
* SQL Server Express or LocalDB.

### Installation
1.  **Clone the repository**
    ```bash
    git clone [https://github.com/YourUsername/A-Thrifters.git](https://github.com/YourUsername/A-Thrifters.git)
    ```
2.  **Setup the Database**
    * Open `EThrift_Service.sln`.
    * Check the `App_Data` folder or Server Explorer. Ensure the connection string in `Web.config` points to your local SQL instance.
3.  **Run the Service Layer**
    * Set `EThrift_Service` as the startup project.
    * Press `F5` to start the WCF Service. **Keep this running.**
4.  **Run the Web Client**
    * Open `EThrift_Web.sln` (or right-click the Web project if in the same solution).
    * Update the **Service Reference** if the port number of the WCF service changed.
    * Set `EThrift_Web` as the startup project.
    * Press `F5` or `Ctrl+F5` to launch the store in your browser.

---

## 👤 Author

**Amogelang Kotu**
* **Portfolio:** [agkotu.vercel.app](https://agkotu.vercel.app)
* **LinkedIn:** [linkedin.com/in/amogelang-kotu](https://linkedin.com/in/amogelang-kotu)

---

## 📝 License

This project is open source and available under the [MIT License](LICENSE).
