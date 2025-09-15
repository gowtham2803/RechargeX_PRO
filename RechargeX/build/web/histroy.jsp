<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
  if(session.getAttribute("username")==null){ response.sendRedirect("index.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Recharge History - RechargePro</title>
<style>
/* Reset & base */
* { box-sizing: border-box; margin:0; padding:0; font-family:'Segoe UI', sans-serif; }
body { background:#f1f3f6; padding:30px; }

/* Container */
.container { max-width: 1200px; margin: auto; }

/* Heading */
h2 { text-align:center; margin-bottom:20px; color:#2c3e50; }

/* Search Bar */
.search-bar {
  display:flex;
  justify-content:center;
  flex-wrap: wrap;
  gap:10px;
  margin-bottom:20px;
}
.search-bar input, .search-bar select {
  padding:10px 15px;
  border-radius:10px;
  border:1px solid #ccc;
  outline:none;
  font-size:14px;
}
.search-bar button {
  padding:10px 25px;
  border-radius:10px;
  border:none;
  background:#0055ff;
  color:#fff;
  font-weight:bold;
  cursor:pointer;
  transition:0.3s;
}
.search-bar button:hover { background:#003bb5; }

/* Table */
.history-table {
  width: 100%;
  border-collapse: collapse;
  margin-bottom:20px;
}
.history-table th, .history-table td {
  padding:12px 15px;
  text-align:center;
  border-bottom:1px solid #ddd;
  font-size:15px;
}
.history-table {
  width: 100%;
  border-collapse: separate; /* allow spacing between cells */
  border-spacing: 5px 0;     /* horizontal and vertical spacing */
  margin-bottom:20px;
}

.history-table th {
  background:#0055ff;
  color:#fff;
  font-weight:700;
  border-radius:5px 5px 0 0;
  justify-content: space-between;
  padding:15px 20px; /* Increased padding for more space */
  letter-spacing: 0.5px; 
}
.history-table tr:hover { background:#f0f4ff; }

/* Buttons */
.small-btn {
  padding:5px 10px;
  border-radius:10px;
  border:none;
  background:#0055ff;
  color:#fff;
  font-size:18px;
  cursor:pointer;
  margin:2px;
  transition:0.3s;
}
.small-btn:hover { background:#003bb5; }
.small-btn.danger { background:#c0392b; }
.small-btn.danger:hover { background:#a93226; }

/* Pagination */
.pagination { display:flex; justify-content:center; gap:8px; margin-top:15px; }
.page { padding:5px 12px; border-radius:15px; border:1px solid #0055ff; text-decoration:none; color:#0055ff; transition:0.3s; }
.page:hover { background:#0055ff; color:#fff; }
.page.active { background:#0055ff; color:#fff; }

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
</style>
</head>
<body>

<div class="container">
  <h2>Your Recharge History</h2>

  <!-- Search -->
  <form method="get" action="histroy.jsp" class="search-bar">
    <input name="mobile" placeholder="Search mobile" value="<%= request.getParameter("mobile")==null? "": request.getParameter("mobile") %>">
    <select name="operator">
      <option value="">All Operators</option>
      <option <%= "Jio".equals(request.getParameter("operator"))? "selected":"" %>>Jio</option>
      <option <%= "Airtel".equals(request.getParameter("operator"))? "selected":"" %>>Airtel</option>
      <option <%= "Vi".equals(request.getParameter("operator"))? "selected":"" %>>Vi</option>
      <option <%= "BSNL".equals(request.getParameter("operator"))? "selected":"" %>>BSNL</option>
    </select>
    <button>Search</button>
  </form>

  <!-- History Table -->
  <table class="history-table">
    <thead>
      <tr><th>ID</th><th>Name</th><th>Mobile</th><th>Operator</th><th>City</th><th>Plan</th><th>Date</th><th>Action</th></tr>
    </thead>
    <tbody>
      <%
        String mobileSearch = request.getParameter("mobile");
        String operatorSearch = request.getParameter("operator");
        int recordsPerPage = 6;
        int pageno = request.getParameter("page")!=null? Integer.parseInt(request.getParameter("page")):1;
        int start = (pageno-1)*recordsPerPage;

        try {
          Class.forName("com.mysql.cj.jdbc.Driver");
          Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/recharge_db","root","Stark@2803");

          String where = " WHERE 1=1 ";
          if(mobileSearch!=null && !mobileSearch.trim().isEmpty()) where += " AND mobile LIKE '%"+mobileSearch+"%'";
          if(operatorSearch!=null && !operatorSearch.trim().isEmpty()) where += " AND operator='"+operatorSearch+"'";

          // total count
          Statement stCount = con.createStatement();
          ResultSet rc = stCount.executeQuery("SELECT COUNT(*) FROM recharges "+where);
          rc.next();
          int total = rc.getInt(1);
          int totalPages = (int)Math.ceil(total/(double)recordsPerPage);

          Statement st = con.createStatement();
          ResultSet rs = st.executeQuery("SELECT * FROM recharges "+where+" ORDER BY recharge_date DESC LIMIT "+start+","+recordsPerPage);
          boolean any = false;
          while(rs.next()){
            any = true;
      %>
      <tr>
        <td><%= rs.getInt("id") %></td>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getString("mobile") %></td>
        <td><%= rs.getString("operator") %></td>
        <td><%= rs.getString("city") %></td>
        <td>₹<%= rs.getString("plan_amount") %></td>
        <td><%= rs.getTimestamp("recharge_date") %></td>
        <td>
          <form action="editrecharge.jsp" method="get" style="display:inline;">
            <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
            <button class="small-btn">Edit</button>
          </form>
          <form action="deleterecharge.jsp" method="post" style="display:inline;">
            <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
            <button class="small-btn danger">Delete</button>
          </form>
        </td>
      </tr>
      <%
          }
          if(!any){
            out.println("<tr><td colspan='8' style='color:#c0392b'>No records found.</td></tr>");
          }
          // pagination UI
          out.println("<tr><td colspan='8'><div class='pagination'>");
          for(int i=1;i<=totalPages;i++){
            String cls = (i==pageno) ? "page active" : "page";
            out.println("<a class='"+cls+"' href='histroy.jsp?page="+i+"&mobile="+(mobileSearch==null?"":mobileSearch)+"&operator="+(operatorSearch==null?"":operatorSearch)+"'>"+i+"</a>");
          }
          out.println("</div></td></tr>");

          con.close();
        } catch(Exception e){
          out.println("<tr><td colspan='8' style='color:red'>Error: "+e.getMessage()+"</td></tr>");
        }
      %>
    </tbody>
  </table>

  <div style="text-align:center; margin-top:18px;">
    <a class="btn" href="recharge.jsp">New Recharge</a>
  </div>
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

  const p = new URLSearchParams(location.search);
  if(p.get('msg')) showToast(decodeURIComponent(p.get('msg')));
</script>

</body>
</html>
