<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.quiz.model.User, com.quiz.model.Quiz, java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/user/login");
        return;
    }
    List<Quiz> quizzes = (List<Quiz>) request.getAttribute("quizzes");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quiz List - Quiz Portal</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .navbar {
            background: #1a1a1a;
            padding: 15px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .logo { color: #ff4444; font-size: 24px; font-weight: bold; }
        .nav-links a {
            color: white;
            text-decoration: none;
            margin-left: 30px;
        }
        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }
        h1 { color: #333; margin-bottom: 30px; }
        .quiz-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
        }
        .quiz-card {
            background: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: transform 0.3s;
            border-left: 5px solid #667eea;
        }
        .quiz-card:hover { transform: translateY(-5px); }
        .quiz-card h3 { color: #333; margin-bottom: 15px; }
        .quiz-category {
            display: inline-block;
            background: #667eea;
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 12px;
            margin-bottom: 15px;
        }
        .btn-start {
            background: #28a745;
            color: white;
            padding: 10px 25px;
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
        }
        .btn-start:hover { background: #218838; }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="logo">ONLINE QUIZ</div>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/user/quizList">Quiz</a>
            <a href="#">Welcome, <%= user.getUsername() %>!</a>
        </div>
    </nav>
    
    <div class="container">
        <h1>Quiz List</h1>
        
        <div class="quiz-grid">
            <% if (quizzes != null && !quizzes.isEmpty()) {
                for (Quiz quiz : quizzes) { %>
                    <div class="quiz-card">
                        <span class="quiz-category"><%= quiz.getCategory() %></span>
                        <h3><%= quiz.getQuizTitle() %></h3>
                        <a href="${pageContext.request.contextPath}/user/attemptQuiz?quizId=<%= quiz.getQuizId() %>" class="btn-start">Start Quiz</a>
                    </div>
            <% }
            } else { %>
                <p>No quizzes available at the moment.</p>
            <% } %>
        </div>
    </div>
</body>
</html>