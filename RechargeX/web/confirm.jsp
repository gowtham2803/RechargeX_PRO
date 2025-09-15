<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
  if(session.getAttribute("username")==null){ response.sendRedirect("index.jsp"); return; }
  String user = (String) session.getAttribute("username");

  String name = request.getParameter("name");
  String mobile = request.getParameter("mobile");
  String operator = request.getParameter("operator");
  String city = request.getParameter("city");
  String plan = request.getParameter("plan");

  boolean ok = false; 
  String err = null;
  try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/recharge_db","root","Stark@2803");
    PreparedStatement ps = con.prepareStatement(
      "INSERT INTO recharges(name,mobile,operator,city,plan_amount) VALUES(?,?,?,?,?)");
    ps.setString(1, name); 
    ps.setString(2, mobile); 
    ps.setString(3, operator);
    ps.setString(4, city); 
    ps.setString(5, plan);
    int r = ps.executeUpdate();
    ok = (r>0);
    con.close();
  } catch(Exception e){ err = e.getMessage(); }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Recharge Result - RechargeX_pro</title>
<style>
/* Reset & base */
* { box-sizing: border-box; margin:0; padding:0; font-family: 'Segoe UI', sans-serif; }
body { 
  background: #f1f3f6; 
  display: flex; 
  justify-content: center; 
  align-items: center; 
  min-height: 100vh;
}

/* Card */
.card {
  background: #fff;
  border-radius: 20px;
  padding: 40px 30px;
  text-align: center;
  box-shadow: 0 10px 30px rgba(0,0,0,0.1);
  max-width: 400px;
  width: 90%;
  position: relative;
  animation: fadeIn 0.5s ease;
}

.tick {
  font-size: 60px;
  color: #27ae60;
  margin-bottom: 20px;
  animation: pop 0.5s ease;
}

/* Headings & Text */
h2 {
  margin-bottom: 10px;
  color: #2c3e50;
}
.muted {
  font-size: 14px;
  color: #7f8c8d;
  margin-bottom: 25px;
}

/* Buttons */
.btn, .btn-link {
  display: inline-block;
  padding: 10px 20px;
  border-radius: 25px;
  font-weight: bold;
  text-decoration: none;
  margin: 5px;
  transition: 0.3s;
}
.btn {
  background: #0055ff;
  color: #fff;
  border: none;
  cursor: pointer;
}
.btn:hover { background: #003bb5; }

.btn-link {
  background: transparent;
  color: #0055ff;
  border: 2px solid #0055ff;
}
.btn-link:hover {
  background: #0055ff;
  color: #fff;
}

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
@keyframes fadeIn { from {opacity:0} to {opacity:1} }
@keyframes pop { 0% {transform: scale(0)} 100% {transform: scale(1)} }
</style>
</head>
<body>

<div class="card">
  <% if(ok) { %>
      <div class="tick">✔</div>
      <h2>Recharge Successful!</h2>
      <p class="muted">₹<%= plan %> for <strong><%= mobile %></strong> (<%= operator %>)</p>
      <div class="actions">
        <a class="btn-link" href="histroy.jsp">View History</a>
        <a class="btn" href="recharge.jsp">New Recharge</a>
      </div>
      <script>showToast('Recharge Successful ✅');</script>
  <% } else { %>
      <h2 style="color:#c0392b">Recharge Failed</h2>
      <p class="muted"><%= err!=null? err : "Unknown error" %></p>
      <a class="btn" href="recharge.jsp">Try Again</a>
  <% } %>
</div>

<div id="toast" class="toast"></div>

<script>
// Toast Function
function showToast(msg){
  const toast = document.getElementById('toast');
  toast.innerText = msg;
  toast.style.opacity = 1;
  toast.style.visibility = 'visible';
  setTimeout(()=>{
    toast.style.opacity = 0;
    toast.style.visibility = 'hidden';
  }, 3000);
}
</script>

</body>
</html>
