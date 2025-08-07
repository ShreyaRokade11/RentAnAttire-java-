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

            String deleteQuery = "DELETE FROM Rentals WHERE id = ?";
            pstmt = con.prepareStatement(deleteQuery);
            pstmt.setInt(1, Integer.parseInt(orderId));
            int deleted = pstmt.executeUpdate();

            if (deleted > 0) {
                response.sendRedirect("ViewOrders.jsp?msg=Order Canceled Successfully");
            } else {
                response.sendRedirect("ViewOrders.jsp?msg=Order Cancellation Failed");
            }
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        } finally {
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        }
    } else {
        response.sendRedirect("ViewOrders.jsp?msg=Invalid Order ID");
    }
%>
