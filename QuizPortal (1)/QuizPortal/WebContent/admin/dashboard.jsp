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
            position: fixed;
            height: 100vh;
            overflow-y: auto;
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
        .logout-section {
            margin-top: auto;
            padding-top: 20px;
            border-top: 1px solid rgba(255,255,255,0.2);
        }
        .main-content {
            flex: 1;
            margin-left: 260px;
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
        .table-container table {
			    width: 100%;
			    border-collapse: collapse;
			    text-align: center; /* ✅ Centers all text */
			}
			
			.table-container th, 
			.table-container td {
			    padding: 10px;
			    border-bottom: 1px solid #ddd;
			    text-align: center; /* ✅ Ensures each cell content is centered */
			    vertical-align: middle;
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
        }
        .user-info {
            background: rgba(255,255,255,0.1);
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            font-size: 14px;
        }
        .btn-delete { background: #dc3545; color: white; border: none; cursor: pointer; }
        
        /* --- Dropdown Menu --- */
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
        <a href="${pageContext.request.contextPath}/user/leaderboard" class="menu-item active">🏆 Leaderboard</a>
    

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
<%@ page import="com.quiz.model.Quiz, java.util.List" %>
<%
    List<Quiz> quizzes = (List<Quiz>) request.getAttribute("quizzes");
%>

<h2 style="margin-bottom: 15px;">Recent Quizzes</h2>

<div class="table-container">
    <table style="width:100%; border-collapse:collapse;">
        <thead>
            <tr style="background:#f8f9fa;">
                <th style="padding:10px; border-bottom:1px solid #ddd;">Sr No.</th>
                <th style="padding:10px; border-bottom:1px solid #ddd;">Quiz Title</th>
                <th style="padding:10px; border-bottom:1px solid #ddd;">Category</th>
                <th style="padding:10px; border-bottom:1px solid #ddd;">Created At</th>
                <th style="padding:10px; border-bottom:1px solid #ddd;">Action</th>
            </tr>
        </thead>
        <tbody>
            <% if (quizzes != null && !quizzes.isEmpty()) {
                int srNo = 1;
                for (Quiz quiz : quizzes) { %>
                    <tr>
                        <td style="padding:10px; border-bottom:1px solid #ddd;"><%= srNo++ %></td>
                        <td style="padding:10px; border-bottom:1px solid #ddd;"><%= quiz.getQuizTitle() %></td>
                        <td style="padding:10px; border-bottom:1px solid #ddd;"><%= quiz.getCategory() %></td>
                        <td style="padding:10px; border-bottom:1px solid #ddd;"><%= quiz.getCreatedAt() %></td>
                        <td style="padding:10px; border-bottom:1px solid #ddd;">
                            
                            <a href="${pageContext.request.contextPath}/admin/quizManager?action=edit&quizId=<%= quiz.getQuizId() %>"
                               style="background:#ffc107; color:white; padding:6px 10px; border-radius:4px; text-decoration:none;">Edit</a>
                               <form action="${pageContext.request.contextPath}/admin/quizManager" method="post" style="display:inline;">
								    <input type="hidden" name="quizId" value="<%= quiz.getQuizId() %>">
								    <input type="hidden" name="action" value="delete">
								    <button type="submit" 
								            style="background:#dc3545; color:white; padding:6px 10px; border:none; border-radius:4px; cursor:pointer;"
								            onclick="return confirm('Are you sure you want to delete this quiz?');">
								        Delete
								    </button>
								</form>
                        </td>
                    </tr>
            <% }
            } else { %>
                <tr>
                    <td colspan="5" style="text-align:center; padding:10px;">No quizzes found</td>
                </tr>
            <% } %>
        </tbody>
    </table>
</div>

</div>
</div>
</div>
</body>
</html>