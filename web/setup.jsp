<%-- 
    Document   : setup
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
        <title>SETUP MODUS</title>
    </head>
    <body>
        <h1>SETUP MODUS MODERNE DOKUMENTENABLAGE</h1>
        
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
                    insertUsers= connection.prepareStatement("INSERT INTO administrator VALUES (?,?)");
                   
                  }catch(SQLException e){
                    e.printStackTrace();
                }
                
               
            }
            
           public int setUsers(String benutzerN, String passW){
                    
                    int result =0;
                    
                    try{
                    insertUsers.setString(1, benutzerN);
                    insertUsers.setString(2,passW);
                    
              
                    result =insertUsers.executeUpdate();
                    
                    
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
            String Benutzername= new String();
            String Passwort = new String();
            
            if(request.getParameter("benutzerN")!=null){
                Benutzername=request.getParameter("benutzerN");
         
            }
            if(request.getParameter("passW")!=null){
               
                Passwort=request.getParameter("passW");
           
            }

            
            User users = new User();
           
            
            if(!Benutzername.isEmpty() && !Passwort.isEmpty()){
            result= users.setUsers(Benutzername, Passwort);
            String url="login.jsp";
            response.sendRedirect(url);
            }else{
                out.print("<p>Bitte legen Sie einen Administrator an</p>");
               
            }
           
            
        %>
        
        
        
        
        <form action="setup.jsp" method="POST">
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
                </tbody>
            </table>
            <input type="reset" value="Clear" name="clear" />
            <input type="submit" value="Submit" name="submit" />
        </form>
    </body>
</html>
