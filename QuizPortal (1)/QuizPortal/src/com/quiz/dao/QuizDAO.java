package com.quiz.dao;

import com.quiz.model.Quiz;
import com.quiz.model.Question;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class QuizDAO {
    
    public int createQuiz(Quiz quiz) {
        int quizId = -1;
        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "INSERT INTO quiz (quiz_title, category, created_by) VALUES (?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, quiz.getQuizTitle());
            pstmt.setString(2, quiz.getCategory());
            pstmt.setInt(3, quiz.getCreatedBy());
            
            int affected = pstmt.executeUpdate();
            if (affected > 0) {
                ResultSet rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    quizId = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return quizId;
    }
    
    public boolean addQuestionToQuiz(int quizId, int questionId) {
        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "INSERT INTO quiz_questions (quiz_id, question_id) VALUES (?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, quizId);
            pstmt.setInt(2, questionId);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Quiz> getAllQuizzes() {
        List<Quiz> quizzes = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "SELECT * FROM quiz ORDER BY created_at DESC";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            
            while (rs.next()) {
                Quiz quiz = new Quiz();
                quiz.setQuizId(rs.getInt("quiz_id"));
                quiz.setQuizTitle(rs.getString("quiz_title"));
                quiz.setCategory(rs.getString("category"));
                quiz.setCreatedBy(rs.getInt("created_by"));
                quiz.setCreatedAt(rs.getTimestamp("created_at"));
                quizzes.add(quiz);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return quizzes;
    }
    
    public Quiz getQuizById(int quizId) {
        Quiz quiz = null;
        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "SELECT * FROM quiz WHERE quiz_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, quizId);
            
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                quiz = new Quiz();
                quiz.setQuizId(rs.getInt("quiz_id"));
                quiz.setQuizTitle(rs.getString("quiz_title"));
                quiz.setCategory(rs.getString("category"));
                quiz.setCreatedBy(rs.getInt("created_by"));
                quiz.setCreatedAt(rs.getTimestamp("created_at"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return quiz;
    }
    
    public List<Question> getQuizQuestions(int quizId) {
        List<Question> questions = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "SELECT q.* FROM questions q INNER JOIN quiz_questions qq ON q.question_id = qq.question_id WHERE qq.quiz_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, quizId);
            
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Question question = new Question();
                question.setQuestionId(rs.getInt("question_id"));
                question.setQuestionText(rs.getString("question_text"));
                question.setOption1(rs.getString("option_1"));
                question.setOption2(rs.getString("option_2"));
                question.setOption3(rs.getString("option_3"));
                question.setOption4(rs.getString("option_4"));
                question.setCorrectOption(rs.getInt("correct_option"));
                question.setCategory(rs.getString("category"));
                questions.add(question);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return questions;
    }
    
    public boolean deleteQuiz(int quizId) {
        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "DELETE FROM quiz WHERE quiz_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, quizId);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public int saveQuizAttempt(int quizId, int userId, int score, int totalQuestions) {
        int attemptId = -1;
        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "INSERT INTO quiz_attempts (quiz_id, user_id, score, total_questions) VALUES (?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            pstmt.setInt(1, quizId);
            pstmt.setInt(2, userId);
            pstmt.setInt(3, score);
            pstmt.setInt(4, totalQuestions);
            
            int affected = pstmt.executeUpdate();
            if (affected > 0) {
                ResultSet rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    attemptId = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return attemptId;
    }
    public void updateQuiz(int quizId, String title, String category) {
        String sql = "UPDATE quiz SET quiz_title = ?, category = ? WHERE quiz_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, title);
            ps.setString(2, category);
            ps.setInt(3, quizId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean saveUserAnswer(int attemptId, int questionId, int selectedOption, boolean isCorrect) {
        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "INSERT INTO user_answers (attempt_id, question_id, selected_option, is_correct) VALUES (?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, attemptId);
            pstmt.setInt(2, questionId);
            pstmt.setInt(3, selectedOption);
            pstmt.setBoolean(4, isCorrect);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean hasUserAttemptedQuiz(int userId, int quizId) {
        String query = "SELECT COUNT(*) FROM quiz_attempts WHERE user_id = ? AND quiz_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            pstmt.setInt(2, quizId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;  // if count > 0, user has already attempted
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

}