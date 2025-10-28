package com.quiz.dao;

import com.quiz.model.Leaderboard;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LeaderboardDAO {
    
    public List<Leaderboard> getLeaderboardByQuiz(int quizId) {
        List<Leaderboard> leaderboard = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "SELECT u.username, u.email, qa.score, qa.total_questions " +
                          "FROM quiz_attempts qa " +
                          "INNER JOIN users u ON qa.user_id = u.user_id " +
                          "WHERE qa.quiz_id = ? " +
                          "ORDER BY qa.score DESC, qa.attempted_at ASC";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, quizId);
            
            ResultSet rs = pstmt.executeQuery();
            int srNo = 1;
            while (rs.next()) {
                Leaderboard entry = new Leaderboard();
                entry.setSrNo(srNo++);
                entry.setUsername(rs.getString("username"));
                entry.setEmail(rs.getString("email"));
                entry.setScore(rs.getInt("score"));
                entry.setTotalQuestions(rs.getInt("total_questions"));
                leaderboard.add(entry);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return leaderboard;
    }
    
    public List<Leaderboard> getAllLeaderboard() {
        List<Leaderboard> leaderboard = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "SELECT u.username, u.email, SUM(qa.score) as total_score, SUM(qa.total_questions) as total_questions " +
                          "FROM quiz_attempts qa " +
                          "INNER JOIN users u ON qa.user_id = u.user_id " +
                          "GROUP BY u.user_id " +
                          "ORDER BY total_score DESC";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            
            int srNo = 1;
            while (rs.next()) {
                Leaderboard entry = new Leaderboard();
                entry.setSrNo(srNo++);
                entry.setUsername(rs.getString("username"));
                entry.setEmail(rs.getString("email"));
                entry.setScore(rs.getInt("total_score"));
                entry.setTotalQuestions(rs.getInt("total_questions"));
                leaderboard.add(entry);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return leaderboard;
    }
}