package com.cms.servlet;

import com.cms.dao.ComplaintDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/** Admin: list all complaints with optional status filter at /admin/complaints. */
@WebServlet("/admin/complaints")
public class AdminComplaintsServlet extends HttpServlet {

    private final ComplaintDAO complaintDAO = new ComplaintDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String filter = req.getParameter("status");
        if (filter != null && filter.isBlank()) filter = null;

        req.setAttribute("activeFilter", filter == null ? "ALL" : filter);
        req.setAttribute("complaints",
                filter == null ? complaintDAO.findAll() : complaintDAO.findByStatus(filter));

        req.getRequestDispatcher("/WEB-INF/jsp/admin-complaints.jsp").forward(req, resp);
    }
}
