-- ============================================================
-- Complaint Management System - MySQL Database Schema
-- Run this script in MySQL before starting the application
-- ============================================================

CREATE DATABASE IF NOT EXISTS complaint_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE complaint_db;

-- ─────────────────────────────────────────────
-- USERS TABLE
-- ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS users (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100)    NOT NULL,
    email       VARCHAR(100)    NOT NULL UNIQUE,
    password    VARCHAR(255)    NOT NULL,          -- SHA-256 hex hash
    phone       VARCHAR(20)     DEFAULT NULL,
    role        ENUM('USER','ADMIN') NOT NULL DEFAULT 'USER',
    created_at  TIMESTAMP       DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ─────────────────────────────────────────────
-- COMPLAINTS TABLE
-- ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS complaints (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    user_id         INT             NOT NULL,
    title           VARCHAR(200)    NOT NULL,
    description     TEXT            NOT NULL,
    category        VARCHAR(100)    NOT NULL,
    status          ENUM('PENDING','IN_PROGRESS','RESOLVED','CLOSED') NOT NULL DEFAULT 'PENDING',
    priority        ENUM('LOW','MEDIUM','HIGH') NOT NULL DEFAULT 'MEDIUM',
    admin_remark    TEXT            DEFAULT NULL,
    created_at      TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP       DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ─────────────────────────────────────────────
-- DEFAULT ADMIN ACCOUNT
-- Email   : admin@cms.com
-- Password: admin123  (SHA-256 hashed)
-- ─────────────────────────────────────────────
INSERT INTO users (name, email, password, role)
    VALUES ('System Admin', 'admin@cms.com',
            SHA2('admin123', 256), 'ADMIN')
ON DUPLICATE KEY UPDATE name = name;

-- ─────────────────────────────────────────────
-- SAMPLE USER ACCOUNT
-- Email   : user@cms.com
-- Password: user123  (SHA-256 hashed)
-- ─────────────────────────────────────────────
INSERT INTO users (name, email, password, role)
    VALUES ('John Doe', 'user@cms.com',
            SHA2('user123', 256), 'USER')
ON DUPLICATE KEY UPDATE name = name;

-- ─────────────────────────────────────────────
-- SAMPLE COMPLAINTS (linked to John Doe id=2)
-- ─────────────────────────────────────────────
INSERT INTO complaints (user_id, title, description, category, status, priority) VALUES
(2, 'Water supply issue in Block A', 'There has been no water supply in Block A since 3 days. Urgent resolution needed.', 'Infrastructure', 'PENDING', 'HIGH'),
(2, 'Street light not working on Main Road', 'The street light near gate no. 3 has been non-functional for a week.', 'Electrical', 'IN_PROGRESS', 'MEDIUM'),
(2, 'Garbage not collected', 'Garbage collection has been skipped for two consecutive days in Sector 5.', 'Sanitation', 'RESOLVED', 'LOW');
