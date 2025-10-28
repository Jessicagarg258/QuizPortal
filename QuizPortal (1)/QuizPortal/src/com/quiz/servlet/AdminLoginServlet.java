package com.quiz.servlet;

import com.quiz.dao.AdminDAO;
import com.quiz.model.Admin;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin/login")
public class AdminLoginServlet extends HttpServlet {
    private AdminDAO adminDAO = new AdminDAO();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/admin/login.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        Admin admin = adminDAO.authenticateAdmin(username, password);
        
        if (admin != null) {
            HttpSession session = request.getSession();
            session.setAttribute("admin", admin);
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        } else {
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("/admin/login.jsp").forward(request, response);
        }
    }
}