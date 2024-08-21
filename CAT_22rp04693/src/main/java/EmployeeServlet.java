

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/employee")
public class EmployeeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/emp_22rp04693", "root", "");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        String action = request.getParameter("action");

        int empId = 0;
        String location = "";
        int age = 0;

        try {
            if (request.getParameter("id") != null) {
                empId = Integer.parseInt(request.getParameter("id"));
            }
            if (request.getParameter("location") != null) {
                location = request.getParameter("location");
            }
            if (request.getParameter("age") != null) {
                age = Integer.parseInt(request.getParameter("age"));
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            throw new ServletException("Invalid number format", e);
        }

        try (Connection conn = getConnection()) {
            PreparedStatement stmt;

            switch (action) {
                case "add":
                    String insertSql = "INSERT INTO employees (ussers_id, age, location) VALUES (?, ?, ?)";
                    stmt = conn.prepareStatement(insertSql);
                    stmt.setInt(1, userId);
                    stmt.setInt(2, age);
                    stmt.setString(3, location);
                    break;
                case "update":
                    String updateSql = "UPDATE employees SET age=?, location=? WHERE id=?";
                    stmt = conn.prepareStatement(updateSql);
                    stmt.setInt(1, age);
                    stmt.setString(2, location);
                    stmt.setInt(3, empId);
                    break;
                case "delete":
                    String deleteSql = "DELETE FROM employees WHERE id=?";
                    stmt = conn.prepareStatement(deleteSql);
                    stmt.setInt(1, empId);
                    break;
                default:
                    throw new ServletException("Invalid action");
            }

            stmt.executeUpdate();
            response.sendRedirect("dashbord.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database error", e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.sendRedirect("dashbord.jsp");
    }
}
