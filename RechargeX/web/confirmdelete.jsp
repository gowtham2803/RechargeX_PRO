<%@ page import="java.sql.*" %>
<%
  if(session.getAttribute("username")==null){ response.sendRedirect("index.jsp"); return; }
  int id = Integer.parseInt(request.getParameter("id"));
  try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/recharge_db","root","Stark@2803");
      PreparedStatement ps = con.prepareStatement("DELETE FROM recharges WHERE id=?");
      ps.setInt(1,id); 
      int r = ps.executeUpdate();
      con.close();
      response.sendRedirect("histroy.jsp?msg="+(r>0? "Deleted+successfully":"Delete+failed"));
  } catch(Exception e){
      response.sendRedirect("histroy.jsp?msg=Error+occurred");
  }
%>
