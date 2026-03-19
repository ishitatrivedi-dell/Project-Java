package com.cms.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.SQLException;

/**
 * Utility class providing a MySQL JDBC connection.
 * Update DB_URL, DB_USER, DB_PASS to match your MySQL setup.
 */
public class DBConnection {

    private static final String HOST_URL = "jdbc:mysql://localhost:3306/?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String DB_NAME  = "complaint_db";
    private static final String DB_URL   = "jdbc:mysql://localhost:3306/" + DB_NAME + "?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String DB_USER = "root";       // ← change if needed
    private static final String DB_PASS = "root";       // ← change if needed

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            ensureDatabaseAndSchema();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found!", e);
        } catch (SQLException e) {
            throw new RuntimeException("Failed to initialize database. Check MySQL credentials in DBConnection.java", e);
        }
    }

    private static void ensureDatabaseAndSchema() throws SQLException {
        try (Connection con = DriverManager.getConnection(HOST_URL, DB_USER, DB_PASS);
             Statement st = con.createStatement()) {
            st.execute("CREATE DATABASE IF NOT EXISTS " + DB_NAME + " CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci");
        }

        try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
             Statement st = con.createStatement()) {

            st.execute("""
                CREATE TABLE IF NOT EXISTS users (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    name VARCHAR(100) NOT NULL,
                    email VARCHAR(100) NOT NULL UNIQUE,
                    password VARCHAR(255) NOT NULL,
                    phone VARCHAR(20) DEFAULT NULL,
                    role ENUM('USER','ADMIN') NOT NULL DEFAULT 'USER',
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                ) ENGINE=InnoDB
                """);

            st.execute("""
                CREATE TABLE IF NOT EXISTS complaints (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    user_id INT NOT NULL,
                    title VARCHAR(200) NOT NULL,
                    description TEXT NOT NULL,
                    category VARCHAR(100) NOT NULL,
                    status ENUM('PENDING','IN_PROGRESS','RESOLVED','CLOSED') NOT NULL DEFAULT 'PENDING',
                    priority ENUM('LOW','MEDIUM','HIGH') NOT NULL DEFAULT 'MEDIUM',
                    admin_remark TEXT DEFAULT NULL,
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
                ) ENGINE=InnoDB
                """);

            // Seed admin/user accounts if missing (passwords are SHA-256 hashes)
            try (PreparedStatement ps = con.prepareStatement("""
                INSERT INTO users (name, email, password, role)
                VALUES (?, ?, SHA2(?, 256), ?)
                ON DUPLICATE KEY UPDATE name = name
                """)) {
                ps.setString(1, "System Admin");
                ps.setString(2, "admin@cms.com");
                ps.setString(3, "admin123");
                ps.setString(4, "ADMIN");
                ps.executeUpdate();

                ps.setString(1, "John Doe");
                ps.setString(2, "user@cms.com");
                ps.setString(3, "user123");
                ps.setString(4, "USER");
                ps.executeUpdate();
            }
        }
    }

    /**
     * Returns a fresh Connection. Callers are responsible for closing it.
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
    }

    private DBConnection() { /* utility class */ }
}
