<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*, com.util.DBConnection" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<title>Place Order - PastelBites</title>
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
        max-width: 800px;
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

    /* MESSAGES */
    .message {
        text-align: center;
        font-weight: bold;
        margin-bottom: 15px;
    }
    .success {
        color: green;
    }
    .error {
        color: red;
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

    /* BUTTONS */
    input[type="submit"] {
        background: #ffb4a2;
        color: #333;
        padding: 10px 20px;
        border: none;
        cursor: pointer;
        font-weight: 500;
        border-radius: 6px;
        transition: background 0.3s ease;
    }
    input[type="submit"]:hover {
        background: #ffd6a5;
    }
    input[type="number"] {
        width: 60px;
        padding: 5px;
        border: 1px solid #ccc;
        border-radius: 4px;
        text-align: center;
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
        <a href="order_history.jsp"><i class="fa-solid fa-box-archive"></i> Orders</a>
        <a href="logout.jsp" class="logout-btn"><i class="fa-solid fa-arrow-right-from-bracket"></i> Logout</a>
    </div>
</header>

<!-- MAIN CONTENT -->
<div class="container">
    <h2>Place Your Order</h2>

    <!-- Show success/error message -->
    <%
    String msg = request.getParameter("msg");
    String error = request.getParameter("error");
    if (msg != null) { %>
        <div class="message success"><%= msg %></div>
    <% } else if (error != null) { %>
        <div class="message error"><%= error %></div>
    <% } %>

    <form action="PlaceOrderServlet" method="post">
        <table>
            <tr><th>Select</th><th>Name</th><th>Category</th><th>Price</th><th>Quantity</th></tr>
            <%
            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM FOOD_ITEMS WHERE availability = true");
                 ResultSet rs = ps.executeQuery()) {

                boolean found = false;
                while (rs.next()) {
                    found = true;
            %>
            <tr>
                <td><input type="checkbox" name="food_id" value="<%= rs.getInt("food_id") %>"></td>
                <td><%= rs.getString("food_name") %></td>
                <td><%= rs.getString("category") %></td>
                <td>₹<%= rs.getDouble("price") %></td>
                <td><input type="number" min="1" name="qty_<%= rs.getInt("food_id") %>" value="1"></td>
            </tr>
            <%
                }
                if (!found) {
                    out.print("<tr><td colspan='5' style='color:red;font-weight:bold;'>❌ No available items to order.</td></tr>");
                }
            } catch (Exception e) {
                out.print("<tr><td colspan='5' style='color:red;'>Error loading menu: " + e.getMessage() + "</td></tr>");
            }
            %>
        </table>
        <br/>
        <input type="submit" value="Place Order"/>
    </form>
</div>

<!-- FOOTER -->
<footer>
    <em>Wholesome bites, pastel vibes — the future of canteen dining!</em><br>
    &copy; 2025 PastelBites Canteen Hub
</footer>

</body>
</html>