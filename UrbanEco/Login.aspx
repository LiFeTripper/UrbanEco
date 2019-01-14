<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="UrbanEco.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Connexion</title>
    
    <link href="lib/css/bootstrap.min.css" rel="stylesheet" />
    <link href="lib/css/signin.css" rel="stylesheet" />
    <link href="lib/css/fancy-switch.css" rel="stylesheet" />
</head>

<body class="text-center">
    <%--IMAGE CO-ÉCO--%>
    <%--<img class="mb-4" src="" alt="" width="72" height="72">--%>

    <div id="background">
        <img src="Resources/fond-login.jpg" alt="Background" />
    </div>

    <!-- Contenu de la page -->
    <div id="contenu">
        <div class="card">
            <form class="form-signin" runat="server">

            <%--ALERT FAILED AUTHENTICATION--%>
            <div runat="server" id="AlertDiv" visible="false" class="alert alert-danger alert-dismissable">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                <strong>Attention!</strong>
                <br />
                Nom d'utilisateur ou mot de passe incorrect !
            </div>

            <!-- Logo -->
            <img alt="Logo Co-Éco" src="Resources/CoEco-Logo.png" />

            <%--USERNAME--%>
            <asp:TextBox ID="Tbx_InputUsername" runat="server" name="Tbx_InputUsername" placeholder="Nom d'usager" class="form-control" ></asp:TextBox>

            <%--PASSWORD--%>
            <input class="form-control" ID="Tbx_InputPassword" name="Tbx_InputPassword" placeholder="Mot de passe" runat="server" type="password" />

            <%--Checkbox--%>
            <table style="width: 100% !important; margin-top:10px; margin-bottom:10px;">
                <tr>
                    <td>
                        <h5 style="float:left;">Se souvenir de moi</h5>
                    </td>
                    <%--CHECKBOX INACTIF OU ACTIF--%>
                    <td style="width:20%;" class="mb-3">
                        <label class="switch" style="float:right;">
                            <asp:CheckBox runat="server" id="Persist" />
                            <span class="slider round"></span>
                        </label>              
                    </td>
                </tr>
            </table>

            <%--BOUTON D'IDENTIFICATION--%>
            <asp:Button ID="Btn_Signin" runat="server" Text="Connexion" class="btn btn-lg btn-primary btn-block" type="submit" OnClick="Btn_Signin_Click" />
            </form>
        </div> <!-- Div Card -->
    </div> <!-- Div Contenu -->




    <%--SCRIPTS--%>
    <script src="lib/js/jquery-3.3.1.min.js"></script>
    <script src="lib/js/popper.js"></script>
    <script src="lib/js/bootstrap.min.js"></script>
</body>
</html>
