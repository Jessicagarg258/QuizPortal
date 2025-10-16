package com.quiz.servlet;

import com.quiz.dao.QuizDAO;
import com.quiz.model.Quiz;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/user/quizList")
public class QuizListServlet extends HttpServlet {
    private QuizDAO quizDAO = new QuizDAO();
    
    protected void doGet(HttpServletRequest  request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }
        
        List<Quiz> quizzes = quizDAO.getAllQuizzes();
        request.setAttribute("quizzes", quizzes);
        request.getRequestDispatcher("/user/quizList.jsp").forward(request, response);
    }
}