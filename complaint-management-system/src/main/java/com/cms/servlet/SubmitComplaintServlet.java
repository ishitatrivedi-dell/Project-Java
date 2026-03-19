package com.cms.servlet;

import com.cms.dao.ComplaintDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/** Handles complaint submission at /complaint/submit. */
@WebServlet("/complaint/submit")
public class SubmitComplaintServlet extends HttpServlet {

    private final ComplaintDAO complaintDAO = new ComplaintDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/jsp/submit-complaint.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String title       = req.getParameter("title");
        String description = req.getParameter("description");
        String category    = req.getParameter("category");
        String priority    = req.getParameter("priority");

        // Preserve entered values when redisplaying the form
        req.setAttribute("titleVal", title);
        req.setAttribute("descriptionVal", description);
        req.setAttribute("categoryVal", category);
        req.setAttribute("priorityVal", priority);

        // Server-side validation
        if (title == null || title.isBlank() ||
            description == null || description.isBlank() ||
            category == null || category.isBlank()) {
            req.setAttribute("error", "Please fill in all required fields.");
            req.getRequestDispatcher("/WEB-INF/jsp/submit-complaint.jsp").forward(req, resp);
            return;
        }

        int userId = (int) req.getSession().getAttribute("userId");
        boolean ok = complaintDAO.submit(userId, title, description, category,
                                         (priority == null || priority.isBlank()) ? "MEDIUM" : priority);

        if (ok) {
            resp.sendRedirect(req.getContextPath() + "/complaint/list?submitted=true");
        } else {
            req.setAttribute("error", "Could not submit your complaint. Please try again.");
            req.getRequestDispatcher("/WEB-INF/jsp/submit-complaint.jsp").forward(req, resp);
        }
    }
}
