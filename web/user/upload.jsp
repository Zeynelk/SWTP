<%-- 
    Document   : success2
    Created on : 06.12.2014, 18:33:37
    Author     : alimpamukci
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<% Class.forName("com.mysql.jdbc.Driver");%>
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


        <script>

            function trim(s)
            {
                return s.replace(/^s*/, "").replace(/s*$/, "");
            }

            function validateUpload()
            {

                if (trim(document.uploadFile.setFileCategory.value) === "")
                {
                    alert("Es existiert noch keine Kategorie.Erstellen Sie eine Kategorie.");
                    document.uploadFile.setFileCategory.focus();
                    return false;
                }
                else if (trim(document.uploadFile.uploadedFile.value) === "")
                {
                    alert("Keine Datei ausgew�hlt");
                    document.uploadFile.uploadedFile.focus();
                    return false;
                }


            }



        </script>

    </head>



    <%!
        public class Category {

            String URL = "jdbc:mysql://localhost:3306/USERS";
            String USERNAME = "root";
            String PASSWORD = "";

            Connection connection = null;
            PreparedStatement getCategories = null;
            PreparedStatement insertCategory = null;
            PreparedStatement insertFileCategory = null;
            ResultSet resultSet = null;
            ResultSet getFileID = null;

            public Category() {

                try {
                    connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);

                    getCategories = connection.prepareStatement("SELECT * from Category;");
                    insertCategory = connection.prepareStatement("INSERT INTO Category VALUES (null,?)");
                    insertFileCategory = connection.prepareStatement("INSERT INTO FileCategory VALUES((SELECT File_ID FROM File ORDER BY File_ID DESC LIMIT 1),(SELECT Category_ID FROM Category WHERE Categoryname=?));");
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

            public int insertFileCategory(String categoryId) {

                int result = 0;

                try {
                    insertFileCategory.setString(1, categoryId);
                    result = insertFileCategory.executeUpdate();

                } catch (SQLException e) {
                    e.printStackTrace();
                }

                return result;
            }
        }
    %>

    <%

        Category cat = new Category();
        ResultSet cats = cat.getCategories();
       // cat.insertFileCategory(request.getParameter("setFileCategory"));


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
                            <a href="user.jsp"><i class="fa fa-fw fa-dashboard"></i> Dashboard</a>
                        </li>

                        <li>
                            <a href="document.jsp"><i class="fa fa-fw fa-download"></i>Dokumente</a>
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
                        <li class="active" >
                            <a href="upload.jsp"><i class="fa fa-fw fa-upload"></i>Upload</a>
                        </li>
                        <li>
                            <a href="category.jsp"><i class="fa fa-fw fa-table"></i>Kategorien</a>
                        </li>

                    </ul>
                </div>
                <!-- /.navbar-collapse -->
            </nav>





            <!-- Page Heading -->

            <div id="page-wrapper" class="col-lg-12">

                <div class="col-lg-4">
                    <br></br>
                    <h2>Kategorie </h2>
                    <p>W�hlen Sie eine Kategorie aus , welcher Ihr Dokument zugewiesen werden soll.</p>
                    <p>Wenn Sie noch keine Kategorie erstellt haben, klicken Sie <a href="category.jsp">hier</a> um eine Kategorie zu erstellen.</p>
                    <br></br>

                    <form name="uploadFile" method="post" action="uploadServlet" onSubmit="return validateUpload();" enctype="multipart/form-data">

                        <select name="setFileCategory" class="form-control">

                            <% while (cats.next()) {%>

                            <option> <%= cats.getString("Categoryname")%> </option>

                            <%  } %>
                            <% cats.beforeFirst();%>

                        </select>

                </div>

                <div class="col-lg-4">
                    <div class="flat-form">
                        <p></p>
                        <center>  <img src="../images/upload.png" width="30%" height="15%"/>
                            <br>
                            </br>
                    </div>

                    <div class="form-group" >
                        <h3>Dokument Hochladen</h3>

                        <table border="0">

                  

                                <td><input  type="file" id="fileselect" name="uploadedFile" size="50" /></td>
                              
                              
                            <input type="hidden" name="User_ID" value="<%=session.getAttribute("sID")%>" size="50"/>
                         
                        </tr>
                            <tr>
                                <td colspan="2">
                                    <p></p>
                                    <input type="submit" id="submitbutton" value="Upload">
                                </td>
                            </tr>
                        </table>   
                            
                            

                      
                            
                            <div id="messages"></div>
                        </form>
                        </center>


                        

                  
                    </div>


                </div>
                <br></br>
                <br></br>
                <div class="col-lg-4">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="alert alert-info alert-dismissable">
                                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                <i class="fa fa-info-circle"></i>  <strong>Upload:<p></p> </strong> <p></p>1. Kategorie ausw�hlen <p></p> 2. Datei ausw�hlen <p></p> 3. Hochladen
                            </div>
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


<%

    /*
     1. Parameter= setFileCategory
     2.
     */
%>


<%     cat.insertFileCategory(request.getParameter("setFileCategory"));

%>





<%            if ((request.getAttribute("Message") != null) && (request.getAttribute("Message").toString() == "YES")) { %>

<SCRIPT LANGUAGE="JavaScript">
                        alert("Upload erfolgreich.");
                        window.document.location.replace("upload.jsp");
</SCRIPT>   <%
} else if (request.getAttribute("Message") != null && request.getAttribute("Messsage") != "YES") {
%>
<SCRIPT LANGUAGE="JavaScript">
    alert("Upload Fehlgeschlagen.");
    window.document.location.replace("upload.jsp");
</SCRIPT>
<%
} else if (request.getAttribute("Message") == null && request.getAttribute("FileCheck") != null) {
%>
<SCRIPT LANGUAGE="JavaScript">
    alert("Die von Ihnen gew�hlte Datei ist kein PDF Dokument.");
    window.document.location.replace("upload.jsp");
</SCRIPT>
<%
    }
%>

</body>

<script>
    /*
filedrag.js - HTML5 File Drag & Drop demonstration
Featured on SitePoint.com
Developed by Craig Buckler (@craigbuckler) of OptimalWorks.net
*/
(function() {

	// getElementById
	function $id(id) {
		return document.getElementById(id);
	}


	// output information
	function Output(msg) {
		var m = $id("messages");
		m.innerHTML = msg + m.innerHTML;
	}


	// file drag hover
	function FileDragHover(e) {
		e.stopPropagation();
		e.preventDefault();
		e.target.className = (e.type == "dragover" ? "hover" : "");
	}


	// file selection
	function FileSelectHandler(e) {

		// cancel event and hover styling
		FileDragHover(e);

		// fetch FileList object
		var files = e.target.files || e.dataTransfer.files;

		// process all File objects
		for (var i = 0, f; f = files[i]; i++) {
			ParseFile(f);
		}

	}


	// output file information
	function ParseFile(file) {

		Output(
			"<p>File information: <strong>" + file.name +
			"</strong> type: <strong>" + file.type +
			"</strong> size: <strong>" + file.size +
			"</strong> bytes</p>"
		);
        
        
        

	}


	// initialize
	function Init() {

		var fileselect = $id("fileselect"),
			filedrag = $id("filedrag"),
			submitbutton = $id("submitbutton");

		// file select
		fileselect.addEventListener("change", FileSelectHandler, false);
     
		// is XHR2 available?
		var xhr = new XMLHttpRequest();
		if (xhr.upload) {

			// file drop
			filedrag.addEventListener("dragover", FileDragHover, false);
			filedrag.addEventListener("dragleave", FileDragHover, false);
			filedrag.addEventListener("drop", FileSelectHandler, false);
			filedrag.style.display = "block";

			// remove submit button
                            
		}

	}

	// call initialization file
	if (window.File && window.FileList && window.FileReader) {
		Init();
                      
	}


})();
</script>


</html>
