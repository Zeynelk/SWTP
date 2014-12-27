<%-- 
    Document   : doLogin
    Created on : 17.11.2014, 14:50:28
    Author     : Zeynel
--%>

<%@page language="java" import="java.sql.*" errorPage=""%>

<%
    Connection conn = null;
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/USERS", "root", "");

    ResultSet rsdoLogin = null;
    PreparedStatement psdoLogin = null;

    String sUserName = request.getParameter("fUserName");
    String sPassword = request.getParameter("fPwd");

    String message = "User-Login war erfolgreich";

    try {
        String sqlOption = "SELECT * FROM User , UserRole , Permission, Role, RolePermission WHERE Username=? AND Password=? AND User.User_ID=UserRole.User_ID AND UserRole.Role_ID=Role.Role_ID AND RolePermission.Role_ID=Role.Role_ID AND Permission.Permission_ID=RolePermission.Permission_ID;";
       

        psdoLogin = conn.prepareStatement(sqlOption);

        psdoLogin.setString(1, sUserName);
        psdoLogin.setString(2, sPassword);

        rsdoLogin = psdoLogin.executeQuery();

        if (rsdoLogin.next()) {
            String ssUserName = rsdoLogin.getString("Username");

            
            session.setAttribute("sUserName", ssUserName);
            session.setAttribute("sFirstName", rsdoLogin.getString("Firstname"));
            session.setAttribute("sLastName", rsdoLogin.getString("Lastname"));
            session.setAttribute("sPassWord",rsdoLogin.getString("Password"));
            session.setAttribute("sEmail", rsdoLogin.getString("Email"));
            session.setAttribute("sRole",rsdoLogin.getString("Rolename"));
            session.setAttribute("sID",rsdoLogin.getString("User_ID"));
            session.setAttribute("sBerechtigungName",rsdoLogin.getString("Permissionname"));
      
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