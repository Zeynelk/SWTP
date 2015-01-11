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
            PreparedStatement deleteFile=null;
            PreparedStatement deleteFileCategory=null;
            ResultSet resultSet = null;
            ResultSet rsCategorynames = null;

            public File() {

                try {
                    connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);

                    getFiles = connection.prepareStatement("SELECT * FROM User,File,FileCategory,Category WHERE User.User_ID=? and User.User_ID=File.User_ID and File.File_ID= FileCategory.File_ID and Category.Category_ID = FileCategory.Category_ID;");
                    getCategories = connection.prepareStatement("SELECT * from Category;");
                    deleteFileCategory = connection.prepareStatement("DELETE FROM FileCategory WHERE File_ID=?;");
                    deleteFile = connection.prepareStatement("DELETE FROM File WHERE File_ID=? ;");
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
                public int deleteFile(String ID) {

                    int res = 0;

                    try {
                      
                      
                       deleteFile.setString(1,ID);
                      
                        res = deleteFile.executeUpdate();
                       
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }

                    return res;
                }
         public int deleteFileCategory(String ID){
             
             int res=0;
                 try {
                      
                      
                       deleteFileCategory.setString(1,ID);
                      
                        res = deleteFileCategory.executeUpdate();
                
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }

                    return res;
                
         }

        }
    %>


    <%

        File file = new File();
        ResultSet files = file.getFiles(session.getAttribute("sID").toString());
        ResultSet cats = file.getCategories();
        int result=0;

         if(request.getParameter("deleteFile")!=null){
                result=file.deleteFileCategory(request.getParameter("id"));
                result=file.deleteFile(request.getParameter("id"));
                
                response.sendRedirect("../user/document.jsp");
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
                    <a class="navbar-brand" href="user.jsp">MOSZDoc</a>
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
                            <a href="document.jsp"><i class="fa fa-fw fa-dashboard"></i>Dokumente</a>
                        </li>
                        <li>
                            <a href="upload.jsp"><i class="fa fa-fw fa-dashboard"></i>Upload</a>
                        </li>

                        <li>
                            <a href="category.jsp"><i class="fa fa-fw fa-dashboard"></i>Kategorien</a>
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
                            <p> <img src="../images/download.jpg" width="100%" height="90%"></p>

                        </div>
                        <div class="col-lg-4">
                            <p></p>
                            <form action="document.jsp">
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

                        <div class="col-lg-6">
                            <p></p>
                            <p>Links können Sie Dokumente spezieller Kategorien anzeigen lassen.</p>
                            <form action="document.jsp">
                                <input type="checkbox" name="activateMail" value="ON" <%if((request.getParameter("activateMail")!=null) && (request.getParameter("activateMail").equals("ON"))){out.print("checked");}%> onchange="this.form.submit()"  /> Aktiviert den E-Mail Modus
                            </form>
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
                                <td><strong>Download</strong></td>
                                <td><strong>View</strong></td>
                                <%if((request.getParameter("activateMail")!=null) && (request.getParameter("activateMail").equals("ON"))){out.print(" <td><strong>Email</strong></td>");}%>
                                <td><strong>Löschen</strong></td>


                            </tr>

                            <% while (files.next()) {

                                    if ((request.getParameter("selectFileCategory") == null) || files.getString("Categoryname").equals(request.getParameter("selectFileCategory")) || request.getParameter("selectFileCategory").equals("All")) {

                                        String a = files.getString("File_ID");
                                        String b = files.getString("Filename");


                            %>
                            <tr>
                                <td>    
                                    <%= a%>
                                </td>
                                <td>
                                    <%= b%>

                                </td>
                                <td>
                                    <%=files.getString("Categoryname")%>
                                </td>
                                <td sorttable_customkey="<%= a%>">
                                    <form method="get" action="downloadFileServlet" enctype="multipart/form-data">

                                        <input type="hidden" name="filename" value="<%=b%>" size="130"/>
                                        <input type="submit" name="setUserRole" value="Download">
                                    </form>
                                </td>
                                <td>
                                    <form method="get" action="FileServlet" enctype="multipart/form-data">

                                        <input type="hidden" name="filename" value="<%=b%>" size="130"/>
                                        <input type="submit" name="setUserRole" value="View">
                                    </form>
                                </td>
                                
                                <%if(request.getParameter("activateMail")!=null && request.getParameter("activateMail").equals("ON")){%>
                                <td><form name="sendMailForm" action="SendMailAttachServlet" method="post" onSubmit="return validateEmail();" enctype="multipart/form-data">
                                   
                                        <input class="form-control" type="text" name="recipient" value="" size="50" placeholder="E-Mail Adresse des Empfängers"/>
                                        <input class="form-control" type="text" name="subject" size="50" placeholder="Betreff"/>
                                    <textarea class="form-control" rows="10" cols="39" name="content" placeholder="Nachricht"></textarea>
                                    <input type="hidden" name="filename" value="<%=b%>" size="130"/>
                                    <input type="submit" value="Senden" />
                                    </form>
                                </td>
                                <%}%>
                                <td>
                                    <form>
                                        <input class="btn btn-danger" type="submit" value="Löschen" name="deleteFile"/>
                                        <input type="hidden" name="id" value="<%=a%>" size="40"/>
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

        
        
        
        <%            if ((request.getAttribute("message") != null)) { %>

<SCRIPT LANGUAGE="JavaScript">
                        alert("<%=request.getAttribute("message")%>");
                        window.document.location.replace("document.jsp");
</SCRIPT>   <%
} 
%>
    </body>

</html>
