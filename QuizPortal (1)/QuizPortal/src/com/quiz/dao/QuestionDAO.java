package com.quiz.dao;

import com.quiz.model.Question;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class QuestionDAO {
    
    public boolean addQuestion(Question question) {
        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "INSERT INTO questions (question_text, option_1, option_2, option_3, option_4, correct_option, category) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, question.getQuestionText());
            pstmt.setString(2, question.getOption1());
            pstmt.setString(3, question.getOption2());
            pstmt.setString(4, question.getOption3());
            pstmt.setString(5, question.getOption4());
            pstmt.setInt(6, question.getCorrectOption());
            pstmt.setString(7, question.getCategory());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Question> getAllQuestions() {
        List<Question> questions = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "SELECT * FROM questions ORDER BY question_id DESC";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            
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
    
    public Question getQuestionById(int questionId) {
        Question question = null;
        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "SELECT * FROM questions WHERE question_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, questionId);
            
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                question = new Question();
                question.setQuestionId(rs.getInt("question_id"));
                question.setQuestionText(rs.getString("question_text"));
                question.setOption1(rs.getString("option_1"));
                question.setOption2(rs.getString("option_2"));
                question.setOption3(rs.getString("option_3"));
                question.setOption4(rs.getString("option_4"));
                question.setCorrectOption(rs.getInt("correct_option"));
                question.setCategory(rs.getString("category"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return question;
    }
    
    public boolean updateQuestion(Question question) {
        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "UPDATE questions SET question_text = ?, option_1 = ?, option_2 = ?, option_3 = ?, option_4 = ?, correct_option = ?, category = ? WHERE question_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, question.getQuestionText());
            pstmt.setString(2, question.getOption1());
            pstmt.setString(3, question.getOption2());
            pstmt.setString(4, question.getOption3());
            pstmt.setString(5, question.getOption4());
            pstmt.setInt(6, question.getCorrectOption());
            pstmt.setString(7, question.getCategory());
            pstmt.setInt(8, question.getQuestionId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteQuestion(int questionId) {
        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "DELETE FROM questions WHERE question_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, questionId);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Question> getQuestionsByCategory(String category) {
        List<Question> questions = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "SELECT * FROM questions WHERE category = ? ORDER BY question_id DESC";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, category);
            
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
}