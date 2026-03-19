<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register — Complaint Management System</title>
    <meta name="description" content="Create a new account to submit and track complaints.">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="auth-bg">
    <div class="auth-card" style="max-width:500px;">

        <div class="auth-logo">
            <div class="logo-icon">📋</div>
            <span class="logo-text">CMS Portal</span>
        </div>

        <h2>Create Account</h2>
        <p class="subtitle">Register to start submitting your complaints</p>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger">❌ ${error}</div>
        <% } %>

        <form method="POST" action="${pageContext.request.contextPath}/register" autocomplete="off">
            <div class="form-row">
                <div class="form-group">
                    <label for="name">Full Name *</label>
                    <input type="text" id="name" name="name" class="form-control"
                           placeholder="John Doe"
                           value="${not empty nameVal ? nameVal : ''}" required>
                </div>
                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input type="tel" id="phone" name="phone" class="form-control"
                           placeholder="+91 98765 43210"
                           value="${not empty phoneVal ? phoneVal : ''}">
                </div>
            </div>
            <div class="form-group">
                <label for="email">Email Address *</label>
                <input type="email" id="email" name="email" class="form-control"
                       placeholder="you@example.com"
                       value="${not empty emailVal ? emailVal : ''}" required>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label for="password">Password *</label>
                    <input type="password" id="password" name="password" class="form-control"
                           placeholder="Min. 6 characters" required>
                </div>
                <div class="form-group">
                    <label for="confirmPassword">Confirm Password *</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" class="form-control"
                           placeholder="Re-enter password" required>
                </div>
            </div>
            <button type="submit" class="btn btn-primary btn-full" style="margin-top:8px;">
                Create Account →
            </button>
        </form>

        <div class="divider"></div>
        <p class="text-center text-muted" style="font-size:0.88rem;">
            Already have an account?
            <a href="${pageContext.request.contextPath}/login" style="color:var(--accent);font-weight:600;">
                Sign in
            </a>
        </p>
    </div>
</div>
</body>
</html>
