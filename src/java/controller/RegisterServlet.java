package controller;

import com.aquavin.models.User; // Import dapat ang Model mo
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Kunin ang lahat ng data mula sa form (Dinagdag ang email)
        String fullname = request.getParameter("fullname");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        String email = request.getParameter("email"); // <--- Bagong input

        // --- VALIDATION RULES ---
        
        // Email Validation Pattern (Basic)
        String emailPattern = "^[A-Za-z0-9+_.-]+@(.+)$";
        
        // Password Pattern: 8+ chars, 1 Uppercase, 1 Number, 1 Special Character
        String passPattern = "^(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";
        
        // Validation Checks
        boolean isPhoneValid = (phone != null && phone.length() == 11 && phone.matches("[0-9]+"));
        boolean isPassValid = (pass != null && pass.matches(passPattern));
        boolean isEmailValid = (email != null && email.matches(emailPattern));

        if (isPhoneValid && isPassValid && isEmailValid) {
            
            // 2. Gawa ng bagong User Object (Base sa inayos nating User.java)
            User newUser = new User(fullname, address, phone, user, pass, email);
            
            // 3. I-save sa Session (Para sa immediate access)
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", newUser); // Mas malinis pag buong object ang nasa session
            session.setAttribute("userName", fullname);
            session.setAttribute("userAddress", address);
            session.setAttribute("userPhone", phone);  
            session.setAttribute("userEmail", email); // I-save rin ang email sa session
            session.setAttribute("userLogin", user);   
            
            /* 4. OPTIONAL: Dito mo dapat i-add sa MockDatabase list mo 
               Halimbawa: MockDatabase.users.add(newUser);
            */

            // Log para sa console
            System.out.println("New User Registered: " + user + " | Email: " + email);

            // Tuloy sa Dashboard
            response.sendRedirect("dashboard.jsp");
            return; 
            
        } else {
            // FAIL: Pag may mali, balik sa register page na may specific error
            String errorType = "invalid";
            if (!isEmailValid) errorType = "invalid_email";
            else if (!isPhoneValid) errorType = "invalid_phone";
            else if (!isPassValid) errorType = "weak_password";
            
            response.sendRedirect("register.jsp?error=" + errorType);
        }
    }
}