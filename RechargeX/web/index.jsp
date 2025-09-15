<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - RechargeX</title>
    <style>
        * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
        font-family: "Poppins", sans-serif;
        }
        body::before {
        content: "";
        position: absolute;
        top: 0; left: 0; right: 0; bottom: 0;
        background: rgba(0, 0, 0, 0.3); /* semi-transparent dark overlay */
        z-index: -1;
        }
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            
            background: url('images/Recharge.png') no-repeat center center fixed;
            background-size: cover;
            position: relative;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        .shape {
            position: absolute;
            width: 200px;
            height: 200px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            animation: float 8s ease-in-out infinite;
        }
        .shape:nth-child(1) {
            top: -50px;
            left: -50px;
        }
        .shape:nth-child(2) {
            bottom: -50px;
            right: -50px;
        }
        header {
            width: 100%;
            padding: 50px 0;
            text-align: center;
            position: fixed;
            top: 0;
            left: 0;   
        }
        .site-title {
            font-size: 34px;
            font-weight: bold;
            color: #fff;
            text-shadow: 
                 0 0 5px #ff4d4d,
                 0 0 10px #ff1a1a,
                 0 0 20px #e60000,
                 0 0 40px #b30000;
            animation: glow 2s ease-in-out infinite alternate;
        }
        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(20px); }
        }

        /* Container for both cards */
        .auth-container {
            display: flex;
            gap: 40px; /* spacing between user & admin login */
            position: relative;
            z-index: 1;
        }

        .auth-card {
            position: relative;
            width: 350px;
            padding: 30px;
            background: rgba(255, 255, 255, 0.15);
            border-radius: 15px;
            backdrop-filter: blur(10px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.3);
            text-align: center;
            color: white;
            animation: fadeIn 1s ease-in-out;
            z-index: 1;
        }
        @keyframes fadeIn {
        from { opacity: 0; transform: scale(0.95); }
        to { opacity: 1; transform: scale(1); }
        }
        .auth-card h2 {
            margin-bottom: 20px;
            font-size: 24px;
        }
        .input-box {
            margin: 10px 0;
        }
        .input-box input {
            width: 100%;
            padding: 12px;
            border: none;
            outline: none;
            border-radius: 10px;
            background: rgba(255, 255, 255, 0.25);
            color: #fff;
            font-size: 14px;
        }
        .input-box input::placeholder {
        color: rgba(255, 255, 255, 0.7);
        }
        button {
            width: 100%;
            padding: 12px;
            background: #FF0000;
            border: none;
            border-radius: 8px;
            color: white;
            font-size: 16px;
            font-weight: bold;
            margin-top: 15px;
            cursor: pointer;
            transition: background 0.3s;
        }
        button:hover {
            background: #ff4f81;
        }
        .auth-card p {
            margin-top: 15px;
            font-size: 14px;
        }
        .auth-card a {
            color: red;
            text-decoration: none;
        }
        .auth-card a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <!-- Floating background shapes -->
    <div class="shape"></div>
    <div class="shape"></div>
    
    <header>
    <div class="site-title">RechargeX_pro</div>
    </header>
    

    <!-- Both Login Cards -->
    <div class="auth-container">
        <!-- User Login -->
        <div class="auth-card">
            <h2>User Login</h2>
            <form action="logincheck.jsp" method="post">
                <div class="input-box">
                    <input type="text" name="username" placeholder="Username" required>
                </div>
                <div class="input-box">
                    <input type="password" name="password" placeholder="Password" required>
                </div>
                <button type="submit">Login</button>
            </form>
            <p>Don’t have an account? <a href="register.jsp">Register</a></p>
        </div>

        <!-- Admin Login -->
        <div class="auth-card">
            <h2>Admin Login</h2>
            <form action="logincheck.jsp" method="post">
                <div class="input-box">
                    <input type="text" name="username" placeholder="Admin Username" required>
                </div>
                <div class="input-box">
                    <input type="password" name="password" placeholder="Admin Password" required>
                </div>
                <button type="submit">Admin Login</button>
            </form>
        </div>
    </div>
</body>
</html>
