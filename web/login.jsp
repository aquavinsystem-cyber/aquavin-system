<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
     <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/logos.jpg">
<title>AquaVin | Login</title>
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

        /* CONTAINER PARA SA DALAWANG PANEL */
        .auth-container {
            display: flex;
            background: white;
            width: 800px; /* Mas malapad para sa split view */
            height: 450px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            overflow: hidden; /* Para rounded din ang kanto ng side panel */
            animation: fadeIn 0.8s ease-out;
        }

        /* 1. LEFT PANEL (Brand/Logo Panel) */
        .brand-panel {
            flex: 1;
            background: #f8fafc; /* Konting contrast sa puti */
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            border-right: 1px solid #f1f5f9;
            padding: 20px;
        }

        .brand-panel img {
            width: 400px; /* Pinalaking logo */
            height: auto;
            mix-blend-mode: multiply; /* Transparent hack */
            margin-bottom: 20px;
        }

        /* 2. RIGHT PANEL (Login Form Panel) */
        .form-panel {
            flex: 1.2;
            padding: 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            text-align: center;
        }

        .form-panel h2 { 
            font-size: 2.2rem; 
            color: #1e293b; 
            margin-bottom: 5px; 
        }

        .form-panel p.subtitle { 
            color: #64748b; 
            margin-bottom: 30px; 
            font-size: 0.95rem; 
        }

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
            margin-top: 5px;
        }
        .btn-action:hover { 
            background: #2563eb; 
            transform: translateY(-1px);
        }

        .footer-links { 
            margin-top: 25px; 
            font-size: 0.85rem; 
            color: #64748b; 
        }
        .footer-links a { 
            color: #3b82f6; 
            text-decoration: none; 
            font-weight: bold; 
        }
        .footer-links a:hover { text-decoration: underline; }
        .divider { margin: 0 8px; color: #cbd5e1; }

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
                <img src="${pageContext.request.contextPath}/images/logo.png" alt="AquaVin Logo">
                
            </div>

            <div class="form-panel">
                <h2>Login</h2>
                <p class="subtitle">Welcome back! Please enter your details.</p>
                
                <form action="AuthServlet" method="POST">
                    <input type="text" name="username" placeholder="Username" required>
                    <input type="password" name="password" placeholder="Password" required>
                    <button type="submit" class="btn-action">Sign In</button>
                </form>
                
                <div class="footer-links">
                    <a href="register.jsp">Create Account</a> 
                    <span class="divider">|</span>
                    <a href="forgot.jsp">Forgot Password?</a>
                </div>
            </div>

        </div>
    </div>
</body>
</html>