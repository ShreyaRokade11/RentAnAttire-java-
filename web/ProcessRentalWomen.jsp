<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rental Confirmation | RentAnAttire</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background: #f4f4f4;
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

        .confirmation-container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 12px 25px rgba(0, 0, 0, 0.1);
            max-width: 900px;
            width: 90%;
            margin: 20px auto;
        }

        .confirmation-title {
            text-align: center;
            font-size: 26px;
            margin-bottom: 30px;
            font-weight: bold;
            color: #333;
        }

        .bill-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .bill-table th, .bill-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .bill-table th {
            background-color: #f1f1f1;
        }

        .bill-table td {
            font-size: 16px;
        }

        .bill-table .total-price {
            font-weight: bold;
            font-size: 18px;
            color: #e74c3c;
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
            text-align: center;
        }

        .btn-back {
            background: #007bff;
        }

        .btn-back:hover {
            background: #0056b3;
        }

        .bill-footer {
            text-align: center;
            font-size: 14px;
            color: #555;
            margin-top: 30px;
        }
    </style>
</head>
<body>
     <div class="header">
        RentAnAttire | Rental Confirmation
    </div>

    <div class="confirmation-container">
        <div class="confirmation-title">
            Rental Confirmation
        </div>

        <%
            // Get email from session
            String email = (String) session.getAttribute("email");

            // If email is not found in session, redirect to login page
            if (email == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            // Variables for rental details
            String productId = request.getParameter("productId");
            String size = request.getParameter("size");
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            String address = request.getParameter("address");
            String paymentMethod = "Cash on Delivery"; // Static payment method
            String name = "";

            if (productId == null || size == null || startDate == null || endDate == null || address == null) {
                out.println("<h2>Invalid Data. Please try again.</h2>");
            } else {
                String url = "jdbc:mysql://localhost:3306/RentAnAttire";
                String dbUsername = "root";
                String dbPassword = "1234";
                Connection con = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    // Step 1: Establish database connection
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection(url, dbUsername, dbPassword);

                    // Step 2: Get username based on email
                    String query = "SELECT name FROM users WHERE email = ?";
                    pstmt = con.prepareStatement(query);
                    pstmt.setString(1, email);
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                        name = rs.getString("name");
                    }

                    // Step 3: Get product details (price) for the rental calculation
                    query = "SELECT price, description, deposit FROM Womens WHERE id = ?";
                    pstmt = con.prepareStatement(query);
                    pstmt.setInt(1, Integer.parseInt(productId));
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                        double pricePerDay = rs.getDouble("price");
                        double deposit = rs.getDouble("deposit"); // Retrieve deposit value

                        // Step 4: Calculate rental duration (in days)
                        long startMillis = java.sql.Date.valueOf(startDate).getTime();
                        long endMillis = java.sql.Date.valueOf(endDate).getTime();
                        long diffInMillis = endMillis - startMillis;
                        long rentalDays = diffInMillis / (1000 * 60 * 60 * 24); // Convert milliseconds to days

                        if (rentalDays <= 0) {
                            out.println("<h2>End date must be after start date.</h2>");
                        } else {
                            double totalPrice = pricePerDay * rentalDays;

                            // Step 5: Insert rental information into the Rentals table
                            String insertQuery = "INSERT INTO Rentals (product_id, size, start_date, end_date, address, total_price) VALUES (?, ?, ?, ?, ?, ?)";
                            pstmt = con.prepareStatement(insertQuery);
                            pstmt.setInt(1, Integer.parseInt(productId));
                            pstmt.setString(2, size);
                            pstmt.setDate(3, java.sql.Date.valueOf(startDate));
                            pstmt.setDate(4, java.sql.Date.valueOf(endDate));
                            pstmt.setString(5, address);
                            pstmt.setDouble(6, totalPrice);

                            pstmt.executeUpdate();

                            // Step 6: Display rental confirmation in a detailed table
                            out.println("<table class='bill-table'>");
                            out.println("<tr><th>Username</th><td>" + name + "</td></tr>"); // Display username
                            out.println("<tr><th>Product</th><td>" + rs.getString("description") + "</td></tr>");
                            out.println("<tr><th>Size</th><td>" + size + "</td></tr>");
                            out.println("<tr><th>Rental Period</th><td>" + rentalDays + " days</td></tr>");
                            out.println("<tr><th>Start Date</th><td>" + startDate + "</td></tr>");
                            out.println("<tr><th>End Date</th><td>" + endDate + "</td></tr>");
                            out.println("<tr><th>Total Price</th><td class='total-price'>₹" + totalPrice + "</td></tr>");
                            out.println("<tr><th>Deposit</th><td>₹" + deposit + "(Refundable)</td></tr>");
                            out.println("<tr><th>Delivery Address</th><td>" + address + "</td></tr>");
                            out.println("<tr><th>Payment Method</th><td>" + paymentMethod + "</td></tr>");
                            out.println("</table>");

                            out.println("<div class='bill-footer'>");
                            out.println("<p>Thank you for choosing RentAnAttire!</p>");
                            out.println("<p>If you have any questions, please contact us at support@rentanattire.com</p>");
                            out.println("</div>");
                        }
                    } else {
                        out.println("<h2>User not found!</h2>");
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
    <a href="ProductMen.jsp" class="btn btn-back">Back to Products</a>

    <div class="footer">
        &copy; 2024 RentAnAttire. All rights reserved.
    </div>

</body>
</html>
