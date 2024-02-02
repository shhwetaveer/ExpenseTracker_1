<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Expense List</title>
    <link rel ="stylesheet" href="expenseStyle.css">
</head>
<body>
     
    <div class="container">
        <h2>Expense List</h2>
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

                // Execute a query to retrieve data
                String selectQuery = "SELECT * FROM expenses";
                resultSet = statement.executeQuery(selectQuery);

        %>
                <table border="1">
                    <tr>
                <th>Category</th>
                <th>Description</th>
                <th>Amount</th>
                <th>Tax</th>
                <th>Saved</th>
                <th>Action</th>
            </tr>
                    <%
                        // Loop through the result set and display data in the table
                        int i = 1;
                        while (resultSet.next()) {
                    %>
                            <tr>
                                <td><%= resultSet.getString("category") %></td>
                                <td><%= resultSet.getString("description") %></td>
                                <td><%= resultSet.getDouble("amount") %></td>
                                <td><%= resultSet.getDouble("tax") %></td>
                                <td><%= resultSet.getDouble("saved") %></td>
                                <td><form action="update.jsp"><input type="hidden" name="id" value="<%= resultSet.getInt("E_id") %>">
                                        <input type="submit" value="Update">
                                    </form><form action="delete.jsp"><input type="hidden" name="id" value="<%= resultSet.getInt("E_id") %>">
                                        <input type="submit" value="Delete">
                                    </form>
                                </td>
                            </tr>
                    <%
                        }
                    %>
                </table>
        <%
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
        <h2>Add New Expense</h2>
        <form action="expenseProcess.jsp" method="post" class="expense-form">
            <input type="hidden" name="action" value="add">
            <label for="category">Category:</label>
            <input type="text" name="category" required><br>
            <label for="description">Description:</label>
            <input type="text" name="description" required><br>
            <label for="amount">Amount:</label>
            <input type="number" name="amount" required><br>
            <label for="tax">Tax:</label>
            <input type="number" name="tax" required><br>
            <label for="saved">Saved:</label>
            <input type="number" name="saved" required><br>
            <input type="submit" value="Add Expense">
        </form>
    </div>
</body>
</html>
