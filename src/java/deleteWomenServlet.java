import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import java.sql.*;

@WebServlet("/deleteWomenServlet")
public class deleteWomenServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Retrieve product ID to delete
        int id = Integer.parseInt(request.getParameter("id"));
        int result = 0;

        try {
            // Debugging log: Check the ID value received
            System.out.println("Received ID to delete: " + id);

            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/RentAnAttire", "root", "1234");

            // SQL query to delete attire by ID
            String query = "DELETE FROM attire WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, id);

            // Debugging log: Check if query was prepared successfully
            System.out.println("Executing delete query: " + query);

            // Execute the delete operation
            result = ps.executeUpdate();

            if (result > 0) {
                // Debugging log: Successful deletion
                System.out.println("Product deleted successfully!");

                // Pass success message to JSP
                request.setAttribute("message", "Product deleted successfully!");
                request.setAttribute("messageType", "success");

                // Redirect to view.jsp after successful deletion
                    response.sendRedirect("viewWomen.jsp");
            } else {
                // Debugging log: Product not found
                System.out.println("Product with ID " + id + " not found.");

                // Pass failure message to JSP
                request.setAttribute("message", "Failed to delete the product. Please try again.");
                request.setAttribute("messageType", "error");

                // Forward to deleteAttire.jsp for error message
                RequestDispatcher dispatcher = request.getRequestDispatcher("deleteAttire.jsp");
                dispatcher.forward(request, response);
            }

            con.close();
        } catch (Exception e) {
            // Handle exceptions and pass error message
            e.printStackTrace();  // Log the stack trace for more details
            request.setAttribute("message", "Error: " + e.getMessage());
            request.setAttribute("messageType", "error");

            // Forward to deleteAttire.jsp for error message
            RequestDispatcher dispatcher = request.getRequestDispatcher("viewWomen.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet to delete attire from the database by ID";
    }
}
