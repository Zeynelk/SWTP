<%-- 
    Document   : index
    Created on : Nov 18, 2014, 12:41:34 PM
    Author     : alim
--%>

<%@page import="java.sql.*"%>
<% Class.forName("com.mysql.jdbc.Driver");%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Index.jsp</title>
    </head>
    <body>
        <%!
            public class User {

                String URL = "jdbc:mysql://localhost:3306/USERS";

                String USERNAME = "root";
                String PASSWORD = "mapm";

                Connection connection = null;
                PreparedStatement selectUsers = null;
                ResultSet resultSet = null;

                public User() {

                    try {

                        connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);

                        selectUsers = connection.prepareStatement("SELECT Benutzername FROM administrator");
                        
                    } catch (SQLException e) {
                        
                        e.printStackTrace();
                    }
                }

                public ResultSet getUsers() {

                    try {

                        resultSet = selectUsers.executeQuery();
                        
                    } catch (SQLException e) {

                        e.printStackTrace();
                    }
                    return resultSet;
                }
            }
        %>

        <%
            User user = new User();
            ResultSet users = user.getUsers();
        %>

        <%
            if (users.first()) {

                String redirectURL = "login.jsp";
                response.sendRedirect(redirectURL);

            } else {

                String redirectURL = "setup.jsp";
                response.sendRedirect(redirectURL);
            }
        %>
    </body>
</html>
