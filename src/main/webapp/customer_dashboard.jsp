<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Dashboard - PastelBites</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #F1FAEE;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        /* HEADER */
        header {
            background-color: #A8DADC;
            color: #264653;
            padding: 15px 20px;
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }
        header h1 {
            margin: 0;
            font-size: 1.8em;
            font-weight: 600;
        }
        .nav-links {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }
        .nav-links a {
            text-decoration: none;
            padding: 8px 14px;
            border-radius: 6px;
            background: #ffb4a2;
            color: #333;
            font-weight: 500;
            transition: all 0.3s ease;
            box-shadow: 0 3px 8px rgba(255, 180, 162, 0.2);
        }
        .nav-links a:hover {
            background: #ffd6a5;
            transform: translateY(-2px);
        }
        .logout-btn {
            background: #f28482 !important;
            color: #fff !important;
        }
        .logout-btn:hover {
            background: #e76f51 !important;
        }

        /* MAIN CONTENT */
        .container {
            max-width: 450px;
            margin: auto;
            background: #ffffff;
            border-radius: 15px;
            box-shadow: 0 8px 26px rgba(0,0,0,0.08);
            padding: 40px;
            text-align: center;
        }
        .container h2 {
            color: #7c5a92;
            margin-bottom: 15px;
        }
        .container p {
            color: #555;
            font-size: 1.1em;
            line-height: 1.5;
        }

    </style>
</head>
<body>

    <!-- HEADER -->
    <header>
        <h1>PastelBites</h1>
        <div class="nav-links">
            <a href="view_menu.jsp"><i class="fa-solid fa-utensils"></i> Menu</a>
            <a href="place_order.jsp"><i class="fa-solid fa-basket-shopping"></i> Place Order</a>
            <a href="order_history.jsp"><i class="fa-solid fa-box-archive"></i> Orders</a>
            <a href="logout.jsp" class="logout-btn"><i class="fa-solid fa-arrow-right-from-bracket"></i> Logout</a>
            
        </div>
    </header>

    <!-- MAIN CONTENT -->
    <div class="container">
        <h2>Welcome, <span style="text-transform:uppercase;"><%= session.getAttribute("userId") %></span>!</h2>
        <p>At <strong>PastelBites</strong>, we believe healthy can be delicious. 
        Explore our plant-powered menu, place your orders with ease, and enjoy quick service 
        in a colorful, cozy environment. Whether you’re craving a protein-packed wrap, a 
        refreshing smoothie, or a wholesome bowl, we’ve got you covered!</p>
    </div>

    <!-- FOOTER -->
   <%@ include file="common/footer.jsp" %>

</body>
</html>