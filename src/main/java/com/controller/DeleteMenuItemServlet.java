package com.controller;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.util.DBConnection;

@WebServlet("/DeleteMenuItemServlet")
public class DeleteMenuItemServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String foodIdStr = request.getParameter("food_id");

        try {
            int foodId = Integer.parseInt(foodIdStr);

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(
                     "DELETE FROM FOOD_ITEMS WHERE food_id = ?")) {

                ps.setInt(1, foodId);
                ps.executeUpdate();
                response.sendRedirect("manage_menu.jsp?msg=Item deleted successfully");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manage_menu.jsp?error=" + e.getMessage());
        }
    }
}
