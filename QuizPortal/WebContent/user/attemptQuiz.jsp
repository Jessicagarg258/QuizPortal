<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.quiz.model.User, com.quiz.model.Quiz, com.quiz.model.Question" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/user/login");
        return;
    }
    Quiz quiz = (Quiz) request.getAttribute("quiz");
    Question question = (Question) request.getAttribute("question");
    int questionNumber = (Integer) request.getAttribute("questionNumber");
    int totalQuestions = (Integer) request.getAttribute("totalQuestions");
    Integer savedAnswer = (Integer) request.getAttribute("savedAnswer");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Attempt Quiz - <%= quiz.getQuizTitle() %></title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .container {
            max-width: 900px;
            margin: 40px auto;
            padding: 0 20px;
        }
        .quiz-header {
            background: white;
            padding: 20px 30px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .quiz-title { color: #333; font-size: 24px; }
        .question-progress {
            margin-top: 10px;
            color: #666;
        }
        .question-card {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .question-text {
            font-size: 20px;
            color: #333;
            margin-bottom: 30px;
        }
        .option {
            background: #f8f9fa;
            padding: 15px 20px;
            margin-bottom: 15px;
            border-radius: 8px;
            border: 2px solid transparent;
            cursor: pointer;
            transition: all 0.3s;
        }
        .option:hover {
            background: #e9ecef;
            border-color: #667eea;
        }
        .option input[type="radio"] {
            margin-right: 15px;
            cursor: pointer;
        }
        .option.selected {
            background: #e7f3ff;
            border-color: #667eea;
        }
        .navigation {
            margin-top: 30px;
            display: flex;
            justify-content: space-between;
        }
        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn-previous {
            background: #6c757d;
            color: white;
        }
        .btn-next {
            background: #667eea;
            color: white;
        }
        .btn-submit {
            background: #28a745;
            color: white;
        }
    </style>
    <script>
        function selectOption(optionNum) {
            document.querySelectorAll('.option').forEach(opt => opt.classList.remove('selected'));
            document.getElementById('opt' + optionNum).classList.add('selected');
            document.getElementById('radio' + optionNum).checked = true;
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="quiz-header">
            <div class="quiz-title"><%= quiz.getQuizTitle() %></div>
            <div class="question-progress">Question <%= questionNumber %> of <%= totalQuestions %></div>
        </div>
        
        <div class="question-card">
            <div class="question-text"><%= question.getQuestionText() %></div>
            
            <form action="${pageContext.request.contextPath}/user/attemptQuiz" method="post">
                <div class="option <%= savedAnswer != null && savedAnswer == 1 ? "selected" : "" %>" id="opt1" onclick="selectOption(1)">
                    <input type="radio" name="selectedOption" value="1" id="radio1" <%= savedAnswer != null && savedAnswer == 1 ? "checked" : "" %>>
                    <label for="radio1" style="cursor: pointer;"><%= question.getOption1() %></label>
                </div>
                
                <div class="option <%= savedAnswer != null && savedAnswer == 2 ? "selected" : "" %>" id="opt2" onclick="selectOption(2)">
                    <input type="radio" name="selectedOption" value="2" id="radio2" <%= savedAnswer != null && savedAnswer == 2 ? "checked" : "" %>>
                    <label for="radio2" style="cursor: pointer;"><%= question.getOption2() %></label>
                </div>
                
                <div class="option <%= savedAnswer != null && savedAnswer == 3 ? "selected" : "" %>" id="opt3" onclick="selectOption(3)">
                    <input type="radio" name="selectedOption" value="3" id="radio3" <%= savedAnswer != null && savedAnswer == 3 ? "checked" : "" %>>
                    <label for="radio3" style="cursor: pointer;"><%= question.getOption3() %></label>
                </div>
                
                <div class="option <%= savedAnswer != null && savedAnswer == 4 ? "selected" : "" %>" id="opt4" onclick="selectOption(4)">
                    <input type="radio" name="selectedOption" value="4" id="radio4" <%= savedAnswer != null && savedAnswer == 4 ? "checked" : "" %>>
                    <label for="radio4" style="cursor: pointer;"><%= question.getOption4() %></label>
                </div>
                
                <div class="navigation">
                    <% if (questionNumber > 1) { %>
                        <button type="submit" name="action" value="previous" class="btn btn-previous">Previous</button>
                    <% } else { %>
                        <div></div>
                    <% } %>
                    
                    <% if (questionNumber < totalQuestions) { %>
                        <button type="submit" name="action" value="next" class="btn btn-next">Next</button>
                    <% } else { %>
                        <button type="submit" name="action" value="submit" class="btn btn-submit">Submit Quiz</button>
                    <% } %>
                </div>
            </form>
        </div>
    </div>
</body>
</html>