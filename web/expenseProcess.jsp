<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PERSONAL FINANCIAL PLANNER</title>
</head>
<body>
    <div class="container">
        <%
            Connection connection = null;
            PreparedStatement preparedStatement = null;
            String category = request.getParameter("category");
            String description = request.getParameter("description");
            double amount = Double.parseDouble(request.getParameter("amount"));
            double tax = Double.parseDouble(request.getParameter("tax"));
            double saved = Double.parseDouble(request.getParameter("saved"));

            try {
                String jdbcDriver = "com.mysql.cj.jdbc.Driver";
                String databaseURL = "jdbc:mysql://localhost:3306/expense_tracker";

                String username = "root";
                String password = "root@123";

                Class.forName(jdbcDriver);

                connection = DriverManager.getConnection(databaseURL, username, password);

                String insertQuery = "INSERT INTO expenses(category, description, amount, tax, saved)  VALUES (?, ?, ?, ?, ?)";
                preparedStatement = connection.prepareStatement(insertQuery);
                preparedStatement.setString(2, description);
                preparedStatement.setString(1, category);
                preparedStatement.setDouble(3, amount);
                preparedStatement.setDouble(4, tax);
                preparedStatement.setDouble(5, saved);
                preparedStatement.executeUpdate();

                out.println("<p>Data successfully inserted into the database.</p>");
                response.sendRedirect("expense.jsp");

            } catch (ClassNotFoundException | SQLException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
                e.printStackTrace();
            } finally {

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
