package controller;

import com.aquavin.models.User;
import com.aquavin.util.DataStore;
import java.io.IOException;
import java.util.Properties;
import java.util.Random;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String emailTo = request.getParameter("email"); 
        HttpSession session = request.getSession();

        // LOG: Check kung nakukuha ang email mula sa form
        System.out.println("--- Forgot Password Started ---");
        System.out.println("Email Input: " + emailTo);

        // 1. DATASTORE CHECK
        DataStore ds = DataStore.getInstance();
        User foundUser = ds.findUserByEmail(emailTo);

        if (foundUser == null) {
            System.out.println("Result: Email not found in DataStore.");
            response.sendRedirect("forgot.jsp?error=not_registered");
            return;
        }

        System.out.println("Result: User found! Generating OTP...");

        // 2. Generate 6-Digit OTP
        Random rand = new Random();
        int otp = 100000 + rand.nextInt(900000);

        // 3. I-save sa Session
        session.setAttribute("generatedOTP", String.valueOf(otp));
        session.setAttribute("resetEmail", emailTo);
        session.setAttribute("resetUsername", foundUser.username);

        // --- GMAIL SMTP CONFIGURATION ---
        final String fromEmail = "aquavinsystem@gmail.com"; 
        final String appPassword = "mxckzdkhturiwyss"; 

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2"); 
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

        Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, appPassword);
            }
        });

        try {
            System.out.println("Attempting to send email via Gmail SMTP...");
            
            Message message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(emailTo));
            message.setSubject("AquaVin System | Password Reset OTP");
            
            String emailContent = "<div style='font-family: sans-serif; border: 1px solid #e2e8f0; padding: 30px; border-radius: 12px; max-width: 500px; margin: auto;'>"
                    + "<h2 style='color: #1e293b; text-align: center;'>AquaVin Password Reset</h2>"
                    + "<p style='color: #64748b;'>Hello <strong>" + foundUser.fullName + "</strong>,</p>"
                    + "<p style='color: #64748b;'>Use the code below to reset your password:</p>"
                    + "<div style='background: #f8fafc; padding: 20px; border-radius: 8px; text-align: center; margin: 20px 0;'>"
                    + "<span style='font-size: 32px; font-weight: bold; color: #3b82f6; letter-spacing: 8px;'>" + otp + "</span>"
                    + "</div>"
                    + "</div>";
            
            message.setContent(emailContent, "text/html");

            // ITO ANG CRITICAL PART
            Transport.send(message);
            
            System.out.println("Email sent successfully! Redirecting...");
            response.sendRedirect("verify_otp.jsp");

        } catch (MessagingException e) {
            System.out.println("MAIL ERROR: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("forgot.jsp?error=mail_failed");
        }
    }
}