<%-- 
    Document   : success2
    Created on : 06.12.2014, 18:33:37
    Author     : alimpamukci
--%>

<%@page import="java.sql.*" %>
<% Class.forName("com.mysql.jdbc.Driver");%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>SB Admin - Bootstrap Admin Template</title>

        <!-- Bootstrap Core CSS -->
        <link href="../style/sbad/css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link href="../style/sbad/css/sb-admin.css" rel="stylesheet">

        <!-- Morris Charts CSS -->
        <link href="../style/sbad/css/plugins/morris.css" rel="stylesheet">

        <!-- Custom Fonts -->
        <link href="../style/sbad/font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->

    </head>

    <body>

        <%!
            public class Roles {
            
            
            }    
        
            public class User {

                String URL = "jdbc:mysql://localhost:3306/USERS";
                String USERNAME = "root";
                String PASSWORD = "";

                Connection connection = null;
                PreparedStatement selectUser = null;
                PreparedStatement updateRoles = null;
                ResultSet resultSet = null;
                PreparedStatement setRoles = null;
                PreparedStatement setBerechtigung = null;
                PreparedStatement showRoles = null;
                PreparedStatement editRole = null;
                PreparedStatement deleteRole = null;
                PreparedStatement aloteRoleToUser = null;
                
                

                public User() {

                    try {

                        connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
                        selectUser = connection.prepareStatement("Select Benutzer_ID, Benutzername, RolleName "
                                + "from benutzer, benutzer_has_Rolle, rolle "
                                + "where benutzer.Benutzer_ID = benutzer_has_rolle.benutzer_Benutzer_ID AND benutzer_has_rolle.rolle_Rolle_ID = rolle.Rolle_ID AND rolle.RolleName != 'admin';");
                        //selectUser = connection.prepareStatement("SELECT ID,Benutzername FROM benutzer WHERE Rolle='USER';");
                        //updateRoles = connection.prepareStatement("UPDATE benutzer SET Rolle=? WHERE ID = ? ;");
                        setRoles = connection.prepareStatement("INSERT INTO rolle VALUES (null, ?);");
                        showRoles = connection.prepareStatement("SELECT RolleName from rolle;");
                        editRole = connection.prepareStatement("UPDATE rolle SET RolleName = ? WHERE RolleName = ?;");
                        setBerechtigung = connection.prepareStatement("INSERT INTO rolle_has_berechtigung VALUES ((SELECT Rolle_ID FROM rolle WHERE RolleName = ?), (SELECT Berechtigung_ID FROM berechtigung WHERE BerechtigungName = ?));");
                        deleteRole = connection.prepareStatement("DELETE FROM rolle WHERE RolleName =?;");
                        aloteRoleToUser = connection.prepareStatement("INSERT INTO benutzer_has_rolle VALUES((SELECT Benutzer_ID FROM benutzer WHERE Benutzername =?),(SELECT Rolle_ID FROM rolle WHERE RolleName=?));");
                        
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }

                public ResultSet getUser() {

                    try {

                        resultSet = selectUser.executeQuery();

                    } catch (SQLException e) {
                        e.printStackTrace();
                    }

                    return resultSet;
                }

                public ResultSet getRole() {

                    try {

                        resultSet = showRoles.executeQuery();

                    } catch (SQLException e) {
                        e.printStackTrace();
                    }

                    return resultSet;
                }
                
                public int setRoles(String RolleName) {
                    int res = 0;
                    try {

                        setRoles.setString(1, RolleName);
                        res = setRoles.executeUpdate();

                    } catch (SQLException e) {
                        e.printStackTrace();
                    }

                    return res;
                }

                public int editRoles(String RolleName, String neuerRolleName) {
                    int res = 0;
                    
                    try {

                        editRole.setString(1, neuerRolleName);
                        editRole.setString(2, RolleName);
                        res = editRole.executeUpdate();

                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
            
                    return res;
                }
                
                public int fdeleteRoles(String RolleName) {
                    int res = 0;
                    try {

                        deleteRole.setString(1, RolleName);
                        res = deleteRole.executeUpdate();

                    } catch (SQLException e) {
                        e.printStackTrace();
                    }

                    return res;
                }
                
                
                public int setRoleToUser(String Benutzername, String RolleName) {
                int res =0;
                
                try {

                        aloteRoleToUser.setString(1, Benutzername);
                        aloteRoleToUser.setString(2, RolleName);
                        res = aloteRoleToUser.executeUpdate();

                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                
                
                return res;
                }
                
                public int setRolle_has_berechtigung(String rol, String ber) {

                    int res = 0;
                    try {

                        setBerechtigung.setString(1, rol);
                        setBerechtigung.setString(2, ber);

                        res = setBerechtigung.executeUpdate();

                    } catch (SQLException e) {
                        e.printStackTrace();
                    }

                    return res;

                }
                
                public int updateRoles(String Rolle, String ID) {

                    int result = 0;

                    try {
                        updateRoles.setString(1, Rolle);
                        updateRoles.setString(2, ID);

                        result = updateRoles.executeUpdate();

                    } catch (SQLException e) {
                        e.printStackTrace();
                    }

                    return result;
                }

            }
        %>

        <%  
            
            User user = new User();
            ResultSet users = user.getUser();
            
            User role = new User();
            ResultSet roles = role.getRole();
            
            
  
            String[] items;
            String rolle;
            String test;
            String old;
            String newRN;
           
            String berechtigung;

            if (request.getParameter("submitRoles") != null) {

                //  user.updateRoles(request.getParameter("item"),Id);
                items = request.getParameterValues("item");
                test = items[0];
                response.sendRedirect("roles.jsp");
            }

            if (request.getParameter("setRoles") != null) {

                rolle = request.getParameter("setRoles");
                user.setRoles(rolle);

                berechtigung = request.getParameter("berechtigung");
                user.setRolle_has_berechtigung(rolle, berechtigung);
                response.sendRedirect("roles.jsp");
            }
            
            if(request.getParameter("editRoleName") != null) {
                
                old = request.getParameter("oldRoleName");
                newRN = request.getParameter("newRoleName");
               
                role.editRoles(old,newRN);
                response.sendRedirect("roles.jsp");
            }
            
            if(request.getParameter("deleteRoles") != null) {
            
                old = request.getParameter("deleteRoleName");
                role.fdeleteRoles(old);
                response.sendRedirect("roles.jsp");
            
            } 
            
            if(request.getParameter("submitRoles") != null) {
               
                role.setRoleToUser(request.getParameter("Benutzername"),request.getParameter("item"));
                response.sendRedirect("roles.jsp");
            }

        %>


        <div id="wrapper">

            <!-- Navigation -->
            <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="admin.jsp">SB Admin</a>
                </div>
                <!-- Top Menu Items -->
                <ul class="nav navbar-right top-nav">


                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <% out.print("&nbsp; &nbsp; &nbsp;" + session.getAttribute("sUserName")); %><b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li>
                                <a href="profile.jsp"><i class="fa fa-fw fa-user"></i> Profile</a>
                            </li>

                            <li>
                                <a href="#"><i class="fa fa-fw fa-gear"></i> Settings</a>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <a href="../setup/logout.jsp"><i class="fa fa-fw fa-power-off"></i> Log Out</a>
                            </li>
                        </ul>
                    </li>
                </ul>
                <!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
                <div class="collapse navbar-collapse navbar-ex1-collapse">
                    <ul class="nav navbar-nav side-nav">
                        <li>
                            <a href="admin.jsp"><i class="fa fa-fw fa-dashboard"></i> Dashboard</a>
                        </li>

                        <li  class="active">
                            <a href="roles.jsp"><i class="fa fa-fw fa-edit"></i>Rollen</a>
                        </li>
                    </ul>
                </div>
                <!-- /.navbar-collapse -->
            </nav>

            <div id="page-wrapper">

                <div class="container-fluid">

                    <!-- Page Heading -->
                    
                    
                    <div class="row">
                        <div class="col-lg-12">

                            <h1 class="page-header">
                                Rollen bearbeiten

                            </h1>

                        </div>

                    </div>

                    <div class="row">
                        
                        <div class="col-lg-12">
                            
                             <table class="table table-hover table-striped">

                                                <tbody>
                                                    <tr>
                                                        
                                                       
                                                <thead><strong>Rollenname</strong></thead>
                                                       
                                                    </tr>

                                                    <% while (roles.next()) {%>
                                                    <tr>
                                                       
                                                        
                                                        <td><%= roles.getString("RolleName")%></td>

                                                    </tr>
                                                    <% }%>

                                                </tbody>
                                            </table>
                            
                        </div>
                        
                        
                    </div>
                    
                    <h4>Rolle anlegen</h4>
                    <div class="row">
                        <div class="col-lg-12">
                           
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                      <form> 
                                            <input type="text" name="setRoles" value="" size="50" />
                                            <input type="submit" name="addRoles" value="Submit" size="40"/> 

                                            <select name="berechtigung">
                                                <option>ADMINISTRATOR</option>
                                                <option>ROLES</option>
                                                <option>USER</option>

                                            </select>

                                        </form>  
                                    </div>
                                </div>
                          
                        </div>

                    </div> 
                    <h4>Rolle editieren</h4>
                    <div class="row">
                        <div class="col-lg-12">
                            
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        
                                        <form>
                                            <input name="oldRoleName" type="text" size="30">
                                            <input name="newRoleName" type="text" size="30">
                                            <input type="submit" name="editRoleName" value="Edit">
                                        </form>
                                        
                                    </div>
                                </div>
                           
                        </div>

                    </div> 
                    <h4>Rolle löschen</h4>
                    <div class="row">
                        <div class="col-lg-12">
                           
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <form>
                                        <input name="RoleNameDelete" type="text" size="30">
                                        <input type="submit" name="deleteRoles" value="Delete">
                                        </form>
                                    </div>
                                </div>
                            
                        </div>

                    </div>           

                    <h4>Rolle zuweisen</h4>
                    <div class="row">
                        <div class="col-lg-12">
                           
                                <div class="panel panel-default">
                                    <div class="panel-body">


                                        

                                        <form>

                                            <table class="table table-hover table-striped">

                                                <thead>
                                                    <tr>
                                                        <th>ID</th>
                                                    
                                                    
                                                    <th>Benutzername</th>
                                                        
                                                    <th>Rolle</th>
                                                      
                                                  
                                                    </tr>
                                                </thead>
                                                    <% while (users.next()) {%>
                                                    <tbody>  
                                                    <tr>
                                                        <td><%= users.getString("Benutzer_ID")%></td>
                                                        <td><%= users.getString("Benutzername")%></td>
                                                        <td><%= users.getString("RolleName")%></td>



                                                        <td>
                           


                                                        </td>

                                                    </tr>
                                                    </tbody> 
                                                    <% }%>

                                                </tbody>
                                            </table>
                                            <input type="submit" name="submitRoles" value="Submit" size="40"/>
                                        </form>
                                    </div>
                                </div>
                          
                        </div>

                    </div>
                    <!-- /.row -->

                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- /#page-wrapper -->

        </div>
        <!-- /#wrapper -->

        <!-- jQuery -->
        <script src="../style/sbad/js/jquery.js"></script>

        <!-- Bootstrap Core JavaScript -->
        <script src="../style/sbad/js/bootstrap.min.js"></script>

        <!-- Morris Charts JavaScript -->
        <script src="../style/js/plugins/morris/raphael.min.js"></script>
        <script src="../style/sbad/js/plugins/morris/morris.min.js"></script>
        <script src="../style/sbadjs/plugins/morris/morris-data.js"></script>

    </body>

</html>
