<%@ page contentType="text/html; charset=UTF-8" session="true" %>
<!DOCTYPE html>
<html>
<head>
<title>Admin Dashboard - Canteen Management System</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
<style>
body {
    font-family: 'Segoe UI', Arial, sans-serif;
    background-color: #F1FAEE;
    margin: 0; padding: 0;
}

/* Header */
.admin-header {
            background-color: #A8DADC;
            color: #264653;
            padding: 15px 20px;
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
}
.admin-header h1 {
            margin: 0;
            font-size: 1.8em;
            font-weight: 600;
}
.admin--links {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }
.admin-header a {
            text-decoration: none;
            padding: 8px 14px;
            border-radius: 6px;
            background: #ffb4a2;
            color: #333;
            font-weight: 500;
            transition: all 0.3s ease;
            box-shadow: 0 3px 8px rgba(255, 180, 162, 0.2);
}
.admin-header a:hover {
            background: #ffd6a5;
            transform: translateY(-2px);
}

/* Container */
.container {
    width: 620px;
    margin: 40px auto;
    background: #fff;
    border-radius: 16px;
    padding: 30px 38px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.07);
    text-align: center;
}
h2 {
    color: #ff7043;
    margin-bottom: 10px;
}
.intro-text {
    color: #ae5a34;
    font-size: 1em;
    margin-bottom: 20px;
}

/* Action List */
ul {
    list-style: none;
    padding: 0;
    margin-top: 24px;
}
ul li {
    background: #ff7043;
    color: white;
    margin: 15px 0;
    font-size: 1.15em;
    padding: 14px 24px;
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: flex-start;
}
ul li i {
    margin-right: 18px;
    font-size: 1.3em;
}
ul li a {
    color: white;
    text-decoration: none;
    display: block;
    width: 100%;
}
ul li a:hover {
    text-decoration: underline;
}
.logout {
    background: #ffb300;
}

/* Footer */
.admin-footer {
            background-color: #A8DADC;
            color: #264653;
            text-align: center;
            padding: 12px 0;
            position: fixed;
            margin-top: auto;
            bottom: 0;
            width: 100%;
            font-size: 0.9rem;
            border-top: 2px solid #F4A261;
}
</style>
</head>
<body>

<!-- Admin Header -->
<div class="admin-header">
    <h1>🍽 Canteen Management - Admin</h1>
    <div>
        <a href="view_all_orders.jsp">View Orders</a>
        <a href="manage_menu.jsp">Manage Menu</a>
        <a href="logout.jsp">Logout</a>
    </div>
</div>

<!-- Main Content -->
<div class="container">
    <h2>Welcome, <span style="text-transform:uppercase;"><%= session.getAttribute("userId") %></span>!</h2>
    <p class="intro-text">Here you can manage and oversee all aspects of the Canteen Management System.</p>
    
    <ul>
        <li><i class="fa-solid fa-list-check"></i> <a href="view_all_orders.jsp">View All Orders</a></li>
        <li><i class="fa-solid fa-pen-to-square"></i> <a href="manage_menu.jsp">Manage Menu</a></li>
        <li class="logout"><i class="fa-solid fa-arrow-right-from-bracket"></i> <a href="logout.jsp">Logout</a></li>
    </ul>
</div>

<!-- Admin Footer -->
<div class="admin-footer">
    © 2025 Canteen Management System | Admin Panel
</div>

</body>
</html>