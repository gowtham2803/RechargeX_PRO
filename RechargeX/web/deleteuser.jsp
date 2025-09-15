<%@ page import="java.sql.*" %>
<%
  String id = request.getParameter("id");

  if(id == null || id.trim().isEmpty()){
      response.sendRedirect("admin.jsp?msg=Invalid+input");
      return;
  }

  boolean deleted = false;
  try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection con = DriverManager.getConnection("jdbc:mysql://localhost/recharge_db","root","Stark@2803");
      PreparedStatement ps = con.prepareStatement("DELETE FROM users WHERE id=?");
      ps.setString(1, id);
      int r = ps.executeUpdate();
      deleted = (r > 0);
      con.close();
  } catch(Exception e){ out.println(e); return; }

  if(deleted){
      response.sendRedirect("admin.jsp?msg=User+deleted+successfully");
  } else {
      response.sendRedirect("admin.jsp?msg=Delete+failed");
  }
%>
