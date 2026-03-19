package com.cms.servlet;

import com.cms.dao.ComplaintDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/** Shows all complaints for the logged-in user at /complaint/list. */
@WebServlet("/complaint/list")
public class MyComplaintsServlet extends HttpServlet {

    private final ComplaintDAO complaintDAO = new ComplaintDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int userId = (int) req.getSession().getAttribute("userId");
        req.setAttribute("complaints", complaintDAO.findByUserId(userId));
        req.getRequestDispatcher("/WEB-INF/jsp/my-complaints.jsp").forward(req, resp);
    }
}
