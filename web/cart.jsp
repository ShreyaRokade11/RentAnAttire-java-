<%-- 
    Document   : cart
    Created on : 22 Jan, 2025, 12:22:11 PM
    Author     : rokad
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cart | RentAnAttire</title>
     
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

        h1 {
            text-align: center;
            margin: 20px 0;
        }

        .cart-container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 12px 25px rgba(0, 0, 0, 0.1);
        }

        .cart-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
        }

        .cart-item img {
            width: 100px;
            height: 100px;
            object-fit: contain;
            margin-right: 20px;
        }

        .cart-item-details {
            flex: 1;
        }

        .cart-item-price {
            font-size: 18px;
            color: #ff6b6b;
            font-weight: bold;
        }

        .cart-item-remove {
            color: #ff6b6b;
            text-decoration: none;
            font-size: 16px;
            margin-left: 10px;
        }

        .cart-item-remove:hover {
            color: #e63946;
        }

        .checkout-btn {
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

        .checkout-btn:hover {
            background: #218838;
        }
     

    </style>
</head>
<body>



<header>
    <h1>RentAnAttire - Cart</h1>
</header>

<div class="cart-container">
    <h2>Your Cart Items</h2>
    <%
        // Retrieve the cart from the session
        List<Map<String, String>> cart = (List<Map<String, String>>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
    %>
        <p>Your cart is empty!</p>
    <%
        } else {
            for (Map<String, String> item : cart) {
                String id = item.get("id");
                String description = item.get("description");
                String price = item.get("price");
                String size = item.get("size");
                String image = item.get("image");
    %>
        <div class="cart-item">
            <img src="data:image/jpeg;base64,<%= image %>" alt="Product Image">
            <div class="cart-item-details">
                <p><strong><%= description %></strong></p>
                <p>Size: <%= size %></p>
                <p class="cart-item-price">₹<%= price %></p>
            </div>
         
                <%--   <a href="RemoveFromCart.jsp?id=<%= id %>" class="cart-item-remove">Remove</a> --%>
                
        </div>
    <%
            }
    %>
        <a href="Checkout.jsp" class="checkout-btn">Proceed to Checkout</a>
        
      

    <%
        }
    %>
</div>

<footer>
    <p>&copy; 2024 RentAnAttire. All rights reserved.</p>
</footer>

</body>
</html>
