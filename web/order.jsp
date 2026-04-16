<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String userName = (String) session.getAttribute("userName");
    if (userName == null) { response.sendRedirect("login.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/logos.jpg">
    <title>AquaVin | Order Water</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Poppins', sans-serif; }
        body { background: #f1f5f9; overflow: hidden; }
        .wrapper { display: flex; height: 100vh; }

        /* SIDEBAR (Consistent with other pages) */
        .sidebar { width: 280px; background: #0f172a; color: white; padding: 25px; display: flex; flex-direction: column; }
        .sidebar-header { padding: 10px 0 40px 0; text-align: center; }
        .sidebar-logo { width: 80px; border-radius: 50%; margin-bottom: 15px; border: 2px solid #3b82f6; }
        .sidebar-title { font-size: 1.4rem; font-weight: 800; color: white; letter-spacing: 1px; }
        
        .nav-links { flex-grow: 1; }
        .sidebar a { 
            display: flex; align-items: center; gap: 12px;
            padding: 14px 18px; color: #94a3b8; text-decoration: none; 
            border-radius: 12px; margin-bottom: 10px; transition: 0.3s; 
        }
        .sidebar a:hover { background: #1e293b; color: white; }
        .sidebar a.active { background: #3b82f6; color: white; box-shadow: 0 4px 15px rgba(59, 130, 246, 0.3); }
        .logout-link { background: #ef4444 !important; color: white !important; font-weight: bold; margin-top: auto; }

        /* MAIN CONTENT */
        .main { flex-grow: 1; padding: 40px; overflow-y: auto; background: #f8fafc; }
        .main h1 { font-size: 2rem; color: #0f172a; font-weight: 800; margin-bottom: 30px; }

        /* PRODUCT GRID */
        .product-grid { 
            display: grid; 
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); 
            gap: 30px; 
            margin-top: 20px; 
        }
        
        .product-card { 
            background: white; 
            padding: 35px 25px; 
            border-radius: 24px; 
            text-align: center; 
            box-shadow: 0 10px 30px rgba(0,0,0,0.02); 
            transition: all 0.3s ease; 
            border: 1px solid #f1f5f9;
            position: relative;
        }
        .product-card:hover { transform: translateY(-10px); box-shadow: 0 20px 40px rgba(0,0,0,0.06); }
        
        .product-icon { 
            width: 80px; height: 80px; background: #eff6ff; color: #3b82f6;
            border-radius: 20px; display: flex; align-items: center; justify-content: center;
            font-size: 2.5rem; margin: 0 auto 20px;
        }

        .product-card h3 { font-size: 1.3rem; color: #0f172a; margin-bottom: 5px; }
        .product-card p.desc { color: #64748b; font-size: 0.9rem; margin-bottom: 15px; }
        .price { color: #3b82f6; font-weight: 800; font-size: 1.8rem; margin-bottom: 20px; }
        
        /* CONTROLS */
        .qty-wrapper { margin-bottom: 20px; display: flex; align-items: center; justify-content: center; gap: 10px; }
        .qty-wrapper label { font-weight: 700; color: #1e293b; font-size: 0.9rem; }
        .qty-input { 
            width: 70px; padding: 10px; border: 2px solid #f1f5f9; 
            border-radius: 12px; text-align: center; font-weight: 700;
            outline: none; transition: 0.3s;
        }
        .qty-input:focus { border-color: #3b82f6; }

        /* BUTTONS */
        .btn-buy { 
            width: 100%; padding: 15px; background: #0f172a; color: white; 
            border: none; border-radius: 14px; cursor: pointer; font-weight: 700; 
            margin-bottom: 12px; transition: 0.3s; font-size: 1rem;
        }
        .btn-buy:hover { background: #3b82f6; transform: scale(1.02); }
        
        .btn-add { 
            width: 100%; padding: 15px; background: white; color: #0f172a; 
            border: 2px solid #f1f5f9; border-radius: 14px; cursor: pointer; 
            font-weight: 700; transition: 0.3s; 
        }
        .btn-add:hover { background: #f8fafc; border-color: #cbd5e1; }

        /* NOTIFICATION */
        .alert-success { 
            background: #dcfce7; color: #166534; padding: 20px; border-radius: 16px; 
            margin-bottom: 30px; border-left: 6px solid #22c55e; 
            display: flex; justify-content: space-between; align-items: center;
            font-weight: 600; box-shadow: 0 4px 12px rgba(34, 197, 94, 0.1);
        }
        .view-cart-btn {
            background: #166534; color: white; padding: 8px 16px; 
            border-radius: 10px; text-decoration: none; font-size: 0.85rem;
        }
    </style>
</head>
<body>
    <div class="wrapper">
        <div class="sidebar">
            <div class="sidebar-header">
                <img src="${pageContext.request.contextPath}/images/logos.jpg" alt="Logo" class="sidebar-logo">
                <h2 class="sidebar-title">AquaVin</h2>
            </div>
            <div class="nav-links">
                <a href="dashboard.jsp"><i class="fas fa-chart-line"></i> Dashboard</a>
                <a href="order.jsp" class="active"><i class="fas fa-droplet"></i> Order Water</a>
                <a href="cart.jsp"><i class="fas fa-shopping-cart"></i> My Cart</a> 
                <a href="profile.jsp"><i class="fas fa-user-circle"></i> My Profile</a>
            </div>
            <a href="logout.jsp" class="logout-link"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>

        <div class="main">
            <h1>Select Your Order</h1>
            
            <%-- Notification Alert --%>
            <% if("added".equals(request.getParameter("status"))) { %>
                <div class="alert-success">
                    <span><i class="fas fa-check-circle"></i> Item added to cart successfully!</span>
                    <a href="cart.jsp" class="view-cart-btn">View Cart</a>
                </div>  
            <% } %>

            <div class="product-grid">
                
                <div class="product-card">
                    <form action="AddToCartServlet" method="POST">
                        <div class="product-icon"><i class="fas fa-bottle-water"></i></div>
                        <h3>5 Gallon Slim</h3>
                        <p class="desc">Purified Slim Container</p>
                        <p class="price">₱35.00</p>
                        
                        <input type="hidden" name="prodName" value="5 Gallon Slim">
                        <input type="hidden" name="prodPrice" value="35.00">
                        <input type="hidden" name="actionType" value="add"> 
                        
                        <div class="qty-wrapper">
                            <label>Quantity:</label>
                            <input type="number" name="qty" value="1" min="1" class="qty-input">
                        </div>
                        
                        <button type="submit" class="btn-buy" onclick="this.form.actionType.value='buy'">Buy Now</button>
                        <button type="submit" class="btn-add" onclick="this.form.actionType.value='add'">Add to Cart</button>
                    </form>
                </div>

                <div class="product-card" style="border: 2px solid #3b82f6;">
                    <span style="position: absolute; top: -12px; left: 50%; transform: translateX(-50%); background: #3b82f6; color: white; padding: 4px 15px; border-radius: 20px; font-size: 0.7rem; font-weight: 800; text-transform: uppercase;">Best Value</span>
                    <form action="AddToCartServlet" method="POST">
                        <div class="product-icon" style="background: #eff6ff;"><i class="fas fa-boxes-stacked"></i></div>
                        <h3>Both Containers</h3>
                        <p class="desc">1 Slim + 1 Round Bundle</p>
                        <p class="price">₱60.00</p>
                        
                        <input type="hidden" name="prodName" value="Both Containers Bundle">
                        <input type="hidden" name="prodPrice" value="65.00">
                        <input type="hidden" name="actionType" value="add">
                        
                        <div class="qty-wrapper">
                            <label>Quantity:</label>
                            <input type="number" name="qty" value="1" min="1" class="qty-input">
                        </div>
                        
                        <button type="submit" class="btn-buy" style="background: #3b82f6;" onclick="this.form.actionType.value='buy'">Buy Now</button>
                        <button type="submit" class="btn-add" onclick="this.form.actionType.value='add'">Add to Cart</button>
                    </form>
                </div>

                <div class="product-card">
                    <form action="AddToCartServlet" method="POST">
                        <div class="product-icon"><i class="fas fa-faucet-drip"></i></div>
                        <h3>5 Gallon Round</h3>
                        <p class="desc">Standard Round Container</p>
                        <p class="price">₱30.00</p>
                        
                        <input type="hidden" name="prodName" value="5 Gallon Round">
                        <input type="hidden" name="prodPrice" value="30.00">
                        <input type="hidden" name="actionType" value="add">
                        
                        <div class="qty-wrapper">
                            <label>Quantity:</label>
                            <input type="number" name="qty" value="1" min="1" class="qty-input">
                        </div>
                        
                        <button type="submit" class="btn-buy" onclick="this.form.actionType.value='buy'">Buy Now</button>
                        <button type="submit" class="btn-add" onclick="this.form.actionType.value='add'">Add to Cart</button>
                    </form>
                </div>

            </div>
        </div>
    </div>
</body>
</html>