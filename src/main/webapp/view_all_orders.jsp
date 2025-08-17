<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*, com.util.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
<title>All Orders - Admin</title>
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
    width: 950px;
    margin: 40px auto;
    background: #fff;
    border-radius: 16px;
    padding: 30px 38px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.07);
}
h2 {
    color: #ff7043;
    text-align: center;
    margin-bottom: 20px;
}

/* Table */
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
}
th, td {
    border: 1px solid #ffb4a2;
    padding: 10px;
    vertical-align: top;
    text-align: left;
}
th {
    background: #ff7043;
    color: white;
}
select {
    padding: 4px 8px;
    border-radius: 6px;
    border: 1px solid #ccc;
}
input[type=submit] {
    background: #ff7043;
    color: white;
    border: none;
    padding: 6px 12px;
    border-radius: 6px;
    cursor: pointer;
    transition: background 0.3s;
}
input[type=submit]:hover {
    background: #ff5722;
}

/* Footer */
.admin-footer {
    background-color: #A8DADC;
    color: #264653;
    text-align: center;
    padding: 12px 0;
    position: fixed;
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
    <h1>📦 All Orders - Admin</h1>
    <div>
        <a href="admin_dashboard.jsp">Dashboard</a>
        <a href="manage_menu.jsp">Manage Menu</a>
        <a href="logout.jsp">Logout</a>
    </div>
</div>

<!-- Main Content -->
<div class="container">
<h2>All Orders</h2>
<table>
<tr>
    <th>Order ID</th>
    <th>Customer Login ID</th>
    <th>Order Details</th>
    <th>Status</th>
    <th>Action</th>
</tr>
<%
try (Connection con = DBConnection.getConnection();
     PreparedStatement ps = con.prepareStatement("SELECT order_id, user_id, status FROM ORDERS ORDER BY order_date DESC");
     ResultSet rs = ps.executeQuery()) {

    while (rs.next()) {
        int orderId = rs.getInt("order_id");
        String userId = rs.getString("user_id");
        String status = rs.getString("status");
%>
<tr>
    <td><%= orderId %></td>
    <td><%= userId %></td>
    <td>
    <%
    try (PreparedStatement psItems = con.prepareStatement(
        "SELECT fi.food_name, oi.quantity, fi.price FROM ORDER_ITEMS oi " +
        "JOIN FOOD_ITEMS fi ON oi.food_id = fi.food_id WHERE oi.order_id = ?")) {
        psItems.setInt(1, orderId);
        try (ResultSet rsItems = psItems.executeQuery()) {
            while (rsItems.next()) {
                out.print(rsItems.getString("food_name") + " (Qty: " + rsItems.getInt("quantity") +
                          ", Price: ₹" + rsItems.getInt("quantity")*rsItems.getDouble("price") + ")<br>");
            }
        }
    }
    %>
    </td>
<td>
<form method="post" action="UpdateOrderStatusServlet">
    <input type="hidden" name="order_id" value="<%= orderId %>"/>
<% if ("Delivered".equalsIgnoreCase(status)) { %>
    <select name="status" disabled>
        <option value="Delivered" selected>Delivered</option>
    </select>
<% } else { %>
    <select name="status">
        <option value="Pending" <%= "Pending".equalsIgnoreCase(status) ? "selected" : "" %>>Pending</option>
        <option value="Delivered" <%= "Delivered".equalsIgnoreCase(status) ? "selected" : "" %>>Delivered</option>
    </select>
<% } %>
</td>
<td>
<% if (!"Delivered".equalsIgnoreCase(status)) { %>
    <input type="submit" value="Update"/>
<% } else { %>
    <input type="submit" value="Update" disabled title="Already Delivered"/>
<% } %>
</form>
</td>
</tr>
<%
    }
} catch (Exception e) {
    out.println("<tr><td colspan='5' style='color:red;'>Error loading orders: " + e.getMessage() + "</td></tr>");
}
%>
</table>
</div>

<!-- Admin Footer -->
<div class="admin-footer">
    © 2025 Canteen Management System | Admin Panel
</div>

</body>
</html>