<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>PastelBites - Canteen Hub</title>
    <!-- Import Font Awesome for icons -->
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

        

        /* Container */
        .container {
            flex: 1;
            width: 500px;
            margin: 50px auto;
            background: #ffffff;
            border-radius: 20px;
            box-shadow: 0 8px 28px rgba(0,0,0,0.08);
            padding: 35px 45px;
            text-align: center;
            border: 3px solid #F4A26122;
        }

        /* Stickers */
        .sticker-row {
            margin-bottom: 18px;
        }
        .sticker-row i {
            font-size: 48px;
            margin: 0 10px;
            vertical-align: middle;
            transition: transform 0.25s ease, filter 0.25s ease;
            filter: drop-shadow(0 2px 4px rgba(0,0,0,0.08));
        }
        .sticker-row i:hover {
            transform: scale(1.2);
            filter: brightness(1.15);
        }

        /* Headings */
        h2 {
            color: #7c5a92;
            font-weight: 500;
            margin-bottom: 25px;
            font-size: 1.4em;
        }

        /* Buttons */
        a.action-btn {
            display: block;
            width: 100%;
            margin: 14px 0;
            padding: 14px;
            background: linear-gradient(90deg, #a8dadc 0%, #ffd6a5 100%);
            color: #264653;
            font-weight: bold;
            text-decoration: none;
            border-radius: 8px;
            font-size: 1.1em;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(168, 218, 220, 0.25);
        }
        a.action-btn:hover {
            background: linear-gradient(90deg, #bde0fe 0%, #ffc8dd 100%);
            color: #1d3557;
            transform: translateY(-2px);
        }


        /* Icon colors - plant protein theme */
        .fa-seedling { color: #6ab04c; }
        .fa-carrot { color: #e67e22; }
        .fa-lemon { color: #f1c40f; }
        .fa-egg { color: #f6e58d; }
        /* .fa-fish { color: #60a3bc; } */
    </style>
</head>
<%@ include file="common/Header.jsp" %>
<body>

    

    <!-- MAIN DASHBOARD -->
    <div class="container">
        <div class="sticker-row">
            <i class="fa-solid fa-seedling" title="Plant Protein"></i>
            <i class="fa-solid fa-carrot" title="Fresh Veggies"></i>
            <i class="fa-solid fa-lemon" title="Citrus Energy"></i>
            <i class="fa-solid fa-egg" title="Organic Eggs"></i>
 
        </div>
        <h2>Welcome to PastelBites Dashboard</h2>

        <a href="login.jsp" class="action-btn">
            <i class="fa-solid fa-user"></i> Customer Login/Admin Login
        </a>

        <a href="register.jsp" class="action-btn">
            <i class="fa-solid fa-user-plus"></i> New Customer Registration
        </a>
    </div>
    
    <%@ include file="common/footer.jsp" %>

</body>
</html>