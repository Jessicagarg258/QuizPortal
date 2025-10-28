<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.quiz.model.Quiz" %>
<%
    Quiz quiz = (Quiz) request.getAttribute("quiz");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Quiz</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .container {
            width: 500px;
            margin: 80px auto;
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        label { display: block; margin-top: 15px; }
        input, select {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .btn {
            margin-top: 20px;
            background: #4e73df;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn:hover { background: #224abe; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Edit Quiz</h2>
        
       <form action="${pageContext.request.contextPath}/admin/quizManager" method="post">
  		  <input type="hidden" name="action" value="update">
  		  <input type="hidden" name="quizId" value="<%= quiz.getQuizId() %>">
            
            <label>Quiz Title:</label>
            <input type="text" name="quizTitle" value="<%= quiz.getQuizTitle() %>" required>
            
            <label>Category:</label>
            <input type="text" name="category" value="<%= quiz.getCategory() %>" required>
            
            <label>Created At:</label>
            <input type="text" name="createdAt" value="<%= quiz.getCreatedAt() %>" readonly>
            
            <button type="submit" class="btn">Update Quiz</button>
        </form>
    </div>
</body>
</html>
