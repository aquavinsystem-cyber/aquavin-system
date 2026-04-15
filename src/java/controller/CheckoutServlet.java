package controller;

import java.io.IOException;
import java.util.*;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // 1. Kunin ang cart items gamit ang Generic List para iwas ClassCastException
        // Sinisiguro natin na List ito ng Maps para tugma sa cart.jsp logic
        List<?> rawCart = (List<?>) session.getAttribute("cartList");
        String total = request.getParameter("totalAmount");
        
        if (rawCart != null && !rawCart.isEmpty()) {
            // 2. I-prepare ang orderList para sa Dashboard
            // Gagamit tayo ng wildcard para iwas casting error kung galing sa session
            List<Map<String, String>> orderList = (List<Map<String, String>>) session.getAttribute("myOrders");
            if (orderList == null) {
                orderList = new ArrayList<>();
            }

            // 3. I-format ang data para sa Dashboard
            Map<String, String> newOrder = new HashMap<>();
            
            // Random or Sequential ID
            String orderId = "ORD-" + (1000 + orderList.size());
            String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
            
            newOrder.put("id", orderId);
            newOrder.put("date", currentDate);
            newOrder.put("qty", String.valueOf(rawCart.size())); 
            newOrder.put("total", "₱" + (total != null ? total : "0.00"));
            newOrder.put("status", "Processing");

            // 4. Idagdag ang bagong order sa unahan ng listahan
            orderList.add(0, newOrder);
            session.setAttribute("myOrders", orderList);

            // 5. LINISIN ANG CART
            // Importante ito para hindi mag-double order ang user
            session.removeAttribute("cartList");

            // 6. Redirect sa Dashboard na may success status
            response.sendRedirect("dashboard.jsp?order=success");
        } else {
            // Kung aksidenteng na-refresh o walang laman ang cart
            response.sendRedirect("cart.jsp?error=empty");
        }
    }
}