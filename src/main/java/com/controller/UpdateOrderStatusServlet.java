package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.util.DBConnection;

@WebServlet("/UpdateOrderStatusServlet")
public class UpdateOrderStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int orderId = Integer.parseInt(request.getParameter("order_id"));
        String newStatus = request.getParameter("status");

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                     "UPDATE ORDERS SET status = ? WHERE order_id = ?")) {

            ps.setString(1, newStatus);
            ps.setInt(2, orderId);
            ps.executeUpdate();

            response.sendRedirect("view_all_orders.jsp?msg=Status updated successfully");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("view_all_orders.jsp?error=" + e.getMessage());
        }
    }
}
