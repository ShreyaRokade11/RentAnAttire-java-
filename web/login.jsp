<%-- 
    Document   : login
    Created on : 5 Dec, 2024, 9:06:22 PM
    Author     : rokad
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <script>
            function redirect() {
                setTimeout(function() {
                    window.location.href = "index.html";
                }, 2000); // Redirect after 2 seconds
            }
        </script>
    </head>
    <body>
        <%
            // Retrieve form data
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String message = "";

            if (email != null && password != null && !email.isEmpty() && !password.isEmpty()) {
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                try {
                    // Load the driver
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    // Create a connection to the database
                    String url = "jdbc:mysql://localhost:3306/RentAnAttire";
                    String user = "root";
                    String pass = "1234";
                    con = DriverManager.getConnection(url, user, pass);

                    // Parameterized SQL query
                    String query = "SELECT * FROM users WHERE email = ? AND password = ?";
                    ps = con.prepareStatement(query);
                    ps.setString(1, email);
                    ps.setString(2, password);
session.setAttribute("email", email);
                    // Execute the query
                    rs = ps.executeQuery();

                    if (rs.next()) {
                        // Login success
                        message = "Successfully logged in! Redirecting to the home page...";
                        out.println("<script>redirect();</script>");
                    } else {
                        // Invalid login
                        message = "Invalid email or password. Please try again.";
                    }

                } catch (Exception e) {
                    message = "An error occurred: " + e.getMessage();
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (con != null) con.close();
                    } catch (SQLException e) {
                        message = "Error closing resources: " + e.getMessage();
                    }
                }
            } else {
                message = "Please provide both email and password.";
            }
        %>

        
        <p><%= message %></p>
    </body>
</html>
