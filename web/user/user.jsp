<%-- 
    Document   : success2
    Created on : 06.12.2014, 18:33:37
    Author     : alimpamukci
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<% Class.forName("com.mysql.jdbc.Driver");%>
<%@ page import="java.util.Date"%>
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


        <link href="../style/sbad/css/plugins/morris.css" rel="stylesheet">


    </head>


    <%!
        public class Message {

            String URL = "jdbc:mysql://localhost:3306/USERS";
            String USERNAME = "root";
            String PASSWORD = "";

            Connection connection = null;
            PreparedStatement getMessages = null;
            PreparedStatement insertMessage = null;
            PreparedStatement insertUserMessage = null;
            ResultSet rsMessages = null;

            public Message() {

                try {
                    connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);

                    getMessages = connection.prepareStatement("SELECT  Message.Message_ID,Firstname,Lastname,Message,Time FROM User,UserMessage,Message WHERE User.User_ID=UserMessage.User_ID and Message.Message_ID=UserMessage.Message_ID ORDER BY Time DESC;");
                    insertMessage = connection.prepareStatement("INSERT INTO Message VALUES (null,?,?)");
                    insertUserMessage = connection.prepareStatement("INSERT INTO UserMessage VALUES(?,(SELECT Message_ID FROM Message ORDER BY Message_ID DESC LIMIT 1));");
                } catch (SQLException e) {
                    e.printStackTrace();
                }

            }

            public int setMessage(String Message, Timestamp date) {

                try {
                    insertMessage.setString(1, Message);
                    insertMessage.setTimestamp(2, date);
                    insertMessage.executeUpdate();

                } catch (SQLException e) {
                    e.printStackTrace();
                }
                return 0;

            }

            public int setUserMessage(String sID) {

                try {
                    insertUserMessage.setString(1, sID);

                    insertUserMessage.executeUpdate();

                } catch (SQLException e) {
                    e.printStackTrace();
                }
                return 0;

            }

            public ResultSet getMessages() {

                try {

                    rsMessages = getMessages.executeQuery();

                } catch (SQLException e) {
                    e.printStackTrace();
                }

                return rsMessages;
            }

        }
    %>


    <%

        Message message = new Message();
        ResultSet messages = message.getMessages();

        int result = 0;


    %>


    <%        if (request.getParameter("sendMessage") != null) {

            java.sql.Timestamp sqlDate = new java.sql.Timestamp(new java.util.Date().getTime());

            message.setMessage(request.getParameter("sendText"), sqlDate);
            message.setUserMessage(session.getAttribute("sID").toString());
            response.sendRedirect("../user/user.jsp");
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
                        <li class="active">
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

                    <div class="row">
                        <div class="col-lg-3 col-md-6">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    <div class="row">
                                        <div class="col-xs-3">
                                            <i class="fa fa-upload fa-5x"></i>
                                        </div>
                                        <div class="col-xs-9 text-right">
                                            <div class="huge"></div>
                                            <div></div>
                                        </div>
                                    </div>
                                </div>
                                <a href="upload.jsp">
                                    <div class="panel-footer">
                                        <span class="pull-left">Dokumente Hochladen</span>
                                        <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                        <div class="clearfix"></div>
                                    </div>
                                </a>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="panel panel-green">
                                <div class="panel-heading">
                                    <div class="row">
                                        <div class="col-xs-3">
                                            <i class="fa fa-tasks fa-5x"></i>
                                        </div>
                                        <div class="col-xs-9 text-right">
                                            <div class="huge"></div>
                                            <div></div>
                                        </div>
                                    </div>
                                </div>
                                <a href="document.jsp">
                                    <div class="panel-footer">
                                        <span class="pull-left">Meine Dokumente</span>
                                        <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                        <div class="clearfix"></div>
                                    </div>
                                </a>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="panel panel-yellow">
                                <div class="panel-heading">
                                    <div class="row">
                                        <div class="col-xs-3">
                                            <i class="fa fa-table fa-5x"></i>
                                        </div>
                                        <div class="col-xs-9 text-right">
                                            <div class="huge"></div>
                                            <div></div>
                                        </div>
                                    </div>
                                </div>
                                <a href="category.jsp">
                                    <div class="panel-footer">
                                        <span class="pull-left">Kategorien</span>
                                        <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                        <div class="clearfix"></div>
                                    </div>
                                </a>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="panel panel-red">
                                <div class="panel-heading">
                                    <div class="row">
                                        <div class="col-xs-3">
                                            <i class="fa fa-adjust fa-5x"></i>
                                        </div>
                                        <div class="col-xs-9 text-right">
                                            <div class="huge"></div>
                                            <div>Einstellungen</div>
                                        </div>
                                    </div>
                                </div>
                                <a href="profile.jsp">
                                    <div class="panel-footer">
                                        <span class="pull-left">Bearbeiten</span>
                                        <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                        <div class="clearfix"></div>
                                    </div>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="container-fluid">
                        <div class="col-lg-12">


                            <div class="container">
                                <div class="flat-form">
                                    <div class="col-lg-6">
                                        <div id="logout" class="form-action show">


                                            <div class="panel panel-info">
                                                <div class="panel-heading">
                                                    Nachricht Schreiben
                                                </div>
                                                <form>
                                                    <div class="panel-body">
                                                        <textarea name="sendText"rows="3" class="form-control"></textarea>
                                                    </div>
                                                    <div class="panel-footer">
                                                        <input name="sendMessage" value="Senden" type="submit" class="btn btn-outline btn-primary btn-lg btn-block" >

                                                    </div>
                                                </form>
                                            </div>




                                            <div class="col-lg-13">
                                                <div class="panel panel-default">
                                                    <div class="panel-heading">
                                                        Softwaretechnik Projekt WS 14 / 15
                                                    </div>
                                                    <div class="panel-body">

                                                        <h4>Teammitglieder</h4>
                                                        <address>

                                                            Salim, Mansur
                                                            <br>Mehmet-Ali,Pamukci
                                                            <br>Zeynel,Kömürcü
                                                            <br>Orhan, Esmer

                                                        </address>
                                                        <address>

                                                        </address>
                                                    </div>
                                                    <!-- /.panel-body -->
                                                </div>
                                                <!-- /.panel -->
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 col-md-12">
                                        <!-- col-lg-4 start here -->
                                        <div class="panel panel-default plain toggle panelMove panelClose panelRefresh" id="dyn_13">
                                            <!-- Start .panel -->
                                            <div class="panel-heading">
                                                <h4 class="panel-title pull-right"><i class="fa fa-comments pull-right"></i> Neueste Nachrichten</h4>
                                                <br>
                                                <div class="panel-body">
                                                    <ul class="list-group recent-comments">


                                                        <% while (messages.next()) {


                                                        %>
                                                        <li class="list-group-item clearfix comment-success">
                                                            <div class="avatar pull-left mr15">

                                                            </div>
                                                            <p class="text-ellipsis pull-right"><span class="name strong"><% out.print(messages.getString("Firstname") + " " + messages.getString("Lastname"));%>: </span> <% out.print(messages.getString("Message"));%></p>

                                                            <span class="date text-muted small pull-right"><% out.print(messages.getString("Time"));%></span>
                                                           
                                                        </li>
                                                        <%
                                                                      }%>


                                                    </ul>
                                                </div>
                                            </div>
                                            <!-- End .panel -->
                                        </div>

                                    </div>
                                </div>

                            </div>
                        </div>
                        <!-- /.row -->

                        <div class="col-lg-12">


                            <div class="container">
                                <div class="flat-form">
                                    <div class="col-lg-6">
                                        <div id="logout" class="form-action show">
                                            <h1>Eingeloggt  </h1>
                                            <p>
                                                Sie haben sich erfolgreich angemeldet. Sie können nun Dokumente hoch- und runterladen,
                                                sowie Kontoeinstellungen vornehmen.
                                            </p>
                                            <form action="logout.jsp" method="POST">
                                                <ul>

                                                    <br>
                                                    <table class="table table-bordered table-hover">
                                                        <tbody>
                                                            <tr>
                                                                <td><strong>Benutzername</strong> </td>
                                                                <td><% out.print("&nbsp; &nbsp; &nbsp;" + session.getAttribute("sUserName")); %></td>


                                                            </tr>
                                                            <tr>
                                                                <td><strong>Vorname </strong></td>
                                                                <td><% out.print("&nbsp; &nbsp; &nbsp;" + session.getAttribute("sFirstName")); %></td>
                                                            </tr>
                                                            <tr>
                                                                <td><strong>Nachname </strong></td>
                                                                <td><% out.print("&nbsp; &nbsp; &nbsp;" + session.getAttribute("sLastName"));%></td>
                                                            </tr>
                                                            <tr>
                                                                <td><strong>Rolle</strong></td>

                                                                <td><% out.print("&nbsp; &nbsp; &nbsp;" + session.getAttribute("sRole"));%></td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                    <br>


                                                </ul>
                                            </form>
                                        </div>
                                    </div>

                                </div>

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
            <script src="../style/sbad/js/plugins/morris/raphael.min.js"></script>
            <script src="../style/sbad/js/plugins/morris/morris.min.js"></script>
            <script src="../style/sbad/js/plugins/morris/morris-data.js"></script>

    </body>

</html>
