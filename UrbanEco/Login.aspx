<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="UrbanEco.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <title>Login Screen</title>

        <link href="lib/css/bootstrap.min.css" rel="stylesheet" />
</head>

<body>
    <div class="container">
        <div class="row">

            <%--ENTETE COECO--%>

        </div>
        <div class="row">
            <div class="col"></div>
            <form class="form-signin col" runat="server">
              <img class="mb-4" src="https://getbootstrap.com/assets/brand/bootstrap-solid.svg" alt="" width="72" height="72"/>
              <h1 class="h3 mb-3 font-weight-normal">Please sign in</h1>
              <label for="inputEmail" class="sr-only">Email address</label>
              <input type="email" id="inputEmail" class="form-control" placeholder="Email address" <%--required--%> autofocus/>
              <label for="inputPassword" class="sr-only">Password</label>
              <input type="password" id="inputPassword" class="form-control" placeholder="Password" <%--required--%>/>
              <div class="checkbox mb-3">
                <label>
                  <input type="checkbox" value="remember-me"/> Remember me
                </label>
              </div>
                <asp:Button ID="Btn_Signin" runat="server" Text="Sign in" class="btn btn-lg btn-primary btn-block" type="submit" OnClick="Btn_Signin_Click"/>
            </form>
            <div class="col"></div>
        </div>
    </div>

    <%--SCRIPTS--%>
    <script src="lib/js/jquery-3.3.1.min.js"></script>
    <script src="lib/js/popper.js"></script>
    <script src="lib/js/bootstrap.min.js"></script>
</body>
</html>