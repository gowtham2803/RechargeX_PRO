<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Recharge</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f1f3f6;
            margin:0;
            padding:0;
        }
        * {
            box-sizing: border-box;
        }

        .container {
            max-width: 500px;
            margin: 50px auto;
            padding: 30px;
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        h2 {
            text-align:center;
            margin-bottom:20px;
            color:#333;
        }

        .form-grid {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        label {
            font-weight: bold;
            font-size: 14px;
            margin-bottom: 5px;
            color:#333;
        }

        input, select {
            padding: 12px;
            border-radius: 8px;
            border:1px solid #ccc;
            outline: none;
            font-size: 14px;
            transition:0.3s;
        }

        input:focus, select:focus {
            border-color:#0055ff;
            box-shadow:0 0 5px rgba(0,85,255,0.3);
        }

        .btn {
            padding: 12px;
            background:#0055ff;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
            color: #fff;
        }

        .btn:hover {
            background:#003bb5;
            transform: translateY(-2px);
        }

        /* Toast Notification */
        .toast {
            visibility: hidden;
            min-width: 250px;
            margin-left: -125px;
            background: #333;
            color: #fff;
            text-align: center;
            border-radius: 8px;
            padding: 12px;
            position: fixed;
            z-index: 1;
            left: 50%;
            bottom: 30px;
            font-size: 14px;
            opacity: 0;
            transition: opacity 0.5s, bottom 0.5s;
        }

        .toast.show {
            visibility: visible;
            opacity: 1;
            bottom: 50px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Mobile Recharge</h2>
    <form action="plans.jsp" method="post" class="form-grid">
        
        <label for="name">Name</label>
        <input type="text" id="name" name="name" required placeholder="Enter Full Name">

        <label for="mobile">Mobile Number</label>
        <input type="text" id="mobile" name="mobile" required placeholder="Enter 10-digit number" pattern="[0-9]{10}">

        <label for="operator">Operator</label>
        <select id="operator" name="operator" required>
            <option value="" disabled selected>Select Operator</option>
            <option value="Jio">Jio</option>
            <option value="Airtel">Airtel</option>
            <option value="VI">VI</option>
            <option value="BSNL">BSNL</option>
        </select>
        
        <label for="city">City</label>
        <select id="city" name="city" required>
            <option value="" disabled selected>Select City</option>
            <option value="Chennai">Chennai</option>
            <option value="Banglore">Banglore</option>
            <option value="Mumbai">Mumbai</option>
            <option value="Delhi">Delhi</option>
        </select>

        <button type="submit" class="btn">Recharge Now</button>
    </form>
</div>

<!-- Toast Notification -->
<div class="toast" id="toast">Recharge Successful!</div>

<script>
    // Example toast trigger
    function showToast(message) {
        let toast = document.getElementById("toast");
        toast.innerText = message;
        toast.classList.add("show");
        setTimeout(() => { toast.classList.remove("show"); }, 3000);
    }
</script>

</body>
</html>
