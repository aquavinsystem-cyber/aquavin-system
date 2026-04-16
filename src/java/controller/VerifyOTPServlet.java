package controller; // Siguraduhin na match ito sa package folder mo

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/VerifyOTPServlet")
public class VerifyOTPServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Kunin ang OTP na tinype ng user sa JSP form
        String userOTP = request.getParameter("userOTP");
        
        // Kunin ang session para makuha yung OTP na ginawa natin kanina
        HttpSession session = request.getSession();
        String systemOTP = (String) session.getAttribute("generatedOTP");

        // I-check kung nag-match sila
        if (userOTP != null && userOTP.equals(systemOTP)) {
            // TAMA ANG OTP!
            // Pwede nating i-set na "verified" na yung session
            session.setAttribute("otpVerified", true);
            
            // Lipat sa page para mag-set ng bagong password
            response.sendRedirect("reset_password.jsp");
        } else {
            // MALI ANG OTP
            // Balik sa verification page na may error message
            response.sendRedirect("verify_otp.jsp?error=invalid");
        }
    }
}