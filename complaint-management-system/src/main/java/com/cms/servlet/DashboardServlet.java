package com.cms.servlet;

import com.cms.dao.ComplaintDAO;
import com.cms.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/** User dashboard — shows personal stats and recent complaints. */
@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private final ComplaintDAO complaintDAO = new ComplaintDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("loggedInUser");
        int userId = user.getId();

        req.setAttribute("totalComplaints",    complaintDAO.countByUserId(userId));
        req.setAttribute("pendingComplaints",  complaintDAO.countByUserIdAndStatus(userId, "PENDING"));
        req.setAttribute("inProgressComplaints", complaintDAO.countByUserIdAndStatus(userId, "IN_PROGRESS"));
        req.setAttribute("resolvedComplaints", complaintDAO.countByUserIdAndStatus(userId, "RESOLVED"));

        // Last 5 complaints of this user
        req.setAttribute("recentComplaints",
                complaintDAO.findByUserId(userId).stream().limit(5).toList());

        req.getRequestDispatcher("/WEB-INF/jsp/dashboard.jsp").forward(req, resp);
    }
}
