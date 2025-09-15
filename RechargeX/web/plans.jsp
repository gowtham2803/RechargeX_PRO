<%@ page contentType="text/html;charset=UTF-8" %>
<%
  String name = request.getParameter("name");
  String mobile = request.getParameter("mobile");
  String operator = request.getParameter("operator");
  String city = request.getParameter("city");
  if(name==null||mobile==null){ response.sendRedirect("recharge.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Recharge Plans - RechargeX_pro</title>
<style>
body {
  font-family: 'Segoe UI', sans-serif;
  background: #f1f3f6;
  margin:0;
  padding:0;
}
* {
  box-sizing: border-box; /* ensures padding/margin do not break layout */
}

.container {
  max-width: 1200px;
  margin: 30px auto;
  padding: 20px;
}

h2 {
  text-align:center;
  margin-bottom:10px;
}

.muted {
  text-align:center;
  font-size:14px;
  color:#666;
  margin-bottom:20px;
}

/* Tabs Navbar */
.tabs {
  display:flex;
  justify-content:center;
  margin-bottom:25px;
  gap: 10px;
}

.tab-btn {
  padding:10px 20px;
  border:none;
  border-radius:25px;
  cursor:pointer;
  background:#e0e0e0;
  color:#333;
  font-weight:bold;
  transition:0.3s;
}

.tab-btn.active {
  background:#0055ff;
  color:#fff;
}

/* Plans Grid */
.plans-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit,minmax(260px,1fr));
  gap: 25px;
  justify-items: center;
}

/* Plan Card */
.plan-card {
  background:#ffffff;
  border-radius:15px;
  padding:15px;
  box-shadow:0 4px 15px rgba(0,0,0,0.1);
  width: 100%;
  max-width: 280px;
  position:relative;
  transition:0.3s;
}

.plan-card:hover {
  transform:translateY(-5px);
  box-shadow:0 8px 25px rgba(0,0,0,0.15);
  padding: 5px;
}

/* Tags */
.tag {
  position:absolute;
  top:15px;
  left:15px;
  background:#d0e9ff;
  color:#0077ff;
  font-size:12px;
  font-weight:bold;
  padding:3px 6px;
  border-radius:5px;
}

.tag-red {
  background:#ffdada;
  color:#ff1a1a;
}

/* Price */
.plan-card h3 {
  font-size:24px;
  margin:20px 0 10px 0;
}

/* Details */
.plan-card p {
  font-size:14px;
  margin:5px 0;
  color:#555;
}

/* Buy Button */
.plan-card button {
  width:100%;
  padding:10px;
  background:#0055ff;
  color:#fff;
  font-weight:bold;
  border:none;
  border-radius:8px;
  cursor:pointer;
  margin-top:10px;
  transition:0.3s;
}

.plan-card button:hover {
  background:#003bb5;
}

.hidden { display:none; }

</style>
</head>
<body>

<div class="container">
<h2>Plans for <%= operator %></h2>
<p class="muted">User: <%= name %> | Mobile: <%= mobile %> | City: <%= city %></p>

<!-- Tabs -->
<div class="tabs">
  <button class="tab-btn active" data-tab="true5g">True5G</button>
  <button class="tab-btn" data-tab="unlimited">Unlimited</button>
  <button class="tab-btn" data-tab="dataaddon">Data Add-on</button>
</div>

<!-- Plans Sections -->
<div id="true5g" class="plans-grid">
  <div class="plan-card">
    <div class="tag">OFFER-GOLD+GIFTS+JIOHOME TRIAL</div>
    <div class="tag-red" style="top:35px; left:15px;">TRUE5G</div>
    <h3>₹349</h3>
    <p>Validity: 28 Days</p>
    <p>Data: 2 GB/Day</p>
    <p>+2 more OTT</p>
    <form action="confirm.jsp" method="post">
      <input type="hidden" name="name" value="<%= name %>">
      <input type="hidden" name="mobile" value="<%= mobile %>">
      <input type="hidden" name="operator" value="<%= operator %>">
      <input type="hidden" name="city" value="<%= city %>">
      <input type="hidden" name="plan" value="349">
      <button>Buy</button>
    </form>
  </div>
      <div class="plan-card">
    <div class="tag">OFFER-GOLD+GIFTS+JIOHOME TRIAL</div>
    <div class="tag-red" style="top:35px; left:15px;">TRUE5G</div>
    <h3>₹449</h3>
    <p>Validity: 48 Days</p>
    <p>Data: 2.5 GB/Day</p>
    <p>+2 more OTT</p>
    <form action="confirm.jsp" method="post">
      <input type="hidden" name="name" value="<%= name %>">
      <input type="hidden" name="mobile" value="<%= mobile %>">
      <input type="hidden" name="operator" value="<%= operator %>">
      <input type="hidden" name="city" value="<%= city %>">
      <input type="hidden" name="plan" value="349">
      <button>Buy</button>
    </form>
  </div>
      <div class="plan-card">
    <div class="tag">OFFER-GOLD+GIFTS+JIOHOME TRIAL</div>
    <div class="tag-red" style="top:35px; left:15px;">TRUE5G</div>
    <h3>₹699</h3>
    <p>Validity: 88 Days</p>
    <p>Data: 3 GB/Day</p>
    <p>+2 more OTT</p>
    <form action="confirm.jsp" method="post">
      <input type="hidden" name="name" value="<%= name %>">
      <input type="hidden" name="mobile" value="<%= mobile %>">
      <input type="hidden" name="operator" value="<%= operator %>">
      <input type="hidden" name="city" value="<%= city %>">
      <input type="hidden" name="plan" value="349">
      <button>Buy</button>
    </form>
  </div>
      <div class="plan-card">
    <div class="tag">OFFER-GOLD+GIFTS+JIOHOME TRIAL</div>
    <div class="tag-red" style="top:35px; left:15px;">TRUE5G</div>
    <h3>₹149</h3>
    <p>Validity: 18 Days</p>
    <p>Data: 1 GB/Day</p>
    <p>+2 more OTT</p>
    <form action="confirm.jsp" method="post">
      <input type="hidden" name="name" value="<%= name %>">
      <input type="hidden" name="mobile" value="<%= mobile %>">
      <input type="hidden" name="operator" value="<%= operator %>">
      <input type="hidden" name="city" value="<%= city %>">
      <input type="hidden" name="plan" value="349">
      <button>Buy</button>
    </form>
  </div>
  <div class="plan-card">
    <div class="tag">CRICKET DATA PACK</div>
    <div class="tag-red" style="top:35px; left:15px;">TRUE5G</div>
    <h3>₹77</h3>
    <p>Validity: 5 Days</p>
    <p>Data: 3 GB</p>
    <form action="confirm.jsp" method="post">
      <input type="hidden" name="name" value="<%= name %>">
      <input type="hidden" name="mobile" value="<%= mobile %>">
      <input type="hidden" name="operator" value="<%= operator %>">
      <input type="hidden" name="city" value="<%= city %>">
      <input type="hidden" name="plan" value="77">
      <button>Buy</button>
    </form>
  </div>
