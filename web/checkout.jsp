<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String userName = (String) session.getAttribute("userName");
    String userAddress = (String) session.getAttribute("userAddress");
    
    // Kunin ang total mula sa POST data (cart.jsp)
    String totalFromPost = request.getParameter("finalGrandTotal");
    Double grandTotal = 0.0;
    
    if (totalFromPost != null && !totalFromPost.isEmpty()) {
        try {
            grandTotal = Double.parseDouble(totalFromPost);
        } catch (Exception e) {
            grandTotal = 0.0;
        }
    } else {
        Object sessionTotal = session.getAttribute("grandTotal");
        if (sessionTotal != null) grandTotal = (Double) sessionTotal;
    }

    if (userName == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/logos.jpg">
    <title>AquaVin | Checkout</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', sans-serif; }
        
        body { 
            background: #f1f5f9; 
            display: flex; 
            justify-content: center; 
            align-items: center; 
            min-height: 100vh;
            width: 100%;
        }

        .checkout-container {
            display: flex;
            width: 950px;
            height: 600px;
            background: white;
            border-radius: 24px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.15);
            overflow: hidden;
            animation: fadeIn 0.6s cubic-bezier(0.16, 1, 0.3, 1);
        }

        /* LEFT PANEL */
        .summary-panel {
            flex: 1;
            background: #1e293b;
            color: white;
            padding: 50px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            position: relative;
        }

        .summary-header h2 { font-size: 1.6rem; margin-bottom: 12px; color: #60a5fa; }
        .summary-header p { color: #94a3b8; font-size: 0.95rem; }
        
        .customer-info { margin-top: 40px; border-top: 1px solid #334155; padding-top: 25px; }
        .customer-info span { color: #94a3b8; font-size: 0.8rem; text-transform: uppercase; }
        .customer-info p { font-size: 1.1rem; font-weight: 500; margin-top: 5px; }

        .total-display { margin-top: auto; }
        .total-label { font-size: 0.85rem; text-transform: uppercase; color: #94a3b8; }
        .total-amount { font-size: 3.5rem; font-weight: 800; color: white; margin-top: 8px; }

        /* RIGHT PANEL */
        .form-panel {
            flex: 1.3;
            padding: 50px;
            background: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .form-panel h1 { font-size: 2rem; color: #0f172a; margin-bottom: 8px; }
        .sub-text { color: #64748b; margin-bottom: 35px; font-size: 0.95rem; }

        .input-group { margin-bottom: 25px; transition: all 0.3s ease; }
        .input-group label { 
            display: block; font-size: 0.75rem; font-weight: 700; color: #475569; 
            text-transform: uppercase; margin-bottom: 10px;
        }

        .payment-select { 
            width: 100%; padding: 14px; border: 2px solid #e2e8f0; border-radius: 12px; 
            outline: none; background: #f8fafc; font-size: 1rem; color: #1e293b;
        }
        .payment-select:focus { border-color: #3b82f6; background: white; }

        .address-info-box { 
            background: #eff6ff; padding: 18px; border-radius: 12px; 
            border-left: 5px solid #3b82f6; font-size: 1rem; color: #1e40af;
        }

        .btn-confirm { 
            width: 100%; padding: 18px; background: #3b82f6; color: white; border: none; 
            border-radius: 14px; font-weight: 700; cursor: pointer; font-size: 1.1rem; 
            box-shadow: 0 10px 15px -3px rgba(59, 130, 246, 0.3);
        }
        .btn-confirm:hover { background: #2563eb; transform: translateY(-2px); }
        
        .back-link { display: block; text-align: center; margin-top: 25px; color: #94a3b8; text-decoration: none; font-size: 0.9rem; }

        @keyframes fadeIn { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<body>

    <div class="checkout-container">
        <div class="summary-panel">
            <div class="summary-header">
                <h2>Order Summary</h2>
                <div class="customer-info">
                    <span>Account Name</span>
                    <p><%= userName %></p>
                </div>
            </div>
            <div class="total-display">
                <p class="total-label">Total Amount to Pay</p>
                <p class="total-amount">₱<%= String.format("%.2f", grandTotal) %></p>
            </div>
        </div>

        <div class="form-panel">
            <h1>Finalize Order</h1>
            <p class="sub-text">Please review your delivery details and choose your preferred payment method.</p>

            <form action="CheckoutServlet" method="POST">
                <div class="input-group">
                    <label>Delivery Method</label>
                    <select name="deliveryMethod" id="deliveryMethod" class="payment-select" onchange="toggleOrderFields()">
                        <option value="Home Delivery">🏠 Home Delivery</option>
                        <option value="Pick-up">🏪 Pick-up at Station</option>
                    </select>
                </div>

                <div class="input-group" id="addressBox">
                    <label>📍 Delivery Address</label>
                    <div class="address-info-box">
                        <%= (userAddress != null && !userAddress.isEmpty()) ? userAddress : "No address set in profile." %>
                    </div>
                </div>

                <div class="input-group" id="paymentBox">
                    <label>Payment Method</label>
                    <select name="paymentMethod" class="payment-select">
                        <option value="Cash on Delivery">💵 Cash on Delivery (COD)</option>
                        <option value="GCash">📱 GCash</option>
                        <option value="Maya">💳 Maya</option>
                    </select>
                </div>

                <input type="hidden" name="totalAmount" value="<%= grandTotal %>">
                <button type="submit" class="btn-confirm">Place Order Now</button>
                <a href="cart.jsp" class="back-link">← Back to Cart</a>
            </form>
        </div>
    </div>

    <script>
        function toggleOrderFields() {
            var method = document.getElementById("deliveryMethod").value;
            var addressBox = document.getElementById("addressBox");
            var paymentBox = document.getElementById("paymentBox");

            if (method === "Pick-up") {
                // Itago ang Address at Payment selection
                addressBox.style.display = "none";
                paymentBox.style.display = "none";
            } else {
                // Ipakita ulit para sa Home Delivery
                addressBox.style.display = "block";
                paymentBox.style.display = "block";
            }
        }
    </script>
</body>
</html>