<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : success2
    Created on : 06.12.2014, 18:33:37
    Author     : alimpamukci
--%>

<%@page import="java.sql.*"%>
<%@page import ="java.util.Date" %>
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
    <link href="style/sbad/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="style/sbad/css/sb-admin.css" rel="stylesheet">

    <!-- Morris Charts CSS -->
    <link href="style/sbad/css/plugins/morris.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="style/sbad/font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>

         <%!
            public class User {

                String URL = "jdbc:mysql://localhost:3306/USERS";

                String USERNAME = "root";
                String PASSWORD = "mapm";

                Connection connection = null;
                PreparedStatement updateUser = null;

                public User() {

                    try {

                        connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
                        updateUser = connection.prepareStatement("UPDATE benutzer SET Benutzername=?, Passwort = ?, Email = ? WHERE ID = ? ;");

                    } catch (SQLException e) {
                        e.printStackTrace();
                    }

                }
                
                public int updateUsers(String benutzerN, String passW,String email,String ID) {

                    int result = 0;
                  
                    

                    try {
                        updateUser.setString(1, benutzerN);
                        updateUser.setString(2, passW);
                        updateUser.setString(3, email);
                        updateUser.setString(4, ID);
                        
                       
                        
                        
                        result = updateUser.executeUpdate();

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
            String Email = new String();
            String Id= new String();
            


            if (request.getParameter("benutzerN") != null) {
                Benutzername = request.getParameter("benutzerN");
                 session.setAttribute("sUserName", Benutzername);

            }
            if (request.getParameter("passW") != null) {

                Passwort = request.getParameter("passW");
                session.setAttribute("sPassWord",Passwort);

            }
            
            if (request.getParameter("email") != null) {

                Email = request.getParameter("email");
                session.setAttribute("sEmail",Email);
                
                

            }
                     if (request.getParameter("id") != null) {

                Id = request.getParameter("id");
                

            }
            

           
          
            User users = new User();

            if (!Benutzername.isEmpty() && !Passwort.isEmpty() && !Email.isEmpty()) {
      
                result = users.updateUsers(Benutzername, Passwort,Email,Id);
               
             
            } else {
              
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
                <a class="navbar-brand" href="success2.jsp">SB Admin</a>
            </div>
            <!-- Top Menu Items -->
            <ul class="nav navbar-right top-nav">
                
   
                <li class="dropdown">
                     <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <% out.print("&nbsp; &nbsp; &nbsp;" + session.getAttribute("sFirstName")); %><% out.print(" "+session.getAttribute("sLastName"));%> <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li>
                            <a href="profile.jsp"><i class="fa fa-fw fa-user"></i> Profile</a>
                        </li>
                    
                        <li>
                            <a href="#"><i class="fa fa-fw fa-gear"></i> Settings</a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="logout.jsp"><i class="fa fa-fw fa-power-off"></i> Log Out</a>
                        </li>
                    </ul>
                </li>
            </ul>
            <!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
            <div class="collapse navbar-collapse navbar-ex1-collapse">
                <ul class="nav navbar-nav side-nav">
                    <li>
                        <a href="index.html"><i class="fa fa-fw fa-dashboard"></i> Dashboard</a>
                    </li>
                    
                   
                    <li>
                        <a href="blank-page.html"><i class="fa fa-fw fa-file"></i> Blank Page</a>
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
                            Benutzerdaten <small></small>
                        </h1>
                      <div class="table-responsive">
                       
                          <form>
                              
                                   <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th></th>
                                        <th></th>
                                        <th></th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Benutzername</td>
                                        <td><input  type="text" name="benutzerN" value="<% out.print(""+session.getAttribute("sUserName"));%>" size="40" /></td>
                                        
                                        
                                    </tr>
                                    <tr>
                                        <td>Passwort</td>
                                        <td><input type="text" name="passW" value="<% out.print(""+session.getAttribute("sPassWord"));%>" size="40" /></td>
                                    </tr>
                                    <tr>
                                        <td>E-Mail</>
                                        <td><input type="text" name="email" value="<% out.print(""+session.getAttribute("sEmail"));%>" size="40"/></td>
                                        <input type="hidden" name="id" value="<% out.print(""+session.getAttribute("sID"));%>" size="40"/>
                                    </tr>
                                   
                                </tbody>
                            </table>
                                    
                                    <input type="submit" value="Ändern" name="Ändern" class="btn btn-lg btn-warning"/>     
                                    <input type="reset" value="Reset" name="Reset" class="btn btn-lg btn-primary"/>
                          </form>
                                        
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
    <script src="style/sbad/js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="style/sbad/js/bootstrap.min.js"></script>

    <!-- Morris Charts JavaScript -->
    <script src="style/js/plugins/morris/raphael.min.js"></script>
    <script src="style/sbad/js/plugins/morris/morris.min.js"></script>
    <script src="style/sbadjs/plugins/morris/morris-data.js"></script>

</body>

</html>
