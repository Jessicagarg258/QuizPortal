<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.quiz.model.Quiz, com.quiz.model.Leaderboard, java.util.List" %>
<%
    Quiz quiz = (Quiz) request.getAttribute("quiz");
    List<Leaderboard> leaderboard = (List<Leaderboard>) request.getAttribute("leaderboard");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Leaderboard</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #1a1a1a; color: white; }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px;
        }
        .header {
            text-align: center;
            margin-bottom: 40px;
        }
        .quiz-name {
            color: #ff4444;
            font-size: 28px;
            margin-bottom: 10px;
        }
        .category {
            font-size: 48px;
            font-weight: bold;
            margin: 20px 0;
        }
        .leaderboard-table {
            background: white;
            border-radius: 10px;
            overflow: hidden;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        thead {
            background: #f8f9fa;
        }
        th, td {
            padding: 15px;
            text-align: left;
            color: #333;
        }
        th {
            font-weight: bold;
            text-transform: uppercase;
            font-size: 12px;
            letter-spacing: 1px;
        }
        tbody tr {
            border-bottom: 1px solid #e0e0e0;
        }
        tbody tr:hover {
            background: #f8f9fa;
        }
        .rank-1 {
            background: #fff3cd !important;
        }
        .rank-2 {
            background: #e8f5e9 !important;
        }
        .rank-3 {
            background: #e3f2fd !important;
        }
        .btn-back {
            display: inline-block;
            margin-top: 30px;
            padding: 12px 30px;
            background: #667eea;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <% if (quiz != null) { %>
                <div class="quiz-name">QUIZ NAME: <%= quiz.getQuizTitle().toUpperCase() %></div>
            <% } %>
            <div class="category">CATEGORY : <%= quiz != null ? quiz.getCategory() : "ALL QUIZZES" %></div>
        </div>
        
        <div class="leaderboard-table">
            <table>
                <thead>
                    <tr>
                        <th>SR NO</th>
                        <th>NAME</th>
                        <th>EMAIL</th>
                        <th>SCORE</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (leaderboard != null && !leaderboard.isEmpty()) {
                        for (Leaderboard entry : leaderboard) {
                            String rankClass = "";
                            if (entry.getSrNo() == 1) rankClass = "rank-1";
                            else if (entry.getSrNo() == 2) rankClass = "rank-2";
                            else if (entry.getSrNo() == 3) rankClass = "rank-3";
                    %>
                            <tr class="<%= rankClass %>">
                                <td><%= entry.getSrNo() %></td>
                                <td><%= entry.getUsername() %></td>
                                <td><%= entry.getEmail() %></td>
                                <td><%= entry.getScore() %></td>
                            </tr>
                    <% }
                    } else { %>
                        <tr>
                            <td colspan="4" style="text-align: center;">No attempts yet</td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        
        <a href="${pageContext.request.contextPath}/user/quizList" class="btn-back">Back to Quiz List</a>
    </div>
</body>
</html>