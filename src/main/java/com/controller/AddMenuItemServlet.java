package com.controller;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.util.DBConnection;

@WebServlet("/AddMenuItemServlet")
public class AddMenuItemServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("food_name");
        String category = request.getParameter("category");
        double price = Double.parseDouble(request.getParameter("price"));

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                 "INSERT INTO FOOD_ITEMS (food_name, category, price,availability) VALUES (?,?, ?, ?)")) {

            ps.setString(1, name);
            ps.setString(2, category);
            ps.setDouble(3, price);
            ps.setBoolean(4, true);
            ps.executeUpdate();

            response.sendRedirect("manage_menu.jsp?msg=Item added successfully");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manage_menu.jsp?error=" + e.getMessage());
        }
    }
}



