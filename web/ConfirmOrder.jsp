<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, java.io.*" %>
<%@ page import="java.sql.*" %> <!-- For database connectivity -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation | RentAnAttire</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #ff6b6b, #f9c4d2);
        }

        header, footer {
            background-color: #391306;
            color: white;
            padding: 20px;
            text-align: center;
        }

        h1, h2 {
            text-align: center;
            margin: 20px 0;
        }

        .confirmation-container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 12px 25px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .confirmation-message {
            font-size: 18px;
            color: #28a745;
            margin: 20px 0;
        }

        .order-summary {
            margin: 20px 0;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
            text-align: left;
        }

        .order-summary p {
            margin: 10px 0;
            font-size: 16px;
        }

        .back-home-btn {
            display: block;
            margin: 20px auto;
            padding: 10px 20px;
            background: #007bff;
            color: white;
            text-decoration: none;
            text-align: center;
            border-radius: 5px;
            font-size: 18px;
        }

        .back-home-btn:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>

<header>
    <h1>RentAnAttire - Order Confirmation</h1>
</header>

<div class="confirmation-container">
    <%
        // Get email from session
        String email = (String) session.getAttribute("email");

        // If email is not found in session, redirect to login page
        if (email == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Database logic to fetch user name
        String userName = "Guest"; // Default value
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            // Assuming database connection setup
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/RentAnAttire", "root", "1234");
            ps = con.prepareStatement("SELECT name FROM users WHERE email = ?");
            ps.setString(1, email);
            rs = ps.executeQuery();
            if (rs.next()) {
                userName = rs.getString("name");
            }
        } catch (Exception e) {
            out.println("<p>Error fetching user details: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    %>
    <h2>Thank You, <%= userName %>, for Your Order!</h2>
    <p class="confirmation-message">Your order has been successfully placed. We appreciate your trust in RentAnAttire.</p>

    <div class="order-summary">
        <h3>Order Summary:</h3>
        <%
            // Retrieve the cart from the session
            List<Map<String, String>> cart = (List<Map<String, String>>) session.getAttribute("cart");
            double totalPrice = 0;

            if (cart != null && !cart.isEmpty()) {
                for (Map<String, String> item : cart) {
                    String description = item.get("description");
                    String price = item.get("price");

                    double itemPrice = Double.parseDouble(price);
                    totalPrice += itemPrice;
        %>
        <p><strong><%= description %></strong> - ₹<%= price %></p>
        <%
                }
            }
        %>
        <p><strong>Total Amount:</strong> ₹<%= totalPrice %></p>
    </div>

    <a href="index.html" class="back-home-btn">Back to Home</a>
</div>

<%
    // Clear the cart after order confirmation
    session.removeAttribute("cart");
%>

<footer>
    <p>&copy; 2024 RentAnAttire. All rights reserved.</p>
</footer>

</body>
</html>
