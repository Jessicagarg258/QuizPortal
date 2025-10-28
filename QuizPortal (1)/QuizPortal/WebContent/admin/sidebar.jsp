<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.quiz.model.Admin" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect(request.getContextPath() + "/admin/login");
        return;
    }
%>

<div class="sidebar">
    <div class="logo">🎯 QUIZ APP</div>

    <div class="user-info">
        <strong><%= admin.getFullName() != null ? admin.getFullName() : admin.getUsername() %></strong><br>
        <small><%= admin.getEmail() %></small>
    </div>

    <a href="${pageContext.request.contextPath}/admin/dashboard" class="menu-item">📊 Dashboard</a>

    <div class="dropdown">
        <div class="menu-item dropdown-toggle">📝 Quiz Manager</div>
        <div class="dropdown-content">
            <a href="${pageContext.request.contextPath}/admin/createQuiz" class="submenu-item">🆕 Create New Quiz</a>
            <a href="${pageContext.request.contextPath}/admin/quizManager" class="submenu-item">📋 Quiz List</a>
        </div>
    </div>

    <div class="dropdown">
        <div class="menu-item dropdown-toggle">❓ Question Manager</div>
        <div class="dropdown-content">
            <a href="${pageContext.request.contextPath}/admin/addQuestion" class="submenu-item">➕ Add New Question</a>
            <a href="${pageContext.request.contextPath}/admin/questionList" class="submenu-item">📋 Question List</a>
        </div>
    </div>

    <div class="logout-section">
        <a href="${pageContext.request.contextPath}/logout" class="btn-logout">🚪 Logout</a>
    </div>
</div>
