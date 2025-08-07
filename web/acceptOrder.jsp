<%@ page import="java.sql.*" %>
<%
    String orderId = request.getParameter("id");

    if (orderId != null && !orderId.isEmpty()) {
        String url = "jdbc:mysql://localhost:3306/RentAnAttire";
        String username = "root";
        String password = "1234";
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, username, password);

            String updateQuery = "UPDATE Rentals SET status = 'Accepted' WHERE id = ?";
            pstmt = con.prepareStatement(updateQuery);
            pstmt.setInt(1, Integer.parseInt(orderId));
            int updated = pstmt.executeUpdate();

            if (updated > 0) {
                response.sendRedirect("ViewOrders.jsp?msg=Order Accepted Successfully");
            } else {
                response.sendRedirect("ViewOrders.jsp?msg=Order Acceptance Failed");
            }
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        } finally {
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        }
    } else {
        response.sendRedirect("viewOrders.jsp?msg=Invalid Order ID");
    }
%>
