<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password</title>
</head>
<body>
    <b>Forgot Password</b><br><br>
    <form action="forgot" method="post">
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
        <input type="submit" value="Reset">
    </form>
</body>
</html>