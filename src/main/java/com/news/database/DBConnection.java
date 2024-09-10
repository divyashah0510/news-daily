package com.news.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/news";
    private static final String USER = "root";
    private static final String PASSWORD = "root";
    private static Connection connection;
    public static Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                System.out.println("Loaded Class!");
                connection = DriverManager.getConnection(URL, USER, PASSWORD);
                System.out.println("Connection Success");
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
        }
        return connection;
    }
}
