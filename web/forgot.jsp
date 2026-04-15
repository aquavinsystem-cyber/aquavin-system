<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/logos.jpg">
<title>AquaVin | Forgot Password</title>
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
            width: 800px; /* Same width as Login */
            height: 480px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            overflow: hidden;
            animation: fadeIn 0.8s ease-out;
        }

        /* LEFT PANEL (Brand/Logo Side) */
        .brand-panel {
            flex: 1;
            background: #f8fafc;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            border-right: 1px solid #f1f5f9;
            padding: 20px;
        }

        .brand-panel img {
            width: 400px; /* Pinalaki para kitang-kita */
            height: auto;
            mix-blend-mode: multiply; /* Transparent hack */
            margin-bottom: 10px;
        }

      

        /* RIGHT PANEL (Form Side) */
        .form-panel {
            flex: 1.2;
            padding: 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            text-align: center;
        }

        .form-panel h2 { 
            font-size: 2rem; 
            color: #1e293b; 
            margin-bottom: 10px; 
        }

        .form-panel p.subtitle { 
            color: #64748b; 
            margin-bottom: 25px; 
            font-size: 0.95rem; 
            line-height: 1.4;
        }

        /* Error & Info Messages */
        .msg {
            padding: 10px;
            border-radius: 8px;
            font-size: 0.8rem;
            margin-bottom: 15px;
            border: 1px solid;
        }
        .error { background: #fef2f2; color: #ef4444; border-color: #fee2e2; }
        .info { background: #f0f9ff; color: #0ea5e9; border-color: #e0f2fe; }

        input {
            width: 100%;
            padding: 14px;
            margin-bottom: 15px;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            outline: none;
            background: #fdfdfd;
            transition: 0.3s;
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
        }
        .btn-action:hover { 
            background: #2563eb; 
            transform: translateY(-1px);
        }
        .btn-action:disabled { background: #94a3b8; cursor: not-allowed; }

        .footer-link { 
            margin-top: 25px; 
            font-size: 0.9rem; 
            color: #64748b; 
        }
        .footer-link a { 
            color: #3b82f6; 
            text-decoration: none; 
            font-weight: bold; 
        }
        .footer-link a:hover { text-decoration: underline; }

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
                <img src="${pageContext.request.contextPath}/images/forgot.png" alt="AquaVin Logo">
                
            </div>

            <div class="form-panel">
                <h2>Forgot Password?</h2>
                <p class="subtitle">Enter your email and we'll send you a 6-digit OTP to reset your password.</p>
                
                <%-- Error & Success Notifications --%>
                <% 
                    String err = request.getParameter("error");
                    if("not_registered".equals(err)) { %>
                        <div class="msg error">❌ Email not found. Please register first.</div>
                <%  } else if("mail_failed".equals(err)) { %>
                        <div class="msg error">❌ Failed to send OTP. Check internet.</div>
                <%  } else if("session_expired".equals(err)) { %>
                        <div class="msg info">ℹ️ Session expired. Please request a new OTP.</div>
                <%  } %>

                <form action="${pageContext.request.contextPath}/ForgotPasswordServlet" method="POST" id="forgotForm">
                    <input type="email" name="email" id="emailInput" required placeholder="Enter your email">
                    <button type="submit" class="btn-action" id="sendBtn">Send OTP</button>
                </form>
                
                <p class="footer-link">
                    Remembered it? <a href="login.jsp">Back to Login</a>
                </p>
            </div>

        </div>
    </div>

    <script>
        // Loading state para iwas double click habang nag-sesend ng email
        document.getElementById("forgotForm").onsubmit = function() {
            var btn = document.getElementById("sendBtn");
            btn.disabled = true;
            btn.innerText = "Sending OTP... Please wait";
        };
    </script>
</body>
</html>