package com.classvoice.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public final class DBConnection {

    private DBConnection() {}

    private static final String URL =
            env("CLASSVOICE_DB_URL",
                "jdbc:mysql://localhost:3306/classvoice_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC");

    private static final String USER =
            env("CLASSVOICE_DB_USER", "classvoice");

    private static final String PASSWORD =
            env("CLASSVOICE_DB_PASSWORD", "ClassVoice@123");

    public static Connection getConnection() throws SQLException {
        try {
            System.out.println("=== ClassVoice DB DEBUG ===");
            System.out.println("DB URL: " + URL);
            System.out.println("DB USER: " + USER);

            Connection connection =
                    DriverManager.getConnection(URL, USER, PASSWORD);

            System.out.println("DB CONNECTION SUCCESS");
            return connection;

        } catch (SQLException e) {
            System.err.println("=== ClassVoice DB CONNECTION FAILED ===");
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            System.err.println("Message: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    private static String env(String key, String fallback) {
        String v = System.getenv(key);
        return v == null || v.isBlank() ? fallback : v;
    }
}
