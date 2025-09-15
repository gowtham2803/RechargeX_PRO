<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,org.mindrot.jbcrypt.BCrypt,javax.mail.*,javax.mail.internet.*,java.util.Properties"%>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    // ---------- Admin Login ----------
    if("admin".equals(username) && "admin123".equals(password)) {
        session.setAttribute("username", "admin");
        response.sendRedirect("admin.jsp"); // redirect to admin panel
    } 
    else {
        // ---------- User Login ----------
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/recharge_db", "root", "Stark@2803");

            PreparedStatement ps = con.prepareStatement("SELECT id,password FROM users WHERE username=?");
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                String storedHash = rs.getString("password");
                if(BCrypt.checkpw(password, storedHash)) {
                    session.setAttribute("username", username);
                    session.setAttribute("userId", rs.getInt("id"));
                    response.sendRedirect("recharge.jsp");
                } else {
                    response.sendRedirect("index.jsp?error=invalid");
                }
            } else {
                response.sendRedirect("index.jsp?error=invalid");
            }

            rs.close();
            ps.close();
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?error=db");
        }
    }
%>
