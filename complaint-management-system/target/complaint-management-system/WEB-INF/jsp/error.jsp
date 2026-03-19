<%@ page contentType="text/html; charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error — CMS Portal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="auth-bg">
    <div class="auth-card" style="text-align:center; max-width:480px;">
        <div style="font-size:4rem; margin-bottom:16px;">⚠️</div>
        <h2 style="margin-bottom:8px;">Something went wrong</h2>
        <p class="subtitle" style="margin-bottom:24px;">
            <% if (request.getAttribute("error") != null) { %>
                ${error}
            <% } else if (pageContext.getErrorData() != null && pageContext.getErrorData().getStatusCode() != 0) { %>
                HTTP <%= pageContext.getErrorData().getStatusCode() %> —
                <%= pageContext.getErrorData().getRequestURI() %>
            <% } else { %>
                An unexpected error occurred. Please try again.
            <% } %>
        </p>
        <div style="display:flex; gap:12px; justify-content:center;">
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">🏠 Go Home</a>
            <button onclick="history.back()" class="btn btn-outline">← Go Back</button>
        </div>
    </div>
</div>
</body>
</html>
