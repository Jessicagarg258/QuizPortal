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
<title>Question List - Quiz App</title>
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
        th { background: #f8f9fa; font-weight: bold; color: #333; }
        .btn-delete {
            background: #dc3545;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-delete:hover { background: #c82333; }
        .btn-add {
            background: #28a745;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
        }
</style>
</head>
<body>
<div class="layout">
<div class="sidebar">
<div class="logo">🎯 QUIZ APP</div>
<a href="${pageContext.request.contextPath}/admin/dashboard" class="menu-item">📊 Dashboard</a>
<a href="${pageContext.request.contextPath}/admin/quizManager" class="menu-item">📝 Quiz Manager</a>
<a href="${pageContext.request.contextPath}/admin/questionList" class="menu-item active">❓ Question Manager</a>
<a href="${pageContext.request.contextPath}/admin/addQuestion" class="menu-item">➕ Add New Question</a>
<a href="${pageContext.request.contextPath}/admin/createQuiz" class="menu-item">🆕 Create Quiz</a>
<div style="margin-top: auto; padding-top: 20px; border-top: 1px solid rgba(255,255,255,0.2);">
<a href="${pageContext.request.contextPath}/logout" style="background: #dc3545; color: white; padding: 10px 15px; border-radius: 5px; display: block; text-align: center; text-decoration: none;">🚪 Logout</a>
</div>
</div>
<div class="main-content">
<div class="table-container">
<div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
<h2>Question List</h2>
<a href="${pageContext.request.contextPath}/admin/addQuestion" class="btn-add">Add New Question</a>
</div>
<table>
<thead>
<tr>
<th>Sr No.</th>
<th>Question</th>
<th>Option 1</th>
<th>Option 2</th>
<th>Option 3</th>
<th>Option 4</th>
<th>Correct Option</th>
<th>Category</th>
<th>Action</th>
</tr>
</thead>
<tbody>
<% if (questions != null && !questions.isEmpty()) {
                            int srNo = 1;
                            for (Question q : questions) { %>
<tr>
<td><%= srNo++ %></td>
<td><%= q.getQuestionText() %></td>
<td><%= q.getOption1() %></td>
<td><%= q.getOption2() %></td>
<td><%= q.getOption3() %></td>
<td><%= q.getOption4() %></td>
<td><%= q.getCorrectOption() %></td>
<td><%= q.getCategory() %></td>
<td>
<form action="${pageContext.request.contextPath}/admin/questionList" method="post" style="display:inline;">
<input type="hidden" name="questionId" value="<%= q.getQuestionId() %>">
<input type="hidden" name="action" value="delete">
<button type="submit" class="btn-delete" onclick="return confirm('Are you sure?')">Delete</button>
</form>
</td>
</tr>
<% }
                        } else { %>
<tr><td colspan="9" style="text-align: center;">No questions found</td></tr>
<% } %>
</tbody>
</table>
</div>
</div>
</div>
</body>
</html>