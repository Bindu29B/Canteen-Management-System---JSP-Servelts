<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*, java.util.*, com.util.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
<title>Manage Menu - Admin</title>
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
    margin-top: 15px;
}
th, td {
    border: 1px solid #ffb4a2;
    padding: 12px 14px;
    text-align: center;
    vertical-align: middle;
}
th {
    background: #ff7043;
    color: white;
    font-weight: 600;
}

/* Form elements */
input, select {
    padding: 6px 8px;
    border-radius: 6px;
    border: 1px solid #ccc;
    margin: 4px 0;
}
input[type=text], input[type=number] {
    width: 100%;
    box-sizing: border-box;
}

/* Buttons */
button, input[type=submit] {
    background: #ff7043;
    color: white;
    border: none;
    padding: 6px 12px;
    border-radius: 6px;
    cursor: pointer;
    transition: background 0.3s;
}
button:hover, input[type=submit]:hover {
    background: #ff5722;
}

.error {
    color: red;
    margin-bottom: 15px;
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
<script>
function confirmDelete(foodId) {
    if (confirm("Are you sure you want to delete this item?")) {
        window.location.href = "DeleteMenuItemServlet?food_id=" + foodId;
    }
}
</script>
</head>
<body>

<!-- Admin Header -->
<div class="admin-header">
    <h1>🍴 Manage Menu - Admin</h1>
    <div>
        <a href="admin_dashboard.jsp">Dashboard</a>
        <a href="view_all_orders.jsp">View Orders</a>
        <a href="logout.jsp">Logout</a>
    </div>
</div>

<!-- Main Content -->
<div class="container">
<h2>Manage Menu</h2>

<!-- Add new menu item -->
<form action="AddMenuItemServlet" method="post">
    <input type="text" name="food_name" placeholder="Food Name" required>
    <input type="text" name="category" placeholder="Category" required>
    <input type="number" step="0.01" name="price" placeholder="Price" required min="0">
    <select name="availability" required>
        <option value="true">Available</option>
        <option value="false">Not Available</option>
    </select>
    <input type="submit" value="Add Item">
</form>

<table>
<tr>
    <th>Food ID</th>
    <th>Name</th>
    <th>Category</th>
    <th>Price</th>
    <th>Availability</th>
    <th>Actions</th>
</tr>
<%
try (Connection con = DBConnection.getConnection();
     PreparedStatement ps = con.prepareStatement("SELECT food_id, food_name, category, price, availability FROM FOOD_ITEMS ORDER BY food_id ASC");
     ResultSet rs = ps.executeQuery()) {

    while (rs.next()) {
%>
<tr>
<form action="UpdateMenuItemServlet" method="post" style="display:inline;">
    <td><%= rs.getInt("food_id") %>
        <input type="hidden" name="food_id" value="<%= rs.getInt("food_id") %>">
    </td>
    <td><input type="text" name="food_name" value="<%= rs.getString("food_name") %>" required></td>
    <td><input type="text" name="category" value="<%= rs.getString("category") %>" required></td>
    <td><input type="number" step="0.01" min="0" name="price" value="<%= rs.getDouble("price") %>" required></td>
    <td>
        <select name="availability">
            <option value="true" <%= rs.getBoolean("availability") ? "selected" : "" %>>Available</option>
            <option value="false" <%= !rs.getBoolean("availability") ? "selected" : "" %>>Not Available</option>
        </select>
    </td>
    <td>
        <input type="submit" value="Edit">
        <button type="button" onclick="confirmDelete(<%= rs.getInt("food_id") %>)">Delete</button>
    </td>
</form>
</tr>
<%
    }
} catch (Exception e) {
    out.print("<tr><td colspan='6' style='color:red;'>Error loading menu: "+e.getMessage()+"</td></tr>");
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