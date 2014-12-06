<%-- 
    Document   : success
    Created on : 17.11.2014, 15:06:04
    Author     : Zeynel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>

<html>
    <head>
        <title>Erfolgreich eingeloggt</title>
        <link rel="stylesheet" href="style/css/style.css" media="screen" type="text/css" />
    </head>

    <body>
        <%--
        <h1>Erfolgreich eingeloggt</h1>
        --%>
        <%
            //out.print("Benutzername : " + session.getAttribute("sUserName") + "<br>");
            //out.print("Vorname:       " + session.getAttribute("sFirstName") + "<br>");
            //out.print("Nachname:      " + session.getAttribute("sLastName") + "<br>");
            //out.print("Logged in at : "+session.getAttribute("sLastLogin") + "<br>");
        %>

        <%--
        <form action="logout.jsp" method="POST">
            <input type="submit"  value="logout" name="logout" class="button"/>
        </form>
        --%>

        <div class="container">
            <div class="flat-form">
                <ul class="tabs">
                    <li>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</li>
                    <li>
                        <a> PDF Dokumentablage &nbsp; THM 2014 </a>
                    </li>
                    <li>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</li>
                </ul>
                <div id="logout" class="form-action show">
                    <h1>Eingeloggt &#10003; </h1>
                    <p>
                        Sie haben sich erfolgreich angemeldet. Sie können sich nun abmelden.
                    </p>
                    <form action="logout.jsp" method="POST">
                        <ul>
                            <li>
                                <br>
                                <table>
                                    <tbody>
                                        <tr>
                                            <td>Benutzername :</td>
                                            <td><% out.print("&nbsp; &nbsp; &nbsp;" + session.getAttribute("sUserName")); %></td>
                                        </tr>
                                        <tr>
                                            <td>Vorname :</td>
                                            <td><% out.print("&nbsp; &nbsp; &nbsp;" + session.getAttribute("sFirstName")); %></td>
                                        </tr>
                                        <tr>
                                            <td>Nachname :</td>
                                            <td><% out.print("&nbsp; &nbsp; &nbsp;" + session.getAttribute("sLastName"));%></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <br>
                            </li>
                           
                                <input type="submit" value="Abmelden" class="button" />
                          
                        </ul>
                    </form>
                </div>
            </div>
        </div>

        <div id="copyright">
            <center>
                <p class="clear"> Copyright &copy 2014 by MAPM, SMNS, ZKMR, OESM</p>
            </center>
        </div>

    </body>
</html>
