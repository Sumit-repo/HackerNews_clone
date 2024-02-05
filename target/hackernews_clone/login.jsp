<html lang="en">

<head>
    <title>Login</title>
</head>

<body>
    <b>Login</b><br><br>
    <form action="login" method="post">
        <table border="0">
            <tbody>
                <tr>
                    <td>username:</td>
                    <td><input type="text" name="acct" size="20" autocorrect="off" spellcheck="false"
                            autocapitalize="off" autofocus="true"></td>
                </tr>
                <tr>
                    <td>password:</td>
                    <td><input type="password" name="pw" size="20"></td>
                </tr>
            </tbody>
        </table><br>
        <input type="submit" value="login">
    </form><a href="forgot.jsp">Forgot your password?</a><br><br>
    <b>Create Account</b><br><br>
    <form action="register" method="post">
        <table border="0">
            <tbody>
                <tr>
                    <td>username:</td>
                    <td><input type="text" name="R-acct" size="20" autocorrect="off" spellcheck="false"
                            autocapitalize="off"></td>
                </tr>
                <tr>
                    <td>password:</td>
                    <td><input type="password" name="R-pw" size="20"></td>
                </tr>
            </tbody>
        </table><br>
        <input type="submit" value="create account">
    </form>
</body>

</html>