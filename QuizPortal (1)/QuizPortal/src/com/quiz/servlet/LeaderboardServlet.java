package com.quiz.servlet;

import com.quiz.dao.LeaderboardDAO;
import com.quiz.dao.QuizDAO;
import com.quiz.model.Leaderboard;
import com.quiz.model.Quiz;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/user/leaderboard")
public class LeaderboardServlet extends HttpServlet {
    private LeaderboardDAO leaderboardDAO = new LeaderboardDAO();
    private QuizDAO quizDAO = new QuizDAO();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String quizIdParam = request.getParameter("quizId");
        
        if (quizIdParam != null && !quizIdParam.isEmpty()) {
            int quizId = Integer.parseInt(quizIdParam);
            Quiz quiz = quizDAO.getQuizById(quizId);
            List<Leaderboard> leaderboard = leaderboardDAO.getLeaderboardByQuiz(quizId);
            
            request.setAttribute("quiz", quiz);
            request.setAttribute("leaderboard", leaderboard);
        } else {
            List<Leaderboard> leaderboard = leaderboardDAO.getAllLeaderboard();
            request.setAttribute("leaderboard", leaderboard);
        }
        
        request.getRequestDispatcher("/user/leaderboard.jsp").forward(request, response);
    }
}