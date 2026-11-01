package com.classvoice.controller;

import com.classvoice.util.DBConnection;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/** Public no-secret DB readiness check, useful after a Render deployment. */
@WebServlet("/health/db")
public class DatabaseHealthServlet extends HttpServlet {
    private static final Logger LOG = Logger.getLogger(DatabaseHealthServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/plain; charset=UTF-8");
        response.setHeader("Cache-Control", "no-store");
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement("SELECT 1 FROM users LIMIT 1");
             ResultSet ignored = ps.executeQuery()) {
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().println("Database OK");
        } catch (SQLException ex) {
            LOG.log(Level.WARNING, "Database health check failed", ex);
            response.setStatus(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
            response.getWriter().println("Database unavailable; check Render logs and SQL settings");
        }
    }
}
