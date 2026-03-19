package com.cms.servlet;

import com.cms.dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/** Handles user self-registration at /register. */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String name     = req.getParameter("name");
        String email    = req.getParameter("email");
        String password = req.getParameter("password");
        String confirm  = req.getParameter("confirmPassword");
        String phone    = req.getParameter("phone");

        // Basic validation
        if (name == null    || name.isBlank()     ||
            email == null   || email.isBlank()    ||
            password == null|| password.isBlank()) {
            req.setAttribute("error", "Please fill in all required fields.");
            forwardBack(req, resp, name, email, phone);
            return;
        }

        if (!password.equals(confirm)) {
            req.setAttribute("error", "Passwords do not match.");
            forwardBack(req, resp, name, email, phone);
            return;
        }

        if (password.length() < 6) {
            req.setAttribute("error", "Password must be at least 6 characters.");
            forwardBack(req, resp, name, email, phone);
            return;
        }

        int result = userDAO.register(name, email, password, phone);

        if (result == -2) {
            req.setAttribute("error", "This email is already registered. Please login.");
            forwardBack(req, resp, name, email, phone);
            return;
        }

        if (result > 0) {
            resp.sendRedirect(req.getContextPath() + "/login?registered=true");
        } else {
            req.setAttribute("error", "Registration failed. Please try again.");
            forwardBack(req, resp, name, email, phone);
        }
    }

    private void forwardBack(HttpServletRequest req, HttpServletResponse resp,
                             String name, String email, String phone)
            throws ServletException, IOException {
        req.setAttribute("nameVal",  name);
        req.setAttribute("emailVal", email);
        req.setAttribute("phoneVal", phone);
        req.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(req, resp);
    }
}
