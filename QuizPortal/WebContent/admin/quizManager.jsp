<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.quiz.model.Admin, com.quiz.model.Quiz, java.util.List" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect(request.getContextPath() + "/admin/login");
        return;
    }
    List<Quiz> quizzes = (List<Quiz>) request.getAttribute("quizzes");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quiz Manager - Quiz App</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .layout { display: flex; min-height: 100vh; }
        .sidebar {
            width: 260px;
            background: linear-gradient(180deg, #4e73df 0%, #224abe 100%);
            color: white;
            padding: 20px;
        }
        .logo { margin-bottom: 30px; font-size: 20px; font-weight: bold; }
        .menu-item {
            padding: 12px 15px;
            margin-bottom: 5px;
            border-radius: 5px;
            display: block;
            color: white;
            text-decoration: none;
        }
        .menu-item:hover { background: rgba(255,255,255,0.1); }
        .main-content { flex: 1; padding: 30px; }
        .table-container {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background: #f8f9fa; font-weight: bold; }
        .btn { padding: 6px 12px; border-radius: 4px; text-decoration: none; display: inline-block; }
        .btn-view { background: #17a2b8; color: white; }
        .btn-delete { background: #dc3545; color: white; border: none; cursor: pointer; }
    </style>
</head>
<body>
    <div class="layout">
        <div class="sidebar">
            <div class="logo">🎯 QUIZ APP</div>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="menu-item">📊 Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/quizManager" class="menu-item active">📝 Quiz Manager</a>
            <a href="${pageContext.request.contextPath}/admin/questionList" class="menu-item">❓ Question Manager</a>
            <a href="${pageContext.request.contextPath}/admin/addQuestion" class="menu-item">➕ Add New Question</a>
            <a href="${pageContext.request.contextPath}/admin/createQuiz" class="menu-item">🆕 Create Quiz</a>
        </div>
        <div class="main-content">
            <div class="table-container">
                <h2>Quiz Manager</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Sr No.</th>
                            <th>Quiz Title</th>
                            <th>Category</th>
                            <th>Created At</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (quizzes != null && !quizzes.isEmpty()) {
                            int srNo = 1;
                            for (Quiz quiz : quizzes) { %>
                                <tr>
                                    <td><%= srNo++ %></td>
                                    <td><%= quiz.getQuizTitle() %></td>
                                    <td><%= quiz.getCategory() %></td>
                                    <td><%= quiz.getCreatedAt() %></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/quizManager?action=view&quizId=<%= quiz.getQuizId() %>" class="btn btn-view">View</a>
                                        <form action="${pageContext.request.contextPath}/admin/quizManager" method="post" style="display:inline;">
                                            <input type="hidden" name="quizId" value="<%= quiz.getQuizId() %>">
                                            <input type="hidden" name="action" value="delete">
                                            <button type="submit" class="btn btn-delete" onclick="return confirm('Are you sure?')">Delete</button>
                                        </form>
                                    </td>
                                </tr>
                        <% }
                        } else { %>
                            <tr><td colspan="5" style="text-align: center;">No quizzes found</td></tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>