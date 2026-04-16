<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%
    String userName = (String) session.getAttribute("userName");
    List<Map<String, Object>> cartList = (List<Map<String, Object>>) session.getAttribute("cartList");

    if (userName == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/logos.jpg">
    <title>AquaVin | My Cart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Poppins', sans-serif; }
        body { background: #f1f5f9; overflow: hidden; }
        .wrapper { display: flex; height: 100vh; }

        /* SIDEBAR (Consistent) */
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
        
        .header-box { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
        .header-box h1 { font-size: 2rem; color: #0f172a; font-weight: 800; }
        .user-badge { 
            background: white; padding: 10px 20px; border-radius: 50px; 
            font-weight: 600; color: #1e293b; display: flex; align-items: center; gap: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.03); border: 1px solid #e2e8f0;
        }

        /* CART CARD */
        .cart-card { 
            background: white; border-radius: 24px; padding: 35px; 
            box-shadow: 0 10px 40px rgba(0,0,0,0.03); max-width: 900px; margin: 0 auto;
            border: 1px solid #f1f5f9;
        }

        .item-row { 
            display: flex; align-items: center; padding: 20px 0; 
            border-bottom: 1px solid #f1f5f9; transition: 0.2s;
        }
        .item-row:hover { background: #fcfdfe; }

        .item-icon { 
            width: 60px; height: 60px; background: #eff6ff; color: #3b82f6;
            border-radius: 16px; display: flex; align-items: center; justify-content: center;
            font-size: 1.5rem;
        }

        .item-details { flex-grow: 1; margin-left: 20px; }
        .item-details h4 { font-size: 1.1rem; color: #0f172a; margin-bottom: 4px; }
        .item-details p { color: #64748b; font-size: 0.9rem; font-weight: 500; }

        .price-text { font-size: 1.1rem; font-weight: 700; color: #0f172a; }

        /* SUMMARY SECTION */
        .cart-summary { margin-top: 30px; padding-top: 20px; }
        .total-row { 
            display: flex; justify-content: space-between; align-items: center;
            font-size: 1.4rem; font-weight: 800; color: #0f172a; margin-bottom: 25px;
        }
        .total-label { color: #64748b; font-size: 1rem; text-transform: uppercase; letter-spacing: 1px; }

        .btn-proceed { 
            display: flex; align-items: center; justify-content: center; gap: 12px;
            width: 100%; padding: 20px; background: #0f172a; color: white; 
            border: none; border-radius: 16px; font-weight: 700; cursor: pointer; 
            font-size: 1.1rem; text-align: center; text-decoration: none; transition: 0.3s;
        }
        .btn-proceed:hover { 
            background: #3b82f6; transform: translateY(-3px); 
            box-shadow: 0 10px 20px rgba(59, 130, 246, 0.2); 
        }

        .empty-state { text-align: center; padding: 60px 20px; }
        .empty-state i { font-size: 4rem; color: #e2e8f0; margin-bottom: 20px; }
        .empty-state p { font-size: 1.2rem; color: #64748b; margin-bottom: 20px; }
        .shop-now { 
            color: #3b82f6; text-decoration: none; font-weight: 700; 
            padding: 10px 25px; border: 2px solid #3b82f6; border-radius: 12px;
            transition: 0.3s;
        }
        .shop-now:hover { background: #3b82f6; color: white; }
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
                <a href="order.jsp"><i class="fas fa-droplet"></i> Order Water</a>
                <a href="cart.jsp" class="active"><i class="fas fa-shopping-cart"></i> My Cart</a> 
                <a href="profile.jsp"><i class="fas fa-user-circle"></i> My Profile</a>
            </div>
            <a href="logout.jsp" class="logout-link"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>

        <div class="main">
            <div class="header-box">
                <h1>My Shopping Cart</h1>
                <div class="user-badge">
                    <i class="fas fa-user"></i> <span><%= userName %></span>
                </div>
            </div>

            <div class="cart-card">
                <%
                    double grandTotal = 0;
                    if (cartList != null && !cartList.isEmpty()) {
                        for (Map<String, Object> item : cartList) {
                            double subtotal = (double) item.get("subtotal");
                            grandTotal += subtotal;
                %>
                            <div class="item-row">
                                <div class="item-icon">
                                    <i class="fas fa-faucet-drip"></i>
                                </div>
                                <div class="item-details">
                                    <h4><%= item.get("name") %></h4>
                                    <p><%= item.get("qty") %> x ₱<%= String.format("%.2f", (double)item.get("price")) %></p>
                                </div>
                                <div class="price-text">₱<%= String.format("%.2f", subtotal) %></div>
                            </div>
                <%
                        }
                        session.setAttribute("grandTotal", grandTotal);
                %>
                        <div class="cart-summary">
                            <div class="total-row">
                                <span class="total-label">Total Amount</span>
                                <span>₱<%= String.format("%.2f", grandTotal) %></span>
                            </div>

                            <a href="checkout.jsp" class="btn-proceed">
                                <i class="fas fa-credit-card"></i> Proceed to Checkout
                            </a>
                        </div>
                <%
                    } else {
                %>
                        <div class="empty-state">
                            <i class="fas fa-shopping-basket"></i>
                            <p>Your cart is empty, pre.</p>
                            <a href="order.jsp" class="shop-now">Go to Shop</a>
                        </div>
                <%
                    }
                %>
            </div>
        </div>
    </div>
</body>
</html>