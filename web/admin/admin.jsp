<%-- 
    Document   : success2
    Created on : 06.12.2014, 18:33:37
    Author     : alimpamukci
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>SOMZDoc Administration</title>

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
                    <a class="navbar-brand" href="admin.jsp">SOMZDoc Administration</a>
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
                        <li class="active">
                            <a href="admin.jsp"><i class="fa fa-fw fa-dashboard"></i> Dashboard</a>
                        </li>

                        <li>
                            
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
                            <div class="container">
                                <div class="flat-form">

                                    <div id="logout" class="form-action show">
                                        <h1>Eingeloggt &#10003; </h1>
                                        <p>
                                            Sie haben sich erfolgreich angemeldet. Sie können sich nun abmelden.
                                        </p>
                                        <form action="logout.jsp" method="POST">
                                            <ul>

                                                <br>
                                                <table>
                                                    <tbody>
                                                        <tr>
                                                            <td>Benutzername :</td>
                                                            <td><% out.print("&nbsp; &nbsp; &nbsp;" + session.getAttribute("sUserName")); %></td>


                                                        </tr>

                                                        <tr>
                                                            <td>Rolle:</td>

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
