<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Form</title>
    <link rel ="stylesheet" href="expenseStyle.css">
</head>
<body>
    <div class="container">
        <h2>Update Form</h2>

        <%
            Connection connection = null;
            Statement statement = null;
            ResultSet resultSet = null;

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

                // Create a statement
                statement = connection.createStatement();

                // Retrieve data for the update form
                int recordId = Integer.parseInt(request.getParameter("id"));
                String selectQuery = "SELECT * FROM expenses WHERE E_id=" + recordId;
                resultSet = statement.executeQuery(selectQuery);

                if (resultSet.next()) {
                    String category = resultSet.getString("category");
                    String description = resultSet.getString("description");
                    double amount = resultSet.getDouble("amount");
                    double saved = resultSet.getDouble("saved");
                    double tax = resultSet.getDouble("tax");
        %>
                    <form action="updateProcess.jsp" method="post">
                        <input type="hidden" name="id" value="<%= recordId %>">
                        
                        <label for="category">Category:</label>
                        <input type="text" name="category" value="<%= category %>" required><br>
                        
                        <label for="description">Description:</label>
                        <input type="text" name="description" value="<%= description %>" required><br>
                        
                        <label for="amount">Amount:</label>
                        <input type="number" name="amount" value="<%= amount %>" required><br>
                        
                        <label for="saved">Saved:</label>
                        <input type="number" name="saved" value="<%= saved %>" required><br>
                        
                        <label for="tax">Tax:</label>
                        <input type="number" name="tax" value="<%= tax %>" required><br>
                        
                        <input type="submit" value="Update">
                    </form>
        <%
                } else {
                    out.println("<p>Record not found.</p>");
                }
            } catch (ClassNotFoundException | SQLException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
                e.printStackTrace();
            } finally {
                // Close resources
                try {
                    if (resultSet != null) {
                        resultSet.close();
                    }
                    if (statement != null) {
                        statement.close();
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
