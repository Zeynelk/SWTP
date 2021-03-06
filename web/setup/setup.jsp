<%-- 
    Document   : setup
    Created on : 21.11.2014, 19:42:04
    Author     : alimpamukci
--%>

<%@page import="java.sql.*"%>
<%@page import ="java.util.Date" %>
<% Class.forName("com.mysql.jdbc.Driver");%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SETUP MODUS</title>
        <link rel="stylesheet" href="../style/css/style.css" media="screen" type="text/css" />
    </head>
    <body>

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
                        insertRole= connection.prepareStatement("INSERT INTO UserRole VALUES ((SELECT User.User_ID FROM User WHERE Username=?),(SELECT Role_ID FROM Role WHERE Rolename='admin'));");

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
                 
                public int setUsers(String benutzerN, String passW) {

                    int result = 0;

                    try {
                        insertUsers.setString(1, null);
                        insertUsers.setString(2, null);
                        insertUsers.setString(3, null);
                        insertUsers.setString(4,null);
                        insertUsers.setString(5, passW);
                        insertUsers.setString(6, benutzerN);
                   
                        result = insertUsers.executeUpdate();

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
            String Benutzername = new String();
            String Passwort = new String();

            if (request.getParameter("benutzerN") != null) {
                Benutzername = request.getParameter("benutzerN");

            }
            if (request.getParameter("passW") != null) {

                Passwort = request.getParameter("passW");

            }

            User users = new User();

            if (!Benutzername.isEmpty() && !Passwort.isEmpty()) {
                result = users.setUsers(Benutzername, Passwort);
                users.setRole(Benutzername);
                String url = "login.jsp";
                response.sendRedirect(url);
            } else {

            }


        %>


        <div class="container">
            <div class="flat-form">
                <ul class="tabs">
                    <li>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</li>
                    <li>
                        <a> PDF Dokumentablage &nbsp; THM 2014 </a>
                    </li>
                    <li>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</li>
                </ul>
                <!--/#login.form-action-->
                <div id="login" class="form-action show">
                    <h1>Setup-Modus</h1>
                    <p>
                        Bitte legen Sie einen Administrator an.
                    </p>
                    <form>
                        <ul>
                            <li>
                                <input type="text" name="benutzerN" placeholder="Benutzername" />
                            </li>
                            <li>
                                <input type="password" name="passW" placeholder="Passwort" />
                            </li>
                            <li>
                                <input type="submit" value="Anlegen" class="button" />
                            </li>
                        </ul>
                    </form>
                </div>
            </div>
        </div>

        <div id="copyright">
            <center>
                <p class="clear"> Copyright &copy 2014 by MAPM, SMNS, ZKMR, OESM</p>
            </center>
        </div>

    </body>
</html>
