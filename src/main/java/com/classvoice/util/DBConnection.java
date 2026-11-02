package com.classvoice.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/** Uses MySQL Connector/J for both local MySQL and free TiDB Cloud Starter. */
public final class DBConnection {
    private static final Logger LOG = Logger.getLogger(DBConnection.class.getName());
    private static final String DEFAULT_LOCAL_URL =
            "jdbc:mysql://localhost:3306/classvoice_db?sslMode=DISABLED&serverTimezone=UTC&connectTimeout=10000";

    private DBConnection() { }

    public static Connection getConnection() throws SQLException {
        boolean onRender = "true".equalsIgnoreCase(System.getenv("RENDER"));
        if (onRender && (missing("CLASSVOICE_DB_URL") || missing("CLASSVOICE_DB_USER") || missing("CLASSVOICE_DB_PASSWORD"))) {
            throw new SQLException("ClassVoice database environment variables are missing on Render", "08001");
        }
        String url = env("CLASSVOICE_DB_URL", DEFAULT_LOCAL_URL);
        String username = env("CLASSVOICE_DB_USER", "classvoice");
        String password = env("CLASSVOICE_DB_PASSWORD", "ClassVoice@123"); // local development only
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC driver is missing from the deployed WAR", e);
        }
        try {
            return DriverManager.getConnection(url, username, password);
        } catch (SQLException ex) {
            // Never log the URL or password: URLs can include credentials/query secrets.
            LOG.log(Level.SEVERE, "SQL connection failed: SQLState=" + ex.getSQLState()
                    + ", errorCode=" + ex.getErrorCode());
            throw ex;
        }
    }

    private static boolean missing(String key) {
        String value = System.getenv(key);
        return value == null || value.isBlank();
    }

    private static String env(String key, String fallback) {
        String value = System.getenv(key);
        return value == null || value.isBlank() ? fallback : value;
    }
}
