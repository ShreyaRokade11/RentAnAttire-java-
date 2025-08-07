<%-- 
    Document   : AddToCart
    Created on : 22 Jan, 2025, 12:20:23 PM
    Author     : rokad

Add TO Cart Logic
--%>

<%@ page import="java.util.*" %>
<%
    String id = request.getParameter("id");
    String description = request.getParameter("description");
    String price = request.getParameter("price");
    String size = request.getParameter("size");

    // Retrieve cart from session
    List<Map<String, String>> cart = (List<Map<String, String>>) session.getAttribute("cart");
    if (cart == null) {
        cart = new ArrayList<>();
    }

    // Create a map for the new item
    Map<String, String> item = new HashMap<>();
    item.put("id", id);
    item.put("description", description);
    item.put("price", price);
    item.put("size", size);

    // Add the new item to the cart
    cart.add(item);

    // Save the updated cart back to the session
    session.setAttribute("cart", cart);

    response.sendRedirect("cart.jsp");
%>
