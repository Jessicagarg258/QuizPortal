<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Online Quiz Portal</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; }
        .navbar {
            background: #1a1a1a;
            padding: 15px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .logo { color: #ff4444; font-size: 24px; font-weight: bold; }
        .nav-links a {
            color: white;
            text-decoration: none;
            margin-left: 30px;
            font-size: 16px;
        }
        .nav-links a:hover { color: #ff4444; }
        .hero {
            background: url('data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 600"%3E%3Cdefs%3E%3ClinearGradient id="bg" x1="0%25" y1="0%25" x2="100%25" y2="100%25"%3E%3Cstop offset="0%25" style="stop-color:%23667eea"/%3E%3Cstop offset="100%25" style="stop-color:%23764ba2"/%3E%3C/linearGradient%3E%3C/defs%3E%3Crect fill="url(%23bg)" width="1200" height="600"/%3E%3C/svg%3E') center/cover;
            height: 500px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: white;
            text-align: center;
        }
        .hero h1 { font-size: 48px; margin-bottom: 20px; }
        .hero p { font-size: 20px; margin-bottom: 30px; }
        .btn-login-hero {
            background: #ff4444;
            color: white;
            padding: 15px 40px;
            text-decoration: none;
            border-radius: 30px;
            font-size: 18px;
            display: inline-block;
        }
        .btn-login-hero:hover { background: #cc0000; }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="logo">ONLINE QUIZ</div>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/user/home.jsp">Home</a>
            <a href="${pageContext.request.contextPath}/user/quizList">Quiz</a>
            <a href="${pageContext.request.contextPath}/user/login">Login/Signup</a>
            
        </div>
    </nav>
    
    <div class="hero">
        <h1>Welcome to Online Quiz Portal</h1>
        <p>Test your knowledge with our interactive quizzes</p>
        <a href="${pageContext.request.contextPath}/user/login" class="btn-login-hero">LOGIN</a>
    </div>
</body>
</html>