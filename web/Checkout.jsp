<%-- 
    Document   : Checkout
    Created on : 22 Jan, 2025, 12:39:58 PM
    Author     : rokad
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout | RentAnAttire</title>
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

        .checkout-container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 12px 25px rgba(0, 0, 0, 0.1);
        }

        .checkout-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
        }

        .checkout-item img {
            width: 100px;
            height: 100px;
            object-fit: contain;
            margin-right: 20px;
        }

        .checkout-item-details {
            flex: 1;
        }

        .checkout-item-price {
            font-size: 18px;
            color: #ff6b6b;
            font-weight: bold;
        }

        .total-price {
            font-size: 20px;
            text-align: right;
            margin-top: 20px;
            font-weight: bold;
            color: #28a745;
        }

        .confirm-btn {
            display: block;
            margin: 20px auto;
            padding: 10px 20px;
            background: #28a745;
            color: white;
            text-decoration: none;
            text-align: center;
            border-radius: 5px;
            font-size: 18px;
        }

        .confirm-btn:hover {
            background: #218838;
        }
    </style>
</head>
<body>

<header>
    <h1>RentAnAttire - Checkout</h1>
</header>

<div class="checkout-container">
    <h2>Your Order Summary</h2>
    <%
        // Retrieve the cart from the session
        List<Map<String, String>> cart = (List<Map<String, String>>) session.getAttribute("cart");
        double totalPrice = 0;

        if (cart == null || cart.isEmpty()) {
    %>
        <p>Your cart is empty!</p>
    <%
        } else {
            for (Map<String, String> item : cart) {
                String description = item.get("description");
                String price = item.get("price");
                String size = item.get("size");
                String image = item.get("image");

                double itemPrice = Double.parseDouble(price);
                totalPrice += itemPrice;
    %>
        <div class="checkout-item">
            <img src="data:image/jpeg;base64,<%= image %>" alt="Product Image">
            <div class="checkout-item-details">
                <p><strong><%= description %></strong></p>
                <p>Size: <%= size %></p>
                <p class="checkout-item-price">₹<%= price %></p>
            </div>
        </div>
    <%
            }
    %>
        <p class="total-price">Total: ₹<%= totalPrice %></p>
        <a href="ConfirmOrder.jsp" class="confirm-btn">Confirm Order</a>
    <%
        }
    %>
</div>

<footer>
    <p>&copy; 2024 RentAnAttire. All rights reserved.</p>
</footer>

</body>
</html>
