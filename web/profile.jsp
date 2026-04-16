<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // HUGOT: Kunin ang data sa session
    String userName = (String) session.getAttribute("userName");
    String userAddress = (String) session.getAttribute("userAddress");
    String userPhone = (String) session.getAttribute("userPhone");
    String userLogin = (String) session.getAttribute("userLogin");
    String userEmail = (String) session.getAttribute("userEmail");
    String userPic = (String) session.getAttribute("userPic"); 

    if (userName == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/logos.jpg">
    <title>AquaVin | Profile</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Poppins', sans-serif; }
        body { background: #f1f5f9; overflow: hidden; }
        .wrapper { display: flex; height: 100vh; }

        /* SIDEBAR SECTION */
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

        /* MAIN CONTENT - SPLIT LAYOUT */
        .main { flex-grow: 1; display: flex; justify-content: center; align-items: center; padding: 40px; }

        .profile-container {
            display: flex;
            background: white;
            width: 100%;
            max-width: 950px;
            height: 600px;
            border-radius: 24px;
            box-shadow: 0 20px 50px rgba(0,0,0,0.1);
            overflow: hidden;
            animation: slideUp 0.6s ease-out;
        }

        /* LEFT PANEL: The Visual Card */
        .left-panel {
            flex: 1;
            background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 40px;
            border-right: 1px solid #e2e8f0;
            text-align: center;
        }

        .profile-pic-container { 
            position: relative; 
            cursor: pointer; 
            width: 160px; height: 160px;
            margin-bottom: 25px;
        }
        
        .circle-name { 
            width: 100%; height: 100%; 
            background: #3b82f6; color: white; 
            border-radius: 50%; display: flex; 
            align-items: center; justify-content: center; 
            font-size: 4.5rem; font-weight: bold; 
            border: 6px solid white;
            box-shadow: 0 10px 25px rgba(59, 130, 246, 0.2); 
            overflow: hidden;
        }
        .circle-name img { width: 100%; height: 100%; object-fit: cover; }
        
        .upload-overlay {
            position: absolute; bottom: 5px; right: 5px;
            background: #0f172a; color: white; width: 42px; height: 42px;
            border-radius: 50%; display: flex; align-items: center; justify-content: center;
            border: 3px solid white; transition: 0.3s;
        }
        .profile-pic-container:hover .upload-overlay { background: #3b82f6; transform: scale(1.1); }

        .user-meta h3 { color: #0f172a; font-size: 1.7rem; margin-bottom: 5px; }
        .user-meta p { color: #64748b; font-size: 0.95rem; font-family: 'Courier New', monospace; background: #e2e8f0; padding: 4px 12px; border-radius: 20px; }

        /* RIGHT PANEL: The Editable Form */
        .right-panel { flex: 1.4; padding: 50px; display: flex; flex-direction: column; justify-content: center; }
        .form-header { margin-bottom: 35px; }
        .form-header h2 { font-size: 2rem; color: #0f172a; font-weight: 800; }

        .info-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .input-box { margin-bottom: 20px; }
        .input-box label { display: block; font-size: 0.75rem; font-weight: 800; color: #475569; margin-bottom: 8px; text-transform: uppercase; letter-spacing: 0.5px; }
        .input-box input { 
            width: 100%; padding: 14px; border: 2px solid #e2e8f0; border-radius: 12px; 
            background: #fff; font-size: 1rem; outline: none; transition: 0.3s; color: #1e293b;
        }
        .input-box input:focus { border-color: #3b82f6; box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.1); }

        .btn-update {
            width: 100%; padding: 18px; background: #0f172a; color: white;
            border: none; border-radius: 14px; font-weight: 700; font-size: 1.1rem;
            cursor: pointer; transition: 0.3s; margin-top: 15px;
            display: flex; align-items: center; justify-content: center; gap: 12px;
        }
        .btn-update:hover { background: #3b82f6; transform: translateY(-2px); box-shadow: 0 10px 20px rgba(59, 130, 246, 0.2); }

        @keyframes slideUp { from { opacity: 0; transform: translateY(30px); } to { opacity: 1; transform: translateY(0); } }
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
                <a href="cart.jsp"><i class="fas fa-shopping-cart"></i> My Cart</a> 
                <a href="profile.jsp" class="active"><i class="fas fa-user-circle"></i> My Profile</a>
            </div>
            <a href="logout.jsp" class="logout-link"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>

        <div class="main">
            <div class="profile-container">
                <div class="left-panel">
                    <div class="profile-pic-container" onclick="document.getElementById('fileInput').click();">
                        <div class="circle-name" id="avatarPreview">
                            <% if (userPic != null && !userPic.isEmpty() && !userPic.equals("default.png")) { %>
                                <img src="${pageContext.request.contextPath}/uploads/<%= userPic %>">
                            <% } else { %>
                                <%= (userName != null) ? userName.substring(0,1).toUpperCase() : "U" %>
                            <% } %>
                        </div>
                        <div class="upload-overlay"><i class="fas fa-camera"></i></div>
                    </div>
                    <div class="user-meta">
                        <h3><%= userName %></h3>
                        <p>@<%= (userLogin != null) ? userLogin : "username" %></p>
                    </div>
                </div>

                <div class="right-panel">
                    <div class="form-header">
                        <h2>Edit Profile</h2>
                    </div>
                    
                    <form action="UpdateProfileServlet" method="POST" enctype="multipart/form-data">
                        <input type="file" name="profilePic" id="fileInput" style="display:none" accept="image/*" onchange="previewImage(this)">
                        
                        <div class="info-grid">
                            <div class="input-box">
                                <label>Full Name</label>
                                <input type="text" name="userName" value="<%= userName %>" required>
                            </div>
                            <div class="input-box">
                                <label>Email Address</label>
                                <input type="email" name="userEmail" value="<%= (userEmail != null) ? userEmail : "" %>" required>
                            </div>
                        </div>

                        <div class="input-box">
                            <label>Primary Address</label>
                            <input type="text" name="userAddress" value="<%= userAddress %>" required>
                        </div>

                        <div class="input-box">
                            <label>Contact Number</label>
                            <input type="text" name="userPhone" value="<%= (userPhone != null) ? userPhone : "" %>" required maxlength="11">
                        </div>

                        <button type="submit" class="btn-update">
                            <i class="fas fa-save"></i> Save Changes
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        function previewImage(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    var preview = document.getElementById('avatarPreview');
                    preview.innerHTML = '<img src="' + e.target.result + '" style="width: 100%; height: 100%; object-fit: cover; border-radius: 50%;">';
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</body>
</html>