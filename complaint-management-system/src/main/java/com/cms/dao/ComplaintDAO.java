package com.cms.dao;

import com.cms.model.Complaint;
import com.cms.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Complaint operations.
 */
public class ComplaintDAO {

    // ── Submit new complaint ──────────────────────────────────────────────────

    public boolean submit(int userId, String title, String description, String category, String priority) {
        String sql = "INSERT INTO complaints (user_id, title, description, category, priority) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setString(2, title.trim());
            ps.setString(3, description.trim());
            ps.setString(4, category.trim());
            ps.setString(5, priority.trim());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ── Get complaints for one user ───────────────────────────────────────────

    public List<Complaint> findByUserId(int userId) {
        String sql = "SELECT c.*, u.name AS user_name, u.email AS user_email " +
                     "FROM complaints c JOIN users u ON c.user_id = u.id " +
                     "WHERE c.user_id = ? ORDER BY c.created_at DESC";
        return queryList(sql, ps -> ps.setInt(1, userId));
    }

    // ── Get all complaints (admin) ────────────────────────────────────────────

    public List<Complaint> findAll() {
        String sql = "SELECT c.*, u.name AS user_name, u.email AS user_email " +
                     "FROM complaints c JOIN users u ON c.user_id = u.id " +
                     "ORDER BY c.created_at DESC";
        return queryList(sql, ps -> {});
    }

    // ── Filter by status (admin) ──────────────────────────────────────────────

    public List<Complaint> findByStatus(String status) {
        String sql = "SELECT c.*, u.name AS user_name, u.email AS user_email " +
                     "FROM complaints c JOIN users u ON c.user_id = u.id " +
                     "WHERE c.status = ? ORDER BY c.created_at DESC";
        return queryList(sql, ps -> ps.setString(1, status));
    }

    // ── Find by ID ────────────────────────────────────────────────────────────

    public Complaint findById(int id) {
        String sql = "SELECT c.*, u.name AS user_name, u.email AS user_email " +
                     "FROM complaints c JOIN users u ON c.user_id = u.id " +
                     "WHERE c.id = ?";
        List<Complaint> list = queryList(sql, ps -> ps.setInt(1, id));
        return list.isEmpty() ? null : list.get(0);
    }

    // ── Update status and remark (admin) ─────────────────────────────────────

    public boolean updateStatus(int complaintId, String status, String remark) {
        String sql = "UPDATE complaints SET status = ?, admin_remark = ?, updated_at = NOW() WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setString(2, remark == null ? "" : remark.trim());
            ps.setInt(3, complaintId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ── Delete complaint ──────────────────────────────────────────────────────

    public boolean delete(int complaintId) {
        String sql = "DELETE FROM complaints WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, complaintId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ── Statistics ────────────────────────────────────────────────────────────

    public int countAll()                     { return countWhere("1=1"); }
    public int countByStatus(String status)   {
        String sql = "SELECT COUNT(*) FROM complaints WHERE status = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }
    public int countByUserId(int userId) {
        String sql = "SELECT COUNT(*) FROM complaints WHERE user_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }
    public int countByUserIdAndStatus(int userId, String status) {
        String sql = "SELECT COUNT(*) FROM complaints WHERE user_id = ? AND status = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, status);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    // ── Private helpers ───────────────────────────────────────────────────────

    @FunctionalInterface
    private interface ParamSetter {
        void set(PreparedStatement ps) throws SQLException;
    }

    private List<Complaint> queryList(String sql, ParamSetter setter) {
        List<Complaint> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            setter.set(ps);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private int countWhere(String condition) {
        String sql = "SELECT COUNT(*) FROM complaints WHERE " + condition;
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    private Complaint mapRow(ResultSet rs) throws SQLException {
        Complaint c = new Complaint();
        c.setId(rs.getInt("id"));
        c.setUserId(rs.getInt("user_id"));
        c.setUserName(rs.getString("user_name"));
        c.setUserEmail(rs.getString("user_email"));
        c.setTitle(rs.getString("title"));
        c.setDescription(rs.getString("description"));
        c.setCategory(rs.getString("category"));
        c.setStatus(rs.getString("status"));
        c.setPriority(rs.getString("priority"));
        c.setAdminRemark(rs.getString("admin_remark"));
        c.setCreatedAt(rs.getTimestamp("created_at"));
        c.setUpdatedAt(rs.getTimestamp("updated_at"));
        return c;
    }
}
