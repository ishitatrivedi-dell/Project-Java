package com.cms.servlet;

import com.cms.dao.ComplaintDAO;
import com.cms.dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/** Admin dashboard at /admin/dashboard — system-wide statistics. */
@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private final ComplaintDAO complaintDAO = new ComplaintDAO();
    private final UserDAO      userDAO      = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute("totalComplaints",      complaintDAO.countAll());
        req.setAttribute("pendingComplaints",    complaintDAO.countByStatus("PENDING"));
        req.setAttribute("inProgressComplaints", complaintDAO.countByStatus("IN_PROGRESS"));
        req.setAttribute("resolvedComplaints",   complaintDAO.countByStatus("RESOLVED"));
        req.setAttribute("closedComplaints",     complaintDAO.countByStatus("CLOSED"));
        req.setAttribute("totalUsers",           userDAO.countUsers());

        // Most-recent 10 complaints for quick overview
        req.setAttribute("recentComplaints",
                complaintDAO.findAll().stream().limit(10).toList());

        req.getRequestDispatcher("/WEB-INF/jsp/admin-dashboard.jsp").forward(req, resp);
    }
}
