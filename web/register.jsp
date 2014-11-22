<%-- 
    Document   : register
    Created on : 21.11.2014, 19:42:04
    Author     : alimpamukci
--%>

<%@page import="java.sql.*"%>
<%@page import ="java.util.Date" %>
<% Class.forName("com.mysql.jdbc.Driver");%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inserting Data Into A Database</title>
    </head>
    <body onload="displayResults()">
        <h1>Instering Data Into A Database</h1>
        
        <%!
                public class User {
            String URL="jdbc:mysql://localhost:3306/USERS";
            
            String USERNAME ="root";
            String PASSWORD="mapm";
            
            Connection connection = null;
            PreparedStatement insertUsers=null;
            
            public User(){
                
                
                try{
                    
                    connection = DriverManager.getConnection(URL,USERNAME,PASSWORD);
                    insertUsers= connection.prepareStatement("INSERT INTO benutzer VALUES (?,?,?,?,?)");
                   
                }catch(SQLException e){
                    e.printStackTrace();
                }
                
               
            }
            
           public int setUsers(String benutzerN, String passW,String vornameN,String nachnameN,String emailN){
                    
                    int result =0;
                    
                    try{
                    insertUsers.setString(1, benutzerN);
                    insertUsers.setString(2,passW);
                    insertUsers.setString(3,vornameN);
                    insertUsers.setString(4,nachnameN);
                    insertUsers.setString(5,emailN);
                    
              
                    result=insertUsers.executeUpdate();
                    
                    
                    }catch(SQLException e){
                        e.printStackTrace();
                    }
                
                     
                    
                    return result;
                }
        }
        %>
        
        <%
//Setup Values The User needs
            int result=0;
            String benutzername= new String();
            String passwort = new String();
            String vorname = new String();
            String nachname = new String();
            String email = new String();
            
            if(request.getParameter("benutzerN")!=null){
                benutzername=request.getParameter("benutzerN");
            }
            if(request.getParameter("passW")!=null){
               
                passwort=request.getParameter("passW");
           
            }
            if(request.getParameter("vornameN")!=null){
               
                vorname=request.getParameter("vornameN");
           
            }
            if(request.getParameter("nachnameN")!=null){
               
                 nachname=request.getParameter("nachnameN");
           
            }
            if(request.getParameter("emailN")!=null){
               
                email=request.getParameter("emailN");
           
            }

            
            User users = new User();
            if(!benutzername.isEmpty() && !passwort.isEmpty()){
            result= users.setUsers(vorname,nachname,email,passwort,benutzername);
            }else{
                
            }
           
            
        %>
        
        
        
        
        <form name="myForm" action="register.jsp" method="POST">
            <table border="0">
                <tbody>
                    <tr>
                        <td>Benutzername</td>
                        <td><input type="text" name="benutzerN" value="" size="30" /></td>
                    </tr>
                    <tr>
                        <td>Passwort</td>
                        <td><input type="text" name="passW" value="" size="20" /></td>
                    </tr>
                    <tr>
                        <td>Vorname</td>
                        <td><input type="text" name="vornameN" value="" size="20" /></td>
                    </tr>
                    <tr>
                        <td>Nachname</td>
                        <td><input type="text" name="nachnameN" value="" size="20" /></td>
                    </tr>
                    <tr>
                        <td>E-Mail</td>
                        <td><input type="text" name="emailN" value="" size="20" /></td>
                    </tr>
                </tbody>
            </table>
            <input type="hidden" name="hidden" value="<%=result%>"/>
            <input type="reset" value="Clear" name="clear" />
            <input type="submit" value="Submit" name="submit" />
        </form>
        
        
        <SCRIPT LANGUAGE="JavaScript">
           
                function displayResults(){
                    if(document.myForm.hidden.value == 1){
                        alert("Registrierung Erfolgreich!\nSie werden auf die Login-Seite weitergeleitet.");
                        window.location="login.jsp";
                    }
                }
              
                </SCRIPT>
    </body>
</html>
