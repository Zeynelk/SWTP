<%-- 
    Document   : doLogin
    Created on : 17.11.2014, 14:50:28
    Author     : Zeynel
--%>

<%@page language="java" import="java.sql.*" errorPage=""%>

<%
    Connection conn = null;
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/USERS", "root", "smns");

    ResultSet rsdoLogin = null;
<<<<<<< Updated upstream
    PreparedStatement psdoLogin = null;

    String sUserName = request.getParameter("fUserName");
    String sPassword = request.getParameter("fPwd");

    String message = "User-Login war erfolgreich";

    try {
        String sqlOption = "SELECT * FROM benutzer where" + " Benutzername=? and Passwort=?";

        psdoLogin = conn.prepareStatement(sqlOption);

        psdoLogin.setString(1, sUserName);
        psdoLogin.setString(2, sPassword);

        rsdoLogin = psdoLogin.executeQuery();

        if (rsdoLogin.next()) {
            String ssUserName = rsdoLogin.getString("Benutzername");

            session.setAttribute("sUserName", ssUserName);
            session.setAttribute("sFirstName", rsdoLogin.getString("Vorname"));
            session.setAttribute("sLastName", rsdoLogin.getString("Nachname"));
            //session.setAttribute("sLastLogin", rsdoLogin.getString("uLastLogin"));

            response.sendRedirect("success.jsp?error=" + message);
            
        } else {%>
           <SCRIPT LANGUAGE="JavaScript">
                        alert("Anmeldung fehlgeschlagen.\nBenutzername oder Passwort falsch.");
                        window.document.location.replace("login.jsp");
                </SCRIPT><%
        }
    } catch (Exception e) {
=======
    PreparedStatement psdoLogin=null;
    
    String sUserName=request.getParameter("fUserName");
    String sPassword=request.getParameter("fPwd");
    
    String message="User-Login war erfolgreich";
    
    try{
    String sqlOption="SELECT * FROM users where"
                    +" uUserName=? and uPassword=?";
    
    psdoLogin=conn.prepareStatement(sqlOption);
    
    psdoLogin.setString(1,sUserName);
    psdoLogin.setString(2,sPassword);
    
    rsdoLogin=psdoLogin.executeQuery();
    
    if(rsdoLogin.next())
    {
      String ssUserName=rsdoLogin.getString("uUserName");
     
      session.setAttribute("sUserName",ssUserName);
      session.setAttribute("sFirstName", rsdoLogin.getString("uFirstName"));
      session.setAttribute("sLastName", rsdoLogin.getString("uLastName"));
      session.setAttribute("sLastLogin", rsdoLogin.getString("uLastLogin"));
     
     
      response.sendRedirect("success.jsp?error="+message);
    }
    else
    {
      message="User nicht registriert." ;
      response.sendRedirect("login.jsp?error="+message);
    }
    }
    catch(Exception e)
    {
>>>>>>> Stashed changes
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