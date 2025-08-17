package com.controller;

import java.io.IOException;
import java.sql.*;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.util.DBConnection;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userId = request.getParameter("userId");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // ===== Validations =====
        if (userId == null || userId.length() < 5 || userId.length() > 20) {
            response.sendRedirect("register.jsp?error=User ID must be between 5 and 20 characters");
            return;
        }
        if (email == null || !Pattern.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$", email)) {
            response.sendRedirect("register.jsp?error=Invalid email format");
            return;
        }
        if (phone == null || !Pattern.matches("^[5-9][0-9]{9}$", phone)) {
            response.sendRedirect("register.jsp?error=Phone must be 10 digits and start with 5-9");
            return;
        }
        if (password == null || !Pattern.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*[\\W_]).{6,}$", password)) {
            response.sendRedirect("register.jsp?error=Password must be at least 6 chars, include uppercase, lowercase & special character");
            return;
        }
        if (confirmPassword == null || !password.equals(confirmPassword)) {
            response.sendRedirect("register.jsp?error=Passwords do not match");
            return;
        }

        // ===== Database Insertion =====
        try (Connection con = DBConnection.getConnection()) {

            // Check if userId already exists
            String checkSql = "SELECT COUNT(*) FROM CUSTOMERS WHERE login_Id=?";
            try (PreparedStatement checkPs = con.prepareStatement(checkSql)) {
                checkPs.setString(1, userId);
                try (ResultSet rsCheck = checkPs.executeQuery()) {
                    if (rsCheck.next() && rsCheck.getInt(1) > 0) {
                        response.sendRedirect("register.jsp?error=User ID already exists");
                        return;
                    }
                }
            }

            // Insert new customer
            String insertSql = "INSERT INTO CUSTOMERS (login_Id, name, email, address, phone, password) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement ps = con.prepareStatement(insertSql)) {
                ps.setString(1, userId);
                ps.setString(2, name);
                ps.setString(3, email);
                ps.setString(4, address);
                ps.setString(5, phone);
                ps.setString(6, password);

                int rows = ps.executeUpdate();
                if (rows > 0) {
                    // Registration successful → forward to success JSP
                    request.setAttribute("userId", userId);
                    request.setAttribute("email", email);
                    request.setAttribute("phone", phone);
                    request.getRequestDispatcher("registration_success.jsp").forward(request, response);
                } else {
                    // Insert failed
                    response.sendRedirect("register.jsp?error=Registration failed");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=Error during registration: " + e.getMessage());
        }
    }
}

