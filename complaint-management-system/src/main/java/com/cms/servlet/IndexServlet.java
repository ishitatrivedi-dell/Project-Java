package com.cms.servlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/** Redirects root "/" to either dashboard or login. */
@WebServlet("/index")
public class IndexServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        String ctx = req.getContextPath();
        if (session != null && session.getAttribute("loggedInUser") != null) {
            String role = (String) session.getAttribute("userRole");
            resp.sendRedirect(ctx + ("ADMIN".equals(role) ? "/admin/dashboard" : "/dashboard"));
        } else {
            resp.sendRedirect(ctx + "/login");
        }
    }
}
