package com.classvoice.controller;

import com.classvoice.model.User;
import com.classvoice.util.DBConnection;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Logger;

/** Read-only, authenticated, SQL-backed metrics for the dashboard live view. */
@WebServlet("/api/dashboard-pulse")
public final class DashboardPulseServlet extends HttpServlet {
    private static final Logger LOG = Logger.getLogger(DashboardPulseServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
        resp.setHeader("X-Content-Type-Options", "nosniff");
        resp.setContentType("application/json; charset=UTF-8");
        HttpSession session = req.getSession(false);
        User user = session == null ? null : (User) session.getAttribute("user");
        if (user == null) {
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            resp.getWriter().write("{\"error\":\"Sign in required\"}");
            return;
        }
        if (!"teacher".equals(user.getRole()) && !"student".equals(user.getRole())) {
            resp.setStatus(HttpServletResponse.SC_FORBIDDEN);
            resp.getWriter().write("{\"error\":\"Not authorized\"}");
            return;
        }
        try (Connection db = DBConnection.getConnection()) {
            if ("teacher".equals(user.getRole())) {
                int active = number(db, "SELECT COUNT(*) FROM lectures WHERE teacher_id=? AND status='active'", user.getUserId());
                int feedback = number(db, "SELECT COUNT(*) FROM feedback f JOIN lectures l ON l.lecture_id=f.lecture_id WHERE l.teacher_id=?", user.getUserId());
                resp.getWriter().write("{\"activeLectures\":" + active + ",\"feedbackCount\":" + feedback + "}");
            } else {
                int active = number(db, "SELECT COUNT(*) FROM lectures WHERE status='active'");
                resp.getWriter().write("{\"activeLectures\":" + active + "}");
            }
        } catch (SQLException ex) {
            LOG.warning("Dashboard SQL pulse failed: SQLState=" + ex.getSQLState());
            resp.setStatus(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
            resp.getWriter().write("{\"error\":\"Database unavailable\"}");
        }
    }

    private int number(Connection db, String query, long... args) throws SQLException {
        try (PreparedStatement ps = db.prepareStatement(query)) {
            for (int i = 0; i < args.length; i++) ps.setLong(i + 1, args[i]);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getInt(1) : 0;
            }
        }
    }
}
