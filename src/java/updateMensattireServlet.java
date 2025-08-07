import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class updateMensattireServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/RentAnAttire";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "1234";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Retrieve form data
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            String status = request.getParameter("status");
            String size = request.getParameter("size");
            int duration = Integer.parseInt(request.getParameter("duration"));
            double deposit = Double.parseDouble(request.getParameter("deposit"));

            // Retrieve image file
            Part filePart = request.getPart("img"); // Corrected field name
            InputStream imageStream = null;
            
            if (filePart != null && filePart.getSize() > 0) {
                imageStream = filePart.getInputStream();
            }

            // Establish database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // SQL update query
            String sql = "UPDATE Mens SET name=?, description=?, price=?, status=?, size=?, duration=?, deposit=?, image=? WHERE id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, description);
            pstmt.setDouble(3, price);
            pstmt.setString(4, status);
            pstmt.setString(5, size);
            pstmt.setInt(6, duration);
            pstmt.setDouble(7, deposit);
            
            // Set the image blob if it exists, otherwise set NULL
            if (imageStream != null) {
                pstmt.setBlob(8, imageStream);
            } else {
                pstmt.setNull(8, java.sql.Types.BLOB);
            }
            
            pstmt.setInt(9, id); // Set the attire ID for update condition (Corrected index to 9)

            // Execute update
            int rowsUpdated = pstmt.executeUpdate();

            // Redirect or forward based on update result
            if (rowsUpdated > 0) {
                request.setAttribute("message", "Attire updated successfully!");
                request.setAttribute("messageType", "success");
            } else {
                request.setAttribute("message", "Failed to update attire. ID not found.");
                request.setAttribute("messageType", "error");
            }

            // Redirecting to avoid form resubmission
            response.sendRedirect("viewMens.jsp");

         } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("message", "Error: " + ex.getMessage());
            request.setAttribute("messageType", "error");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
