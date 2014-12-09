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
        public class User {
            String URL="jdbc:mysql://localhost:3306/USERS";
            String USERNAME="root";
            String PASSWORD="mapm";
            
            Connection connection = null;
            PreparedStatement selectUser = null;
            PreparedStatement updateRoles =null;
            ResultSet resultSet = null;
            
            
            public User(){
                
                try{
                    
                    connection = DriverManager.getConnection(URL,USERNAME,PASSWORD);
                    selectUser = connection.prepareStatement("SELECT ID,Benutzername,Rolle FROM benutzer WHERE Rolle='USER';");
                    updateRoles = connection.prepareStatement("UPDATE benutzer SET Rolle=? WHERE ID = ? ;");
                }catch(SQLException e){
                    e.printStackTrace();
                }
            }
            
            public ResultSet getUser(){
                
                try{
                    
                    resultSet=selectUser.executeQuery();
                    
                }catch(SQLException e){
                    e.printStackTrace();
                }
                
                return resultSet;
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
   User user= new User();
         ResultSet users =user.getUser();
         
         String Id="14";
         String Role= new String();
         String []items;
     
         if(request.getParameter("submitRoles")!=null){
           //  user.updateRoles(request.getParameter("item"),Id);
             items=request.getParameterValues("item");
             
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
                            <a href="../admin/logout.jsp"><i class="fa fa-fw fa-power-off"></i> Log Out</a>
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
                  
                        
                           <div class="container">
            <div class="flat-form">
                
                <div id="logout" class="form-action show">
                    <h1>Rollen</h1>
                    <p>
                        Sie haben sich erfolgreich angemeldet. Sie können sich nun abmelden.
                    </p>
                   
                    <table class="table table-hover table-striped">
           
            <tbody>
                <tr>
                    <td>ID</td>
                    <td>Benutzername</td>
                    <td>Rolle</td>
                    <td></td>
                </tr>
                
                <% while(users.next()) {%>
                 <tr>
                     <td><%= users.getString("ID")%></td>
                     <td><%= users.getString("Benutzername")%></td>
                     <td><%= users.getString("Rolle")%></td>
                     <td>
                         <form>
                          <select name="item+<%= users.getString("ID")%>">
                            <option value="USER">USER</option>
                            <option value="ADMINISTRATOR">ADMINISTRATOR</option>
                            <option value="ROLES">ROLES</option>
                           
                      
                             </select>
                            
                         
                     </td>
                     
                 </tr>
                 <% } %>
                    

                        
            </tbody>
        </table>
                    <input type="submit" name="submitRoles" value="Submit" size="40"/>
                     </form>
                </div>
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
