<%-- 
    Document   : logout
    Created on : 24.11.2014, 16:16:55
    Author     : alimpamukci
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
      
        <%
            session.invalidate();
            response.sendRedirect("login.jsp?logout=" + ">> Erfolgreich abgemeldet");
        %>
    </body>
</html>
