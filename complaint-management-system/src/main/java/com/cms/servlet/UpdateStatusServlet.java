package com.cms.servlet;

import com.cms.dao.ComplaintDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Admin: updates the status and remark of a complaint.
 * POST /admin/update-status
 */
@WebServlet("/admin/update-status")
public class UpdateStatusServlet extends HttpServlet {

    private final ComplaintDAO complaintDAO = new ComplaintDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String idParam = req.getParameter("complaintId");
        String status  = req.getParameter("status");
        String remark  = req.getParameter("adminRemark");

        if (idParam == null || status == null || status.isBlank()) {
            resp.sendRedirect(req.getContextPath() + "/admin/complaints?error=invalid");
            return;
        }

        int complaintId = Integer.parseInt(idParam);
        boolean ok = complaintDAO.updateStatus(complaintId, status, remark);

        String redirect = req.getContextPath() +
                "/admin/complaint-detail?id=" + complaintId +
                (ok ? "&updated=true" : "&error=updateFailed");
        resp.sendRedirect(redirect);
    }
}
