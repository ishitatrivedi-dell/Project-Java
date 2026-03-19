package com.cms.servlet;

import com.cms.dao.ComplaintDAO;
import com.cms.model.Complaint;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Shows a single complaint's full detail.
 * GET  /admin/complaint-detail?id=X  → admin view
 * GET  /complaint/detail?id=X        → user view (ownership checked)
 */
@WebServlet({"/admin/complaint-detail", "/complaint/detail"})
public class ComplaintDetailServlet extends HttpServlet {

    private final ComplaintDAO complaintDAO = new ComplaintDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String idParam = req.getParameter("id");
        if (idParam == null) {
            resp.sendRedirect(req.getContextPath() + "/dashboard");
            return;
        }

        int id = Integer.parseInt(idParam);
        Complaint complaint = complaintDAO.findById(id);

        if (complaint == null) {
            req.setAttribute("error", "Complaint not found.");
            req.getRequestDispatcher("/WEB-INF/jsp/error.jsp").forward(req, resp);
            return;
        }

        // For user route: verify ownership
        String uri  = req.getRequestURI();
        String ctx  = req.getContextPath();
        String role = (String) req.getSession().getAttribute("userRole");

        if (!uri.startsWith(ctx + "/admin")) {
            int sessionUserId = (int) req.getSession().getAttribute("userId");
            if (complaint.getUserId() != sessionUserId) {
                resp.sendRedirect(ctx + "/complaint/list?error=unauthorized");
                return;
            }
        }

        req.setAttribute("complaint", complaint);
        req.setAttribute("isAdmin", "ADMIN".equals(role));
        req.getRequestDispatcher("/WEB-INF/jsp/complaint-detail.jsp").forward(req, resp);
    }
}
