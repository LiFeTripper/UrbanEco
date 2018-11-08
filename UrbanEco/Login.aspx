<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="UrbanEco.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <title>Connexion</title>

        <link href="lib/css/bootstrap.min.css" rel="stylesheet" />
</head>

<body>
    <br />
    <br />
    <br />

    <div class="container">
        <div class="row">

            <%--ENTETE COECO AVEC LOGO--%>

        </div>
        <div class="row">
            <div class="col"></div>
            <form class="form-signin col" runat="server">

                <%--ALERT FAILED AUTHENTICATION--%>
                <div runat="server" id="AlertDiv" visible="false" class="alert alert-danger alert-dismissable">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    <strong>Attention!</strong> <br />Nom d'utilisateur ou mot de passe incorrect !
                </div>

                <%--TITRE--%>
                <h1 class="h3 mb-3 font-weight-normal">Entrez votre nom d'utilisateur</h1>

                <%--USERNAME--%>
                <asp:TextBox ID="Tbx_InputUsername" runat="server" name="Tbx_InputUsername" placeholder="Utilisateur" class="form-control" required="autofocus"></asp:TextBox>

                <%--PASSWORD--%>
                <asp:TextBox class="form-control" ID="Tbx_InputPassword" name="Tbx_InputPassword" placeholder="Mot de passe" runat="server" required="true"></asp:TextBox>

                <%--CHECKBOX--%>
                <div class="checkbox mb-3">
                    <label for="Persist">Se souvenir de moi :</label>
                    <asp:CheckBox ID="Persist" runat="server"></asp:CheckBox>
                </div>

                <%--BOUTON D'IDENTIFICATION--%>
                <asp:Button ID="Btn_Signin" runat="server" Text="S'identifier" class="btn btn-lg btn-primary btn-block" type="submit" OnClick="Btn_Signin_Click" />
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