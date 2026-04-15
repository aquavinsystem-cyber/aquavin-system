package controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
   // Sa loob ng doPost method:
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    HttpSession session = request.getSession();

    // 1. Kunin ang listahan ng orders sa session. Kung wala pa, gumawa ng bago.
    ArrayList<Map<String, String>> orderList = (ArrayList<Map<String, String>>) session.getAttribute("myOrders");
    if (orderList == null) {
        orderList = new ArrayList<>();
    }

    // 2. Kunin ang data mula sa form
    String typeValue = request.getParameter("container");
    String qty = request.getParameter("quantity");
    String containerName = typeValue.equals("25") ? "Round" : typeValue.equals("30") ? "Slim" : "Both";
    double price = Double.parseDouble(typeValue) * Integer.parseInt(qty);

    // 3. I-save sa isang Map (isang row ng order)
    Map<String, String> newOrder = new HashMap<>();
  // BURAHIN MO 'TO (Line 34 sa screenshot):
// newOrder.id = "#AV-" + (int)(Math.random() * 9000 + 1000); 

// DAPAT GANITO LANG (Line 35 pababa):
newOrder.put("id", "#AV-" + (int)(Math.random() * 9000 + 1000));
newOrder.put("type", containerName);
newOrder.put("qty", qty);
newOrder.put("total", "₱" + String.format("%.2f", price));
newOrder.put("status", "Processing");
newOrder.put("date", "April 1, 2026");

    // 4. I-add yung bagong order sa listahan
    orderList.add(0, newOrder); // '0' para laging nasa taas yung pinakabago

    // 5. I-save ulit yung updated na listahan sa session
    session.setAttribute("myOrders", orderList);

    response.sendRedirect("dashboard.jsp");
}
}