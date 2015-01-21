<%-- 
    Document   : permission
    Created on : 22.12.2014, 22:15:01
    Author     : Zeynel
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@page import="java.sql.*" %>
<% Class.forName("com.mysql.jdbc.Driver");%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html" pageEncoding="UTF-8" charset=UTF-8">
        <title>Kategorien verwalten</title>
        <!-- Bootstrap Core CSS -->
        <link href="../style/sbad/css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link href="../style/sbad/css/sb-admin.css" rel="stylesheet">

        <!-- Morris Charts CSS -->
        <link href="../style/sbad/css/plugins/morris.css" rel="stylesheet">

        <!-- Custom Fonts -->
        <link href="../style/sbad/font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
      <script src="../style/js/sorttable.js"></script>
    </head>


    <%!
        public class Category{

            String URL = "jdbc:mysql://localhost:3306/USERS";
            String USERNAME = "root";
            String PASSWORD = "";

            Connection connection = null;
            PreparedStatement getCategories = null;
            PreparedStatement insertCategory=null;
            PreparedStatement deleteCategory=null;
            ResultSet resultSet = null;
            
            
            
            public Category() {

                try {
                    connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
                    
                    getCategories = connection.prepareStatement("SELECT * from Category;");
                    insertCategory= connection.prepareStatement("INSERT INTO Category VALUES (null,?)");
                    deleteCategory = connection.prepareStatement("DELETE FROM Category WHERE Category_ID=? ;");
                } catch (SQLException e) {
                    e.printStackTrace();
                }

            }
            
              public ResultSet getCategories() {

                    try {

                        resultSet = getCategories.executeQuery();

                    } catch (SQLException e) {
                        e.printStackTrace();
                    }

                    return resultSet;
              }
                public int deleteCategory(String ID) {

                    int res = 0;

                    try {
                      
                      
                       deleteCategory.setString(1,ID);
                      
                        res = deleteCategory.executeUpdate();
                       
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }

                    return res;
                }
              
              public int setCategory(String kategoriename){
                  
                   try {
                        insertCategory.setString(1, kategoriename);
                        insertCategory.executeUpdate();

                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                     return 0;
                  
              }

        }
    %>
    
    
    <%

            Category cat = new Category();
            ResultSet cats = cat.getCategories();
            String kategoriename= new String();
            int result=0;
           
            if(request.getParameter("kategorieAnlegen")!=null){
                if(!request.getParameter("kategorieName").isEmpty()){
                    
                    kategoriename= request.getParameter("kategorieName");
                    cat.setCategory(kategoriename);
                    response.sendRedirect("category.jsp");
                }
                
            }
             if(request.getParameter("deleteCategory")!=null){
                result=cat.deleteCategory(request.getParameter("id"));
                result=cat.deleteCategory(request.getParameter("id"));
                
                response.sendRedirect("../user/category.jsp");
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
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i>  <% out.print("&nbsp; &nbsp; &nbsp;" + session.getAttribute("sFirstName")); %><% out.print(" " + session.getAttribute("sLastName"));%> <b class="caret"></b></a>
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
                    
                    <li>
                            <a href="document.jsp"><i class="fa fa-fw fa-dashboard"></i>Dokumente</a>
                        </li>
                        <li>
                            <a data-target="#demo" data-toggle="collapse" href="javascript:;" class="" aria-expanded="true"><i class="fa fa-fw fa-arrows-v"></i> Verwalten <i class="fa fa-fw fa-caret-down"></i></a>
                            <ul class="collapse out" id="demo" aria-expanded="true" style="">
                                <li>
                                    <a href="rename.jsp">Umbenennen</a>
                                </li>
                                <li>
                                    <a href="changecategory.jsp">Verschieben</a>
                                </li>
                            </ul>
                        </li>
                    <li  >
                        <a href="upload.jsp"><i class="fa fa-fw fa-upload"></i>Upload</a>
                    </li>
                    <li class="active">
                        <a href="category.jsp"><i class="fa fa-fw fa-table"></i>Kategorien</a>
                    </li>
                    </ul>
                </div>
                <!-- /.navbar-collapse -->
            </nav>

            <div id="page-wrapper">

                <div class="container-fluid">

                    <!-- Page Heading -->
                    
                       <h1 class="page-header">Kategorie anlegen </h1>
                            <div class="row">
                        <div class="col-lg-12">

                           <!-- Todo -->
                           <div class="col-lg-6">
                               <p>Legen Sie Kategorien an, um Ihre Dokumente in die gewünschte Kategorie einzuordnen.</p>
                               <p>Wenn Sie noch keine Kategorien angelegt haben werden Sie keine Dateien hochladen können.</p>
                           
                               
                                <div class="row">
                    <div class="col-lg-12">
                        <div class="alert alert-info alert-dismissable">
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                            <i class="fa fa-info-circle"></i>  <strong>Löschen: </strong> Sie können nur Kategorien löschen, die von keiner Datei verwendet wird.
                        </div>
                    </div>
                </div>
                               
                           </div>
                           <div class="col-lg-6">
                               
                               <form>
                                   <label> Kategorienamen eingeben :</label>
                               <input type="text" name="kategorieName" class="form-control" placeholder="Kategoriename">
                               <p></p>
                               <input type="submit"class="btn btn-default" value="anlegen" name="kategorieAnlegen" />
                               </form>
                               </div>


                        </div>

                    </div> 


                    <h1 class="page-header">Kategorien</h1>

                    <div class="row">
                        <div class="col-lg-12">

                            <table class="table col-lg-12;sortable">
                                <tr class="active">

                                    <td><strong>Kategorie ID</strong></td>
                                    <td><strong>Kategoriename</strong></td>
                                    <td><strong>Löschen</strong></td>


                                </tr>

                                <% while (cats.next()) {
                                
                                                String a = cats.getString("Category_ID");
                                                String b = cats.getString("Categoryname");


                                        %>
                                <tr>
                                    <td>    
                                        <%= a %>
                                    </td>
                                    <td>
                                        <%= b %>
                                    </td>
                                    <td>
                                        <form>
                                            <input class="btn btn-sm btn-danger" type="submit" value="Löschen" name="deleteCategory" />
                                            <input type="hidden" name="id" value="<%=a%>" size="40"/>
                                        </form>
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
