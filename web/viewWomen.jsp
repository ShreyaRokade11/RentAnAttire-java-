<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View | RentAnAttire</title>

    <style>
        /* Body and general styles */
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

        /* Button group at the top */
        .button-group {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin: 20px 0;
        }

        .button-group a {
            padding: 12px 25px;
            background: #ff6b6b;
            color: white;
            text-decoration: none;
            font-size: 14px;
            font-weight: bold;
            border-radius: 25px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease;
        }

        .button-group a:hover {
            transform: scale(1.05);
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

        /* Image preview styles */
        .image-preview {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 50%;
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

        .btn-edit {
            background: #28a745;
        }

        .btn-edit:hover {
            background: #218838;
        }

        .btn-delete {
            background: #dc3545;
        }

        .btn-delete:hover {
            background: #c82333;
        }

        /* Custom Modal (Delete Confirmation) Styles */
        .modal {
            display: none; /* Hidden by default */
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4); /* Black with opacity */
            padding-top: 60px;
        }

        .modal-content {
            background-color: #fff;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 400px;
            border-radius: 10px;
            text-align: center;
        }

        .modal-header {
            font-size: 24px;
            color: #ff6b6b;
            margin-bottom: 20px;
        }

        .modal-footer {
            margin-top: 20px;
        }

        .modal-btn {
            padding: 10px 20px;
            background-color: #ff6b6b;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .modal-btn:hover {
            background-color: #ff4b4b;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>View Women's Attires</h1>

    <!-- Button group -->
    <div class="button-group">
        <a href="insertWomen.jsp">Add New Attire</a>
        <a href="UpdateWomenAttire.jsp">Update Attire</a>
        <a href="deleteWomen.jsp">Delete Attire</a>
    </div>

    <!-- Search Bar -->
    <input type="text" class="search-bar" placeholder="Search for attire..." onkeyup="searchAttires()">

    <!-- Table -->
    <table id="attiresTable">
        <thead>
            <tr>
                <th>ID</th>
                <th>Image</th>
                <th>Name</th>
                <th>Price</th>
                <th>Status</th>
                <th>Size</th>
                <th>Duration</th>
                <th>Deposit</th>
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
                    
                    String query = "SELECT id, name, description, price, status, size, duration, deposit, image " +
                                   "FROM Womens";
                    rs = stmt.executeQuery(query);

                    while (rs.next()) {
                        int id = rs.getInt("id");
                        Blob imageBlob = rs.getBlob("image");
                        byte[] imageBytes = imageBlob.getBytes(1, (int) imageBlob.length());
                        String name = rs.getString("name");
                        double price = rs.getDouble("price");
                        String status = rs.getString("status");
                        String size = rs.getString("size");
                        int duration = rs.getInt("duration");
                        double deposit = rs.getDouble("deposit");
            %>
                <tr>
                    <td><%= id %></td>
                    <td><img src="data:image/jpeg;base64,<%= javax.xml.bind.DatatypeConverter.printBase64Binary(imageBytes) %>" alt="<%= name %>" class="image-preview"></td>
                    <td><%= name %></td>
                    <td>$<%= price %></td>
                    <td><%= status %></td>
                    <td><%= size %></td>
                    <td><%= duration %> days</td>
                    <td>$<%= deposit %></td>
                    <td>
                        <a href="UpdateWomenAttire.jsp?id=<%= id %>" class="action-btn btn-edit">Edit</a>
                        <a href="javascript:void(0);" class="action-btn btn-delete" onclick="confirmDelete(<%= id %>)">Delete</a>
                    </td>
                </tr>
            <% 
                    }
                } catch (Exception e) {
                    // Error handling can be added here
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (con != null) con.close();
                }
            %>
        </tbody>
    </table>
</div>

<!-- Modal (Delete Confirmation) -->
<div id="deleteModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">Are you sure you want to delete this attire?</div>
        <div class="modal-footer">
            <button class="modal-btn" id="confirmDeleteBtn">Yes</button>
            <button class="modal-btn" onclick="closeModal()">No</button>
        </div>
    </div>
</div>

<script>
// JavaScript for Delete Confirmation
let deleteId = null;

function confirmDelete(id) {
    deleteId = id;
    document.getElementById("deleteModal").style.display = "block";
}

function closeModal() {
    document.getElementById("deleteModal").style.display = "none";
}

document.getElementById("confirmDeleteBtn").addEventListener("click", function() {
    if (deleteId != null) {
        // Redirect to delete action (replace with actual delete functionality)
        window.location.href = "deleteWomen.jsp?id=" + deleteId;
    }
});

// Search function
function searchAttires() {
    let input = document.querySelector(".search-bar").value.toLowerCase();
    let rows = document.querySelectorAll("#attiresTable tbody tr");
    rows.forEach(row => {
        let name = row.cells[2].textContent.toLowerCase();
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
