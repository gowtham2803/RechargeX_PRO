<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
  if(session.getAttribute("username")==null){ response.sendRedirect("index.jsp"); return; }

  int id = Integer.parseInt(request.getParameter("id"));
  String name="", mobile="", operator="", city="", plan="";
  boolean recordFound = false;
  
  try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/recharge_db","root","Stark@2803");
      PreparedStatement ps = con.prepareStatement("SELECT * FROM recharges WHERE id=?");
      ps.setInt(1,id);
      ResultSet rs = ps.executeQuery();
      if(rs.next()){
          recordFound = true;
          name = rs.getString("name");
          mobile = rs.getString("mobile");
          operator = rs.getString("operator");
          city = rs.getString("city");
          plan = rs.getString("plan_amount");
      }
      con.close();
  } catch(Exception e){ recordFound=false; }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Recharge - RechargePro</title>
<style>
body { font-family:'Segoe UI', sans-serif; background:#f1f3f6; margin:0; padding:30px; display:flex; justify-content:center; align-items:center; min-height:100vh; }
.container { background:#fff; padding:30px 40px; border-radius:15px; box-shadow:0 8px 25px rgba(0,0,0,0.15); width:100%; max-width:500px; text-align:center; animation:fadeIn 0.8s ease; }
h2 { color:#c0392b; margin-bottom:15px; }
.details { text-align:left; margin-bottom:20px; }
.details p { margin:5px 0; }
.btn { padding:12px 25px; border:none; border-radius:25px; cursor:pointer; margin:0 10px; font-weight:bold; transition:0.3s; }
.btn-cancel { background:#ccc; color:#333; }
.btn-cancel:hover { background:#999; }
.btn-delete { background:#e74c3c; color:#fff; }
.btn-delete:hover { background:#c0392b; transform:translateY(-2px); box-shadow:0 5px 15px rgba(0,0,0,0.1); }
@keyframes fadeIn { from {opacity:0; transform:translateY(-20px);} to {opacity:1; transform:translateY(0);} }
.toast { position: fixed; bottom: 30px; left: 50%; transform: translateX(-50%); background: #27ae60; color: #fff; padding: 15px 25px; border-radius: 30px; box-shadow: 0 5px 15px rgba(0,0,0,0.2); opacity: 0; visibility: hidden; transition: 0.5s; z-index: 1000; }
</style>
</head>
<body>

<div class="container">
<% if(recordFound){ %>
    <h2>Confirm Deletion</h2>
    <div class="details">
        <p><strong>Name:</strong> <%= name %></p>
        <p><strong>Mobile:</strong> <%= mobile %></p>
        <p><strong>Operator:</strong> <%= operator %></p>
        <p><strong>City:</strong> <%= city %></p>
        <p><strong>Plan:</strong> ₹<%= plan %></p>
    </div>
    <form method="post" action="confirmdelete.jsp">
        <input type="hidden" name="id" value="<%= id %>">
        <button type="submit" class="btn btn-delete">Delete</button>
        <a href="histroy.jsp" class="btn btn-cancel">Cancel</a>
    </form>
<% } else { %>
    <h2>Record Not Found</h2>
    <a href="histroy.jsp" class="btn btn-cancel">Go Back</a>
<% } %>
</div>

<div id="toast" class="toast"></div>
<script>
function showToast(msg){
    const toast = document.getElementById('toast');
    toast.innerText = msg;
    toast.style.opacity = 1;
    toast.style.visibility = 'visible';
    setTimeout(()=>{ toast.style.opacity = 0; toast.style.visibility='hidden'; }, 3000);
}

// Show success/failure messages from query param if needed
const p = new URLSearchParams(location.search);
if(p.get('msg')) showToast(decodeURIComponent(p.get('msg')));
</script>
</body>
</html>

