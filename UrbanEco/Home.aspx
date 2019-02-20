<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="UrbanEco.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Co-Éco - Accueil</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="TitlePlaceHolder" runat="server">
    <h1>Accueil</h1>
    <label id="Lbl_HelloUser" runat="server" text="Bonjour"></label>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
    <form runat="server">
        <div class="col-md-12">
            <span runat="server" class="alert alert-warning" style="width: 100%;" id="alert_warning_sunday" visible="false"><b>L'année se termine bientôt !</b> N'oublier pas d'aller changer la date du premier dimanche dans l'onglet "Paramètres Administrateur".</span>
            <span runat="server" class="alert alert-danger" style="width: 100%;" id="alert_danger_sunday" visible="false"><b>Le premier dimanche de l'année est expiré !</b> Veuillez aller le mettre à jour dans l'onglet "Paramètres Administrateur".</span>
        </div>

        <div runat="server" id="tbl_resume">
            <%--CODE REPEATER DE FEUILLES DE TEMPS NON-APPROUVER--%>
            <h5>Bienvenue dans la gestion des projets de Co-Éco!</h5>
         
        </div>
        <div class="" >
            <asp:Button ID="btn_download" CssClass="btn btn-raised btn-success" runat="server" Text="Télécharger le guide d'utilisateur" OnClick="btn_download_Click"/>
        </div>

    </form>
</asp:Content>
