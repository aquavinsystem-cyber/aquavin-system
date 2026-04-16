package controller;

import com.aquavin.models.User;
import com.aquavin.util.DataStore;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String un = request.getParameter("username");
        String pw = request.getParameter("password");
        
        DataStore ds = DataStore.getInstance();
        
        // Hanapin ang user gamit ang helper method sa DataStore
        User foundUser = ds.findUserByUsername(un);

        // I-verify kung nahanap ang user at kung tama ang password
        if (foundUser != null && foundUser.password.equals(pw)) {
            HttpSession session = request.getSession();
            
            // I-load ang data mula sa User object (DataStore) patungong Session
            session.setAttribute("userName", foundUser.fullName);
            session.setAttribute("userAddress", foundUser.address);
            session.setAttribute("userPhone", foundUser.contact);
            session.setAttribute("userLogin", foundUser.username);
            session.setAttribute("userEmail", foundUser.email);
            
            // KUNIN ANG PICTURE - Dito tayo mag-fofocus
            String pic = foundUser.getProfilePic();
            
            // Kung biglang nag-null sa DataStore, lagyan natin ng default
            if (pic == null || pic.isEmpty()) {
                pic = "default-avatar.png"; 
            }
            
            session.setAttribute("userPic", pic);
            
            // Tingnan mo ito sa Output Window ng NetBeans pagka-login mo
            System.out.println("========== LOGIN DEBUG ==========");
            System.out.println("User: " + foundUser.username);
            System.out.println("Picture in DataStore: " + foundUser.profilePic);
            System.out.println("Picture in Session: " + pic);
            System.out.println("=================================");
            
            response.sendRedirect("dashboard.jsp");
        } else {
            System.out.println("DEBUG: Login failed for: " + un);
            response.sendRedirect("login.jsp?error=invalid");
        }
    }
}