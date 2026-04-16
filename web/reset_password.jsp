<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Security check: Dapat verified ang OTP bago makapasok dito
    Boolean verified = (Boolean) session.getAttribute("otpVerified");
    if (verified == null || !verified) {
        response.sendRedirect("verify_otp.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
     <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/logos.jpg">
<title>AquaVin | New Password</title>
    <style>
        /* Shared Styles */
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', sans-serif; }
        body, html { height: 100%; width: 100%; overflow: hidden; }

        .wrapper {
            height: 100vh;
            width: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(rgba(255, 255, 255, 0.7), rgba(255, 255, 255, 0.7)), 
                        url('images/water-bg.jpg'); 
            background-size: cover;
            background-position: center;
        }

        /* CONTAINER PARA SA SPLIT PANEL */
        .auth-container {
            display: flex;
            background: white;
            width: 800px; 
            min-height: 520px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            overflow: hidden;
            animation: fadeIn 0.8s ease-out;
        }

        /* LEFT PANEL (Branding) */
        .brand-panel {
            flex: 1;
            background: #f8fafc;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            border-right: 1px solid #f1f5f9;
            padding: 30px;
        }

        .brand-panel img {
            width: 300px;
            height: auto;
            mix-blend-mode: multiply;
            margin-bottom: 10px;
        }


        /* RIGHT PANEL (Form) */
        .form-panel {
            flex: 1.2;
            padding: 40px 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .form-header { text-align: center; margin-bottom: 25px; }
        .form-header h2 { font-size: 2rem; color: #1e293b; margin-bottom: 5px; }
        .form-header p { color: #64748b; font-size: 0.9rem; }

        .input-group { margin-bottom: 15px; }
        label { display: block; font-size: 0.85rem; font-weight: bold; color: #475569; margin-bottom: 5px; }
        
        input {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #cbd5e1;
            border-radius: 10px;
            outline: none;
            background: #fdfdfd;
            transition: 0.3s;
            font-size: 1rem;
        }
        
        input:focus { 
            border-color: #3b82f6; 
            background: white;
            box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.1); 
        }

        .btn-action {
            width: 100%;
            padding: 14px;
            background: #3b82f6;
            color: white;
            border: none;
            border-radius: 10px;
            font-weight: bold;
            font-size: 1rem;
            cursor: pointer;
            transition: 0.3s;
            margin-top: 10px;
        }
        
        .btn-action:hover { background: #2563eb; transform: translateY(-1px); }

        .error-msg {
            color: #ef4444;
            background: #fef2f2;
            padding: 10px;
            border-radius: 8px;
            font-size: 0.8rem;
            margin-top: 10px;
            display: none;
            text-align: center;
            border: 1px solid #fee2e2;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <div class="wrapper">
        <div class="auth-container">
            
            <div class="brand-panel">
                <img src="${pageContext.request.contextPath}/images/Newpass.png" alt="AquaVin Logo">
            </div>

            <div class="form-panel">
                <div class="form-header">
                    <h2>New Password</h2>
                    <p>Set a strong password for your account.</p>
                </div>

                <form action="UpdatePasswordServlet" method="POST" onsubmit="return validatePasswords()">
                    <div class="input-group">
                        <label>New Password</label>
                        <input type="password" name="newPassword" id="newPassword" required placeholder="••••••••"
                               pattern="^(?=.*[A-Z])(?=.*[0-9])(?=.*[@$!%*?&])[A-Za-z0-9@$!%*?&]{8,}$"
                               title="Must be 8+ chars, 1 Uppercase, 1 Number, 1 Special Char">
                    </div>

                    <div class="input-group">
                        <label>Confirm Password</label>
                        <input type="password" id="confirmPassword" required placeholder="••••••••">
                    </div>

                    <div id="matchError" class="error-msg">❌ Passwords do not match!</div>

                    <button type="submit" class="btn-action">Update Password</button>
                </form>
            </div>

        </div>
    </div>

    <script>
        function validatePasswords() {
            var pass = document.getElementById("newPassword").value;
            var confirm = document.getElementById("confirmPassword").value;
            var error = document.getElementById("matchError");

            if (pass !== confirm) {
                error.style.display = "block";
                return false;
            }
            error.style.display = "none";
            return true;
        }
    </script>
</body>
</html>