package com.quiz.model;

public class Leaderboard {
    private int srNo;
    private String username;
    private String email;
    private int score;
    private int totalQuestions;
    
    public Leaderboard() {}
    
    public Leaderboard(int srNo, String username, String email, int score, int totalQuestions) {
        this.srNo = srNo;
        this.username = username;
        this.email = email;
        this.score = score;
        this.totalQuestions = totalQuestions;
    }
    
    // Getters and Setters
    public int getSrNo() {
        return srNo;
    }
    
    public void setSrNo(int srNo) {
        this.srNo = srNo;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public int getScore() {
        return score;
    }
    
    public void setScore(int score) {
        this.score = score;
    }
    
    public int getTotalQuestions() {
        return totalQuestions;
    }
    
    public void setTotalQuestions(int totalQuestions) {
        this.totalQuestions = totalQuestions;
    }
}