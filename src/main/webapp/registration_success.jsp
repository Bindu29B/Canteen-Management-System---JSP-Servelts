<%@ page contentType="text/html;charset=UTF-8" %>  
<!DOCTYPE html>  
<html>  
<head>  
<title>Registration Success</title>  
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

    /* CONTAINER */  
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

    h2 {  
            color: #7c5a92;
            font-weight: 500;
            margin-bottom: 25px;
            font-size: 1.4em; 
    }  

    p {  
        font-size: 1.1em;  
        margin: 6px 0;  
    }  

    /* BUTTON */  
    button {  
        margin-top: 20px;  
        padding: 10px 20px;  
        background: #ff8c94; /* Soft coral */  
        color: white;  
        border: none;  
        border-radius: 6px;  
        font-size: 1em;  
        cursor: pointer;  
        transition: background 0.3s ease;  
    }  

    button:hover {  
        background: #ff6f69; /* Slightly darker coral */  
    }  
 
</style>  
</head>  
<body>  
<!-- HEADER -->  
<%@ include file="common/Header.jsp" %> 

<div class="container">  
    <h2>🎉 Registration Successful!</h2>  
    <p><strong>User ID:</strong> ${userId}</p>  
    <p><strong>Email:</strong> ${email}</p>  
    <p><strong>Phone:</strong> ${phone}</p>  
    <form action="login.jsp">  
        <button type="submit">Go to Login</button>  
    </form>  
</div>  

<!-- FOOTER -->  
<%@ include file="common/footer.jsp" %>

</body>  
</html>