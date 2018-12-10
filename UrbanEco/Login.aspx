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

    <form class="form-signin" runat="server">

        <%--ALERT FAILED AUTHENTICATION--%>
        <div runat="server" id="AlertDiv" visible="false" class="alert alert-danger alert-dismissable">
            <button type="button" class="close" data-dismiss="alert">&times;</button>
            <strong>Attention!</strong>
            <br />
            Nom d'utilisateur ou mot de passe incorrect !
        </div>

        <%--TITRE--%>
        <h1 class="h3 mb-3 font-weight-normal">Entrez votre nom d'utilisateur</h1>

        <%--USERNAME--%>
        <asp:TextBox ID="Tbx_InputUsername" runat="server" name="Tbx_InputUsername" placeholder="Utilisateur" class="form-control" required="autofocus"></asp:TextBox>

        <%--PASSWORD--%>
        <input class="form-control" ID="Tbx_InputPassword" name="Tbx_InputPassword" placeholder="Mot de passe" runat="server" type="password" />
        <%--<asp:TextBox class="form-control" ID="Tbx_InputPassword" name="Tbx_InputPassword" placeholder="Mot de passe" runat="server"></asp:TextBox>--%>

        <%--CHECKBOX--%>
<%--        <div class="checkbox mb-3">
            <label for="Persist">Se souvenir de moi :</label>
            <asp:CheckBox ID="Persist" runat="server"></asp:CheckBox>
        </div>--%>

        <%--Checkbox--%>
        <table style="width: 100% !important; margin-top:10px; margin-bottom:10px;">
            <tr>
                <td>
                    <h4 style="float:left;">Se souvenir de moi</h4>
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
        <asp:Button ID="Btn_Signin" runat="server" Text="S'identifier" class="btn btn-lg btn-primary btn-block" type="submit" OnClick="Btn_Signin_Click" />
    </form>


    <%--SCRIPTS--%>
    <script src="lib/js/jquery-3.3.1.min.js"></script>
    <script src="lib/js/popper.js"></script>
    <script src="lib/js/bootstrap.min.js"></script>
</body>
</html>
