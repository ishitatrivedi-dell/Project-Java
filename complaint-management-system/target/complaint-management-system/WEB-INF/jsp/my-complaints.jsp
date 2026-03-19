<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Complaints — CMS Portal</title>
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
            <a href="${pageContext.request.contextPath}/complaint/submit" class="nav-item">
                <span class="nav-icon">➕</span> Submit Complaint
            </a>
            <a href="${pageContext.request.contextPath}/complaint/list" class="nav-item active">
                <span class="nav-icon">📄</span> My Complaints
            </a>
        </nav>
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/logout" class="nav-item" style="color:var(--danger);">
                <span class="nav-icon">🚪</span> Logout
            </a>
        </div>
    </aside>

    <main class="main-content">
        <div class="page-header flex items-center justify-between">
            <div>
                <div class="page-title">📄 My Complaints</div>
                <div class="page-subtitle">Track status updates for all your submitted complaints.</div>
            </div>
            <a href="${pageContext.request.contextPath}/complaint/submit" class="btn btn-primary">
                + New Complaint
            </a>
        </div>

        <c:if test="${'true' eq param.submitted}">
            <div class="alert alert-success">✅ Your complaint has been submitted successfully!</div>
        </c:if>

        <div class="card">
            <div class="card-header">
                <div class="card-title">All Complaints (${complaints.size()})</div>
            </div>
            <div class="table-container">
                <c:choose>
                    <c:when test="${empty complaints}">
                        <div class="empty-state">
                            <div class="empty-icon">📭</div>
                            <h3>No complaints found</h3>
                            <p>You haven't submitted any complaints yet.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <table>
                            <thead>
                                <tr>
                                    <th>#ID</th>
                                    <th>Title</th>
                                    <th>Category</th>
                                    <th>Priority</th>
                                    <th>Status</th>
                                    <th>Submitted</th>
                                    <th>Last Updated</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="c" items="${complaints}">
                                    <tr>
                                        <td style="color:var(--text-muted); font-weight:600;">#${c.id}</td>
                                        <td style="font-weight:600; max-width:220px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">
                                            <c:out value="${c.title}"/>
                                        </td>
                                        <td style="color:var(--text-secondary);">
                                            <c:out value="${c.category}"/>
                                        </td>
                                        <td>
                                            <span class="badge ${c.priorityClass}"><c:out value="${c.priority}"/></span>
                                        </td>
                                        <td>
                                            <span class="badge ${c.statusClass}"><c:out value="${c.statusLabel}"/></span>
                                        </td>
                                        <td style="color:var(--text-muted); font-size:0.82rem;">
                                            <fmt:formatDate value="${c.createdAt}" pattern="dd MMM yyyy"/>
                                        </td>
                                        <td style="color:var(--text-muted); font-size:0.82rem;">
                                            <fmt:formatDate value="${c.updatedAt}" pattern="dd MMM yyyy"/>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/complaint/detail?id=${c.id}"
                                               class="btn btn-outline btn-sm">View</a>
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
