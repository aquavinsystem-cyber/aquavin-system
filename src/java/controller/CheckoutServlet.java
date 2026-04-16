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
        
        // Kunin ang cart items gamit ang Generic List para iwas ClassCastException
        // Sinisiguro natin na List ito ng Maps para tugma sa cart.jsp logic
        List<?> rawCart = (List<?>) session.getAttribute("cartList");
        String total = request.getParameter("totalAmount");
        
        if (rawCart != null && !rawCart.isEmpty()) {
            //I-prepare ang orderList para sa Dashboard
            List<Map<String, String>> orderList = (List<Map<String, String>>) session.getAttribute("myOrders");
            if (orderList == null) {
                orderList = new ArrayList<>();
            }

            // I-format ang data para sa Dashboard
            Map<String, String> newOrder = new HashMap<>();
            
            // Random or Sequential ID
            String orderId = "ORD-" + ( 0 + orderList.size());
            String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
            
            newOrder.put("id", orderId);
            newOrder.put("date", currentDate);
            newOrder.put("qty", String.valueOf(rawCart.size())); 
            newOrder.put("total", "₱" + (total != null ? total : "0.00"));
            newOrder.put("status", "Processing");

            // Idagdag ang bagong order sa unahan ng list
            orderList.add(0, newOrder);
            session.setAttribute("myOrders", orderList);

           
            // Important ito para hindi mag-double order ang user
            session.removeAttribute("cartList");

            // Redirect sa Dashboard na may success status
            response.sendRedirect("dashboard.jsp?order=success");
        } else {
            // Kung aksidenteng na-refresh o walang laman ang cart
            response.sendRedirect("cart.jsp?error=empty");
        }
    }
}