<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Rental Orders | RentAnAttire</title>

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #ff6b6b, #f9c4d2);
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 50px auto;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 12px 25px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        h1 {
            font-size: 28px;
            text-align: center;
            color: white;
            padding: 20px;
            background: #ff6b6b;
            margin: 0;
        }

        /* Search Bar */
        .search-bar {
            padding: 12px;
            margin: 20px 0;
            width: 100%;
            border-radius: 8px;
            border: 1px solid #ddd;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            font-size: 16px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        th, td {
            padding: 15px;
            text-align: center;
            border: 1px solid #ddd;
            font-size: 14px;
        }

        th {
            background: #ff6b6b;
            color: white;
            text-transform: uppercase;
            font-weight: 600;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #fff7f7;
        }

        .action-btn {
            padding: 8px 12px;
            font-size: 12px;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin: 0 5px;
            transition: background 0.3s ease;
        }

        .btn-accept {
            background: #28a745;
        }

        .btn-accept:hover {
            background: #218838;
        }

        .btn-cancel {
            background: #dc3545;
        }

        .btn-cancel:hover {
            background: #c82333;
        }

    </style>
</head>
<body>
    <%
    String message = request.getParameter("msg");
    if (message != null && !message.isEmpty()) {
%>
    <div style="background-color: #d4edda; color: #155724; padding: 10px; text-align: center; margin: 10px 0; border-radius: 5px;">
        <%= message %>
    </div>
<%
    }
%>


<div class="container">
    <h1>Your Rental Orders</h1>

    <!-- Search Bar -->
    <input type="text" class="search-bar" placeholder="Search for rental orders..." onkeyup="searchOrders()">

    <!-- Table -->
    <table id="ordersTable">
        <thead>
            <tr>
                <th>Order ID</th>
                <th>Product ID</th>
                <th>Size</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Address</th>
                <th>Total Price</th>
                <th>User ID</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
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
                    
                    String query = "SELECT * FROM Rentals"; // Get all rentals
                    rs = stmt.executeQuery(query);

                    while (rs.next()) {
                        int orderId = rs.getInt("id");
                        int productId = rs.getInt("product_id");
                        String size = rs.getString("size");
                        Date startDate = rs.getDate("start_date");
                        Date endDate = rs.getDate("end_date");
                        String address = rs.getString("address");
                        double totalPrice = rs.getDouble("total_price");
                        int userId = rs.getInt("user_id");
                        String status = rs.getString("status");
            %>
                <tr>
                    <td><%= orderId %></td>
                    <td><%= productId %></td>
                    <td><%= size %></td>
                    <td><%= startDate %></td>
                    <td><%= endDate %></td>
                    <td><%= address %></td>
                    <td>$<%= totalPrice %></td>
                    <td><%= userId %></td>
                    <td><%= status %></td>
                    <td>
                        <a href="acceptOrder.jsp?id=<%= orderId %>" class="action-btn btn-accept">Accept</a>
                        <a href="cancelOrder.jsp?id=<%= orderId %>" class="action-btn btn-cancel">Cancel</a>
                    </td>
                </tr>
            <% 
                    }
                } catch (Exception e) {
                    // Error handling can be added here
                    out.println("Error: " + e.getMessage());
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (con != null) con.close();
                }
            %>
        </tbody>
    </table>
</div>

<script>
// JavaScript for Search functionality
function searchOrders() {
    let input = document.querySelector(".search-bar").value.toLowerCase();
    let rows = document.querySelectorAll("#ordersTable tbody tr");
    rows.forEach(row => {
        let name = row.cells[1].textContent.toLowerCase();
        if (name.includes(input)) {
            row.style.display = "";
        } else {
            row.style.display = "none";
        }
    });
}
</script>

</body>
</html>
