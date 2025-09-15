<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
  String id = request.getParameter("id");
  if(id == null) { response.sendRedirect("admin.jsp"); return; }

  String username = "";
  try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection con = DriverManager.getConnection("jdbc:mysql://localhost/recharge_db","root","Stark@2803");
      PreparedStatement ps = con.prepareStatement("SELECT username FROM users WHERE id=?");
      ps.setString(1, id);
      ResultSet rs = ps.executeQuery();
      if(rs.next()) {
          username = rs.getString("username");
      } else {
          response.sendRedirect("admin.jsp?msg=User+not+found");
          return;
      }
      con.close();
  } catch(Exception e){ out.println(e); return; }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit User Password</title>
<style>
body { font-family: 'Segoe UI', sans-serif; background:#f1f3f6; margin:0; padding:0; }
.container { max-width: 500px; margin:50px auto; background:#fff; padding:30px; border-radius:10px; box-shadow:0 5px 15px rgba(0,0,0,0.1); }
h2 { text-align:center; color:#333; margin-bottom:20px; }
label { display:block; margin:15px 0 5px; font-weight:bold; }
input[type="password"] { width:100%; padding:10px; border-radius:5px; border:1px solid #ccc; }
button { margin-top:20px; width:100%; padding:12px; border:none; border-radius:8px; background:#0055ff; color:#fff; font-weight:bold; cursor:pointer; transition:0.3s; }
button:hover { background:#003bb5; }
.success { text-align:center; color:green; margin-top:20px; font-weight:bold; }
</style>
</head>
<body>

<div class="container">
<h2>Edit Password for "<%= username %>"</h2>

<form action="updateuser.jsp" method="post">
    <input type="hidden" name="id" value="<%= id %>">
    <label>New Password:</label>
    <input type="password" name="newpass" required placeholder="Enter new password">
    <button type="submit">Update Password</button>
</form>

</div>
</body>
</html>
