<%@ page import="java.sql.*" %>
<%
  if(session.getAttribute("username")==null || !"admin".equals(session.getAttribute("username"))){
      response.sendRedirect("index.jsp");
      return;
  }
%>
<!DOCTYPE html>
<html>
<head>
  <title>Admin Dashboard</title>
  <style>
    body {
      font-family: "Segoe UI", Arial, sans-serif;
      background: linear-gradient(135deg, #74ebd5, #ACB6E5);
      margin: 0; padding: 0;
      display: flex; justify-content: center; align-items: center;
      min-height: 100vh; overflow-x: hidden;
    }
    .container {
      width: 90%; max-width: 1000px;
      background: rgba(255,255,255,0.15);
      backdrop-filter: blur(12px);
      border-radius: 16px; padding: 30px; color: #fff;
      box-shadow: 0 8px 25px rgba(0,0,0,0.3); animation: fadeIn 1s ease-in-out;
    }
    h2 { text-align:center; margin-bottom: 20px; font-size:28px; color:#fff; text-shadow:1px 1px 6px rgba(0,0,0,0.5);}
    h3 { margin-bottom: 10px; font-size:20px; color:#fffa; }

    table { width: 100%; border-collapse: collapse; margin-bottom: 25px; overflow: hidden; border-radius: 10px;}
    th, td { padding: 8px; border: 1px solid rgba(255,255,255,0.3); text-align: center; color: #fff; }
    th { background: rgba(0,0,0,0.4); font-size:16px; text-transform: uppercase; letter-spacing: 1px; }
    tr:nth-child(even){ background: rgba(255,255,255,0.08); }
    tr:hover{ background: rgba(255,255,255,0.2); transition: 0.3s; }

    a.btn, button { padding: 10px 18px; border: none; border-radius:8px; background: linear-gradient(135deg, #74ebd5, #ACB6E5); color:#000; font-weight:bold; cursor:pointer; text-decoration:none; display:inline-block; transition: all 0.3s ease; box-shadow:0 4px 12px rgba(0,0,0,0.2);}
    a.btn:hover, button:hover { transform: translateY(-3px); box-shadow:0 6px 16px rgba(0,0,0,0.3); opacity:0.95; }

    /* Modal Styles */
    .modal { display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.6); justify-content:center; align-items:center; z-index:9999;}
    .modal-content { background:#fff; color:#000; padding:30px; border-radius:12px; max-width:400px; width:90%; text-align:center; box-shadow:0 5px 20px rgba(0,0,0,0.3);}
    .modal-content h3 { margin-bottom:20px; font-size:18px; }
    .modal-content button { margin:10px; width:120px; font-weight:bold; }
    .btn-danger { background:#e74c3c; color:#fff; }
    .btn-cancel { background:#95a5a6; color:#fff; }
    label{
        font-size: xx-large;
    }

    @keyframes fadeIn { from{opacity:0; transform:translateY(20px);} to{opacity:1; transform:translateY(0);} }
  </style>
</head>
<body>
<div class="container">
  <h2>Admin Dashboard</h2>
  
  <h3>Users Table</h3>
  <table>
    <tr>
      <th>ID</th>
      <th>Username</th>
      <th>Password</th>
      <th>Action</th>
    </tr>
    <%
      try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost/recharge_db","root","Stark@2803");
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("select * from users");
        while(rs.next()) {
    %>
    <tr>
      <td><%=rs.getInt("id")%></td>
      <td><%=rs.getString("username")%></td>
      <td><%=rs.getString("password")%></td>
      <td>
        <a class="btn" href="edituser.jsp?id=<%=rs.getInt("id")%>">Edit</a>
        <a class="btn" href="histroy.jsp?id=<%=rs.getInt("id")%>">History</a>
        <button class="btn btn-delete" data-id="<%=rs.getInt("id")%>" data-username="<%=rs.getString("username")%>">Delete</button>
      </td>
    </tr>
    <% } con.close(); } catch(Exception e){ out.println(e);} %>
  </table>

  <div style="text-align:center;">
    <a class="btn" href="recharge.jsp">New Recharge</a>
  </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal" id="deleteModal">
  <div class="modal-content">
    <h3 id="modalText">Delete User?</h3>
    <form id="deleteForm" method="post">
        <label>Confirm to delete ?!</label>
        <input type="hidden" name="id" id="deleteId"> <br> <br> <br> 
      <button type="submit" class="btn btn-danger">Delete</button>
      <button type="button" class="btn btn-cancel" onclick="closeModal()">Cancel</button>
    </form>
  </div>
</div>

<script>
  const modal = document.getElementById('deleteModal');
  const modalText = document.getElementById('modalText');
  const deleteId = document.getElementById('deleteId');
  const deleteButtons = document.querySelectorAll('.btn-delete');

  deleteButtons.forEach(btn => {
    btn.addEventListener('click', () => {
      const id = btn.getAttribute('data-id');
      const username = btn.getAttribute('data-username');
      modalText.innerHTML = `Are you sure you want to delete user <strong>${username}</strong>?`;
      deleteId.value = id;
      document.getElementById('deleteForm').action = "deleteuser.jsp?id=" + id;
      modal.style.display = 'flex';
    });
  });

  function closeModal(){
    modal.style.display = 'none';
  }
</script>
</body>
</html>
