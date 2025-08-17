<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*, com.util.DBConnection" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<title>Order History - PastelBites</title>
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
        background: #f4978e !important;
        color: #fff !important;
    }
    .logout-btn:hover {
        background: #e76f51 !important;
    }

    /* CONTAINER */
    .container {
        flex: 1;
        max-width: 900px;
        margin: 30px auto;
        background: #ffffff;
        border-radius: 15px;
        box-shadow: 0 8px 26px rgba(0,0,0,0.08);
        padding: 30px;
    }
    h2 {
        color: #7c5a92;
        text-align: center;
        margin-bottom: 20px;
    }

    /* TABLE */
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
        border-radius: 8px;
        overflow: hidden;
    }
    th {
        background: #A8DADC;
        color: #264653;
        padding: 12px;
        font-weight: 600;
    }
    td {
        padding: 10px;
        border: 1px solid #ddd;
        text-align: center;
        vertical-align: top;
    }
    tr:nth-child(even) {
        background-color: #f9f9f9;
    }
    tr:nth-child(odd) {
        background-color: #fff;
    }
    tr:hover {
        background-color: #f1f1f1;
    }

    /* FOOTER */
    footer {
        background-color: #A8DADC;
        color: #264653;
        text-align: center;
        padding: 10px 0;
        margin-top: auto;
        border-top: 2px solid #F4A261;
        font-size: 0.9rem;
    }
</style>
</head>
<body>

<!-- HEADER -->
<header>
    <h1>PastelBites</h1>
    <div class="nav-links">
        <a href="customer_dashboard.jsp"><i class="fa-solid fa-house"></i> Dashboard</a>
        <a href="view_menu.jsp"><i class="fa-solid fa-utensils"></i> Menu</a>
        <a href="place_order.jsp"><i class="fa-solid fa-basket-shopping"></i> Place Order</a>
        <a href="order_history.jsp"><i class="fa-solid fa-clock-rotate-left"></i> Orders</a>
        <a href="logout.jsp" class="logout-btn"><i class="fa-solid fa-arrow-right-from-bracket"></i> Logout</a>
    </div>
</header>

<!-- MAIN CONTENT -->
<div class="container">
<h2>Your Order History</h2>
<table>
<tr><th>Order ID</th><th>Date</th><th>Items</th><th>Total</th><th>Status</th></tr>
<%
String userId = (String) session.getAttribute("userId");

try (Connection con = DBConnection.getConnection();
     PreparedStatement ps = con.prepareStatement(
         "SELECT * FROM ORDERS WHERE user_id=? ORDER BY order_date DESC")) {

    ps.setString(1, userId);
    try (ResultSet rs = ps.executeQuery()) {
        boolean found = false;
        while (rs.next()) {
            found = true;
            int orderId = rs.getInt("order_id");
%>
<tr>
    <td><%= orderId %></td>
    <td><%= rs.getTimestamp("order_date") %></td>
    <td>
    <%
    try (PreparedStatement psItems = con.prepareStatement(
            "SELECT food_name, quantity FROM ORDER_ITEMS oi " +
            "JOIN FOOD_ITEMS fi ON oi.food_id = fi.food_id " +
            "WHERE oi.order_id=?")) {
        psItems.setInt(1, orderId);
        try (ResultSet rsItems = psItems.executeQuery()) {
            while (rsItems.next()) {
                out.print(rsItems.getString("food_name") + " (x" + rsItems.getInt("quantity") + ")<br/>");
            }
        }
    }
    %>
    </td>
    <td>₹<%= rs.getDouble("total_amount") %></td>
    <td><%= rs.getString("status") %></td>
</tr>
<%
        }
        if (!found) {
            out.print("<tr><td colspan='5' style='color:red;font-weight:bold;'>❌ No orders found.</td></tr>");
        }
    }
} catch (Exception e) {
    out.print("<tr><td colspan='5' style='color:red;'>Error loading orders: " + e.getMessage() + "</td></tr>");
}
%>
</table>
</div>

<!-- FOOTER -->
<footer>
    <em>Wholesome bites, pastel vibes — the future of canteen dining!</em><br>
    &copy; 2025 PastelBites Canteen Hub
</footer>

</body>
</html>

