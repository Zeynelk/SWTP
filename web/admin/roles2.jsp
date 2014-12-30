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


        
        <script type="text/javascript">
     
            var counter = 0;
            var limit = 1;
            var counter2 = 0;

            function addEditInput() {

                if (counter === limit || counter2 === limit) {

                } else {

                    var form = document.createElement("form");
                    var element = document.createElement("input");
                    var element2 = document.createElement("input");

                    form.setAttribute("method", "POST");

                    element.setAttribute("type", "text");
                    element.setAttribute("name", "newRoleName");

                    element2.setAttribute("type", "submit");
                    element2.setAttribute("name", "editRoleName");
                    element2.setAttribute("value", "Edit new Rolename");

                    form.appendChild(element);
                    form.appendChild(element2);

                    var foo = document.getElementById("fooBar");

                    foo.appendChild(form);

                    counter++;

                }
            }

            function addDeleteSubmit() {

                if (counter2 === limit || counter === limit) {

                } else {

                    var form = document.createElement("form");

                    form.setAttribute("method", "POST");

                    var element = document.createElement("input");


                    element.setAttribute("type", "submit");
                    element.setAttribute("name", "deleteRoleName");
                    element.setAttribute("value", "Delete Role");

                    form.appendChild(element);

                    var foo = document.getElementById("fooBar");

                    foo.appendChild(form);
                    counter2++;
                }
            }

        </script>

    </head>

    <body>

        <%!
            public class User {

                String URL = "jdbc:mysql://localhost:3306/USERS";
                String USERNAME = "root";
                String PASSWORD = "";

                Connection connection = null;
                
                PreparedStatement selectUser = null;
                
                PreparedStatement selectAllUserRole = null;

                
                ResultSet getAllUsers = null;
                ResultSet resultSet = null;
                ResultSet results = null;
                ResultSet allRoles = null;
                ResultSet roleNames = null;
                ResultSet roleNameByUser = null;

                PreparedStatement allUsers = null;
                PreparedStatement setRoles = null;
                PreparedStatement setPermission = null;
                PreparedStatement selectRoleName = null;
                PreparedStatement showRoles = null;
                PreparedStatement editRole = null;
                PreparedStatement deleteRole = null;
              

                PreparedStatement aloteRoleToUser = null;
              

                public User() {

                    try {

                        connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
                        selectUser = connection.prepareStatement("Select User_ID, Username, Rolename "
                                + "from User, UserRole, Role "
                                + "where User.User_ID = UserRole.User_ID AND UserRole.Role_ID = Role.Role_ID AND Role.Rolename != 'admin';");
                        
                        allUsers = connection.prepareStatement("SELECT * from User;");

                        setRoles = connection.prepareStatement("INSERT INTO Role VALUES (null, ?);");
                        selectRoleName = connection.prepareStatement("SELECT Rolename, Role_ID from Role;");
                        showRoles = connection.prepareStatement("SELECT * from Role;");
                        editRole = connection.prepareStatement("UPDATE Role SET Rolename = ? WHERE Role_ID = ?;");
                        setPermission = connection.prepareStatement("INSERT INTO RolePermission VALUES ((SELECT Role_ID FROM Role WHERE Rolename = ?), (SELECT Permission_ID FROM Permission WHERE Permissionname = ?));");

                        deleteRole = connection.prepareStatement("DELETE FROM Role WHERE Role_ID =?;");
                        

                        aloteRoleToUser = connection.prepareStatement("UPDATE UserRole SET Role_ID = ? WHERE User_ID = ?;");

                       
                        selectAllUserRole = connection.prepareStatement("SELECT * FROM UserRole, User, Role WHERE UserRole.User_ID= User.User_ID AND Role.Role_ID = UserRole.Role_ID;");

                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }

                public ResultSet getAllUserRole() {

                    try {

                        roleNameByUser = selectAllUserRole.executeQuery();

                    } catch (SQLException e) {
                        e.printStackTrace();
                    }

                    return roleNameByUser;
                }

                public ResultSet getUser() {

                    try {

                        resultSet = selectUser.executeQuery();

                    } catch (SQLException e) {
                        e.printStackTrace();
                    }

                    return resultSet;
                }

                public ResultSet getUsers() {

                    try {

                        getAllUsers = allUsers.executeQuery();

                    } catch (SQLException e) {
                        e.printStackTrace();
                    }

                    return getAllUsers;
                }

                public ResultSet getRole() {

                    try {

                        resultSet = selectRoleName.executeQuery();

                    } catch (SQLException e) {
                        e.printStackTrace();
                    }

                    return resultSet;
                }

                public ResultSet getRoles() {

                    try {

                        allRoles = showRoles.executeQuery();

                    } catch (SQLException e) {
                        e.printStackTrace();
                    }

                    return allRoles;
                }

                public int setRoles(String Rolename) {
                    int res = 0;
                    try {

                        setRoles.setString(1, Rolename);
                        res = setRoles.executeUpdate();

                    } catch (SQLException e) {
                        e.printStackTrace();
                    }

                    return res;
                }

                public int editRoles(String neuerRolename, String Role_ID) {
                    int res = 0;

                    try {

                        editRole.setString(1, neuerRolename);
                        editRole.setString(2, Role_ID);
                        res = editRole.executeUpdate();

                    } catch (SQLException e) {
                        e.printStackTrace();
                    }

                    return res;
                }

                public int deleteRoles(String Role_ID) {

                    int res = 0;
                    try {

                        deleteRole.setString(1, Role_ID);
                        res = deleteRole.executeUpdate();

                    } catch (SQLException e) {
                        e.printStackTrace();
                    }

                    return res;
                }

                public int setPermToRole(String r, String p) {

                    int res = 0;
                    try {

                        setPermission.setString(1, r);
                        setPermission.setString(2, p);

                        res = setPermission.executeUpdate();

                    } catch (SQLException e) {
                        e.printStackTrace();
                    }

                    return res;

                }

                public int setRoleToUser(String RoleId, String UserId) {

                    int res = 0;

                    try {
                                        
                        aloteRoleToUser.setString(1, RoleId);
                        aloteRoleToUser.setString(2, UserId);
                        
                        res = aloteRoleToUser.executeUpdate();

                    } catch (SQLException e) {
                        e.printStackTrace();
                    }

                    return res;
                }

            }


        %>

        <%

            User user = new User();
            User role = new User();
            User role3 = new User();
            User user3 = new User();
            
            ResultSet allUserRoles = user3.getAllUserRole();
            ResultSet roleNames = role.getRole();
            ResultSet roles3 = role3.getRoles();


            String rId;
            String newRN;
            String rol;
            String permission;
            String userName;

            if (request.getParameter("radios") != null) {

                rId = request.getParameter("radios");

                if (request.getParameter("editRoleName") != null) {

                    newRN = request.getParameter("newRoleName");

                    role.editRoles(newRN, rId);
                    response.sendRedirect("roles2.jsp");
                }

            }

            if (request.getParameter("radios") != null) {

                rId = request.getParameter("radios");

                if (request.getParameter("deleteRoleName") != null) {

                    role.deleteRoles(rId);
                    response.sendRedirect("roles2.jsp");

                }

            }

            if (request.getParameter("setRoles") != null) {

                rol = request.getParameter("setRoles");
                user.setRoles(rol);

                permission = request.getParameter("berechtigung");
                user.setPermToRole(rol, permission);
                response.sendRedirect("roles2.jsp");
            }

            if (request.getParameter("setUserRole") != null) {

                userName = request.getParameter("userId");
                
                rol = request.getParameter("roleId");

                user.setRoleToUser(rol ,userName);
                response.sendRedirect("roles2.jsp");

            }

        %>

        <%!  %>

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

                    <div class="row">
                        <div class="col-lg-12">

                            <h1 class="page-header">Rollen bearbeiten</h1>

                        </div>
                    </div>



                    <div class="row">
                        <div class="col-lg-12">
                            <div class="selectRoleToEditDiv">

                                <form name="SelectRoleRB" method="get" action="">

                                    <table class="table">
                                        <tr>

                                            <td><strong>Rolename</strong></td>
                                            <td>
                                                <input type="button" value="Edit" onclick="addEditInput();">  
                                                <input type="button" value="Delete" name="deleteRoleRB" onclick="addDeleteSubmit();">
                                                
                                            </td>

                                        </tr>

                                        <% while (roles3.next()) {
                                                String a = roles3.getString("Role_ID");
                                                String b = roles3.getString("Rolename");

                                        %>

                                        <tr>
                                            <td>    
                                                <label>

                                                    <input type="radio" name="radios" value="<%= a%>" <% if (request.getParameter("radios") != null) {
                                                            if (request.getParameter("radios").equals(a)) {
                                                                out.print("checked");
                                                            } else {
                                                                out.print("unchecked");
                                                            }
                                                        }%> onclick="this.form.submit()">
                                                    <%= b%>
                                                </label>


                                            </td>

                                        </tr>   
                                        <% }
                                            roles3.close(); %>
                                    </table>

                                    <noscript><input type="submit" value="Submit"></noscript>

                                </form>

                                <span id="fooBar">&nbsp;</span>    
                               
                            </div>
                        </div>

                    </div>
                    <h4>Rolle anlegen</h4>

                    <div class="row">
                        <div class="col-lg-12">

                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <form> 
                                        <input type="text" name="setRoles" value="" size="40" />

                                        <select name="berechtigung">
                                            <option>ADMINISTRATOR</option>
                                            <option>ROLES</option>
                                            <option>USER</option>

                                        </select>
                                        <input type="submit" name="addRoles" value="Add Role"/> 

                                    </form>  
                                </div>
                            </div>

                        </div>

                    </div> 

                    <h4>Rolle zuweisen</h4>

                    <div class="row">
                        <div class="col-lg-12">
                            
                            <table name="myTable" class="table table-hover table-striped">

                                <tr>
                                    <th>ID</th>

                                    <th>Username</th>
                                    <th>Current Role</th>
                                    <th>Change Role To</th>
                                    <th>Action</th>

                                </tr>
                                <% while (allUserRoles.next()) {%>
                                <form>
                                <tr>
                                
                                    <td><%= allUserRoles.getString("User_ID")%></td>
                                    <td><input type="hidden" value="<%= allUserRoles.getString("User_ID")%>" name="userId">
                                        <%= allUserRoles.getString("Username")%>
                                    </td>
                                    <td><%= allUserRoles.getString("Rolename")%></td>

                                    <td>
                                        <select name="roleId">

                                            <% while (roleNames.next()) {%>

                                            <option value="<%= roleNames.getString("Role_ID")%>"><%= roleNames.getString("Rolename")%> </option>

                                            <%  } %>
                                            
                                        </select>
                                            <% roleNames.beforeFirst(); %>
                                    </td>
                                    <td><input type="submit" name="setUserRole" value="Submit"></td>
                                </tr>       
                                  </form>

                                <% } %>
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
