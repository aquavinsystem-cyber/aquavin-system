<%
    // Burahin lahat ng laman ng session
    session.invalidate(); 
    // I-redirect sa login page
    response.sendRedirect("login.jsp");
%>