<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
</head>
<body>
    <h1>Login</h1>
    <form action="login" method="post">
        <label>Email:</label>
        <input type="email" name="email" required><br>
        <label>Password:</label>
        <input type="password" name="password" required><br>
        <label>Remember Me:</label>
        <input type="checkbox" name="rememberMe"><br>
        <input type="submit" value="Login">
    </form>
    <a href="signup.jsp">Don't have an account? Sign up here.</a>
</body>
</html>
