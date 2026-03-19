<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complaint #${complaint.id} — CMS Portal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="layout">

    <!-- Sidebar changes based on role -->
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
                <div class="user-role">${isAdmin ? 'Admin' : 'User'}</div>
            </div>
        </div>
        <nav class="sidebar-nav">
            <div class="nav-section-label">Main</div>
            <c:choose>
                <c:when test="${isAdmin}">
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-item">
                        <span class="nav-icon">🏠</span> Admin Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/complaints" class="nav-item active">
                        <span class="nav-icon">📋</span> All Complaints
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/dashboard" class="nav-item">
                        <span class="nav-icon">🏠</span> Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/complaint/submit" class="nav-item">
                        <span class="nav-icon">➕</span> Submit Complaint
                    </a>
                    <a href="${pageContext.request.contextPath}/complaint/list" class="nav-item active">
                        <span class="nav-icon">📄</span> My Complaints
                    </a>
                </c:otherwise>
            </c:choose>
        </nav>
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/logout" class="nav-item" style="color:var(--danger);">
                <span class="nav-icon">🚪</span> Logout
            </a>
        </div>
    </aside>

    <main class="main-content">
        <!-- Back link -->
        <div class="mb-2">
            <c:choose>
                <c:when test="${isAdmin}">
                    <a href="${pageContext.request.contextPath}/admin/complaints"
                       style="color:var(--accent); font-size:0.85rem; font-weight:600;">← Back to All Complaints</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/complaint/list"
                       style="color:var(--accent); font-size:0.85rem; font-weight:600;">← Back to My Complaints</a>
                </c:otherwise>
            </c:choose>
        </div>

        <c:if test="${'true' eq param.updated}">
            <div class="alert alert-success">✅ Complaint updated successfully.</div>
        </c:if>

        <div class="page-header">
            <div class="page-title">Complaint #${complaint.id}</div>
            <div class="page-subtitle">Submitted on
                <fmt:formatDate value="${complaint.createdAt}" pattern="dd MMMM yyyy, hh:mm a"/>
            </div>
        </div>

        <c:choose>
            <c:when test="${isAdmin}">
                <div class="detail-layout detail-layout-admin">

                    <!-- Left: Complaint Info -->
                    <div>
                        <div class="card mb-3">
                            <div class="card-header">
                                <div class="card-title">Complaint Details</div>
                                <div style="display:flex;gap:8px;">
                                    <span class="badge ${complaint.statusClass}"><c:out value="${complaint.statusLabel}"/></span>
                                    <span class="badge ${complaint.priorityClass}"><c:out value="${complaint.priority}"/></span>
                                </div>
                            </div>
                            <div class="card-body">
                                <h3 style="font-size:1.1rem; font-weight:700; margin-bottom:16px; color:var(--text-primary);">
                                    <c:out value="${complaint.title}"/>
                                </h3>

                                <div class="detail-grid">
                                    <div class="detail-item">
                                        <label>Submitted By</label>
                                        <span><c:out value="${complaint.userName}"/></span>
                                    </div>
                                    <div class="detail-item">
                                        <label>Email</label>
                                        <span><c:out value="${complaint.userEmail}"/></span>
                                    </div>
                                    <div class="detail-item">
                                        <label>Category</label>
                                        <span><c:out value="${complaint.category}"/></span>
                                    </div>
                                    <div class="detail-item">
                                        <label>Last Updated</label>
                                        <span><fmt:formatDate value="${complaint.updatedAt}" pattern="dd MMM yyyy, hh:mm a"/></span>
                                    </div>
                                </div>

                                <div class="divider"></div>
                                <label style="font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:var(--text-muted);">
                                    Description
                                </label>
                                <div class="detail-desc mt-1"><c:out value="${complaint.description}"/></div>
                            </div>
                        </div>

                        <c:if test="${not empty complaint.adminRemark}">
                            <div class="card">
                                <div class="card-header">
                                    <div class="card-title">💬 Admin Response</div>
                                </div>
                                <div class="card-body">
                                    <div class="remark-box">"<c:out value="${complaint.adminRemark}"/>"</div>
                                </div>
                            </div>
                        </c:if>
                    </div>

                    <!-- Right: Admin Action Panel -->
                    <div class="card detail-sticky">
                        <div class="card-header">
                            <div class="card-title">⚙️ Update Status</div>
                        </div>
                        <div class="card-body">
                            <form method="POST" action="${pageContext.request.contextPath}/admin/update-status">
                                <input type="hidden" name="complaintId" value="${complaint.id}">

                                <div class="form-group">
                                    <label for="status">New Status</label>
                                    <select id="status" name="status" class="form-control">
                                        <option value="PENDING"     ${complaint.status=='PENDING'     ? 'selected':''}>⏳ Pending</option>
                                        <option value="IN_PROGRESS" ${complaint.status=='IN_PROGRESS' ? 'selected':''}>🔄 In Progress</option>
                                        <option value="RESOLVED"    ${complaint.status=='RESOLVED'    ? 'selected':''}>✅ Resolved</option>
                                        <option value="CLOSED"      ${complaint.status=='CLOSED'      ? 'selected':''}>🔒 Closed</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label for="adminRemark">Remark / Response</label>
                                    <textarea id="adminRemark" name="adminRemark" class="form-control" rows="4"
                                              placeholder="Leave a note for the complainant..."><c:out value="${complaint.adminRemark}"/></textarea>
                                </div>

                                <button type="submit" class="btn btn-primary btn-full">Update Complaint</button>
                            </form>
                        </div>
                    </div>
                </div>
            </c:when>

            <c:otherwise>
                <div class="detail-layout detail-layout-user">
                    <div class="card">
                        <div class="card-header">
                            <div class="card-title">Complaint Details</div>
                            <div style="display:flex;gap:8px;">
                                <span class="badge ${complaint.statusClass}"><c:out value="${complaint.statusLabel}"/></span>
                                <span class="badge ${complaint.priorityClass}"><c:out value="${complaint.priority}"/></span>
                            </div>
                        </div>
                        <div class="card-body">
                            <h3 style="font-size:1.1rem; font-weight:700; margin-bottom:16px; color:var(--text-primary);">
                                <c:out value="${complaint.title}"/>
                            </h3>

                            <div class="detail-grid">
                                <div class="detail-item">
                                    <label>Category</label>
                                    <span><c:out value="${complaint.category}"/></span>
                                </div>
                                <div class="detail-item">
                                    <label>Last Updated</label>
                                    <span><fmt:formatDate value="${complaint.updatedAt}" pattern="dd MMM yyyy, hh:mm a"/></span>
                                </div>
                            </div>

                            <div class="divider"></div>
                            <label style="font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:var(--text-muted);">
                                Description
                            </label>
                            <div class="detail-desc mt-1"><c:out value="${complaint.description}"/></div>

                            <c:if test="${not empty complaint.adminRemark}">
                                <div class="divider"></div>
                                <div class="card" style="background:transparent; border:none;">
                                    <div class="card-header" style="padding:0 0 12px 0; border:none;">
                                        <div class="card-title">💬 Admin Response</div>
                                    </div>
                                    <div class="remark-box">"<c:out value="${complaint.adminRemark}"/>"</div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </main>
</div>
</body>
</html>
