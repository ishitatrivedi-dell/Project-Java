<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submit Complaint — CMS Portal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="layout">

    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="sidebar-header">
            <div class="sidebar-logo">
                <div class="logo-icon">📋</div>
                <div>
                    <div class="logo-name">CMS Portal</div>
                    <div class="logo-sub">Complaint Management</div>
                </div>
            </div>
        </div>
        <div class="sidebar-user">
            <div class="user-avatar">${userName.substring(0,1).toUpperCase()}</div>
            <div class="user-info">
                <div class="user-name">${userName}</div>
                <div class="user-role">User</div>
            </div>
        </div>
        <nav class="sidebar-nav">
            <div class="nav-section-label">Main</div>
            <a href="${pageContext.request.contextPath}/dashboard" class="nav-item">
                <span class="nav-icon">🏠</span> Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/complaint/submit" class="nav-item active">
                <span class="nav-icon">➕</span> Submit Complaint
            </a>
            <a href="${pageContext.request.contextPath}/complaint/list" class="nav-item">
                <span class="nav-icon">📄</span> My Complaints
            </a>
        </nav>
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/logout" class="nav-item" style="color:var(--danger);">
                <span class="nav-icon">🚪</span> Logout
            </a>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        <div class="page-header">
            <div class="page-title">➕ Submit a Complaint</div>
            <div class="page-subtitle">Describe your issue clearly so it can be resolved quickly.</div>
        </div>

        <div class="card" style="max-width: 760px;">
            <div class="card-header">
                <div class="card-title">📝 Complaint Details</div>
            </div>
            <div class="card-body">

                <c:if test="${not empty error}">
                    <div class="alert alert-danger">❌ <c:out value="${error}"/></div>
                </c:if>

                <form method="POST" action="${pageContext.request.contextPath}/complaint/submit">

                    <div class="form-group">
                        <label for="title">Complaint Title *</label>
                        <input type="text" id="title" name="title" class="form-control"
                               placeholder="Brief summary of your complaint (e.g. Water supply issue in Block A)"
                               maxlength="200" required>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="category">Category *</label>
                            <select id="category" name="category" class="form-control" required>
                                <option value="">— Select Category —</option>
                                <option value="Infrastructure">🏗️ Infrastructure</option>
                                <option value="Electrical">⚡ Electrical</option>
                                <option value="Sanitation">🚮 Sanitation</option>
                                <option value="Water Supply">💧 Water Supply</option>
                                <option value="Road & Transport">🛣️ Road & Transport</option>
                                <option value="Public Safety">🛡️ Public Safety</option>
                                <option value="Internet / IT">💻 Internet / IT</option>
                                <option value="Administrative">📁 Administrative</option>
                                <option value="Other">📌 Other</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="priority">Priority *</label>
                            <select id="priority" name="priority" class="form-control" required>
                                <option value="LOW">🟢 Low</option>
                                <option value="MEDIUM" selected>🟡 Medium</option>
                                <option value="HIGH">🔴 High</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="description">Description *</label>
                        <textarea id="description" name="description" class="form-control"
                                  placeholder="Provide a detailed description: location, time, impact, any relevant context..."
                                  rows="5" required></textarea>
                    </div>

                    <div class="flex gap-2" style="justify-content:flex-end; margin-top:8px;">
                        <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-outline">Cancel</a>
                        <button type="submit" class="btn btn-primary">Submit Complaint →</button>
                    </div>

                </form>
            </div>
        </div>
    </main>
</div>
</body>
</html>
