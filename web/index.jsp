<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
     <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/logos.jpg">
<title>AquaVin | Welcome</title>
    <style>
        /* Shared Styles for Landing Page */
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', sans-serif; }
        body, html { height: 100%; width: 100%; overflow: hidden; }

        .hero {
            height: 100vh;
            width: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(rgba(255, 255, 255, 0.6), rgba(255, 255, 255, 0.7)), 
                        url('images/water-bg.jpg'); 
            background-size: cover;
            background-position: center;
            text-align: center;
        }

        .hero-content {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 5px; 
            max-width: 800px;
            color: #1e293b;

            /* ETO ANG SOLUSYON: Itataas natin ang buong group */
            /* Mag-adjust ka dito (hal. 80px hanggang 150px) depende sa trip mo */
            margin-bottom: 120px; 
            
            /* Konting animation para swabe ang pag-load */
            animation: fadeIn 0.8s ease-out;
        }

        /* Dagdag mo na rin itong animation para mas maganda tignan */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .hero-logo {
            width: 450px; /* Pwede mong gawing 200px kung gusto mong mas maliit konti */
            height: auto;
            
            /* ETO ANG SOLUSYON: Negative margin para lumapit sa Welcome text */
            margin-bottom: -100px; 
            
            mix-blend-mode: multiply;
            filter: contrast(110%);
        }

        .hero h2 { 
            font-size: 4rem; 
            font-weight: bold;
            line-height: 1; /* Binabaan para dikit ang taas at baba ng letters */
            margin-top: 0; /* Siguraduhin walang space sa taas */
            margin-bottom: 5px;
        }
        
        .hero p.subtitle { 
            color: #475569; 
            margin-bottom: 30px; 
            font-size: 1.2rem; 
        }

        /* Style para sa Buttons */
        .hero-btns { display: flex; gap: 20px; }

        .btn {
            padding: 15px 40px;
            border-radius: 30px; 
            font-weight: bold;
            text-decoration: none;
            font-size: 1.1rem;
            transition: 0.3s;
            cursor: pointer;
        }

        .btn-login {
            background: #3b82f6; 
            color: white;
            border: 1px solid #3b82f6;
            box-shadow: 0 4px 15px rgba(59, 130, 246, 0.3);
        }
        .btn-login:hover { 
            background: #2563eb; 
            transform: translateY(-2px);
        }

        .btn-register {
            background: white;
            color: #1e293b;
            border: 1px solid #cbd5e1;
        }
        .btn-register:hover { 
            background: #f8fafc; 
            transform: translateY(-2px);
        }

    </style>
</head>
<body>
    <div class="hero">
        <div class="hero-content">
            
            <img src="${pageContext.request.contextPath}/images/logo.png" alt="AquaVin Logo" class="hero-logo">
            
            <h2>Welcome to AquaVin</h2>
            <p class="subtitle">Pure. Refreshing. Delivered to your doorstep.</p>
            
            <div class="hero-btns">
                <a href="login.jsp" class="btn btn-login">Login</a>
                <a href="register.jsp" class="btn btn-register">Register Now</a>
            </div>
            
        </div>
    </div>
</body>
</html>