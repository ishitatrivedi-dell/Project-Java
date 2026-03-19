package com.cms.servlet;

import com.cms.dao.UserDAO;
import com.cms.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/** Handles GET (show form) and POST (process credentials) for /login. */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // If already logged in, redirect straight to dashboard
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("loggedInUser") != null) {
            String role = (String) session.getAttribute("userRole");
            resp.sendRedirect(req.getContextPath() + ("ADMIN".equals(role) ? "/admin/dashboard" : "/dashboard"));
            return;
        }
        req.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String email    = req.getParameter("email");
        String password = req.getParameter("password");

        if (email == null || email.isBlank() || password == null || password.isBlank()) {
            req.setAttribute("error", "Please fill in all fields.");
            req.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(req, resp);
            return;
        }

        User user = userDAO.login(email, password);
        if (user == null) {
            req.setAttribute("error", "Invalid email or password.");
            req.setAttribute("emailVal", email);
            req.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(req, resp);
            return;
        }

        // Create session
        HttpSession session = req.getSession(true);
        session.setAttribute("loggedInUser", user);
        session.setAttribute("userId",       user.getId());
        session.setAttribute("userName",     user.getName());
        session.setAttribute("userRole",     user.getRole());
        session.setMaxInactiveInterval(30 * 60); // 30 minutes

        String ctx = req.getContextPath();
        resp.sendRedirect(ctx + (user.isAdmin() ? "/admin/dashboard" : "/dashboard"));
    }
}
