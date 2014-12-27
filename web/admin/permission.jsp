<%-- 
    Document   : permission
    Created on : 22.12.2014, 22:15:01
    Author     : Zeynel
--%>
<%@page import="java.sql.*" %>
<% Class.forName("com.mysql.jdbc.Driver");%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Permissions</title>
        <!-- Bootstrap Core CSS -->
        <link href="../style/sbad/css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link href="../style/sbad/css/sb-admin.css" rel="stylesheet">

        <!-- Morris Charts CSS -->
        <link href="../style/sbad/css/plugins/morris.css" rel="stylesheet">

        <!-- Custom Fonts -->
        <link href="../style/sbad/font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    </head>


    <%!
        public class Permission {

            String URL = "jdbc:mysql://localhost:3306/USERS";
            String USERNAME = "root";
            String PASSWORD = "";

            Connection connection = null;
            PreparedStatement getPermissions = null;
            ResultSet resultSet = null;
            
            
            
            public Permission() {

                try {
                    connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
                    
                    getPermissions = connection.prepareStatement("SELECT * from Permission;");
                    
                } catch (SQLException e) {
                    e.printStackTrace();
                }

            }
            
              public ResultSet getPermission() {

                    try {

                        resultSet = getPermissions.executeQuery();

                    } catch (SQLException e) {
                        e.printStackTrace();
                    }

                    return resultSet;
              }

        }
    %>
    
    
    <%

            Permission perm = new Permission();
            ResultSet perms = perm.getPermission();
           
            
            
   %>

    <body>

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
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <% out.print("&nbsp; &nbsp; &nbsp;" + session.getAttribute("sUserName"));%><b class="caret"></b></a>
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
                           
                            <a href="roles2.jsp"><i class="fa fa-fw fa-edit"></i>Rollen</a>
                            <a href="permission.jsp"><i class="fa fa-fw fa-edit"></i>Berechtigungen</a>
                        </li>
                    </ul>
                </div>
                <!-- /.navbar-collapse -->
            </nav>

            <div id="page-wrapper">

                <div class="container-fluid">

                    <!-- Page Heading -->

                    <h1 class="page-header">Berechtigungen</h1>

                    <div class="row">
                        <div class="col-lg-12">

                            <table class="table col-lg-12">
                                <tr>

                                    <td><strong>Permission ID</strong></td>
                                    <td><strong>Permissionname</strong></td>


                                </tr>

                                <% while (perms.next()) {
                                
                                                String a = perms.getString("Permission_ID");
                                                String b = perms.getString("Permissionname");


                                        %>
                                <tr>
                                    <td>    
                                        <%= a %>
                                    </td>
                                    <td>
                                        <%= b %>
                                    </td>

                                </tr>   
                                <% } 
                                 %>
                            </table>


                        </div>

                    </div> 

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
