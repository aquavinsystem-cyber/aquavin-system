package controller;

import com.aquavin.models.User;
import com.aquavin.util.DataStore;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/UpdatePasswordServlet")
public class UpdatePasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        DataStore ds = DataStore.getInstance();
        
        // 1. Kunin ang bagong password mula sa form
        String newPassword = request.getParameter("newPassword");
        
        // 2. Kunin ang email na itinabi natin sa session kanina
        String resetEmail = (String) session.getAttribute("resetEmail");

        // DEBUG: Makikita mo ito sa baba ng NetBeans (Output Tab)
        System.out.println("--- Update Password Debug ---");
        System.out.println("Email from Session: " + resetEmail);
        System.out.println("New Password received: " + (newPassword != null ? "Yes" : "No"));

        if (resetEmail != null && newPassword != null && !newPassword.isEmpty()) {
            boolean updated = false;

            // 3. Hanapin ang user sa Mock DataStore list
            for (User u : ds.users) {
                if (u.email != null && u.email.equalsIgnoreCase(resetEmail.trim())) {
                    u.password = newPassword; // I-update ang password sa memory
                    updated = true;
                    System.out.println("SUCCESS: Password updated for user: " + u.username);
                    break;
                }
            }

            if (updated) {
                // 4. Linisin ang temporary session data
                session.removeAttribute("generatedOTP");
                session.removeAttribute("resetEmail");
                session.removeAttribute("otpVerified");
                
                // 5. REDIRECT SA LOGIN
                System.out.println("Redirecting to login.jsp...");
                response.sendRedirect("login.jsp?reset=success");
                return; 
            } else {
                System.out.println("FAILED: Email not found in DataStore.");
            }
        } else {
            System.out.println("FAILED: Missing session email or password input.");
        }
        
        // Pag may error, balik sa forgot page para mag-request uli ng OTP
        response.sendRedirect("forgot.jsp?error=session_expired");
    }
}