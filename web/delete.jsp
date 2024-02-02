<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Expense Delete Servlet</title>
</head>
<body>
    <div class="container">
        <h2>Expense Delete Servlet</h2>
        <%
            Connection connection = null;
            PreparedStatement preparedStatement = null;
            try {
                // JDBC Driver and Database URL
                String jdbcDriver = "com.mysql.cj.jdbc.Driver";
                String databaseURL = "jdbc:mysql://localhost:3306/expense_tracker";
                // Database credentials
                String username = "root";
                String password = "root@123";
                // Load JDBC driver
                Class.forName(jdbcDriver);
                // Establish a connection
                connection = DriverManager.getConnection(databaseURL, username, password);
                // Delete operation
                int id = Integer.parseInt(request.getParameter("id"));
                String deleteQuery = "DELETE FROM expenses WHERE E_id=?";
                preparedStatement = connection.prepareStatement(deleteQuery);
                preparedStatement.setInt(1, id);

                int deletedRows = preparedStatement.executeUpdate();

                out.println("<p>Deleted " + deletedRows + " rows successfully.</p>");
                response.sendRedirect("expense.jsp");

            } catch (ClassNotFoundException | SQLException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
                e.printStackTrace();
            } finally {
                // Close resources
                try {
                    if (preparedStatement != null) {
                        preparedStatement.close();
                    }
                    if (connection != null) {
                        connection.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </div>
</body>
</html>
