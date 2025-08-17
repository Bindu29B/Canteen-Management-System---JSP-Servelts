package com.controller;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.util.DBConnection;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userId = request.getParameter("userId");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        if (userId == null || password == null || role == null || role.isEmpty()) {
            response.sendRedirect("login.jsp?error=All fields are required!");
            return;
        }

        try (Connection con = DBConnection.getConnection()) {

            if ("admin".equalsIgnoreCase(role)) {
                // ===== Admin login from ADMINS table =====
                String sql = "SELECT * FROM ADMINS WHERE admin_id = ? AND password = ?";
                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    ps.setString(1, userId);
                    ps.setString(2, password);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            HttpSession session = request.getSession();
                            session.setAttribute("userId", userId);
                            session.setAttribute("role", "admin");
                            response.sendRedirect("admin_dashboard.jsp");
                        } else {
                            response.sendRedirect("login.jsp?error=Invalid admin credentials!");
                        }
                    }
                }
                return; // End admin login
            }

            if ("customer".equalsIgnoreCase(role)) {
                // ===== Customer login from CUSTOMERS table =====
                String sql = "SELECT * FROM CUSTOMERS WHERE login_id = ? AND password = ?";
                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    ps.setString(1, userId);
                    ps.setString(2, password);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            HttpSession session = request.getSession();
                            session.setAttribute("userId", userId);
                            session.setAttribute("role", "customer");
                            response.sendRedirect("customer_dashboard.jsp");
                        } else {
                            response.sendRedirect("login.jsp?error=Invalid customer credentials!");
                        }
                    }
                }
                return;
            }

            // If role not recognized
            response.sendRedirect("login.jsp?error=Invalid role selected!");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=Error during login: " + e.getMessage());
        }
    }
}

