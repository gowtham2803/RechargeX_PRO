<%@ page import="java.sql.*" %>
<%
  if(session.getAttribute("username")==null){ response.sendRedirect("index.jsp"); return; }
  int id = Integer.parseInt(request.getParameter("id"));
  String name = request.getParameter("name");
  String mobile = request.getParameter("mobile");
  String operator = request.getParameter("operator");
  String city = request.getParameter("city");
  String plan = request.getParameter("plan_amount");
  try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/recharge_db","root","Stark@2803");
    PreparedStatement ps = con.prepareStatement("UPDATE recharges SET name=?, mobile=?, operator=?, city=?, plan_amount=? WHERE id=?");
    ps.setString(1,name); ps.setString(2,mobile); ps.setString(3,operator); ps.setString(4,city); ps.setString(5,plan); ps.setInt(6,id);
    ps.executeUpdate(); con.close();
    response.sendRedirect("histroy.jsp?msg=Updated+successfully");
  } catch(Exception e){
    response.sendRedirect("histroy.jsp?msg=Update+failed");
  }
%>
