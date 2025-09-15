<%@ page import="java.sql.*" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<%
  String id = request.getParameter("id");
  String newpass = request.getParameter("newpass");

  if(id == null || newpass == null || newpass.trim().isEmpty()){
      response.sendRedirect("admin.jsp?msg=Invalid+input");
      return;
  }

  boolean updated = false;
  try {
      // Hash the password using bcrypt
      String hashedPassword = BCrypt.hashpw(newpass, BCrypt.gensalt(12)); // 12 rounds

      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection con = DriverManager.getConnection("jdbc:mysql://localhost/recharge_db","root","Stark@2803");
      PreparedStatement ps = con.prepareStatement("UPDATE users SET password=? WHERE id=?");
      ps.setString(1, hashedPassword);
      ps.setString(2, id);
      int r = ps.executeUpdate();
      updated = (r>0);
      con.close();
  } catch(Exception e){ out.println(e); return; }

  if(updated){
      response.sendRedirect("admin.jsp?msg=Password+updated+successfully");
  } else {
      response.sendRedirect("admin.jsp?msg=Update+failed");
  }
%>
