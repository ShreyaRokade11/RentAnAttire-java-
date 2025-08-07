<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, java.io.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%@ page errorPage="errorPage.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Mens Attire | RentAnAttire</title>
    <link href="https://fonts.googleapis.com/css2?family=Raleway:wght@400;500;700&family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(45deg, #FF6F61, #f5f7fa);
            height: 100vh;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            background-size: 400% 400%;
            animation: gradientBackground 10s ease infinite;
            will-change: background-position;
        }

        @keyframes gradientBackground {
            0% {
                background-position: 0% 50%;
            }
            50% {
                background-position: 100% 50%;
            }
            100% {
                background-position: 0% 50%;
            }
        }

        .container {
            width: 100%;
            max-width: 700px;
            margin: 20px;
            background: #fff;
            padding: 35px 45px;
            border-radius: 15px;
            box-shadow: 0 15px 45px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease-in-out;
            position: relative;
            overflow: hidden;
        }

        .container:hover {
            transform: scale(1.05);
        }

        .container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('https://www.transparenttextures.com/patterns/sigma.png');
            background-size: 200px 200px;
            opacity: 0.1;
            pointer-events: none;
        }

        h1 {
            font-size: 32px;
            font-weight: 700;
            color: #333;
            text-align: center;
            margin-bottom: 30px;
            letter-spacing: 1px;
        }

        form {
            margin-top: 20px;
        }

        label {
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 8px;
            display: block;
            color: #444;
            transition: color 0.3s ease;
        }

        input[type="number"] {
            width: 100%;
            padding: 15px;
            margin-bottom: 20px;
            border: 2px solid #ddd;
            border-radius: 10px;
            font-size: 14px;
            color: #333;
            background-color: #f9f9f9;
            box-sizing: border-box;
            transition: all 0.3s ease;
        }

        input[type="number"]:focus {
            border-color: #FF6F61;
            box-shadow: 0 0 10px rgba(255, 111, 97, 0.4);
            outline: none;
        }

        button {
            width: 100%;
            padding: 15px;
            background: #FF6F61;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            color: white;
            cursor: pointer;
            transition: background 0.3s, transform 0.3s;
        }

        button:hover {
            background: #e05b4f;
            transform: translateY(-3px);
        }

        .form-footer {
            font-size: 13px;
            color: #777;
            text-align: center;
            margin-top: 20px;
        }

        .form-footer a {
            color: #FF6F61;
            text-decoration: none;
            font-weight: 600;
        }

        .form-footer a:hover {
            text-decoration: underline;
        }

        #message {
            margin-top: 20px;
            font-size: 14px;
            text-align: center;
            display: none;
        }

        #message.success {
            color: green;
        }

        #message.error {
            color: red;
        }

    </style>
</head>
<body>

<%
    String url = "jdbc:mysql://localhost:3306/RentAnAttire"; 
    String username = "root"; 
    String password = "1234"; 
    Connection con = null;
    PreparedStatement pstmt = null;

    String id = request.getParameter("id");
    String message = "";

    if (id != null && !id.isEmpty()) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, username, password);

            // Delete query to remove attire from Mens table
            String deleteQuery = "DELETE FROM Mens WHERE id = ?";
            pstmt = con.prepareStatement(deleteQuery);
            pstmt.setInt(1, Integer.parseInt(id));

            int result = pstmt.executeUpdate();

            if (result > 0) {
                message = "Attire successfully deleted.";
            } else {
                message = "Attire not found or could not be deleted.";
            }
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        } finally {
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        }
    } else {
        message = "Invalid attire ID.";
    }
%>

<div class="container">
    <h1>Delete Attire</h1>
    <form action="deleteattireServlet" method="post" onsubmit="return validateForm();">
        <label for="id">Enter Attire ID to Delete</label>
        <input type="number" name="id" id="id" placeholder="Attire ID" required aria-label="Enter Attire ID">
        <button type="submit">Delete Attire</button>
    </form>

    <div id="message" class="<%= (message.contains("successfully")) ? "success" : "error" %>">
        <%= message %>
    </div>

    <div class="form-footer">
        <p><strong>Warning:</strong> Ensure you enter the correct ID. This action is <span style="color: #FF6F61; font-weight: bold;">irreversible</span>.</p>
    </div>
</div>

<script>
    function validateForm() {
        const id = document.getElementById('id').value;
        const message = document.getElementById('message');
        if (isNaN(id) || id <= 0) {
            message.textContent = 'Please enter a valid Attire ID.';
            message.className = 'error';
            message.style.display = 'block';
            return false;
        }
        message.style.display = 'none';
        return true;
    }
</script>

</body>
</html>
