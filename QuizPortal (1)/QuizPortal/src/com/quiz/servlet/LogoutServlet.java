/*
 * package com.quiz.servlet;
 * 
 * import java.io.IOException; import jakarta.servlet.ServletException; import
 * jakarta.servlet.annotation.WebServlet; import
 * jakarta.servlet.http.HttpServlet; import
 * jakarta.servlet.http.HttpServletRequest; import
 * jakarta.servlet.http.HttpServletResponse; import
 * jakarta.servlet.http.HttpSession;
 * 
 * @WebServlet("/logout") public class LogoutServlet extends HttpServlet {
 * 
 * protected void doGet(HttpServletRequest request, HttpServletResponse
 * response) throws ServletException, IOException { HttpSession session =
 * request.getSession(false); if (session != null) { session.invalidate(); }
 * response.sendRedirect(request.getContextPath() + "/user/login"); } }
 */
package com.quiz.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session != null) {
            // Determine if admin or user
            Object admin = session.getAttribute("admin");
            Object user = session.getAttribute("user");

            // Invalidate session
            session.invalidate();

            // Redirect based on who was logged in
            if (admin != null) {
                response.sendRedirect(request.getContextPath() + "/admin/login");
            } else if (user != null) {
                response.sendRedirect(request.getContextPath() + "/user/login");
            } else {
                // fallback if neither exists
                response.sendRedirect(request.getContextPath() + "/user/login");
            }
        } else {
            // No session exists
            response.sendRedirect(request.getContextPath() + "/user/login");
        }
    }
}
