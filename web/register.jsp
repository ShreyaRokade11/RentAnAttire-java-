<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registration Page</title>
    </head>
    <body>
        <%
            // Retrieving form data
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String mobile = request.getParameter("mobile");
            String password = request.getParameter("password");
            String confirmpassword = request.getParameter("confirmpassword");

            // Validate password and confirm password match
            if (!password.equals(confirmpassword)) {
                out.print("Passwords do not match!");
                return; // Exit if passwords don't match
            }

            try {
                // Load the driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Create a connection to the database
                String url = "jdbc:mysql://localhost:3306/RentAnAttire";
                String user = "root";
                String pass = "1234";
                Connection con = DriverManager.getConnection(url, user, pass);

                // Prepare the SQL query
                String sql = "INSERT INTO users (name, email, mobile, password) VALUES (?, ?, ?, ?)";
                PreparedStatement ps = con.prepareStatement(sql);

                // Set parameters
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, mobile);
                ps.setString(4, password);

                // Execute the query
                int cnt = ps.executeUpdate();

                if (cnt > 0) {
                    out.print("Thank you for registering!");
                } else {
                    out.print("Registration failed, please try again.");
                }

                // Close the connection
                con.close();
            } catch (Exception e) {
                out.print("An error occurred: " + e.getMessage());
            }
        %>
    </body>
</html>
