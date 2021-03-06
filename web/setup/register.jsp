<%-- 
    Document   : register
    Created on : 21.11.2014, 19:42:04
    Author     : alimpamukci
--%>

<%@page import="java.sql.*"%>
<%@page import="javax.script.*"%>
<%@page import ="java.util.Date" %>
<% Class.forName("com.mysql.jdbc.Driver");%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Doc: Register</title>    
    </head>
    <body onload="displayResults()">
        <%!
            public class User {

                String URL = "jdbc:mysql://localhost:3306/USERS";

                String USERNAME = "root";
                String PASSWORD = "";

                Connection connection = null;
                PreparedStatement insertUsers = null;
                PreparedStatement insertRole =null;
                
                public User() {

                    try {

                        connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
                        insertUsers = connection.prepareStatement("INSERT INTO User VALUES (?,?,?,?,?,?);");
                        insertRole= connection.prepareStatement("INSERT INTO UserRole VALUES ((SELECT User.User_ID FROM User WHERE Username=?),(SELECT Role_ID FROM Role WHERE Rolename='default'));");
                        
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    
                    

                }
                 public int setRole(String benutzerN){
                     try {
                        insertRole.setString(1, benutzerN);
                        insertRole.executeUpdate();

                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                     return 0;
                }
                public int setUsers(String benutzerN, String passW, String vornameN, String nachnameN, String emailN) {

                    int result = 0;
                    String Id= new String();

                    try {
                        insertUsers.setString(1, null);
                        insertUsers.setString(2, benutzerN);
                        insertUsers.setString(3, passW);
                        insertUsers.setString(4, vornameN);
                        insertUsers.setString(5, nachnameN);
                        insertUsers.setString(6, emailN);
                    
                        
                        
                       insertRole.setString(1, benutzerN);

                        result = insertUsers.executeUpdate();
                        insertRole.executeUpdate();

                    } catch (SQLException e) {
                        e.printStackTrace();
                    }

                    return result;
                }
                
               
            }
            
        %>

        <%
//Setup Values The User needs
            int result = 0;
            String benutzername = new String();
            String passwort = new String();
            String vorname = new String();
            String nachname = new String();
            String email = new String();

            if (request.getParameter("benutzerN") != null) {
                benutzername = request.getParameter("benutzerN");
            }
            if (request.getParameter("passW") != null) {

                passwort = request.getParameter("passW");

            }
            if (request.getParameter("vornameN") != null) {

                vorname = request.getParameter("vornameN");

            }
            if (request.getParameter("nachnameN") != null) {

                nachname = request.getParameter("nachnameN");

            }
            if (request.getParameter("emailN") != null) {

                email = request.getParameter("emailN");

            }

            User users = new User();
            if (!benutzername.isEmpty() && !passwort.isEmpty()) {
                result = users.setUsers(vorname, nachname, email, passwort, benutzername);
                users.setRole(benutzername);
            } else {

            }


        %>

        <%            if (result == 0) { %>
        <SCRIPT LANGUAGE="JavaScript">
            alert("Registrierung fehlgeschlagen!\nSie werden auf die Login-Seite weitergeleitet.");
            window.document.location.replace("login.jsp");
        </SCRIPT>   <%
        } else if (result == 1) {
        %>
        <SCRIPT LANGUAGE="JavaScript">
            alert("Registrierung Erfolgreich!\nSie werden auf die Login-Seite weitergeleitet.");
            window.document.location.replace("login.jsp");
        </SCRIPT>
        <%
            }
        %>




    </body>
</html>
