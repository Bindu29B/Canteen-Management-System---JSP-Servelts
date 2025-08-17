<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>User Login - Canteen Management System</title>
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

.container {
    width: 360px;
    margin: 50px auto;
    background: #ffffff;
    border-radius: 20px;
    padding: 25px;
    box-shadow: 0 8px 28px rgba(0,0,0,0.08);
    padding: 35px 45px;
    text-align: center;
    border: 3px solid #F4A26122;
}
h2 {
    text-align: center;
            color: #7c5a92;
            font-weight: 500;
            margin-bottom: 25px;
            font-size: 1.4em;
}
input, select {
    width: 100%;
    padding: 10px;
    margin: 8px 0 12px 0;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 1rem;
}
button {
    width: 100%;
    padding: 12px;
    background: #ff6600; /* Orange button */
    color: white;
    border: none;
    font-size: 1rem;
    border-radius: 6px;
    cursor: pointer;
}
button:hover {
    background: #e65c00; /* Darker orange on hover */
}
.error {
    color: red;
    font-size: 0.9rem;
    text-align: center;
    margin-bottom: 10px;
}
a {
    color: #ff6600;
    text-decoration: none;
}
a:hover {
    text-decoration: underline;
}

</style>
</head>
<body>
    <!-- HEADER -->
<%@ include file="common/Header.jsp" %>
<div class="container">
    <h2><i class="fa-solid fa-right-to-bracket"></i> User Login</h2>

    <%
    String error = request.getParameter("error");
    if (error != null) {
    %>
    <div class="error"><%= error %></div>
    <%
    }
    %>

    <form action="LoginServlet" method="post">
        <input type="text" name="userId" placeholder="User ID" required>
        <input type="password" name="password" placeholder="Password" required>
        <select name="role" required>
            <option value="">Select Role</option>
            <option value="customer">Customer</option>
            <option value="admin">Admin</option>
        </select>
        <button type="submit"><i class="fa-solid fa-arrow-right-to-bracket"></i> Login</button>
    </form>

    <div style="text-align:center; margin-top:15px;">
        <a href="register.jsp">New User? Register here</a>
    </div>
</div>
    <!-- FOOTER -->
<%@ include file="common/footer.jsp" %>
</body>
</html>