package com.util;

public class RunDBConnectionTest {
    public static void main(String[] args) {
        if (DBConnection.testConnection()) {
            System.out.println("Database created (if not existed) and connected successfully.");
        } else {
            System.out.println("Failed to create/connect database.");
        }
    }
}

