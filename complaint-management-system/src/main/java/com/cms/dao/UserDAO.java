package com.cms.dao;

import com.cms.model.User;
import com.cms.util.DBConnection;
import com.cms.util.PasswordUtil;

import java.sql.*;

/**
 * Data Access Object for User operations.
 */
public class UserDAO {

    // ── Register ─────────────────────────────────────────────────────────────

    /**
     * Inserts a new USER-role account. Returns the generated id, or -1 on failure.
     */
    public int register(String name, String email, String plainPassword, String phone) {
        String sql = "INSERT INTO users (name, email, password, phone, role) VALUES (?, ?, ?, ?, 'USER')";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, name.trim());
            ps.setString(2, email.trim().toLowerCase());
            ps.setString(3, PasswordUtil.hash(plainPassword));
            ps.setString(4, phone == null ? "" : phone.trim());
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            // Duplicate email → return -2
            if (e.getErrorCode() == 1062) return -2;
            e.printStackTrace();
        }
        return -1;
    }

    // ── Login ─────────────────────────────────────────────────────────────────

    /**
     * Validates credentials and returns the User on success, null otherwise.
     */
    public User login(String email, String plainPassword) {
        String sql = "SELECT id, name, email, password, phone, role, created_at FROM users WHERE email = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email.trim().toLowerCase());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String storedHash = rs.getString("password");
                    if (PasswordUtil.verify(plainPassword, storedHash)) {
                        return mapRow(rs);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ── Fetch by ID ───────────────────────────────────────────────────────────

    public User findById(int id) {
        String sql = "SELECT id, name, email, password, phone, role, created_at FROM users WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ── Count users ───────────────────────────────────────────────────────────

    public int countUsers() {
        String sql = "SELECT COUNT(*) FROM users WHERE role = 'USER'";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ── Private helper ────────────────────────────────────────────────────────

    private User mapRow(ResultSet rs) throws SQLException {
        User u = new User();
        u.setId(rs.getInt("id"));
        u.setName(rs.getString("name"));
        u.setEmail(rs.getString("email"));
        u.setPassword(rs.getString("password"));
        u.setPhone(rs.getString("phone"));
        u.setRole(rs.getString("role"));
        u.setCreatedAt(rs.getTimestamp("created_at"));
        return u;
    }
}
