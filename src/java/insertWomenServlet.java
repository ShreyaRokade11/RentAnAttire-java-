import java.io.IOException; 
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.sql.*;

@WebServlet("/insertWomenServlet")
@MultipartConfig(maxFileSize = 16177216) // Max file size: 16MB
public class insertWomenServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Retrieve form fields
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        int categoryId = Integer.parseInt(request.getParameter("category"));
        String status = request.getParameter("status");
        String size = request.getParameter("size");
        int duration = Integer.parseInt(request.getParameter("duration"));
        double price = Double.parseDouble(request.getParameter("price"));
        double deposit = Double.parseDouble(request.getParameter("deposit"));

        // Get subcategory_id from form
        int subcategoryId = Integer.parseInt(request.getParameter("subcategory"));

        // Get the uploaded image
        Part imagePart = request.getPart("img");
        InputStream imageStream = imagePart.getInputStream();

        Connection con = null;
        PreparedStatement ps = null;
        int result = 0;
        
        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/RentAnAttire", "root", "1234");

            // SQL query to insert attire data into Mens table
            String query = "INSERT INTO Womens (name, description, price, status, size, duration, deposit, image, subcategory_id) "
                         + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

            ps = con.prepareStatement(query);

            // Set the parameters for the SQL query
            ps.setString(1, name);
            ps.setString(2, description);
            ps.setDouble(3, price);
            ps.setString(4, status);
            ps.setString(5, size);
            ps.setInt(6, duration);
            ps.setDouble(7, deposit);
            ps.setBlob(8, imageStream);
            ps.setInt(9, subcategoryId);  // Insert the subcategory ID

            // Execute the update
            result = ps.executeUpdate();

            if (result > 0) {
                // Redirect to success page
                response.sendRedirect("viewWomen.jsp");
            } else {
                // If insertion fails, redirect to an error page
                response.sendRedirect("index.html");
            }

        } catch (Exception e) {
            // Log the exception (you can use a logging framework here)
            out.println("Error: " + e.getMessage());
        } finally {
            // Close resources
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException se) {
                out.println("Error closing resources: " + se.getMessage());
            }
        }
    }
}
