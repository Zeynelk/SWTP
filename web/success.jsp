<%-- 
    Document   : success
    Created on : 17.11.2014, 15:06:04
    Author     : Zeynel
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>

<html>
<head>
<title>Erfolgreich eingeloggt</title>
</head>

<body>
    <p>Erfolgreich eingeloggt</p>
    

<%
out.print("Benutzername : "+session.getAttribute("sUserName")+"<br>");

out.print("Nachname: "+session.getAttribute("sFirstName")+"<br>");
out.print("Nachname: "+session.getAttribute("sLastName")+"<br>");

//out.print("Logged in at : "+session.getAttribute("sLastLogin")+"<br>");
%>
</body>
</html>
