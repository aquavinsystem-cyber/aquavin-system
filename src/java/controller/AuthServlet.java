package controller;

import com.aquavin.models.User;
import com.aquavin.util.DataStore;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AuthServlet")
public class AuthServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        DataStore ds = DataStore.getInstance();
        HttpSession session = request.getSession(true);

        if ("register".equals(action)) {
            // 1. Kunin ang lahat ng data kasama ang EMAIL
            String fn = request.getParameter("fullName");
            String ad = request.getParameter("address");
            String cn = request.getParameter("contact");
            String un = request.getParameter("username");
            String pw = request.getParameter("password");
            String em = request.getParameter("email"); // Dinagdag ito

            // 2. I-save sa DataStore (Dapat 6 parameters na ito para mawala ang error)
            User newUser = new User(fn, ad, cn, un, pw, em);
            ds.users.add(newUser);
            
            // 3. Auto-login after registration - Isave ang kumpletong info sa session
            session.setAttribute("userName", fn);
            session.setAttribute("userAddress", ad);
            session.setAttribute("userPhone", cn);
            session.setAttribute("userEmail", em);
            session.setAttribute("userLogin", un);
            
            response.sendRedirect("dashboard.jsp");
            return; 

        } else {
            // LOGIN LOGIC
            String un = request.getParameter("username");
            String pw = request.getParameter("password");
            
            User foundUser = null;
            for (User u : ds.users) {
                // Check username and password
                if (u.username != null && u.username.equals(un) && u.password != null && u.password.equals(pw)) {
                    foundUser = u;
                    break; 
                }
            }

            if (foundUser != null) {
                // ETO YUNG IMPORTANTE: Isusulat lahat ng data ng user sa session
                session.setAttribute("userName", foundUser.fullName); 
                session.setAttribute("userAddress", foundUser.address); 
                session.setAttribute("userPhone", foundUser.contact);
                session.setAttribute("userEmail", foundUser.email); // Para sa Forgot Password/Profile
                session.setAttribute("userLogin", foundUser.username);
                
                response.sendRedirect("dashboard.jsp");
                return; 
            } else {
                response.sendRedirect("login.jsp?error=invalid");
                return;
            }
        }
    }
}