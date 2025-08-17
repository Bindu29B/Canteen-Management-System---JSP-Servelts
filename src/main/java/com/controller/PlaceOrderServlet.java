package com.controller;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.util.DBConnection;

@WebServlet("/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String loginId = (session != null) ? (String) session.getAttribute("userId") : null;

        if (loginId == null) {
            // User not logged in
            response.sendRedirect("login.jsp?error=Please login to place an order");
            return;
        }

        String[] selectedFoodIds = request.getParameterValues("food_id");
        if (selectedFoodIds == null || selectedFoodIds.length == 0) {
            response.sendRedirect("place_order.jsp?error=Please select at least one item");
            return;
        }

        try (Connection con = DBConnection.getConnection()) {
            con.setAutoCommit(false); // transaction start

            double totalAmount = 0.0;

            // 1️⃣ Insert order master row
            String insertOrderSQL = "INSERT INTO ORDERS (user_id, status) VALUES (?, ?)";
            try (PreparedStatement psOrder = con.prepareStatement(insertOrderSQL, Statement.RETURN_GENERATED_KEYS)) {
                psOrder.setString(1, loginId); // From session
                psOrder.setString(2, "Pending");

                psOrder.executeUpdate();

                // Get generated order_id
                int orderId = 0;
                try (ResultSet rsKeys = psOrder.getGeneratedKeys()) {
                    if (rsKeys.next()) {
                        orderId = rsKeys.getInt(1);
                    }
                }

                // 2️⃣ Insert order items
                String insertItemSQL = "INSERT INTO ORDER_ITEMS (order_id, food_id, quantity, price) VALUES (?, ?, ?, ?)";
                try (PreparedStatement psItem = con.prepareStatement(insertItemSQL)) {
                    for (String foodIdStr : selectedFoodIds) {
                        int foodId = Integer.parseInt(foodIdStr);
                        int qty = Integer.parseInt(request.getParameter("qty_" + foodId));

                        // Get the price of the food item
                        double price = 0.0;
                        try (PreparedStatement psPrice = con.prepareStatement(
                                "SELECT price FROM FOOD_ITEMS WHERE food_id=?")) {
                            psPrice.setInt(1, foodId);
                            try (ResultSet rs = psPrice.executeQuery()) {
                                if (rs.next()) {
                                    price = rs.getDouble("price");
                                }
                            }
                        }

                        totalAmount += (price * qty);

                        psItem.setInt(1, orderId);
                        psItem.setInt(2, foodId);
                        psItem.setInt(3, qty);
                        psItem.setDouble(4, price);
                        psItem.addBatch();
                    }
                    psItem.executeBatch();
                }

                // 3️⃣ (Optional) Update total_amount in ORDERS if you have this column
                try {
                    String updateTotalSQL = "UPDATE ORDERS SET total_amount=? WHERE order_id=?";
                    try (PreparedStatement psTotal = con.prepareStatement(updateTotalSQL)) {
                        psTotal.setDouble(1, totalAmount);
                        psTotal.setInt(2, orderId);
                        psTotal.executeUpdate();
                    }
                } catch (SQLException e) {
                    // Column might not exist — ignore if so
                }

            }

            con.commit();
            response.sendRedirect("place_order.jsp?msg=Order placed successfully!");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("place_order.jsp?error=Failed to place order: " + e.getMessage());
        }
    }
}
