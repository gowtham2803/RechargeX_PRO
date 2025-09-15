<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*,org.mindrot.jbcrypt.BCrypt" %>
<%
    String message = null;
    String msgType = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            message = "Please fill in both username and password.";
            msgType = "error";
        } else {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/recharge_db", "root", "Stark@2803");

                ps = con.prepareStatement("SELECT id FROM users WHERE username = ?");
                ps.setString(1, username);
                rs = ps.executeQuery();
                if (rs.next()) {
                    message = "Username already taken. Please choose another.";
                    msgType = "error";
                } else {
                    rs.close();
                    ps.close();

                    String hashed = BCrypt.hashpw(password, BCrypt.gensalt());
                    ps = con.prepareStatement("INSERT INTO users(username,password) VALUES(?,?)");
                    ps.setString(1, username);
                    ps.setString(2, hashed);

                    int result = ps.executeUpdate();
                    if (result > 0) {
                        message = "Registration successful! Redirecting to login...";
                        msgType = "success";
                    } else {
                        message = "Registration failed. Please try again.";
                        msgType = "error";
                    }
                }
            } catch (Exception e) {
                message = "Server error: " + e.getMessage();
                msgType = "error";
            }finally {
                try { if (rs != null) rs.close(); } catch(Exception ignored) {}
                try { if (ps != null) ps.close(); } catch(Exception ignored) {}
                try { if (con != null) con.close(); } catch(Exception ignored) {}
            
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register - RechargeX_pro</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: white;
            margin: 0;
            padding: 0;
        }
        * { box-sizing: border-box; }

        .container {
            max-width: 400px;
            margin: 80px auto;
            padding: 20px;
        }

        h2 {
            text-align: center;
            margin-bottom: 8px;
        }
        .muted {
            text-align: center;
            font-size: 14px;
            color: #666;
            margin-bottom: 20px;
        }

        /* Reusing plan-card style */
        .plan-card {
            background: #fff;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: 0.3s;
        }
        .plan-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }

        .field {
            margin-bottom: 15px;
        }
        .field input {
            width: 100%;
            padding: 12px 14px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            outline: none;
            transition: border 0.2s, box-shadow 0.2s;
        }
        .field input:focus {
            border: 1px solid #0055ff;
            box-shadow: 0 0 6px rgba(0,85,255,0.3);
        }

        button {
            width: 100%;
            padding: 12px;
            background: #0055ff;
            color: #fff;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: 0.3s;
            margin-top: 10px;
        }
        button:hover {
            background: #003bb5;
        }

        .muted-link {
            display: block;
            text-align: center;
            margin-top: 12px;
            font-size: 13px;
            color: #333;
            text-decoration: none;
        }
        .muted-link:hover { text-decoration: underline; }

        /* Flash message */
        .flash {
            text-align: center;
            margin-bottom: 15px;
            padding: 10px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: bold;
        }
        .flash.success { background: #d0f5e3; color: #0a8c3a; }
        .flash.error { background: #ffdada; color: #d00000; }
    </style>
</head>
<body>
<div class="container">
    <h2>Create an account</h2>
    <p class="muted">Join RechargeX_pro — secure sign up with hashed password storage.</p>

    <% if (message != null) { %>
        <div class="flash <%= msgType %>"><%= message %></div>
    <% } %>

    <div class="plan-card">
        <form action="register.jsp" method="post" autocomplete="on" novalidate>
            <div class="field">
                <input type="text" name="username" id="username" placeholder="Username" required minlength="3" maxlength="50">
            </div>
            <div class="field">
                <input type="password" name="password" id="password" placeholder="Password (min 6 chars)" required minlength="6" maxlength="72">
            </div>
            <button type="submit">Register</button>
            <a class="muted-link" href="index.jsp">Already have an account? Login</a>
        </form>
    </div>
</div>
</body>
</html>
