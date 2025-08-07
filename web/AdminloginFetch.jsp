<%@ page import="java.sql.*" %>
<%
    // Get form data
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    // Database connection variables
    Connection conn = null;
    PreparedStatement ps = null;
    int result = 0;

    try {
        // Step 1: Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Step 2: Establish the connection
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/RentAnAttire", "root", "1234");

        // Step 3: Create the SQL query
        String sql = "INSERT INTO admin (email, password) VALUES (?, ?)";

        // Step 4: Create PreparedStatement and set parameters
        ps = conn.prepareStatement(sql);
        ps.setString(1, email);
        ps.setString(2, password);

        // Step 5: Execute the query
        result = ps.executeUpdate();

        // Step 6: Check if insertion is successful
        if (result > 0) {
            out.println("login  successfully ");
             // Redirect to the admin panel if login is successful
  
        response.sendRedirect("AdminPannel.html"); // Redirect to the admin panel
    
        } else {
            out.println("Failed to insert admin login details.");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error occurred: " + e.getMessage());
    } finally {
        // Close resources
        try {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
    }
    
%>
