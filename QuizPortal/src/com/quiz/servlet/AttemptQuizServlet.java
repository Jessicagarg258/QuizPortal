package com.quiz.servlet;

import com.quiz.dao.QuizDAO;
import com.quiz.model.Quiz;
import com.quiz.model.Question;
import com.quiz.model.User;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/user/attemptQuiz")
public class AttemptQuizServlet extends HttpServlet {
    private QuizDAO quizDAO = new QuizDAO();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }
        
        int quizId = Integer.parseInt(request.getParameter("quizId"));
        Quiz quiz = quizDAO.getQuizById(quizId);
        List<Question> questions = quizDAO.getQuizQuestions(quizId);
        
        quiz.setQuestions(questions);
        session.setAttribute("currentQuiz", quiz);
        session.setAttribute("currentQuestionIndex", 0);
        
        request.setAttribute("quiz", quiz);
        request.setAttribute("question", questions.get(0));
        request.setAttribute("questionNumber", 1);
        request.setAttribute("totalQuestions", questions.size());
        
        request.getRequestDispatcher("/user/attemptQuiz.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }
        
        Quiz quiz = (Quiz) session.getAttribute("currentQuiz");
        int currentIndex = (Integer) session.getAttribute("currentQuestionIndex");
        List<Question> questions = quiz.getQuestions();
        
        // Store user's answer
        String answerKey = "answer_" + questions.get(currentIndex).getQuestionId();
        String selectedOption = request.getParameter("selectedOption");
        if (selectedOption != null) {
            session.setAttribute(answerKey, Integer.parseInt(selectedOption));
        }
        
        String action = request.getParameter("action");
        
        if ("next".equals(action) && currentIndex < questions.size() - 1) {
            currentIndex++;
            session.setAttribute("currentQuestionIndex", currentIndex);
        } else if ("previous".equals(action) && currentIndex > 0) {
            currentIndex--;
            session.setAttribute("currentQuestionIndex", currentIndex);
        } else if ("submit".equals(action)) {
            response.sendRedirect(request.getContextPath() + "/user/submitQuiz");
            return;
        }
        
        Question currentQuestion = questions.get(currentIndex);
        Integer savedAnswer = (Integer) session.getAttribute("answer_" + currentQuestion.getQuestionId());
        
        request.setAttribute("quiz", quiz);
        request.setAttribute("question", currentQuestion);
        request.setAttribute("questionNumber", currentIndex + 1);
        request.setAttribute("totalQuestions", questions.size());
        request.setAttribute("savedAnswer", savedAnswer);
        
        request.getRequestDispatcher("/user/attemptQuiz.jsp").forward(request, response);
    }
}