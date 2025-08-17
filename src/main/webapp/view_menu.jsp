<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*, com.util.DBConnection" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<title>View Menu - PastelBites</title>
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

    /* CONTAINER */
    .container {
        flex: 1;
        max-width: 1200px;
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

    /* SEARCH */
    #searchBar {
        width: 60%;
        padding: 8px;
        border: 1px solid #ffb4a2;
        border-radius: 6px;
        outline: none;
    }
    #searchBtn {
        background: #ffb4a2;
        color: #333;
        border: none;
        padding: 8px 18px;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 500;
    }
    #searchBtn:hover {
        background: #ffd6a5;
    }

    /* TABLE */
    .menu-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    .menu-table th {
        background: #A8DADC;
        color: #264653;
    }
    .menu-table th, .menu-table td {
        padding: 10px;
        border: 1px solid #ccc;
        text-align: center;
    }
    .menu-table tr:nth-child(even) {
        background: #f9f9f9;
    }
    .menu-table tr:nth-child(odd) {
        background: #fff;
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
    <h2>Available Menu</h2>
    <form method="get" action="view_menu.jsp" style="text-align:center;">
        <input type="text" name="search" id="searchBar" placeholder="Search by food name or category"
        value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>"/>
        <button type="submit" id="searchBtn">Search</button>
    </form>

    <table class="menu-table">
        <tr><th>ID</th><th>Name</th><th>Category</th><th>Price</th><th>Availability</th></tr>
        <%
        String search = request.getParameter("search");
        String sql = "SELECT * FROM FOOD_ITEMS";
        boolean hasSearch = search != null && !search.trim().isEmpty();
        if (hasSearch) {
            sql += " WHERE LOWER(food_name) LIKE ? OR LOWER(category) LIKE ?";
        }
        boolean found = false;
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            if (hasSearch) {
                String p = "%" + search.toLowerCase() + "%";
                ps.setString(1, p);
                ps.setString(2, p);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    found = true;
        %>
        <tr>
            <td><%= rs.getInt("food_id") %></td>
            <td><%= rs.getString("food_name") %></td>
            <td><%= rs.getString("category") %></td>
            <td>₹<%= rs.getDouble("price") %></td>
            <td><%= rs.getBoolean("availability") ? "Available" : "Not Available" %></td>
        </tr>
        <%
                }
            }
        } catch (Exception e) {
            out.print("<tr><td colspan='5' style='color:red;'>Error loading menu: " + e.getMessage() + "</td></tr>");
        }
        if (!found) {
            out.print("<tr><td colspan='5' style='color:red;font-weight:bold;'>❌ No items available matching your search.</td></tr>");
        }
        %>
    </table>
</div>

<!-- FOOTER -->
   <%@ include file="common/footer.jsp" %>
</body>
</html>