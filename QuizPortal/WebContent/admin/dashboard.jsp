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
    <title>Dashboard - Quiz App</title>
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
        .menu-item.active {
            background: rgba(255,255,255,0.2);
        }
        .main-content {
            flex: 1;
            padding: 30px;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }
        .welcome {
            font-size: 16px;
            color: #666;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .stat-card h3 {
            color: #666;
            font-size: 14px;
            margin-bottom: 10px;
        }
        .stat-card .number {
            font-size: 36px;
            font-weight: bold;
            color: #4e73df;
        }
        .table-container {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        h2 {
            color: #333;
        }
    </style>
</head>
<body>
    <div class="layout">
        <div class="sidebar">
            <div class="logo">
                🎯 QUIZ APP
            </div>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="menu-item active">📊 Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/quizManager" class="menu-item">📝 Quiz Manager</a>
            <a href="${pageContext.request.contextPath}/admin/questionList" class="menu-item">❓ Question Manager</a>
            <a href="${pageContext.request.contextPath}/admin/addQuestion" class="menu-item">➕ Add New Question</a>
            <a href="${pageContext.request.contextPath}/admin/createQuiz" class="menu-item">🆕 Create Quiz</a>
        </div>
        <div class="main-content">
            <div class="header">
                <h1>Dashboard</h1>
                <div class="welcome">Welcome, <%= admin.getFullName() != null ? admin.getFullName() : admin.getUsername() %>!</div>
            </div>
            
            <div class="stats-grid">
                <div class="stat-card">
                    <h3>TOTAL QUIZ</h3>
                    <div class="number"><%= request.getAttribute("totalQuiz") %></div>
                </div>
                <div class="stat-card">
                    <h3>TOTAL QUESTIONS</h3>
                    <div class="number"><%= request.getAttribute("totalQuestions") %></div>
                </div>
                <div class="stat-card">
                    <h3>TOTAL USERS</h3>
                    <div class="number"><%= request.getAttribute("totalUsers") %></div>
                </div>
            </div>
            
            <div class="table-container">
                <div class="table-header">
                    <h2>Tables</h2>
                </div>
                <p style="color: #666;">DataTables Example</p>
                <p style="margin-top: 20px; color: #999;">Navigate to Quiz Manager or Question Manager to view detailed tables.</p>
            </div>
        </div>
    </div>
</body>
</html>