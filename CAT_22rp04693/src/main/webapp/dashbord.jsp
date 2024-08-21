<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int userId = (Integer) userSession.getAttribute("userId");
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
</head>
<body>
    <h1>Employee Dashboard</h1>

    <!-- Add Employee Form -->
    <form action="employee" method="post">
        <input type="hidden" name="action" value="add">
        <label>Age:</label><input type="text" name="age" required><br>
        <label>Location:</label><input type="text" name="location" required><br>
        <input type="submit" value="Add Employee">
    </form>

    <h2>Employee List</h2>
    <a href="employee">Refresh List</a>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Age</th>
            <th>Location</th>
            <th>Actions</th>
        </tr>
        <%
            try {
               

                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/emp_22rp04693", "root", "");
                String sql = "SELECT * FROM employees WHERE ussers_id=?";
                stmt = conn.prepareStatement(sql);
                stmt.setInt(1, userId);
                rs = stmt.executeQuery();

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
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<tr><td colspan='4'>Error fetching data.</td></tr>");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </table>
    <a href="logout.jsp">Logout</a>
</body>
</html>
