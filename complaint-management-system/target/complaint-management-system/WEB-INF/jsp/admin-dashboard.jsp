<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard — CMS Portal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="layout">

    <aside class="sidebar">
        <div class="sidebar-header">
            <div class="sidebar-logo">
                <div class="logo-icon">📋</div>
                <div>
                    <div class="logo-name">CMS Portal</div>
                    <div class="logo-sub">Admin Panel</div>
                </div>
            </div>
        </div>
        <div class="sidebar-user">
            <div class="user-avatar" style="background:linear-gradient(135deg,#ff6b6b,#dc2626);">
                ${userName.substring(0,1).toUpperCase()}
            </div>
            <div class="user-info">
                <div class="user-name">${userName}</div>
                <div class="user-role">Admin</div>
            </div>
        </div>
        <nav class="sidebar-nav">
            <div class="nav-section-label">Admin</div>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-item active">
                <span class="nav-icon">🏠</span> Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/admin/complaints" class="nav-item">
                <span class="nav-icon">📋</span> All Complaints
            </a>
            <a href="${pageContext.request.contextPath}/admin/complaints?status=PENDING" class="nav-item">
                <span class="nav-icon">⏳</span> Pending
            </a>
            <a href="${pageContext.request.contextPath}/admin/complaints?status=IN_PROGRESS" class="nav-item">
                <span class="nav-icon">🔄</span> In Progress
            </a>
            <a href="${pageContext.request.contextPath}/admin/complaints?status=RESOLVED" class="nav-item">
                <span class="nav-icon">✅</span> Resolved
            </a>
        </nav>
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/logout" class="nav-item" style="color:var(--danger);">
                <span class="nav-icon">🚪</span> Logout
            </a>
        </div>
    </aside>

    <main class="main-content">
        <div class="page-header">
            <div class="page-title">🛡️ Admin Dashboard</div>
            <div class="page-subtitle">System-wide overview of all complaints and users.</div>
        </div>

        <!-- Stats Grid -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon purple">📋</div>
                <div>
                    <div class="stat-value">${totalComplaints}</div>
                    <div class="stat-label">Total Complaints</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon orange">⏳</div>
                <div>
                    <div class="stat-value">${pendingComplaints}</div>
                    <div class="stat-label">Pending</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon blue">🔄</div>
                <div>
                    <div class="stat-value">${inProgressComplaints}</div>
                    <div class="stat-label">In Progress</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon green">✅</div>
                <div>
                    <div class="stat-value">${resolvedComplaints}</div>
                    <div class="stat-label">Resolved</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon gray">🔒</div>
                <div>
                    <div class="stat-value">${closedComplaints}</div>
                    <div class="stat-label">Closed</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon red">👥</div>
                <div>
                    <div class="stat-value">${totalUsers}</div>
                    <div class="stat-label">Registered Users</div>
                </div>
            </div>
        </div>

        <!-- Recent Complaints -->
        <div class="card">
            <div class="card-header">
                <div class="card-title">📝 Recent Complaints</div>
                <a href="${pageContext.request.contextPath}/admin/complaints" class="btn btn-outline btn-sm">
                    View All →
                </a>
            </div>
            <div class="table-container">
                <c:choose>
                    <c:when test="${empty recentComplaints}">
                        <div class="empty-state">
                            <div class="empty-icon">📭</div>
                            <h3>No complaints yet</h3>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <table>
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Title</th>
                                    <th>User</th>
                                    <th>Category</th>
                                    <th>Priority</th>
                                    <th>Status</th>
                                    <th>Date</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="c" items="${recentComplaints}">
                                    <tr>
                                        <td style="color:var(--text-muted)">#${c.id}</td>
                                        <td style="font-weight:600; max-width:180px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">
                                            <c:out value="${c.title}"/>
                                        </td>
                                        <td style="color:var(--text-secondary);">
                                            <c:out value="${c.userName}"/>
                                        </td>
                                        <td style="color:var(--text-secondary);">
                                            <c:out value="${c.category}"/>
                                        </td>
                                        <td><span class="badge ${c.priorityClass}"><c:out value="${c.priority}"/></span></td>
                                        <td><span class="badge ${c.statusClass}"><c:out value="${c.statusLabel}"/></span></td>
                                        <td style="color:var(--text-muted); font-size:0.82rem;">
                                            <fmt:formatDate value="${c.createdAt}" pattern="dd MMM yyyy"/>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/admin/complaint-detail?id=${c.id}"
                                               class="btn btn-primary btn-sm">Manage</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>
</div>
</body>
</html>
