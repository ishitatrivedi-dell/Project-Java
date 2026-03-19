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
                               maxlength="200"
                               value="${not empty titleVal ? titleVal : ''}" required>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="category">Category *</label>
                            <select id="category" name="category" class="form-control" required>
                                <option value="">— Select Category —</option>
                                <option value="Infrastructure" ${categoryVal=='Infrastructure' ? 'selected' : ''}>🏗️ Infrastructure</option>
                                <option value="Electrical" ${categoryVal=='Electrical' ? 'selected' : ''}>⚡ Electrical</option>
                                <option value="Sanitation" ${categoryVal=='Sanitation' ? 'selected' : ''}>🚮 Sanitation</option>
                                <option value="Water Supply" ${categoryVal=='Water Supply' ? 'selected' : ''}>💧 Water Supply</option>
                                <option value="Road & Transport" ${categoryVal=='Road & Transport' ? 'selected' : ''}>🛣️ Road & Transport</option>
                                <option value="Public Safety" ${categoryVal=='Public Safety' ? 'selected' : ''}>🛡️ Public Safety</option>
                                <option value="Internet / IT" ${categoryVal=='Internet / IT' ? 'selected' : ''}>💻 Internet / IT</option>
                                <option value="Administrative" ${categoryVal=='Administrative' ? 'selected' : ''}>📁 Administrative</option>
                                <option value="Other" ${categoryVal=='Other' ? 'selected' : ''}>📌 Other</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="priority">Priority *</label>
                            <select id="priority" name="priority" class="form-control" required>
                                <option value="LOW" ${priorityVal=='LOW' ? 'selected' : ''}>🟢 Low</option>
                                <option value="MEDIUM" ${(empty priorityVal || priorityVal=='MEDIUM') ? 'selected' : ''}>🟡 Medium</option>
                                <option value="HIGH" ${priorityVal=='HIGH' ? 'selected' : ''}>🔴 High</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="description">Description *</label>
                        <textarea id="description" name="description" class="form-control"
                                  placeholder="Provide a detailed description: location, time, impact, any relevant context..."
                                  rows="5" required><c:out value="${descriptionVal}"/></textarea>
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
