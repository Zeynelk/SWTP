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

<%
    String logout = request.getParameter("logout");
    if (logout == null || logout == "null") {
        logout = "";
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Document</title>
        <link rel="stylesheet" href="../style/css/style.css" media="screen" type="text/css" />

        <script>

            function trim(s)
            {
                return s.replace(/^s*/, "").replace(/s*$/, "");
            }

            function validateLogin()
            {

                if (trim(document.formLogin.fUserName.value) === "")
                {
                    alert("Login ist leer!");
                    document.formLogin.fUserName.focus();
                    return false;
                }
                else if (trim(document.formLogin.fPwd.value) === "")
                {
                    alert("Passwort ist leer!");
                    document.formLogin.fPwd.focus();
                    return false;
                }

            }

            function validateRegister() {

                if (trim(document.formRegister.vornameN.value) === "")
                {
                    alert("Vorname ist leer!");
                    document.formRegister.vornameN.focus();
                    return false;
                }
                else if (trim(document.formRegister.nachnameN.value) === "")
                {
                    alert("Nachname ist leer!");
                    document.formRegister.nachnameN.focus();
                    return false;
                }
                else if (trim(document.formRegister.emailN.value) === "")
                {
                    alert("Email ist leer!");
                    document.formRegister.emailN.focus();
                    return false;
                }
                else if (trim(document.formRegister.benutzerN.value) === "")
                {
                    alert("Benutzername ist leer!");
                    document.formRegister.benutzerN.focus();
                    return false;
                }
                else if (trim(document.formRegister.passW.value) === "")
                {
                    alert("Passwort ist leer!");
                    document.formRegister.passW.focus();
                    return false;
                }
            }

        </script>

    </head>

    <body>

        <div class="container" >
            <div class="flat-form">
                <ul class="tabs">
                    <li>
                        <a href="#login" class="active">Login</a>
                    </li>
                    <li>
                        <a href="#register">Register</a>
                    </li>
                    <li>
                        <a href="#reset">Reset Password</a>
                    </li>
                </ul>
                <!--/#login.form-action-->
                <div id="login" class="form-action show">
                    <h1>Anmelden</h1>
                    <p>
                        Bitte melden Sie sich mit Ihren Benutzerdaten sich an.
                    </p>
                    <form name="formLogin" onSubmit="return validateLogin();" action="doLogin.jsp" method="POST">
                        <ul>
                            <li>
                                <input type="text" name="fUserName" placeholder="Benutzername" />
                            </li>
                            <li>
                                <input type="password"  name="fPwd" placeholder="Passwort" />
                            </li>
                            <li>
                                <input type="submit" value="Anmelden" class="button" />
                            </li>
                        </ul>
                    </form>
                </div>
                <!--/#register.form-action-->
                <div id="register" class="form-action hide">
                    <h1>Registrieren</h1>
                    <p>
                        Bitte füllen Sie alle Felder aus, um sich erfolgreich zu registrieren.
                    </p>
                    <form name="formRegister" onSubmit="return validateRegister();" action="register.jsp" method="POST">
                        <ul>
                            <li>
                                <input type="text" name="vornameN" placeholder="Vorname" />
                            </li>
                            <li>
                                <input type="text" name="nachnameN" placeholder="Nachname" />
                            </li>
                            <li>
                                <input type="text" name="emailN" placeholder="Email" />
                            </li>
                            <li>
                                <input type="text" name="benutzerN" placeholder="Benutzername" />
                            </li>
                            <li>
                                <input type="password" name="passW" placeholder="Passwort" />
                            </li>
                            <li>
                                <input type="submit" value="Registrieren" class="button" />

                            </li>
                        </ul>
                    </form>
                </div>

                <%
                    if (request.getParameter("hidden") != null) {

                        response.sendRedirect("http://www.google.de");

                    }
                %>
                <!--/#reset.form-action-->
                <div id="reset" class="form-action hide">
                    <h1>Passwort zurücksetzen</h1>
                    <p>
                        Bitte geben Sie Ihre Email Adresse und Ihren Benutzernamen an.
                    </p>
                    <form>
                        <ul>
                            <li>
                                <input type="text" placeholder="Benutzername" />
                            </li>
                            <li>
                                <input type="text" placeholder="Email" />
                            </li>
                            <li>
                                <input type="submit" value="Senden" class="button" />
                            </li>
                        </ul>
                    </form>
                </div>
            </div>   
        </div>

        <div id="copyright">
            <center>
                <p class="clear"> Copyright &copy; 2014 by MAPM, SMNS, ZKMR, OESM</p>
            </center>
        </div>

        <script class="cssdeck" src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.8.0/jquery.min.js"></script>
        <script src="../style/js/index.js"></script>

    <center>

        <p><%=logout%></p>

    </center>

</body>

</html>
