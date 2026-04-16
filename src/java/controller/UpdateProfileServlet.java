package controller;

import com.aquavin.models.User;
import com.aquavin.util.DataStore;
import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/UpdateProfileServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class UpdateProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        DataStore ds = DataStore.getInstance();
        
        // Siguraduhin na 'userLogin' ang ginamit mo sa LoginServlet
        String currentLogin = (String) session.getAttribute("userLogin");
        
        String newName = request.getParameter("userName");
        String newAddress = request.getParameter("userAddress");
        String newPhone = request.getParameter("userPhone");
        String newEmail = request.getParameter("userEmail");

        if (currentLogin != null) {
            User u = ds.findUserByUsername(currentLogin);

            if (u != null) {
                // Update Text Data
                u.fullName = newName;
                u.address = newAddress;
                u.contact = newPhone;
                u.email = newEmail;
                
                // PICTURE LOGIC
                try {
                    Part filePart = request.getPart("profilePic"); 
                    if (filePart != null && filePart.getSize() > 0) {
                        String fileName = filePart.getSubmittedFileName();
                        
                        // Kunin ang path kung saan talaga naka-store ang images
                        String uploadPath = getServletContext().getRealPath("/") + "uploads";
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }
                        
                        String fullPath = uploadPath + File.separator + fileName;
                        filePart.write(fullPath);
                        
                        // I-SAVE SA DATASTORE (Ito ang importante para sa logout/login)
                        u.setProfilePic(fileName); 
                        
                        // I-SAVE SA SESSION (Para sa dashboard/profile view agad)
                        session.setAttribute("userPic", fileName);
                        
                        System.out.println("DEBUG: File saved to: " + fullPath);
                    }
                } catch (Exception e) {
                    System.out.println("DEBUG: Error uploading file: " + e.getMessage());
                }

                // Sync Session Attributes
                session.setAttribute("userName", u.fullName);
                session.setAttribute("userAddress", u.address);
                session.setAttribute("userPhone", u.contact);
                session.setAttribute("userEmail", u.email);
                
                System.out.println("DEBUG: User " + currentLogin + " updated. Pic: " + u.getProfilePic());
                
                response.sendRedirect("profile.jsp?status=success");
            } else {
                response.sendRedirect("profile.jsp?error=notfound");
            }
        } else {
            response.sendRedirect("login.jsp");
        }
    }
}