<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Men Products | RentAnAttire</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
      
    body {
        font-family: 'Poppins', sans-serif;
        margin: 0;
        padding: 0;
        background: linear-gradient(135deg, #ff6b6b, #f9c4d2);
    }

    header {
        background-color: #391306;
        padding: 20px 0;
        color: white;
        position: sticky;
        top: 0;
        z-index: 1000;
    }

    .navbar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 20px;
    }

    .logo h1 {
        font-size: 24px;
        color: white;
        font-weight: bold;
        margin: 0;
    }

    nav ul {
        display: flex;
        list-style: none;
        margin: 0;
        padding: 0;
    }

    nav ul li {
        margin: 0 20px;
        position: relative; /* For dropdown positioning */
    }

    nav ul li a {
        text-decoration: none;
        color: white;
        font-size: 18px;
        font-weight: bold;
        text-transform: uppercase;
        transition: color 0.3s ease;
    }

    nav ul li a:hover {
        color: #f1c40f; /* Yellow color on hover */
    }

    /* Dropdown Menu Styling */
    nav ul li .dropdown {
        display: none;
        position: absolute;
        top: 100%;
        left: 0;
        background-color: #444;
        padding: 10px 0;
        list-style: none;
        width: 150px;
    }

    nav ul li:hover .dropdown {
        display: block;
    }

    nav ul li .dropdown li a {
        color: white;
        padding: 10px 20px;
        text-decoration: none;
        display: block;
    }

    nav ul li .dropdown li a:hover {
        background-color: #555;
    }

    /* Login Button Styling */
    .login-btn {
        color: white;
        background-color: #b95c50;
        padding: 10px 20px;
        text-decoration: none;
        border-radius: 5px;
    }

    .login-btn:hover {
        background-color: #deb3ad;
    }

    footer {
        background: #391306;
        color: white;
        text-align: center;
        padding: 20px;
        position: relative;
        bottom: 0;
        width: 100%;
    }

    .search-bar {
        padding: 12px;
        margin: 20px 0;
        width: 100%;
        border-radius: 8px;
        border: 1px solid #ddd;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        font-size: 16px;
    }

    .product-container {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
        justify-content: center;
    }

    .product-card {
        background: white;
        border-radius: 10px;
        box-shadow: 0 12px 25px rgba(0, 0, 0, 0.1);
        overflow: hidden;
        width: calc(25% - 20px);
        transition: transform 0.3s ease;
        text-align: center;
    }

    .product-card:hover {
        transform: scale(1.05);
    }

    .product-image {
        width: 100%;
        height: 200px;
        object-fit: contain;
    }

    .product-details {
        padding: 15px;
    }

    .product-description {
        font-size: 14px;
        color: #555;
        margin: 10px 0;
    }

    .product-price {
        font-size: 18px;
        color: #ff6b6b;
        font-weight: bold;
    }

    .btn-rent {
        display: inline-block;
        padding: 10px 20px;
        margin-top: 10px;
        color: white;
        background: #28a745;
        text-decoration: none;
        border-radius: 5px;
        transition: background 0.3s ease;
    }

    .btn-rent:hover {
        background: #218838;
    }
    </style>
</head>
<body>
     <!-- Navigation Bar -->
  <header>
    <div class="navbar">
      <div class="logo">
        <h1>RentAnAttire</h1>
      </div>
      <nav>
        <ul>
          <li><a href="index.html">Home</a></li>
          <li>
            <a href="#categories">Categories</a>
            <ul class="dropdown">
              <li><a href="ProductMen.jsp">Men's</a></li>
              <li><a href="ProductWomen.jsp">Women's</a></li>
              
            </ul>
          </li>
          <li><a href="about.jsp">About</a></li>
          <li><a href="#contact">Contact</a></li>
        </ul>
      </nav>
         <a href="cart.jsp" class="login-btn">cart</a>
         <a href="login.html" class="login-btn">Login</a>
         <a href="AdminLogin.jsp" class="login-btn">Admin </a>

    </div>
  </header>
    </header>

    <!-- Search Bar -->
    <div class="container">
        <input type="text" class="search-bar" placeholder="Search for attire..." onkeyup="searchProducts()">
    </div>

    <div class="container">
        <h1>All Products</h1>
        <div class="product-container" id="productContainer">
            <%
                String url = "jdbc:mysql://localhost:3306/RentAnAttire";
                String username = "root";
                String password = "1234";
                Connection con = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection(url, username, password);
                    stmt = con.createStatement();
                    
                    // Fetch all products
                    String query = "SELECT id, description, price, image, size, status FROM Womens";
                    rs = stmt.executeQuery(query);

                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String description = rs.getString("description");
                        double price = rs.getDouble("price");
                        String size = rs.getString("size");
                        String status = rs.getString("status");
                        Blob imageBlob = rs.getBlob("image");
                        byte[] imageBytes = imageBlob.getBytes(1, (int) imageBlob.length());
                        String base64Image = javax.xml.bind.DatatypeConverter.printBase64Binary(imageBytes);
            %>
                <div class="product-card" data-description="<%= description %>">
                    <img src="data:image/jpeg;base64,<%= base64Image %>" alt="Product Image" class="product-image">
                    <div class="product-details">
                        <div class="product-description"><%= description %></div>
                        <div class="product-price"><%= price %></div>
                        <div class="product-size">Size: <%= size %></div>
                        <div class="product-status">Status: <%= status %></div>
                        <!-- Add to Cart Button -->
                         <a href="AddToCart.jsp?id=<%= id %>&description=<%= description %>&price=<%= price %>&size=<%= size %>" class="btn-rent">Add to Cart</a>
        
                          <!-- Rent Now Button -->
                          <a href="WomenproductDetails.jsp?id=<%= id %>" class="btn-rent" style="background: #007bff;">Rent Now</a>
                    </div>
                </div>
            <%
                    }
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                } finally {
                    try {
                        if (stmt != null) stmt.close();
                        if (con != null) con.close();
                    } catch (SQLException se) {
                        out.println("<p>Error: " + se.getMessage() + "</p>");
                    }
                }
            %>
        </div>
    </div>

    <!-- Footer Section -->
    <footer>
        <p>&copy; 2024 RentAnAttire. All rights reserved.</p>
    </footer>

    <script>
        // Search function
        function searchProducts() {
            let input = document.querySelector(".search-bar").value.toLowerCase();
            let productCards = document.querySelectorAll(".product-card");
            
            productCards.forEach(card => {
                let description = card.getAttribute("data-description").toLowerCase();
                if (description.includes(input)) {
                    card.style.display = "";
                } else {
                    card.style.display = "none";
                }
            });
        }
    </script>

</body>
</html>
