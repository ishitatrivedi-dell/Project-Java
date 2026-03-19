package com.cms.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Authentication filter — protects all pages under /dashboard, /complaint/*, /admin/*.
 * Redirects unauthenticated users to /login.
 * Redirects non-admins away from /admin/*.
 */
@WebFilter(urlPatterns = {"/dashboard", "/complaint/*", "/admin/*"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  req  = (HttpServletRequest)  request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession         session = req.getSession(false);

        String ctxPath = req.getContextPath();

        boolean loggedIn = (session != null && session.getAttribute("loggedInUser") != null);

        if (!loggedIn) {
            resp.sendRedirect(ctxPath + "/login?error=session");
            return;
        }

        // Protect admin routes
        String uri = req.getRequestURI();
        if (uri.startsWith(ctxPath + "/admin")) {
            String role = (String) session.getAttribute("userRole");
            if (!"ADMIN".equals(role)) {
                resp.sendRedirect(ctxPath + "/dashboard?error=unauthorized");
                return;
            }
        }

        chain.doFilter(request, response);
    }

    @Override public void init(FilterConfig f) {}
    @Override public void destroy() {}
}
