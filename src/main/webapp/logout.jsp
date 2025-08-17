<%@ page contentType="text/html;charset=UTF-8" %>
<%
    if (session != null) {
        session.invalidate();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Logout</title>
    <style>
        /* General Page Styling */
        body {
            font-family: 'Segoe UI', Tahoma, sans-serif;
            background: linear-gradient(135deg, #f9f7f7, #e3f6f5);
            margin: 0;
            padding: 0;
            text-align: center;
            display: flex;
            flex-direction: column;
            justify-content: center;
            height: 100vh;
            color: #333;
        }

        /* Card Styling */
        .box {
            background: #ffffff;
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.08);
            display: inline-block;
            animation: fadeIn 0.5s ease-in-out;
        }

        /* Heading */
        h2 {
            color: #5c5470;
            margin-bottom: 10px;
        }

        /* Link Styling */
        a {
            display: inline-block;
            margin-top: 15px;
            padding: 10px 20px;
            background: #a6e3e9;
            color: #05445e;
            font-weight: bold;
            border-radius: 25px;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        a:hover {
            background: #71c9ce;
            transform: scale(1.05);
        }

        /* Footer Styling */
        footer {
            margin-top: auto;
            padding: 10px;
            background: #defcf9;
            color: #555;
            font-size: 14px;
            text-align: center;
            border-top: 1px solid #d0ece7;
        }

        /* Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <div class="box">
        <h2>You have been logged out successfully!</h2>
        <p><a href="login.jsp">Click here to Login again</a></p>
    </div>

    <footer>
        &copy; 2025 Canteen Management System. All rights reserved.
    </footer>
</body>
</html>
