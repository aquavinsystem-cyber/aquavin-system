<%@page import="java.util.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // SECURITY CHECK
    String userName = (String) session.getAttribute("userName");
    String userAddress = (String) session.getAttribute("userAddress");
    
    if (userName == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    ArrayList<Map<String, String>> orderList = (ArrayList<Map<String, String>>) session.getAttribute("myOrders");
    int totalOrdersCount = 0, pendingCount = 0, deliveredCount = 0;

    if (orderList != null) {
        totalOrdersCount = orderList.size();
        for (Map<String, String> o : orderList) {
            if ("Processing".equals(o.get("status"))) pendingCount++;
            else if ("Delivered".equals(o.get("status"))) deliveredCount++;
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/logos.jpg">
    <title>AquaVin | Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Poppins', sans-serif; }
        body { background: #f1f5f9; overflow: hidden; }
        .wrapper { display: flex; height: 100vh; }

        /* SIDEBAR STYLE (Consistent with Profile) */
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

        /* MAIN CONTENT AREA */
        .main { flex-grow: 1; padding: 40px; overflow-y: auto; background: #f8fafc; }
        
        .welcome-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
        .welcome-header h1 { font-size: 2rem; color: #0f172a; font-weight: 800; }
        .address-badge { 
            background: white; padding: 12px 20px; border-radius: 50px; 
            font-weight: 600; color: #1e293b; display: flex; align-items: center; gap: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.03); border: 1px solid #e2e8f0;
        }

        /* STAT CARDS GRID */
        .card-container { display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px; margin-bottom: 40px; }
        .card { 
            background: white; padding: 25px; border-radius: 20px; 
            box-shadow: 0 10px 25px rgba(0,0,0,0.02); display: flex; align-items: center; gap: 20px;
            transition: 0.3s ease; border-bottom: 4px solid transparent;
        }
        .card:hover { transform: translateY(-5px); box-shadow: 0 15px 30px rgba(0,0,0,0.05); }
        
        .card-icon { 
            width: 60px; height: 60px; border-radius: 16px; 
            display: flex; align-items: center; justify-content: center; font-size: 1.5rem; 
        }
        .blue { background: rgba(59, 130, 246, 0.1); color: #3b82f6; }
        .amber { background: rgba(245, 158, 11, 0.1); color: #f59e0b; }
        .emerald { background: rgba(16, 185, 129, 0.1); color: #10b981; }

        .card-data p { color: #64748b; font-size: 0.85rem; font-weight: 700; text-transform: uppercase; margin-bottom: 4px; }
        .card-data h3 { font-size: 1.8rem; color: #0f172a; font-weight: 800; }

        /* RECENT ORDERS TABLE */
        .table-container { 
            background: white; padding: 30px; border-radius: 24px; 
            box-shadow: 0 10px 40px rgba(0,0,0,0.03); border: 1px solid #f1f5f9;
        }
        .table-container h2 { margin-bottom: 25px; font-size: 1.4rem; color: #0f172a; font-weight: 700; }
        
        table { width: 100%; border-collapse: collapse; }
        thead tr { border-bottom: 2px solid #f1f5f9; text-align: left; }
        th { padding: 15px; color: #64748b; font-size: 0.75rem; text-transform: uppercase; letter-spacing: 1px; }
        td { padding: 20px 15px; border-bottom: 1px solid #f8fafc; font-size: 0.95rem; color: #1e293b; }
        
        .order-id { font-weight: 700; color: #3b82f6; }
        .status-badge { 
            background: #fef3c7; color: #92400e; padding: 6px 12px; 
            border-radius: 50px; font-size: 0.75rem; font-weight: 800;
        }
        .status-delivered { background: #dcfce7; color: #166534; }

        /* SCROLLBAR CUSTOMIZATION */
        .main::-webkit-scrollbar { width: 8px; }
        .main::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 10px; }
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
                <a href="dashboard.jsp" class="active"><i class="fas fa-chart-line"></i> Dashboard</a>
                <a href="order.jsp"><i class="fas fa-droplet"></i> Order Water</a>
                <a href="cart.jsp"><i class="fas fa-shopping-cart"></i> My Cart</a> 
                <a href="profile.jsp"><i class="fas fa-user-circle"></i> My Profile</a>
            </div>
            <a href="logout.jsp" class="logout-link"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>

        <div class="main">
            <div class="welcome-header">
                <h1>Welcome, <%= userName %>!</h1>
                <div class="address-badge">
                    <i class="fas fa-map-marker-alt" style="color: #ef4444;"></i>
                    <span><%= (userAddress != null && !userAddress.isEmpty()) ? userAddress : "Set your address" %></span>
                </div>
            </div>
            
            <div class="card-container">
                <div class="card" style="border-bottom-color: #3b82f6;">
                    <div class="card-icon blue"><i class="fas fa-box"></i></div>
                    <div class="card-data">
                        <p>Total Orders</p>
                        <h3><%= totalOrdersCount %></h3>
                    </div>
                </div>
                <div class="card" style="border-bottom-color: #f59e0b;">
                    <div class="card-icon amber"><i class="fas fa-clock"></i></div>
                    <div class="card-data">
                        <p>Pending</p>
                        <h3><%= pendingCount %></h3>
                    </div>
                </div>
                <div class="card" style="border-bottom-color: #10b981;">
                    <div class="card-icon emerald"><i class="fas fa-truck"></i></div>
                    <div class="card-data">
                        <p>Delivered</p>
                        <h3><%= deliveredCount %></h3>
                    </div>
                </div>
            </div>

            <div class="table-container">
                <h2>Recent Orders</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Date</th>
                            <th>Quantity</th>
                            <th>Total Price</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (orderList != null && !orderList.isEmpty()) { 
                            for (Map<String, String> order : orderList) { 
                                String statusClass = "Processing".equals(order.get("status")) ? "" : "status-delivered";
                        %>
                            <tr>
                                <td class="order-id">#<%= order.get("id") %></td>
                                <td><i class="far fa-calendar-alt" style="margin-right: 8px; color: #94a3b8;"></i><%= order.get("date") %></td>
                                <td style="font-weight: 600;"><%= order.get("qty") %> Containers</td>
                                <td style="font-weight: 700; color: #0f172a;">₱<%= order.get("total") %></td>
                                <td>
                                    <span class="status-badge <%= statusClass %>">
                                        <%= order.get("status").toUpperCase() %>
                                    </span>
                                </td>
                            </tr>
                        <% } } else { %>
                            <tr>
                                <td colspan="5" style="padding: 60px; text-align: center; color: #94a3b8;">
                                    <i class="fas fa-box-open" style="font-size: 3rem; display: block; margin-bottom: 15px; opacity: 0.3;"></i>
                                    No recent orders yet.
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>