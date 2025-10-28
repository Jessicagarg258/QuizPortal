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
        .btn-edit {
		    background: #ffc107;
		    color: white;
		}
		.btn-edit:hover {
		    background: #e0a800;
		}
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
									    <a href="${pageContext.request.contextPath}/admin/quizManager?action=edit&quizId=<%= quiz.getQuizId() %>" class="btn btn-edit">Edit</a>
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