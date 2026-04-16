<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
     <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/logos.jpg">
<title>AquaVin | Register</title>
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

        /* CONTAINER PARA SA SPLIT PANEL - Mas malapad para sa registration fields */
        .auth-container {
            display: flex;
            background: white;
            width: 900px; 
            min-height: 550px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            overflow: hidden;
            animation: fadeIn 0.8s ease-out;
        }

        /* LEFT PANEL (Branding/Logo Side) */
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
            width: 400px;
            height: auto;
            mix-blend-mode: multiply;
            margin-bottom: 10px;
        }

        /* RIGHT PANEL (Register Form Side) */
        .form-panel {
            flex: 1.5;
            padding: 40px 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .form-header { text-align: center; margin-bottom: 25px; }
        .form-header h2 { font-size: 2.2rem; color: #1e293b; }
        .form-header p { color: #64748b; font-size: 0.95rem; }

        /* Grid layout para sa registration fields */
        .form-grid { 
            display: grid; 
            grid-template-columns: 1fr 1fr; 
            gap: 15px; 
            margin-bottom: 10px; 
        }

        input {
            width: 100%;
            padding: 12px 15px;
            margin-bottom: 15px;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            outline: none;
            background: #fdfdfd;
            transition: 0.3s;
            font-size: 0.95rem;
        }
        
        input:focus { 
            border-color: #3b82f6; 
            background: white;
            box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.1); 
        }

        /* Full width utility */
        .full-width { grid-column: span 2; }

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
        
        .btn-action:hover { 
            background: #2563eb; 
            transform: translateY(-1px);
        }

        .footer-link { 
            margin-top: 25px; 
            font-size: 0.9rem; 
            color: #64748b; 
            text-align: center;
        }
        
        .footer-link a { 
            color: #3b82f6; 
            text-decoration: none; 
            font-weight: bold; 
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
                <img src="${pageContext.request.contextPath}/images/Register.png" alt="AquaVin Logo">
            </div>

            <div class="form-panel">
                <div class="form-header">
                    <h2>Register</h2>
                    <p>Create your account to start ordering</p>
                </div>
                
                <form action="AuthServlet" method="POST">
                    <input type="hidden" name="action" value="register">
                    
                    <div class="form-grid">
                        <input type="text" name="fullName" placeholder="Full Name" required>
                        <input type="text" name="address" placeholder="Address" required>
                        
                        <input type="text" name="contact" placeholder="Contact #" required
                               maxlength="11" 
                               oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                               
                        <input type="text" name="username" placeholder="Username" required>
                        
                        <input type="email" name="email" placeholder="Email Address" required class="full-width">
                    </div>

                    <input type="password" name="password" placeholder="Password" required 
                           pattern="^(?=.*[A-Z])(?=.*[0-9])(?=.*[@$!%*?&])[A-Za-z0-9@$!%*?&]{8,}$"
                           title="Must be 8+ chars, 1 Uppercase, 1 Number, 1 Special Char">
                           
                    <button type="submit" class="btn-action">Register</button>
                </form>
                
                <p class="footer-link">Already have an account? <a href="login.jsp">Login</a></p>
            </div>

        </div>
    </div>
</body>
</html>