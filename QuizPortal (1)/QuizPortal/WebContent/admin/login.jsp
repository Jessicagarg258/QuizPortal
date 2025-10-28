<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login - Quiz Portal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-container {
            display: flex;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            max-width: 900px;
            width: 90%;
        }
        .login-image {
            flex: 1;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px;
        }
        .login-image img {
            width: 200px;
            height: 200px;
            border-radius: 50%;
            object-fit: cover;
        }
        .login-form {
            flex: 1;
            padding: 60px 40px;
        }
        h2 {
            margin: 0 0 30px 0;
            color: #333;
            font-size: 28px;
        }
        .form-group {
            margin-bottom: 25px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            color: #666;
            font-size: 14px;
        }
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            box-sizing: border-box;
        }
        .btn-login {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: transform 0.2s;
        }
        .btn-login:hover {
            transform: translateY(-2px);
        }
        .error {
            background: #ffebee;
            color: #c62828;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
    </style>
</head>

<body>
    <div class="login-container">
        <div class="login-image">
            <img src="https://image.shutterstock.com/z/stock-vector-quiz-and-question-marks-trivia-night-quiz-symbol-neon-sign-night-online-game-with-questions-2052894734.jpg" alt="Admin">
        </div>
        <div class="login-form">
            <h2>Welcome Back!</h2>
            <% if (request.getAttribute("error") != null) { %>
                <div class="error"><%= request.getAttribute("error") %></div>
            <% } %>
            <form action="${pageContext.request.contextPath}/admin/login" method="post">
                <div class="form-group">
                    <label for="username">Enter Username</label>
                    <input type="text" id="username" name="username" required>
                </div>
                <div class="form-group">
				    <label for="password">Password</label>
				    <div style="position: relative;">
				        <input type="password" id="password" name="password" required>
				        <button type="button" id="togglePassword"
				            style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%);
				                   background: none; border: none; cursor: pointer; color: #667eea; font-size: 14px;">
				            Show
				        </button>
				    </div>
				</div>
				
				                <button type="submit" class="btn-login">Login</button>
				            </form>
				        </div>
				    </div>
				    <script>
    const passwordInput = document.getElementById("password");
    const togglePassword = document.getElementById("togglePassword");

    togglePassword.addEventListener("click", () => {
        const isPassword = passwordInput.type === "password";
        passwordInput.type = isPassword ? "text" : "password";
        togglePassword.textContent = isPassword ? "Hide" : "Show";
    });
</script>
    
</body>
</html>