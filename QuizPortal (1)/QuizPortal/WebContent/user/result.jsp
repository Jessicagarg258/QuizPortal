<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.quiz.model.User, com.quiz.model.Quiz, com.quiz.model.Question, java.util.List, java.util.Map" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/user/login");
        return;
    }
    int score = (Integer) request.getAttribute("score");
    int totalQuestions = (Integer) request.getAttribute("totalQuestions");
    Quiz quiz = (Quiz) request.getAttribute("quiz");
    List<Question> questions = (List<Question>) request.getAttribute("questions");
    Map<Integer, Integer> userAnswers = (Map<Integer, Integer>) request.getAttribute("userAnswers");
    double percentage = (score * 100.0) / totalQuestions;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quiz Result</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 0 20px;
        }
        .result-card {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
            margin-bottom: 30px;
        }
        .score-display {
            font-size: 72px;
            font-weight: bold;
            color: #28a745;
            margin: 20px 0;
        }
        .percentage {
            font-size: 24px;
            color: #666;
            margin-bottom: 20px;
        }
        .btn {
            padding: 12px 30px;
            border-radius: 5px;
            text-decoration: none;
            display: inline-block;
            margin: 10px;
        }
        .btn-leaderboard {
            background: #667eea;
            color: white;
        }
        .btn-home {
            background: #6c757d;
            color: white;
        }
        .answers-review {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .question-review {
            margin-bottom: 30px;
            padding: 20px;
            border-left: 4px solid #ddd;
        }
        .question-review.correct {
            border-left-color: #28a745;
            background: #f1f9f4;
        }
        .question-review.incorrect {
            border-left-color: #dc3545;
            background: #fef5f6;
        }
        .correct-answer {
            color: #28a745;
            font-weight: bold;
        }
        .wrong-answer {
            color: #dc3545;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="result-card">
            <h1>Quiz Completed!</h1>
            <div class="score-display"><%= score %> / <%= totalQuestions %></div>
            <div class="percentage"><%= String.format("%.1f", percentage) %>%</div>
            
            <a href="${pageContext.request.contextPath}/user/leaderboard?quizId=<%= quiz.getQuizId() %>" class="btn btn-leaderboard">View Leaderboard</a>
            <a href="${pageContext.request.contextPath}/user/quizList" class="btn btn-home">Back to Quiz List</a>
        </div>
        
        <div class="answers-review">
            <h2 style="margin-bottom: 30px;">Review Your Answers</h2>
            <%
            int qNum = 1;
            for (Question q : questions) {
                Integer userAnswer = userAnswers.get(q.getQuestionId());
                boolean isCorrect = userAnswer != null && userAnswer == q.getCorrectOption();
                String[] options = {q.getOption1(), q.getOption2(), q.getOption3(), q.getOption4()};
            %>
                <div class="question-review <%= isCorrect ? "correct" : "incorrect" %>">
                    <h3>Question <%= qNum++ %>: <%= q.getQuestionText() %></h3>
                    <p style="margin-top: 15px;">
                        <strong>Your Answer:</strong>
                        <span class="<%= isCorrect ? "correct-answer" : "wrong-answer" %>">
                            <%= userAnswer != null ? options[userAnswer - 1] : "Not answered" %>
                        </span>
                    </p>
                    <% if (!isCorrect) { %>
                        <p style="margin-top: 10px;">
                            <strong>Correct Answer:</strong>
                            <span class="correct-answer"><%= options[q.getCorrectOption() - 1] %></span>
                        </p>
                    <% } %>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>