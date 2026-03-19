package com.cms.model;

import java.sql.Timestamp;

/**
 * Represents a registered user in the system.
 */
public class User {

    private int       id;
    private String    name;
    private String    email;
    private String    password;   // stored as SHA-256 hash
    private String    phone;
    private String    role;       // "USER" or "ADMIN"
    private Timestamp createdAt;

    public User() {}

    public User(int id, String name, String email, String phone, String role, Timestamp createdAt) {
        this.id        = id;
        this.name      = name;
        this.email     = email;
        this.phone     = phone;
        this.role      = role;
        this.createdAt = createdAt;
    }

    // ── Getters ──────────────────────────────────────────────────────────────
    public int       getId()        { return id; }
    public String    getName()      { return name; }
    public String    getEmail()     { return email; }
    public String    getPassword()  { return password; }
    public String    getPhone()     { return phone; }
    public String    getRole()      { return role; }
    public Timestamp getCreatedAt() { return createdAt; }

    // ── Setters ──────────────────────────────────────────────────────────────
    public void setId(int id)               { this.id = id; }
    public void setName(String name)        { this.name = name; }
    public void setEmail(String email)      { this.email = email; }
    public void setPassword(String password){ this.password = password; }
    public void setPhone(String phone)      { this.phone = phone; }
    public void setRole(String role)        { this.role = role; }
    public void setCreatedAt(Timestamp t)   { this.createdAt = t; }

    // ── Helpers ───────────────────────────────────────────────────────────────
    public boolean isAdmin() { return "ADMIN".equalsIgnoreCase(role); }

    @Override
    public String toString() {
        return "User{id=" + id + ", name='" + name + "', email='" + email + "', role='" + role + "'}";
    }
}
