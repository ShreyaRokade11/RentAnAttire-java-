<%-- 
    Document   : logout
    Created on : 15 Jan, 2025, 8:21:10 PM
    Author     : rokad
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logout | RentAnAttire</title>
    <script>
        function redirect() {
            setTimeout(function() {
                window.location.href = "login.html"; // Redirect to login page after 3 seconds
            }, 2000); // 2 seconds delay
        }
    </script>
</head>
<body>
    <%
        // Invalidate the session to log the user out
        session.invalidate();
    %>

    <h2>You have been successfully logged out.</h2>
    <p>You will be redirected to the login page shortly.</p>

    <script>
        redirect(); // Trigger the redirect after logout
    </script>
</body>
</html>
