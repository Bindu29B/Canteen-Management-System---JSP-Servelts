package com.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

	private static final String URL = "jdbc:derby:D:\\Users\\2827683\\MyDB\\cann;create=true";

    private static final String USER = "";
    private static final String PASS = "";

    static {
        try {
            Class.forName("org.apache.derby.jdbc.EmbeddedDriver");
            System.out.println("Derby driver loaded successfully");
        } catch (ClassNotFoundException e) {
            System.err.println("Derby driver not found!");
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }

    // Test connection method
    public static boolean testConnection() {
        try (Connection conn = getConnection()) {
            System.out.println("Database connection successful!");
            return true;
        } catch (SQLException e) {
            System.err.println("Database connection failed: " + e.getMessage());
            return false;
        }
    }
}
