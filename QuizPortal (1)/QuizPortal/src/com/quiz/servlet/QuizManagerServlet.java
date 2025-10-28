package com.quiz.servlet;

import com.quiz.dao.QuizDAO;
import com.quiz.model.Quiz;
import com.quiz.model.Question;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin/quizManager")
public class QuizManagerServlet extends HttpServlet {
    private QuizDAO quizDAO = new QuizDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String action = request.getParameter("action");

        if ("view".equals(action)) {
            String quizIdParam = request.getParameter("quizId");
            if (quizIdParam != null) {
                int quizId = Integer.parseInt(quizIdParam);
                Quiz quiz = quizDAO.getQuizById(quizId);
                List<Question> questions = quizDAO.getQuizQuestions(quizId);
                quiz.setQuestions(questions);
                request.setAttribute("quiz", quiz);
                request.getRequestDispatcher("/admin/quizDetail.jsp").forward(request, response);
                return;
            }
        } else if ("edit".equals(action)) {
            String quizIdParam = request.getParameter("quizId");
            if (quizIdParam != null) {
                int quizId = Integer.parseInt(quizIdParam);
                Quiz quiz = quizDAO.getQuizById(quizId);
                request.setAttribute("quiz", quiz);
                request.getRequestDispatcher("/admin/editQuiz.jsp").forward(request, response);
                return;
            }
        }

        // Default: list all quizzes
        List<Quiz> quizzes = quizDAO.getAllQuizzes();
        request.setAttribute("quizzes", quizzes);
        request.getRequestDispatcher("/admin/quizManager.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            int quizId = Integer.parseInt(request.getParameter("quizId"));
            quizDAO.deleteQuiz(quizId);
        } else if ("update".equals(action)) {
            int quizId = Integer.parseInt(request.getParameter("quizId"));
            String quizTitle = request.getParameter("quizTitle");
            String category = request.getParameter("category");

            quizDAO.updateQuiz(quizId, quizTitle, category);
        }

        // Redirect back to quiz manager after any POST action
        response.sendRedirect(request.getContextPath() + "/admin/quizManager");
    }
}
