package com.quiz.servlet;

import com.quiz.dao.AdminDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private AdminDAO adminDAO = new AdminDAO();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }
        
        int totalQuiz = adminDAO.getTotalQuizCount();
        int totalQuestions = adminDAO.getTotalQuestionCount();
        int totalUsers = adminDAO.getTotalUserCount();
        
        request.setAttribute("totalQuiz", totalQuiz);
        request.setAttribute("totalQuestions", totalQuestions);
        request.setAttribute("totalUsers", totalUsers);
        
        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}