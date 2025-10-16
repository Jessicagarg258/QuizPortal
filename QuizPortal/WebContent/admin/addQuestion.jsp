<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.quiz.model.Admin" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect(request.getContextPath() + "/admin/login");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Question - Quiz App</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
        }
        .layout {
            display: flex;
            min-height: 100vh;
        }
        .sidebar {
            width: 260px;
            background: linear-gradient(180deg, #4e73df 0%, #224abe 100%);
            color: white;
            padding: 20px;
        }
        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 30px;
            font-size: 20px;
            font-weight: bold;
        }
        .menu-item {
            padding: 12px 15px;
            margin-bottom: 5px;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s;
            display: block;
            color: white;
            text-decoration: none;
        }
        .menu-item:hover {
            background: rgba(255,255,255,0.1);
        }
        .main-content {
            flex: 1;
            padding: 30px;
        }
        .form-container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            max-width: 800px;
        }
        h2 {
            color: #333;
            margin-bottom: 30px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            color: #666;
            font-weight: bold;
        }
        input[type="text"],
        textarea,
        select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        textarea {
            resize: vertical;
            min-height: 80px;
        }
        .btn {
            padding: 12px 30px;
            background: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn:hover {
            background: #218838;
        }
        .success {
            background: #d4edda;
            color: #155724;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .error {
            background: #f8d7da;
            color: #721c24;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="layout">
        <div class="sidebar">
            <div class="logo">
                🎯 QUIZ APP
            </div>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="menu-item">📊 Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/quizManager" class="menu-item">📝 Quiz Manager</a>
            <a href="${pageContext.request.contextPath}/admin/questionList" class="menu-item">❓ Question Manager</a>
            <a href="${pageContext.request.contextPath}/admin/addQuestion" class="menu-item active">➕ Add New Question</a>
            <a href="${pageContext.request.contextPath}/admin/createQuiz" class="menu-item">🆕 Create Quiz</a>
        </div>
        <div class="main-content">
            <div class="form-container">
                <h2>Add New Question</h2>
                
                <% if (request.getAttribute("success") != null) { %>
                    <div class="success"><%= request.getAttribute("success") %></div>
                <% } %>
                
                <% if (request.getAttribute("error") != null) { %>
                    <div class="error"><%= request.getAttribute("error") %></div>
                <% } %>
                
                <form action="${pageContext.request.contextPath}/admin/addQuestion" method="post">
                    <div class="form-group">
                        <label>Question</label>
                        <textarea name="questionText" required></textarea>
                    </div>
                    
                    <div class="form-group">
                        <label>Option 1</label>
                        <input type="text" name="option1" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Option 2</label>
                        <input type="text" name="option2" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Option 3</label>
                        <input type="text" name="option3" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Option 4</label>
                        <input type="text" name="option4" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Correct Option</label>
                        <select name="correctOption" required>
                            <option value="">Select Correct Option</option>
                            <option value="1">Option 1</option>
                            <option value="2">Option 2</option>
                            <option value="3">Option 3</option>
                            <option value="4">Option 4</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label>Category</label>
                        <input type="text" name="category" placeholder="e.g., SCIENCE" required>
                    </div>
                    
                    <button type="submit" class="btn">Add Question</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>