<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="ModifCategorie.aspx.cs" Inherits="UrbanEco.ModifCategorie" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .asp-table {
            table-layout: fixed;


        }
    </style>
    <title>Co-Éco - modification des catégories</title>
    <link rel="stylesheet" type="text/css" href="lib/css/modifCategorie.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="TitlePlaceholder" runat="server">
    <h1>
        <asp:Label ID="Lbl_Titre" runat="server" Text="Sous-Projet"></asp:Label>
    </h1>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="BodyPlaceHolder" runat="server">

    <form runat="server">



        <%--SOUS-CATÉGORIE--%>
        <div class="form-group" runat="server">
            <label for="Tbx_Titre" class="bmd-label-floating">Titre</label>
            <asp:TextBox ID="Tbx_Titre" runat="server" class="form-control" ></asp:TextBox>
        </div>

        <div class="form-group" runat="server">
            <label for="Tbx_Description" class="bmd-label-floating">Description</label>
            <asp:TextBox ID="Tbx_Description" runat="server" class="form-control"></asp:TextBox>
        </div>



        <asp:Button ID="Btn_Enregistrer" runat="server" Text="Enregistrer"  CssClass="btn btn-raised btn-success" OnClick="Btn_Enregistrer_Click" />
        <asp:Button ID="Btn_Annuler" runat="server" Text="Annuler" CssClass="btn btn-raised btn-danger" OnClick="Btn_Annuler_Click" />



    </form>

    
</asp:Content>
