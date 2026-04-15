<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // KONEKSYON: Kunin ang data na galing sa Register/Login Session
    String currentName = (String) session.getAttribute("userName");
    String currentAddress = (String) session.getAttribute("userAddress");
    String currentPhone = (String) session.getAttribute("userPhone");

    if (currentName == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/logos.jpg">
<title>AquaVin | Edit Profile</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', sans-serif; }
        body { background: #f8fafc; display: flex; justify-content: center; align-items: center; height: 100vh; }
        .edit-container { background: white; padding: 35px; border-radius: 15px; box-shadow: 0 10px 25px rgba(0,0,0,0.05); width: 100%; max-width: 400px; }
        h2 { color: #1e293b; margin-bottom: 20px; text-align: center; }
        .input-group { margin-bottom: 15px; }
        label { font-size: 0.8rem; color: #64748b; font-weight: bold; display: block; margin-bottom: 5px; }
        input { width: 100%; padding: 12px; border: 1px solid #e2e8f0; border-radius: 8px; outline: none; font-size: 1rem; }
        input:focus { border-color: #3b82f6; border-width: 2px; }
        .btn-save { width: 100%; padding: 14px; background: #3b82f6; color: white; border: none; border-radius: 8px; font-weight: bold; cursor: pointer; margin-top: 10px; }
        .btn-cancel { display: block; text-align: center; margin-top: 15px; color: #64748b; text-decoration: none; font-size: 0.9rem; }
    </style>
</head>
<body>
    <div class="edit-container">
        <h2>Update Details</h2>
        <form action="UpdateProfileServlet" method="POST">
            <div class="input-group">
                <label>FULL NAME</label>
                <input type="text" name="fullname" value="<%= currentName %>" required>
            </div>
            <div class="input-group">
                <label>ADDRESS</label>
                <input type="text" name="address" value="<%= currentAddress %>" required>
            </div>
            <div class="input-group">
                <label>CONTACT NUMBER</label>
                <input type="text" name="phone" value="<%= (currentPhone != null) ? currentPhone : "" %>" 
                       maxlength="11" oninput="this.value = this.value.replace(/[^0-9]/g, '');" required>
            </div>
            <button type="submit" class="btn-save">Save Changes</button>
            <a href="profile.jsp" class="btn-cancel">Cancel</a>
        </form>
    </div>
</body>
</html>