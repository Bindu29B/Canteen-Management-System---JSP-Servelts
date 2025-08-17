<%@ page contentType="text/html;charset=UTF-8" %>  
<!DOCTYPE html>  
<html>  
<head>  
<title>Customer Registration - PastelBites</title>  
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


    /* Form Container */  
    .container {  
        width: 450px;  
        margin: 40px auto;  
        background: #fff;  
        border-radius: 15px;  
        padding: 30px 35px;  
        box-shadow: 0 8px 26px rgba(0,0,0,0.10);  
    }  
    h2 {  
        text-align: center;  
        color: #7c5a92;  
        margin-bottom: 25px;  
        font-weight: 500;  
    }  

    input, textarea {  
        width: 100%;  
        padding: 10px;  
        margin: 4px 0 2px;  
        border: 1px solid #ccc;  
        border-radius: 6px;  
        font-size: 1rem;  
        box-sizing: border-box;  
    }  

    /* Error messages with reserved space */
    .error {  
        color: red;  
        font-size: 0.85rem;  
        margin-bottom: 8px;  
        min-height: 16px; /* ensures space is always there */  
        display: block;  
    }  

    button {  
        width: 100%;  
        padding: 12px;  
        background: linear-gradient(90deg, #ffb4a2 0%, #ffd6a5 100%);  
        color: #333;  
        border: none;  
        font-size: 1rem;  
        font-weight: bold;  
        border-radius: 6px;  
        cursor: pointer;  
        transition: all 0.3s ease;  
        box-shadow: 0 3px 10px rgba(255, 180, 162, 0.15);  
    }  
    button:hover {  
        background: linear-gradient(90deg, #ffdac1 0%, #fff1e6 100%);  
        transform: translateY(-2px);  
    }  

    .login-link {  
        text-align: center;  
        margin-top: 15px;  
    }  
    .login-link a {  
        color: #F4A261;  
        text-decoration: none;  
        font-weight: bold;  
    }   
</style>  
</head>  
<body>  

<!-- HEADER -->  
<%@ include file="common/Header.jsp" %> 

<!-- FORM -->  
<div class="container">  
    <h2><i class="fa-solid fa-user-plus"></i> Customer Registration</h2>
        <%
    String error = request.getParameter("error");
    if (error != null) {
    %>
    <div class="error"><%= error %></div>
    <%
    }
    %>   

    <form id="regForm" action="RegisterServlet" method="post" novalidate> 


        <input type="text" name="userId" id="userId" placeholder="User ID" required>  
        <span class="error" id="userIdError"></span>  

        <input type="text" name="name" id="name" placeholder="Full Name" required>  
        <span class="error" id="nameError"></span>  

        <input type="email" name="email" id="email" placeholder="Email" required>  
        <span class="error" id="emailError"></span>  

        <textarea name="address" id="address" placeholder="Address" rows="3" required></textarea>  
        <span class="error" id="addressError"></span>  

        <input type="text" name="phone" id="phone" placeholder="Phone Number" required>  
        <span class="error" id="phoneError"></span>  

        <input type="password" name="password" id="password" placeholder="Password" required>  
        <span class="error" id="passwordError"></span>  

        <input type="password" name="confirmPassword" id="confirmPassword" placeholder="Confirm Password" required>  
        <span class="error" id="confirmPasswordError"></span>  

        <button type="submit"><i class="fa-solid fa-paper-plane"></i> Register</button>  
    </form>  

    <div class="login-link">  
        Already have an account? <a href="login.jsp">Login here</a>  
    </div>  
</div>  

<!-- FOOTER -->  
<%@ include file="common/footer.jsp" %> 

<script>  
function validateUserId() {  
    let userId = document.getElementById("userId").value.trim();  
    let error = "";  
    if (userId.length < 5 || userId.length > 20) {  
        error = "User ID must be between 5 and 20 characters";  
    }  
    document.getElementById("userIdError").innerText = error;  
    return error === "";  
}  

function validateName() {  
    let name = document.getElementById("name").value.trim();  
    let error = name ? "" : "Name is required";  
    document.getElementById("nameError").innerText = error;  
    return error === "";  
}  

function validateEmail() {  
    let email = document.getElementById("email").value.trim();  
    let regex = /^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$/;  
    let error = regex.test(email) ? "" : "Invalid email format";  
    document.getElementById("emailError").innerText = error;  
    return error === "";  
}  

function validateAddress() {  
    let address = document.getElementById("address").value.trim();  
    let error = address ? "" : "Address is required";  
    document.getElementById("addressError").innerText = error;  
    return error === "";  
}  

function validatePhone() {  
    let phone = document.getElementById("phone").value.trim();  
    let regex = /^[5-9][0-9]{9}$/;  
    let error = regex.test(phone) ? "" : "Phone must be 10 digits, starting with 5-9";  
    document.getElementById("phoneError").innerText = error;  
    return error === "";  
}  

function validatePassword() {  
    let password = document.getElementById("password").value;  
    let error = "";  
    let regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[\W_]).{6,}$/;  
    if (!password) {  
        error = "Password is required";  
    } else if (!regex.test(password)) {  
        error = "Password must be at least 6 characters, include uppercase, lowercase, and a special character";  
    }   
    document.getElementById("passwordError").innerText = error;  
    return error === "";  
}  

function validateConfirmPassword() {  
    let password = document.getElementById("password").value;  
    let confirmPassword = document.getElementById("confirmPassword").value;  
    let error = (password === confirmPassword) ? "" : "Passwords do not match";  
    document.getElementById("confirmPasswordError").innerText = error;  
    return error === "";  
}  

document.getElementById("userId").addEventListener("blur", validateUserId);  
document.getElementById("name").addEventListener("blur", validateName);  
document.getElementById("email").addEventListener("blur", validateEmail);  
document.getElementById("address").addEventListener("blur", validateAddress);  
document.getElementById("phone").addEventListener("blur", validatePhone);  
document.getElementById("password").addEventListener("blur", validatePassword);  
document.getElementById("confirmPassword").addEventListener("blur", validateConfirmPassword);  

document.getElementById("regForm").addEventListener("submit", function(e) {  
    if (!(  
         validateUserId() &  
         validateName() &  
         validateEmail() &  
         validateAddress() &  
         validatePhone() &  
         validatePassword() &  
         validateConfirmPassword()  
    )) {  
        e.preventDefault();  
    }  
});  
</script>  

</body>  
</html>