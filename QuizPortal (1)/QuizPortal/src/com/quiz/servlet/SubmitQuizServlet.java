package com.quiz.servlet;
 
import com.quiz.dao.QuizDAO;
import com.quiz.model.Quiz;
import com.quiz.model.Question;
import com.quiz.model.User;
 
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
 
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
 
@WebServlet("/user/submitQuiz")
public class SubmitQuizServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private QuizDAO quizDAO = new QuizDAO();
 
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }
 
        Quiz quiz = (Quiz) session.getAttribute("currentQuiz");
        if (quiz == null || quiz.getQuestions() == null) {
            response.sendRedirect(request.getContextPath() + "/user/quizList");
            return;
        }
 
        List<Question> questions = quiz.getQuestions();
        int score = 0;
        Map<Integer, Integer> userAnswers = new HashMap<>();
 
        for (Question question : questions) {
            Integer selectedOption = (Integer) session.getAttribute("answer_" + question.getQuestionId());
            if (selectedOption != null) {
                userAnswers.put(question.getQuestionId(), selectedOption);
                if (selectedOption == question.getCorrectOption()) {
                    score++;
                }
            }
        }
 
        int attemptId = quizDAO.saveQuizAttempt(quiz.getQuizId(), user.getUserId(), score, questions.size());
 
        if (attemptId > 0) {
            for (Question question : questions) {
                Integer selectedOption = userAnswers.get(question.getQuestionId());
                if (selectedOption != null) {
                    boolean isCorrect = selectedOption == question.getCorrectOption();
                    quizDAO.saveUserAnswer(attemptId, question.getQuestionId(), selectedOption, isCorrect);
                }
            }
        }
 
        for (Question question : questions) {
            session.removeAttribute("answer_" + question.getQuestionId());
        }
        session.removeAttribute("currentQuiz");
        session.removeAttribute("currentQuestionIndex");
 
        request.setAttribute("score", score);
        request.setAttribute("totalQuestions", questions.size());
        request.setAttribute("quiz", quiz);
        request.setAttribute("questions", questions);
        request.setAttribute("userAnswers", userAnswers);
 
        request.getRequestDispatcher("/user/result.jsp").forward(request, response);
    }
}