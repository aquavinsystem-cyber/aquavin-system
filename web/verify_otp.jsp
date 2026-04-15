<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
     <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/logos.jpg">
<title>AquaVin | Verify OTP</title>
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
            min-height: 450px;
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

        /* RIGHT PANEL (OTP Form) */
        .form-panel {
            flex: 1.2;
            padding: 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            text-align: center;
        }

        .form-panel h2 { font-size: 2.2rem; color: #1e293b; margin-bottom: 10px; }
        .form-panel p.subtitle { color: #64748b; margin-bottom: 25px; font-size: 0.95rem; }

        /* Error Style */
        .error-msg {
            color: #ef4444;
            background: #fef2f2;
            padding: 10px;
            border-radius: 8px;
            font-size: 0.85rem;
            margin-bottom: 20px;
            border: 1px solid #fee2e2;
        }

        /* OTP Input Styling */
        .otp-input {
            width: 100%;
            padding: 15px;
            margin-bottom: 20px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            outline: none;
            background: #fdfdfd;
            transition: 0.3s;
            font-size: 1.8rem;
            letter-spacing: 8px; /* Mas malaking space para sa 6 digits */
            text-align: center;
            font-weight: bold;
            color: #1e293b;
        }
        
        .otp-input:focus { 
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
                <img src="${pageContext.request.contextPath}/images/otp.png" alt="AquaVin Logo">
            </div>

            <div class="form-panel">
                <h2>Enter OTP</h2>
                <p class="subtitle">We sent a 6-digit code to your account. Please check your email.</p>
                
                <% if(request.getParameter("error") != null) { %>
                    <div class="error-msg">❌ Invalid OTP. Please try again.</div>
                <% } %>

                <form action="VerifyOTPServlet" method="POST">
                    <input type="text" 
                           name="userOTP" 
                           class="otp-input" 
                           maxlength="6" 
                           placeholder="000000" 
                           required
                           oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                    
                    <button type="submit" class="btn-action">Verify OTP</button>
                </form>
            </div>

        </div>
    </div>
</body>
</html>