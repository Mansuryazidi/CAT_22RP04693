<%@ page import="java.sql.ResultSet" %>
<html>
<head>
    <title>Employee List</title>
</head>
<body>
    <h1>Employee List</h1>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Age</th>
            <th>Location</th>
            <th>Actions</th>
        </tr>
        <%
            ResultSet rs = (ResultSet) request.getAttribute("employees");
            while (rs.next()) {
                int empId = rs.getInt("id");
                int age = rs.getInt("age");
                String location = rs.getString("location");
        %>
        <tr>
            <td><%= empId %></td>
            <td><%= age %></td>
            <td><%= location %></td>
            <td>
                <form action="employee" method="post" style="display:inline;">
                    <input type="hidden" name="id" value="<%= empId %>">
                    <input type="hidden" name="action" value="update">
                    <input type="text" name="age" value="<%= age %>" required>
                    <input type="text" name="location" value="<%= location %>" required>
                    <input type="submit" value="Update">
                </form>
                <form action="employee" method="post" style="display:inline;">
                    <input type="hidden" name="id" value="<%= empId %>">
                    <input type="hidden" name="action" value="delete">
                    <input type="submit" value="Delete">
                </form>
            </td>
        </tr>
        <%
            }
        %>
    </table>
    <a href="dashboard.jsp">Back to Dashboard</a>
</body>
</html>

