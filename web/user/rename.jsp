<%-- 
    Document   : success2
    Created on : 06.12.2014, 18:33:37
    Author     : alimpamukci
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<% Class.forName("com.mysql.jdbc.Driver");%>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>MOSZDoc</title>

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

        <script src="../style/js/sorttable.js"></script>


        <script>

            function trim(s)
            {
                return s.replace(/^s*/, "").replace(/s*$/, "");
            }

            function validateEmail()
            {

                if (trim(document.sendMailForm.recipient.value) === "")
                {
                    alert("Es existiert noch keine Kategorie.Erstellen Sie eine Kategorie.");
                    document.sendMailForm.recipient.focus();
                    return false;
                }
                else if (trim(document.sendMailForm.subject.value) === "")
                {
                    alert("Keine Datei ausgewhält");
                    document.sendMailForm.subject.focus();
                    return false;
                }


            }



        </script>
    </head>




    <%!
        public class File {

            String URL = "jdbc:mysql://localhost:3306/USERS";
            String USERNAME = "root";
            String PASSWORD = "";

            Connection connection = null;
            PreparedStatement getFiles = null;
            PreparedStatement getCategoryname = null;
            PreparedStatement getCategories = null;
            PreparedStatement updateFilename = null;

            ResultSet resultSet = null;
            ResultSet rsCategorynames = null;

            public File() {

                try {
                    connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);

                    getFiles = connection.prepareStatement("SELECT * FROM User,File,FileCategory,Category WHERE User.User_ID=? and User.User_ID=File.User_ID and File.File_ID= FileCategory.File_ID and Category.Category_ID = FileCategory.Category_ID;");
                    getCategories = connection.prepareStatement("SELECT * from Category;");
                    updateFilename = connection.prepareStatement("UPDATE File SET Filename = ? WHERE File_ID = ?;");
                } catch (SQLException e) {
                    e.printStackTrace();
                }

            }

            public ResultSet getFiles(String userid) {

                try {
                    getFiles.setString(1, userid);
                    resultSet = getFiles.executeQuery();

                } catch (SQLException e) {
                    e.printStackTrace();
                }

                return resultSet;
            }

            public ResultSet getCategories() {

                try {

                    resultSet = getCategories.executeQuery();

                } catch (SQLException e) {
                    e.printStackTrace();
                }

                return resultSet;
            }

            public int updateFilename(String filename, String fileid) {

                int result = 0;

                try {
                    updateFilename.setString(1, filename);
                    updateFilename.setString(2, fileid);

                    result = updateFilename.executeUpdate();

                } catch (SQLException e) {
                    e.printStackTrace();
                }

                return result;
            }

        }
    %>


    <%

        File file = new File();
        ResultSet files = file.getFiles(session.getAttribute("sID").toString());
        ResultSet cats = file.getCategories();
        int result = 0;

        if (request.getParameter("changeFilename") != null) {

            file.updateFilename(request.getParameter("dateiName"), request.getParameter("dateiID"));
            response.sendRedirect("rename.jsp");
        }


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
 <a class="navbar-brand" href="user.jsp"><img src="../images/logo.png"height="150%" width="60%"></a>
                </div>
                <!-- Top Menu Items -->
                <ul class="nav navbar-right top-nav">


                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <% out.print("&nbsp; &nbsp; &nbsp;" + session.getAttribute("sFirstName")); %><% out.print(" " + session.getAttribute("sLastName"));%> <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li>
                                <a href="profile.jsp"><i class="fa fa-fw fa-user"></i> Profile</a>
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
                            <a href="user.jsp"><i class="fa fa-fw fa-dashboard"></i> Dashboard</a>
                        </li>

                        <li class="active">
                            <a href="document.jsp"><i class="fa fa-fw fa-download"></i>Dokumente</a>
                        </li>
                        <li>
                            <a data-target="#demo" data-toggle="collapse" href="javascript:;" class="" aria-expanded="true"><i class="fa fa-fw fa-arrows-v"></i> Verwalten <i class="fa fa-fw fa-caret-down"></i></a>
                            <ul class="collapse in" id="demo" aria-expanded="true" style="">
                                <li>
                                    <a href="rename.jsp">Umbenennen</a>
                                </li>
                                <li>
                                    <a href="changecategory.jsp">Verschieben</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="upload.jsp"><i class="fa fa-fw fa-upload"></i>Upload</a>
                        </li>

                        <li>
                            <a href="category.jsp"><i class="fa fa-fw fa-table"></i>Kategorien</a>
                        </li>

                    </ul>
                </div>
                <!-- /.navbar-collapse -->
            </nav>

            <div id="page-wrapper">

                <div class="container-fluid">

                    <!-- Page Heading -->


                    <!-- /.row -->
                    <div class="col-lg-12">
                        <div class="col-lg-1">
                            <p></p>

                        </div>
                        <div class="col-lg-4">
                            <p></p>
                            <form action="rename.jsp">
                                <label>Kategorien :</label>
                                <select name="selectFileCategory" class="form-control" onchange="this.form.submit()">

                                    <option>All</option>
                                    <% while (cats.next()) {%>

                                    <option <%if (request.getParameter("selectFileCategory") != null) {
                                            if (request.getParameter("selectFileCategory").equals(cats.getString("Categoryname"))) {
                                                out.print("selected");
                                            }
                                        }%>> <%= cats.getString("Categoryname")%> </option>

                                    <%  } %>
                                    <% cats.beforeFirst();%>

                                </select>
                            </form>

                            <br>
                            </br>

                        </div>


                    </div>
                    <!-- 2. row -->


                    <div class="col-lg-12">
                        <!--<p>Current Users ID :<%=session.getAttribute("sID")%></p>-->

                        <%if (1 == 1) {%>
                        <table class="table table-hover table-striped;sortable">
                            <tr class="active">

                                <td><strong>Datei ID</strong></td>
                                <td><strong>Dateiname</strong></td>
                                <td><strong>Kategoriename</strong></td>
                                <td><strong>Action</strong></td>


                            </tr>

                            <% while (files.next()) {

                                    if ((request.getParameter("selectFileCategory") == null) || files.getString("Categoryname").equals(request.getParameter("selectFileCategory")) || request.getParameter("selectFileCategory").equals("All")) {

                                        String a = files.getString("File_ID");
                                        String b = files.getString("Filename");


                            %>
                            <form>
                                <tr>
                                    <td>    
                                        <%= a%>
                                    </td>
                                    <td>
                                        <input  type="text" name="dateiName" value="<%=b%>" size="40" />
                                        <input  type="hidden" name="dateiID" value="<%=a%>" size="40" />


                                    </td>
                                    <td>
                                        <%=files.getString("Categoryname")%>
                                    </td>


                                    <td>



                                        <input class="btn btn-danger" type="submit" value="Ändern" name="changeFilename"/>
                            </form>
                            </td>
                            </tr>   
                            <%}%>
                            <% }
                            %>


                        </table>

                        <%}%>

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




        <%            if ((request.getAttribute("message") != null)) {%>

        <SCRIPT LANGUAGE="JavaScript">
                                    alert("<%=request.getAttribute("message")%>");
                                    window.document.location.replace("document.jsp");
        </SCRIPT>   <%
            }
        %>
    </body>

</html>