</div>

<div id="unlimited" class="plans-grid hidden">
  <div class="plan-card">
    <div class="tag">UNLIMITED TALK + DATA</div>
    <h3>₹299</h3>
    <p>Validity: 28 Days</p>
    <p>Data: Unlimited</p>
    <form action="confirm.jsp" method="post">
      <input type="hidden" name="name" value="<%= name %>">
      <input type="hidden" name="mobile" value="<%= mobile %>">
      <input type="hidden" name="operator" value="<%= operator %>">
      <input type="hidden" name="city" value="<%= city %>">
      <input type="hidden" name="plan" value="499">
      <button>Buy</button>
    </form>
  </div>
      <div class="plan-card">
    <div class="tag">UNLIMITED TALK + DATA</div>
    <h3>₹499</h3>
    <p>Validity: 56 Days</p>
    <p>Data: Unlimited</p>
    <form action="confirm.jsp" method="post">
      <input type="hidden" name="name" value="<%= name %>">
      <input type="hidden" name="mobile" value="<%= mobile %>">
      <input type="hidden" name="operator" value="<%= operator %>">
      <input type="hidden" name="city" value="<%= city %>">
      <input type="hidden" name="plan" value="499">
      <button>Buy</button>
    </form>
  </div>
      <div class="plan-card">
    <div class="tag">UNLIMITED TALK + DATA</div>
    <h3>₹799</h3>
    <p>Validity: 88 Days</p>
    <p>Data: Unlimited</p>
    <form action="confirm.jsp" method="post">
      <input type="hidden" name="name" value="<%= name %>">
      <input type="hidden" name="mobile" value="<%= mobile %>">
      <input type="hidden" name="operator" value="<%= operator %>">
      <input type="hidden" name="city" value="<%= city %>">
      <input type="hidden" name="plan" value="499">
      <button>Buy</button>
    </form>
  </div>
  <!-- Add more unlimited plans here -->
</div>

<div id="dataaddon" class="plans-grid hidden">
  <div class="plan-card">
    <div class="tag">ADD-ON DATA PACK</div>
    <h3>₹49</h3>
    <p>Validity: 7 Days</p>
    <p>Data: 1 GB</p>
    <form action="confirm.jsp" method="post">
      <input type="hidden" name="name" value="<%= name %>">
      <input type="hidden" name="mobile" value="<%= mobile %>">
      <input type="hidden" name="operator" value="<%= operator %>">
      <input type="hidden" name="city" value="<%= city %>">
      <input type="hidden" name="plan" value="49">
      <button>Buy</button>
    </form>
  </div>
      <div class="plan-card">
    <div class="tag">ADD-ON DATA PACK</div>
    <h3>₹99</h3>
    <p>Validity: 28 Days</p>
    <p>Data: 15 GB</p>
    <form action="confirm.jsp" method="post">
      <input type="hidden" name="name" value="<%= name %>">
      <input type="hidden" name="mobile" value="<%= mobile %>">
      <input type="hidden" name="operator" value="<%= operator %>">
      <input type="hidden" name="city" value="<%= city %>">
      <input type="hidden" name="plan" value="49">
      <button>Buy</button>
    </form>
  </div>
  <!-- Add more data add-on plans here -->
</div>

</div>

<script>
// Tab switching
const tabs = document.querySelectorAll('.tab-btn');
const sections = document.querySelectorAll('.plans-grid');

tabs.forEach(tab => {
  tab.addEventListener('click', () => {
    // Remove active from all tabs
    tabs.forEach(t => t.classList.remove('active'));
    tab.classList.add('active');

    // Show/hide sections
    const target = tab.getAttribute('data-tab');
    sections.forEach(sec => {
      if(sec.id === target) sec.classList.remove('hidden');
      else sec.classList.add('hidden');
    });
  });
});
</script>

</body>
</html>
