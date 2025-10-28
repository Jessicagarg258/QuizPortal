<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.quiz.model.Admin, com.quiz.model.Question, java.util.List" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect(request.getContextPath() + "/admin/login");
        return;
    }
    List<Question> questions = (List<Question>) request.getAttribute("questions");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Quiz - Quiz App</title>
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
        .form-container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            max-width: 900px;
        }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; color: #666; font-weight: bold; }
        input[type="text"], select { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 5px; }
        .question-list {
            max-height: 400px;
            overflow-y: auto;
            border: 1px solid #ddd;
            padding: 15px;
            border-radius: 5px;
        }
        .question-item {
            padding: 10px;
            border: 1px solid #e0e0e0;
            margin-bottom: 10px;
            border-radius: 5px;
            display: flex;
            align-items: start;
            gap: 10px;
        }
        .question-item input[type="checkbox"] { margin-top: 5px; }
        .btn {
            padding: 12px 30px;
            background: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        .success { background: #d4edda; color: #155724; padding: 12px; border-radius: 5px; margin-bottom: 20px; }
        .error { background: #f8d7da; color: #721c24; padding: 12px; border-radius: 5px; margin-bottom: 20px; }
        .dropdown {
    margin-bottom: 10px;
}

.dropdown-toggle {
    position: relative;
}

.dropdown-content {
    display: none;
    flex-direction: column;
    background: rgba(255,255,255,0.1);
    border-radius: 5px;
    margin-top: 5px;
    padding-left: 10px;
}

.submenu-item {
    padding: 10px 15px;
    color: #f1f1f1;
    text-decoration: none;
    display: block;
    border-radius: 5px;
    transition: background 0.3s;
}

.submenu-item:hover {
    background: rgba(255,255,255,0.2);
}

/* Show dropdown on hover */
.dropdown:hover .dropdown-content {
    display: flex;
}

/* Rotate arrow when hovered */
.dropdown:hover .dropdown-toggle::after {
    content: "▲";
    position: absolute;
    right: 15px;
    font-size: 10px;
}

/* Default arrow symbol */
.dropdown-toggle::after {
    content: "▼";
    position: absolute;
    right: 15px;
    font-size: 10px;
}
 .btn-logout {
            background: #dc3545;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: block;
            text-align: center;
            width: 100%;
            font-size: 14px;
            transition: background 0.3s;
        }
        .btn-logout:hover {
            background: #c82333;
    </style>
</head>
<body>
    <div class="layout">
        <div class="sidebar">
    <div class="logo">🎯 QUIZ APP</div>

    <div class="user-info">
        <strong><%= admin.getFullName() != null ? admin.getFullName() : admin.getUsername() %></strong><br>
        <small><%= admin.getEmail() %></small>
    </div>

    <!-- Dashboard -->
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="menu-item active">📊 Dashboard</a>

    <!-- Quiz Manager Dropdown -->
    <div class="dropdown">
        <div class="menu-item dropdown-toggle">📝 Quiz Manager</div>
        <div class="dropdown-content">
            <a href="${pageContext.request.contextPath}/admin/createQuiz" class="submenu-item">🆕 Create New Quiz</a>
            <a href="${pageContext.request.contextPath}/admin/quizManager" class="submenu-item">📋 Quiz List</a>
        </div>
    </div>

    <!-- Question Manager Dropdown -->
    <div class="dropdown">
        <div class="menu-item dropdown-toggle">❓ Question Manager</div>
        <div class="dropdown-content">
            <a href="${pageContext.request.contextPath}/admin/addQuestion" class="submenu-item">➕ Add New Question</a>
            <a href="${pageContext.request.contextPath}/admin/questionList" class="submenu-item">📋 Question List</a>
        </div>
    </div>

    <!-- Logout -->
    <div class="logout-section">
        <a href="${pageContext.request.contextPath}/logout" class="btn-logout">🚪 Logout</a>
    </div>
</div>
        <div class="main-content">
            <div class="form-container">
                <h2>Create New Quiz</h2>
                
                <% if (request.getAttribute("success") != null) { %>
                    <div class="success"><%= request.getAttribute("success") %></div>
                <% } %>
                <% if (request.getAttribute("error") != null) { %>
                    <div class="error"><%= request.getAttribute("error") %></div>
                <% } %>
                
                <form action="${pageContext.request.contextPath}/admin/createQuiz" method="post">
                    <div class="form-group">
                        <label>Quiz Title</label>
                        <input type="text" name="quizTitle" placeholder="Enter quiz title" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Category</label>
                        <input type="text" name="category" placeholder="e.g., SCIENCE" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Select Questions</label>
                        <div class="question-list">
                            <% if (questions != null && !questions.isEmpty()) {
                                for (Question q : questions) { %>
                                    <div class="question-item">
                                        <input type="checkbox" name="questions" value="<%= q.getQuestionId() %>" id="q<%= q.getQuestionId() %>">
                                        <label for="q<%= q.getQuestionId() %>" style="font-weight: normal; margin: 0;">
                                            <%= q.getQuestionText() %> <small style="color: #999;">(Category: <%= q.getCategory() %>)</small>
                                        </label>
                                    </div>
                            <% }
                            } else { %>
                                <p>No questions available. Please add questions first.</p>
                            <% } %>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn">Create Quiz</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>