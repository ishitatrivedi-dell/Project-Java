<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login — Complaint Management System</title>
    <meta name="description" content="Sign in to the Complaint Management System to submit and track your complaints.">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="auth-bg">
    <div class="auth-card">

        <div class="auth-logo">
            <div class="logo-icon">📋</div>
            <span class="logo-text">CMS Portal</span>
        </div>

        <h2>Welcome back</h2>
        <p class="subtitle">Sign in to manage and track your complaints</p>

        <!-- Flash messages -->
        <% if ("true".equals(request.getParameter("registered"))) { %>
            <div class="alert alert-success">✅ Registration successful! Please login.</div>
        <% } %>
        <% if ("true".equals(request.getParameter("logout"))) { %>
            <div class="alert alert-info">👋 You have been logged out.</div>
        <% } %>
        <% if ("session".equals(request.getParameter("error"))) { %>
            <div class="alert alert-warning">⚠️ Session expired. Please login again.</div>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger">❌ ${error}</div>
        <% } %>

        <form method="POST" action="${pageContext.request.contextPath}/login" autocomplete="on">
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" class="form-control"
                       placeholder="you@example.com"
                       value="${not empty emailVal ? emailVal : ''}" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" class="form-control"
                       placeholder="Enter your password" required>
            </div>
            <button type="submit" class="btn btn-primary btn-full" style="margin-top:8px;">
                Sign In →
            </button>
        </form>

        <div class="divider"></div>
        <p class="text-center text-muted" style="font-size:0.88rem;">
            Don't have an account?
            <a href="${pageContext.request.contextPath}/register" style="color:var(--accent);font-weight:600;">
                Create one
            </a>
        </p>

        <!-- Demo credentials hint -->
        <div style="margin-top:20px; padding:14px; background:rgba(108,99,255,0.07); border:1px solid rgba(108,99,255,0.15); border-radius:8px; font-size:0.78rem; color:var(--text-muted);">
            <strong style="color:var(--text-secondary);">Demo credentials</strong><br>
            Admin: <code>admin@cms.com</code> / <code>admin123</code><br>
            User:  <code>user@cms.com</code> / <code>user123</code>
        </div>
    </div>
</div>
</body>
</html>
