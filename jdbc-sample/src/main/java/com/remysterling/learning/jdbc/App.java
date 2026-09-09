package com.remysterling.learning.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class App {
    private static final String JDBC_URL = "jdbc:sqlite:learning.db";

    public static void main(String[] args) {
        try (Connection connection = DriverManager.getConnection(JDBC_URL)) {
            connection.setAutoCommit(false);
            createTable(connection);
            clearSampleData(connection);
            insertStudent(connection, "Aisha Khan", "Database Systems", 92);
            insertStudent(connection, "Marco Silva", "Database Systems", 78);
            insertStudent(connection, "Nora Chen", "Database Systems", 88);
            connection.commit();

            System.out.println("Students with grades of at least 80:");
            printHighScorers(connection, 80);
        } catch (SQLException exception) {
            System.err.println("Database operation failed: " + exception.getMessage());
        }
    }

    private static void createTable(Connection connection) throws SQLException {
        String sql = """
                CREATE TABLE IF NOT EXISTS students (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    name TEXT NOT NULL,
                    course TEXT NOT NULL,
                    grade INTEGER NOT NULL CHECK (grade BETWEEN 0 AND 100)
                )
                """;
        try (Statement statement = connection.createStatement()) {
            statement.executeUpdate(sql);
        }
    }

    private static void clearSampleData(Connection connection) throws SQLException {
        try (Statement statement = connection.createStatement()) {
            statement.executeUpdate("DELETE FROM students");
        }
    }

    private static void insertStudent(Connection connection, String name,
                                      String course, int grade) throws SQLException {
        String sql = "INSERT INTO students (name, course, grade) VALUES (?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, name);
            statement.setString(2, course);
            statement.setInt(3, grade);
            statement.executeUpdate();
        }
    }

    private static void printHighScorers(Connection connection, int minimumGrade)
            throws SQLException {
        String sql = """
                SELECT name, course, grade
                FROM students
                WHERE grade >= ?
                ORDER BY grade DESC, name
                """;
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, minimumGrade);
            try (ResultSet results = statement.executeQuery()) {
                while (results.next()) {
                    System.out.printf("- %s | %s | %d%n",
                            results.getString("name"),
                            results.getString("course"),
                            results.getInt("grade"));
                }
            }
        }
    }
}
