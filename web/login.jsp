<%-- 
    Document   : Login
    Created on : 17.11.2014, 14:45:38
    Author     : Zeynel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String error = request.getParameter("error");
    if (error == null || error == "null") {
        error = "";
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login-Page</title>
        <link rel="stylesheet" href="stylesheet.css" type="text/css">
<script>
            
    function trim(s) 
    {
        return s.replace( /^s*/, "" ).replace( /s*$/, "" );
    }

    function validate()
    {
        if(trim(document.formLogin.fUserName.value)==="")
        {
          alert("Login ist leer");
          document.formLogin.fUserName.focus();
          return false;
        }
        else if(trim(document.formLogin.fPwd.value)==="")
        {
          alert("passwort ist leer");
          document.formLogin.fPwd.focus();
          return false;
        }
    }
</script>

    </head>
    <body>
        <div><%=error%></div>
        
        <h3>Bitte geben Sie Ihre Zugangsdaten ein</h3>
        <form name="formLogin" onSubmit="return validate();" action="doLogin.jsp" method="post">
            <fieldset>
                <legend>Login</legend>
                <label for="lUserName">Username</label>
                <input type="text" name="fUserName" id="lUserName" /><br/>
                <label for="lPwd">Password</label>
                <input type="password" name="fPwd" id="lPwd"/><br/>
                <input type="submit" name="sSubmit" value="Submit" />
            </fieldset>
        </form> 

       
      
    </body>
</html>
