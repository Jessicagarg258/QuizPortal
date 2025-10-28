package com.quiz.dao;

import com.quiz.model.Admin;
import java.sql.*;

public class AdminDAO {
    
    public Admin authenticateAdmin(String username, String password) {
        Admin admin = null;
        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "SELECT * FROM admin WHERE username = ? AND password = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                admin = new Admin();
                admin.setAdminId(rs.getInt("admin_id"));
                admin.setUsername(rs.getString("username"));
                admin.setEmail(rs.getString("email"));
                admin.setFullName(rs.getString("full_name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return admin;
    }
    
    public boolean updateAdmin(int adminId, String email, String fullName) {
        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "UPDATE admin SET email = ?, full_name = ? WHERE admin_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, email);
            pstmt.setString(2, fullName);
            pstmt.setInt(3, adminId);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean changePassword(int adminId, String newPassword) {
        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "UPDATE admin SET password = ? WHERE admin_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, newPassword);
            pstmt.setInt(2, adminId);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public int getTotalQuizCount() {
        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "SELECT COUNT(*) as count FROM quiz";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public int getTotalQuestionCount() {
        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "SELECT COUNT(*) as count FROM questions";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public int getTotalUserCount() {
        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "SELECT COUNT(*) as count FROM users";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}