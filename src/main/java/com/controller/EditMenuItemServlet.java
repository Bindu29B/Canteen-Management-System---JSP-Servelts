package com.controller;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.util.DBConnection;

@WebServlet("/UpdateMenuItemServlet")
public class EditMenuItemServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int foodId = Integer.parseInt(request.getParameter("food_id"));
            String name = request.getParameter("food_name");
            String category = request.getParameter("category");
            double price = Double.parseDouble(request.getParameter("price"));

            // Availability — assuming you send "true"/"false" or checkbox "on"
            boolean availability = "on".equalsIgnoreCase(request.getParameter("availability"))
                                 || "true".equalsIgnoreCase(request.getParameter("availability"));

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(
                        "UPDATE FOOD_ITEMS SET food_name=?, category=?, price=?, availability=? WHERE food_id=?")) {

                ps.setString(1, name);
                ps.setString(2, category);
                ps.setDouble(3, price);
                ps.setBoolean(4, availability);
                ps.setInt(5, foodId);

                int updated = ps.executeUpdate();

                if (updated > 0) {
                    response.sendRedirect("manage_menu.jsp?msg=Item updated successfully");
                } else {
                    response.sendRedirect("manage_menu.jsp?error=No such food item found");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manage_menu.jsp?error=" + e.getMessage());
        }
    }
}

