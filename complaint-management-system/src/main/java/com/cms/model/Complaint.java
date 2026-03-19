package com.cms.model;

import java.sql.Timestamp;

/**
 * Represents a single complaint raised by a user.
 */
public class Complaint {

    private int       id;
    private int       userId;
    private String    userName;      // joined from users table for display
    private String    userEmail;     // joined from users table for display
    private String    title;
    private String    description;
    private String    category;
    private String    status;        // PENDING | IN_PROGRESS | RESOLVED | CLOSED
    private String    priority;      // LOW | MEDIUM | HIGH
    private String    adminRemark;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public Complaint() {}

    // ── Getters ──────────────────────────────────────────────────────────────
    public int       getId()          { return id; }
    public int       getUserId()      { return userId; }
    public String    getUserName()    { return userName; }
    public String    getUserEmail()   { return userEmail; }
    public String    getTitle()       { return title; }
    public String    getDescription() { return description; }
    public String    getCategory()    { return category; }
    public String    getStatus()      { return status; }
    public String    getPriority()    { return priority; }
    public String    getAdminRemark() { return adminRemark; }
    public Timestamp getCreatedAt()   { return createdAt; }
    public Timestamp getUpdatedAt()   { return updatedAt; }

    // ── Setters ──────────────────────────────────────────────────────────────
    public void setId(int id)                   { this.id = id; }
    public void setUserId(int userId)           { this.userId = userId; }
    public void setUserName(String n)           { this.userName = n; }
    public void setUserEmail(String e)          { this.userEmail = e; }
    public void setTitle(String title)          { this.title = title; }
    public void setDescription(String desc)     { this.description = desc; }
    public void setCategory(String category)    { this.category = category; }
    public void setStatus(String status)        { this.status = status; }
    public void setPriority(String priority)    { this.priority = priority; }
    public void setAdminRemark(String remark)   { this.adminRemark = remark; }
    public void setCreatedAt(Timestamp t)       { this.createdAt = t; }
    public void setUpdatedAt(Timestamp t)       { this.updatedAt = t; }

    // ── Helper badge CSS classes (used in JSP) ────────────────────────────────
    public String getStatusClass() {
        if (status == null) return "badge-pending";
        return switch (status) {
            case "IN_PROGRESS" -> "badge-in-progress";
            case "RESOLVED"    -> "badge-resolved";
            case "CLOSED"      -> "badge-closed";
            default            -> "badge-pending";
        };
    }

    public String getPriorityClass() {
        if (priority == null) return "badge-medium";
        return switch (priority) {
            case "HIGH" -> "badge-high";
            case "LOW"  -> "badge-low";
            default     -> "badge-medium";
        };
    }

    public String getStatusLabel() {
        if (status == null) return "Pending";
        return switch (status) {
            case "IN_PROGRESS" -> "In Progress";
            case "RESOLVED"    -> "Resolved";
            case "CLOSED"      -> "Closed";
            default            -> "Pending";
        };
    }
}
