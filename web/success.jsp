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

<<<<<<< Updated upstream
        <%
            out.print("Benutzername : " + session.getAttribute("sUserName") + "<br>");
            out.print("Nachname: " + session.getAttribute("sFirstName") + "<br>");
            out.print("Nachname: " + session.getAttribute("sLastName") + "<br>");
        //out.print("Logged in at : "+session.getAttribute("sLastLogin")+"<br>");
 
        %>
        <form action="logout.jsp" method="POST">
            <input type="submit"  value="logout" name="logout" />
        </form>
        
        
    </body>
=======
<%
out.print("UserName : "+session.getAttribute("sUserName")+"<br>");
out.print("First- & LastName : "+session.getAttribute("sFirstName")+", "+session.getAttribute("sLastName")+"<br>");
out.print("Logged in at : "+session.getAttribute("sLastLogin")+"<br>");


%>


    
</body>
>>>>>>> Stashed changes
</html>
