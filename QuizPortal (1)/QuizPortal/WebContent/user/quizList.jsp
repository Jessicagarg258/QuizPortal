<%@page import="com.quiz.dao.QuizDAO"%>
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

    /* Table Styles */
    table {
        width: 100%;
        border-collapse: collapse;
        background: white;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        border-radius: 8px;
        overflow: hidden;
    }
    th, td {
        padding: 12px 15px;
        border-bottom: 1px solid #ddd;
        text-align: center;
        vertical-align: middle;
    }
    th {
        background: #667eea;
        color: white;
        font-size: 14px;
    }
    tr:hover { background: #f1f1f1; }
    .btn-start {
        background: #28a745;
        color: white;
        padding: 6px 12px;
        text-decoration: none;
        border-radius: 4px;
        font-size: 14px;
    }
    .btn-start:hover { background: #218838; }
    .no-quiz {
        text-align: center;
        padding: 20px;
        color: #555;
    }
</style>
</head>
<body>
<nav class="navbar">
    <div class="logo">ONLINE QUIZ</div>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/user/quizList">Quiz</a>
                    <a href="${pageContext.request.contextPath}/user/leaderboard">Leaderboard</a>
        
        <a href="#">Welcome, <%= user.getUsername() %>!</a>
        <a href="${pageContext.request.contextPath}/logout" style="color: #ff4444;">Logout</a>
    </div>
</nav>
<div class="container">
    <h1>Quiz List</h1>
    <% if (quizzes != null && !quizzes.isEmpty()) { %>
        <table style="width:100%; border-collapse: collapse; text-align: center;">
            <thead>
                <tr style="background:#f8f9fa;">
                    <th style="padding:10px; border-bottom:1px solid #ddd;">S.No</th>
                    <th style="padding:10px; border-bottom:1px solid #ddd;">Quiz Title</th>
                    <th style="padding:10px; border-bottom:1px solid #ddd;">Category</th>
                    <th style="padding:10px; border-bottom:1px solid #ddd;">Action</th>
                </tr>
            </thead>
            <tbody>
                <% 
                   int srNo = 1;
                   QuizDAO quizDAO = new QuizDAO();
                   int userId = user.getUserId(); // from session
                   for (Quiz quiz : quizzes) { 
                       boolean attempted = quizDAO.hasUserAttemptedQuiz(userId, quiz.getQuizId());
                %>
                <tr>
                    <td style="padding:10px; border-bottom:1px solid #ddd;"><%= srNo++ %></td>
                    <td style="padding:10px; border-bottom:1px solid #ddd;"><%= quiz.getQuizTitle() %></td>
                    <td style="padding:10px; border-bottom:1px solid #ddd;"><%= quiz.getCategory() %></td>
                    <td style="padding:10px; border-bottom:1px solid #ddd;">
                        <% if (!attempted) { %>
                            <a href="${pageContext.request.contextPath}/user/attemptQuiz?quizId=<%= quiz.getQuizId() %>" 
                               class="btn-start"
                               style="background:#28a745; color:white; padding:6px 12px; border-radius:4px; text-decoration:none;">
                               Start
                            </a>
                        <% } else { %>
                            <span style="color:#ff4444; font-weight:bold;">Completed</span>
                        <% } %>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    <% } else { %>
        <div class="no-quiz" style="margin-top:20px; color:#666;">No quizzes available at the moment.</div>
    <% } %>
</div>

</body>
</html>
