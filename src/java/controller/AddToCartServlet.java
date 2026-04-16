package controller;

import java.io.IOException;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        try {
            //Kunin ang pinasa mula sa order.jsp
            String name = request.getParameter("prodName");
            String priceStr = request.getParameter("prodPrice");
            String qtyStr = request.getParameter("qty");
            
            // DITO MALALAMAN KUNG BUY NOW O ADD TO CART
            String actionType = request.getParameter("actionType"); 

            // Pag walang data, balik sa order page
            if (name == null || priceStr == null || qtyStr == null) {
                response.sendRedirect("order.jsp");
                return;
            }

            double price = Double.parseDouble(priceStr);
            int qty = Integer.parseInt(qtyStr);
            
            // Gumawa ng map para sa item
            Map<String, Object> item = new HashMap<>();
            item.put("name", name);
            item.put("price", price);
            item.put("qty", qty);
            item.put("subtotal", price * qty);
            
            // Kunin ang cart mula sa session.
            List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cartList");
            if (cart == null) {
                cart = new ArrayList<>();
            }
            
            // Idagdag ang item sa listahan
            cart.add(item);
            
            // I-save pabalik sa session
            session.setAttribute("cartList", cart);
            
            //BAGONG LOGIC PARA SA REDIRECT
            if ("buy".equals(actionType)) {
                // Pag "Buy Now", rekta agad sa Cart Page
                response.sendRedirect("cart.jsp");
            } else {
                // Pag "Add to Cart", balik sa Order Page na may success message
                response.sendRedirect("order.jsp?status=added");
            }

        } catch (NumberFormatException e) {
            // Pag nag-error ang numbers, balik sa order
            response.sendRedirect("order.jsp?error=invalidInput");
        }
    }
}