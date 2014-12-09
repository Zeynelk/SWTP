<%-- 
    Document   : doLogin
    Created on : 17.11.2014, 14:50:28
    Author     : Zeynel
--%>

<%@page language="java" import="java.sql.*" errorPage=""%>

<%
    Connection conn = null;
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/USERS", "root", "mapm");

    ResultSet rsdoLogin = null;
    PreparedStatement psdoLogin = null;

    String sUserName = request.getParameter("fUserName");
    String sPassword = request.getParameter("fPwd");

    String message = "User-Login war erfolgreich";

    try {
        String sqlOption = "SELECT * FROM benutzer , benutzer_has_rolle , berechtigung, rolle, rolle_has_berechtigung WHERE Benutzername=? AND Passwort=? AND benutzer.Benutzer_ID=benutzer_has_rolle.benutzer_Benutzer_ID AND benutzer_has_rolle.rolle_Rolle_ID=rolle.Rolle_ID AND rolle_has_berechtigung.rolle_Rolle_ID=rolle.Rolle_ID AND berechtigung.Berechtigung_ID=rolle_has_berechtigung.berechtigung_Berechtigung_ID;";
       

        psdoLogin = conn.prepareStatement(sqlOption);

        psdoLogin.setString(1, sUserName);
        psdoLogin.setString(2, sPassword);

        rsdoLogin = psdoLogin.executeQuery();

        if (rsdoLogin.next()) {
            String ssUserName = rsdoLogin.getString("Benutzername");

            
            session.setAttribute("sUserName", ssUserName);
            session.setAttribute("sFirstName", rsdoLogin.getString("Vorname"));
            session.setAttribute("sLastName", rsdoLogin.getString("Nachname"));
            session.setAttribute("sPassWord",rsdoLogin.getString("Passwort"));
            session.setAttribute("sEmail", rsdoLogin.getString("Email"));
            session.setAttribute("sRole",rsdoLogin.getString("RolleName"));
            session.setAttribute("sID",rsdoLogin.getString("Benutzer_ID"));
            session.setAttribute("sBerechtigungName",rsdoLogin.getString("BerechtigungName"));
      
            //session.setAttribute("sLastLogin", rsdoLogin.getString("uLastLogin"));
            
            if(session.getAttribute("sBerechtigungName").equals("USER")){
                
            response.sendRedirect("../user/user.jsp?error=" + message);
            
            }else{
                
     
                response.sendRedirect("../admin/admin.jsp?error="+message);
            }
            
        } else {%>
           <SCRIPT LANGUAGE="JavaScript">
                        alert("Anmeldung fehlgeschlagen.\nBenutzername oder Passwort falsch.");
                        window.document.location.replace("login.jsp");
                </SCRIPT><%
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    /// close object and connection
    try {
        if (psdoLogin != null) {
            psdoLogin.close();
        }
        if (rsdoLogin != null) {
            rsdoLogin.close();
        }

        if (conn != null) {
            conn.close();
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>