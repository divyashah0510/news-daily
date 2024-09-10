package com.news.main;

import com.news.database.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
//        if ("user@example.com".equals(email) && "pass".equals(password)) {
//            // Create session and store user email if valid
//            HttpSession session = request.getSession();
//            session.setAttribute("user", email);
//
//            // Redirect to home or dashboard
//            response.sendRedirect("index.jsp");
//        } else {
//            // If invalid, redirect back to login page with error message
//            response.sendRedirect("login.jsp?error=Invalid%20email%20or%20password");
//        }
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM users WHERE email = ? AND password = ?");
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("user", rs.getString("email"));
                session.setAttribute("name", rs.getString("name"));
                session.setAttribute("facebook_link", rs.getString("facebook_link"));
                session.setAttribute("x_link", rs.getString("x_link"));
                session.setAttribute("instagram_link", rs.getString("instagram_link"));
                session.setAttribute("contact_number", rs.getString("contact_number"));

                // Retrieve image as byte[] and store in session
                byte[] imageBytes = rs.getBytes("photo");
                session.setAttribute("photo", imageBytes);


                response.sendRedirect("index.jsp");
            } else {
                response.sendRedirect("login.jsp?error=Invalid%20email%20or%20password");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=Database%20Error");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
