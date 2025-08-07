<!-- 
delevery details,select size,date,address 
-->

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Men Details | RentAnAttire</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #f9c4d2, #ff6b6b);
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .header {
            background: #333;
            color: white;
            padding: 15px;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
        }

        .footer {
            background: #333;
            color: white;
            padding: 10px;
            text-align: center;
            margin-top: auto;
        }

        .product-details-container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 12px 25px rgba(0, 0, 0, 0.1);
            max-width: 900px;
            width: 90%;
            display: flex;
            align-items: center;
            margin: 20px auto;
        }

        .product-image {
            width: 100%;
            max-width: 300px;
            height: auto;
            object-fit: contain;
            border-radius: 10px;
            margin-right: 20px;
        }

        .product-info {
            flex-grow: 1;
            text-align: left;
        }

        .product-description {
            font-size: 18px;
            color: #555;
            margin: 10px 0;
        }

        .product-price {
            font-size: 22px;
            color: #ff6b6b;
            font-weight: bold;
        }

        .date-selection {
            margin: 20px 0;
        }

        .date-selection label {
            font-size: 16px;
            color: #555;
        }

        .date-selection input {
            padding: 10px;
            margin: 10px 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .size-selection {
            margin: 20px 0;
        }

        .size-selection label {
            font-size: 16px;
            color: #555;
        }

        .size-selection select {
            padding: 10px;
            margin: 10px 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .address-selection {
            margin: 20px 0;
        }

        .address-selection label {
            font-size: 16px;
            color: #555;
        }

        .address-selection textarea {
            padding: 10px;
            margin: 10px 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 100%;
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            margin-top: 20px;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background 0.3s ease;
            font-size: 16px;
        }

        .btn-rent {
            background: #28a745;
        }

        .btn-rent:hover {
            background: #218838;
        }

        .btn-back {
            background: #007bff;
        }

        .btn-back:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>
    <div class="header">
        RentAnAttire | Product Details
    </div>


    <div class="product-details-container">
        <%
            String productId = request.getParameter("id");
            if (productId == null || productId.isEmpty()) {
                out.println("<h2>Invalid Product ID!</h2>");
            } else {
                String url = "jdbc:mysql://localhost:3306/RentAnAttire";
                String username = "root";
                String password = "1234";
                Connection con = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection(url, username, password);
                    
                    String query = "SELECT description, price, image, status FROM Mens WHERE id = ?";
                    pstmt = con.prepareStatement(query);
                    pstmt.setInt(1, Integer.parseInt(productId));
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                        String description = rs.getString("description");
                        double price = rs.getDouble("price");
                        Blob imageBlob = rs.getBlob("image");
                        byte[] imageBytes = imageBlob.getBytes(1, (int) imageBlob.length());
                        String base64Image = javax.xml.bind.DatatypeConverter.printBase64Binary(imageBytes);
                        String status = rs.getString("status");
        %>

        <!-- Display product details -->
        <img src="data:image/jpeg;base64,<%= base64Image %>" alt="Product Image" class="product-image">
        <div class="product-info">
            <div class="product-description"><%= description %></div>
            <div class="product-price">Price Per Day: ₹<%= price %></div>
            <div class="availability">
                <%= "Status: " + (status.equals("1") ? "Available" : "Not Available") %>
            </div>
            
            <!-- Product rental form -->
            <form action="ProcessRentalMen.jsp" method="POST">
                <input type="hidden" name="productId" value="<%= productId %>">
                
                <div class="date-selection">
                    <label for="startDate">Start Date:</label>
                    <input type="date" id="startDate" name="startDate" required>
                    <label for="endDate">End Date:</label>
                    <input type="date" id="endDate" name="endDate" required>
                </div>
                
                <div class="size-selection">
                    <label for="size">Select Size:</label>
                    <select id="size" name="size" required>
                        <option value="S">Small</option>
                        <option value="M">Medium</option>
                        <option value="L">Large</option>
                        <option value="XL">Extra Large</option>
                    </select>
                </div>

                <div class="address-selection">
                    <label for="address">Enter Delivery Address:</label>
                    <textarea id="address" name="address" rows="4" required></textarea>
                </div>

                <!-- Submit button -->
                <button type="submit" class="btn btn-rent">Rent Now</button>
            </form>

            <a href="ProductMen.jsp" class="btn btn-back">Back to Products</a>
        </div>
        <%
                    } else {
                        out.println("<h2>Product not found!</h2>");
                    }
                } catch (Exception e) {
                    out.println("<h2>Error: " + e.getMessage() + "</h2>");
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (con != null) con.close();
                    } catch (SQLException se) {
                        out.println("<h2>Error: " + se.getMessage() + "</h2>");
                    }
                }
            }
        %>
    </div>
    <div class="footer">
        &copy; 2024 RentAnAttire. All rights reserved.
    </div>
</body>
</html>
