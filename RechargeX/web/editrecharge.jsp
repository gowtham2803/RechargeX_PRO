<%@ page import="java.sql.*" %>
<%
  if(session.getAttribute("username")==null){ response.sendRedirect("index.jsp"); return; }
  int id = Integer.parseInt(request.getParameter("id"));
  String name="", mobile="", operator="", city="", plan="";
  try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/recharge_db","root","Stark@2803");
    PreparedStatement ps = con.prepareStatement("SELECT * FROM recharges WHERE id=?");
    ps.setInt(1,id); ResultSet rs = ps.executeQuery();
    if(rs.next()){
      name = rs.getString("name"); mobile = rs.getString("mobile");
      operator = rs.getString("operator"); city = rs.getString("city");
      plan = rs.getString("plan_amount");
    } else { response.sendRedirect("histroy.jsp?msg=Record+not+found"); return; }
    con.close();
  } catch(Exception e){ response.sendRedirect("histroy.jsp?msg=Error"); return; }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Recharge - RechargePro</title>
<style>
/* Base */
body { font-family:'Segoe UI', sans-serif; background:#f1f3f6; margin:0; padding:30px; display:flex; justify-content:center; }
.container { background:#fff; padding:10px 40px; border-radius:15px; box-shadow:0 8px 25px rgba(0,0,0,0.15); width:100%; max-width:500px; animation:fadeIn 0.8s ease; }

/* Heading */
h2 { text-align:center; color:#0055ff; margin-bottom:25px; }

/* Form Grid */
.form-grid { display:grid; grid-template-columns:1fr; gap:15px; }
.form-grid label { font-weight:600; color:#333; margin-bottom:5px; }
.form-grid input { padding:12px 15px; border-radius:10px; border:1px solid #ccc; outline:none; transition:0.3s; font-size:14px; }
.form-grid input:focus { border-color:#0055ff; box-shadow:0 0 8px rgba(0,85,255,0.2); }

/* Full-width button container */
.full { margin-top:10px; text-align:center; }
.btn { padding:12px 25px; border:none; border-radius:25px; background:#0055ff; color:#fff; font-weight:bold; cursor:pointer; transition:0.3s; }
.btn:hover { background:#003bb5; transform:translateY(-2px); box-shadow:0 5px 15px rgba(0,0,0,0.1); }

/* Toast */
.toast {
  position: fixed;
  bottom: 30px;
  left: 50%;
  transform: translateX(-50%);
  background: #27ae60;
  color: #fff;
  padding: 15px 25px;
  border-radius: 30px;
  box-shadow: 0 5px 15px rgba(0,0,0,0.2);
  opacity: 0;
  visibility: hidden;
  transition: 0.5s;
  z-index: 1000;
}

/* Animations */
@keyframes fadeIn {
  from { opacity:0; transform: translateY(-20px); }
  to { opacity:1; transform: translateY(0); }
}
</style>
</head>
<body>

<div class="container card">
  <h2>Edit Recharge</h2>
  <form action="updaterecharge.jsp" method="post" class="form-grid">
    <input type="hidden" name="id" value="<%= id %>">
    <label>Name</label><input name="name" value="<%= name %>" required>
    <label>Mobile</label><input name="mobile" value="<%= mobile %>" required>
    <label>Operator</label><input name="operator" value="<%= operator %>" required>
    <label>City</label><input name="city" value="<%= city %>" required>
    <label>Plan</label><input name="plan_amount" value="<%= plan %>" required>
    <div class="full"><button class="btn">Update</button></div>
  </form>
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

// Example: show toast if URL has msg param
const p = new URLSearchParams(location.search);
if(p.get('msg')) showToast(decodeURIComponent(p.get('msg')));
</script>

</body>
</html>
