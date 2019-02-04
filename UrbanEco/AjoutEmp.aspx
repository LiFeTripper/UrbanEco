<%@ Page Title="Co-Éco" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="AjoutEmp.aspx.cs" Inherits="UrbanEco.AjoutEmp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="lib/css/ajoutEmpForm.css" />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="TitlePlaceHolder" runat="server">
    <h1>
        <asp:Label ID="lbl_Top" runat="server" Text="Label"></asp:Label>
    </h1>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlaceHolder" runat="server">

    <form runat="server">
        <%--PRÉNOM--%>
        <div class="form-group">
            <label for="Tbx_Prenom" class="bmd-label-floating">Prénom</label>
            <asp:TextBox ID="Tbx_Prenom" runat="server" CssClass="form-control" type="text"></asp:TextBox>
            <asp:Label ID="lb_erreurPrenom" runat="server" Text="Le champ n'est pas valide" Visible="false" CssClass="alert-danger small"></asp:Label>
        </div>

        <%--NOM--%>
        <div class="form-group">
            <label for="Tbx_Nom" class="bmd-label-floating">Nom</label>
            <asp:TextBox ID="Tbx_Nom" runat="server" CssClass="form-control" type="text"></asp:TextBox>
            <asp:Label ID="lb_erreurNom" runat="server" Text="Le champ n'est pas valide" Visible="false" CssClass="alert-danger small"></asp:Label>
        </div>

        <%--email--%>
        <div class="form-group spantwo">
            <label for="Tbx_email" class="bmd-label-floating">Courriel</label>
            <asp:TextBox ID="Tbx_email" runat="server" CssClass="form-control" type="email"></asp:TextBox>
        </div>

        <%--Username--%>
        <div class="form-group">
            <label for="Tbx_username" class="bmd-label-floating">Nom d'usager</label>
            <asp:TextBox ID="Tbx_username" runat="server" CssClass="form-control" type="text"></asp:TextBox>
            <asp:Label ID="lb_erreurUsername" runat="server" Text="Le champ n'est pas valide" Visible="false" CssClass="alert-danger small"></asp:Label>
        </div>

        <%--password--%>
        <div class="form-group">
            <label for="Tbx_password" class="bmd-label-floating">Mot de passe</label>
            <asp:TextBox ID="Tbx_password" runat="server" CssClass="form-control" type="text"></asp:TextBox>
        </div>

        <%--TYPE--%>
         <div class="form-group">
            <label for="Ddl_TypeEmp" class="bmd-label-floating">Type d'employé</label>
            <asp:DropDownList ID="Ddl_TypeEmp" runat="server" DataSourceID="LinqTypeEmp" DataTextField="nomType" DataValueField="idType" class="form-control"></asp:DropDownList>
            <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqTypeEmp" ContextTypeName="UrbanEco.CoecoDataContext" TableName="tbl_TypeEmploye"></asp:LinqDataSource>
        </div>

        <%--inactif--%>
        <div class="form-group monCheckbox">
            <table>
                <tr>
                    <%--CHECKBOX INACTIF OU ACTIF--%>
                    <td>
                        <label class="switch">
                            <asp:CheckBox ID="Chkbx_Inactif" runat="server" />
                            <span class="slider round"></span>
                        </label>
                    </td>
                    <td>
                        <h5>Inactif</h5>
                    </td>
                </tr>
            </table>
        </div>

        <%--btn--%>
        <asp:Button CssClass="btn btn-raised btn-success" ID="Btn_Enregistrer" runat="server" Text="Enregistrer" OnClick="Btn_Enregistrer_Click" />
        <asp:Button type="button" CssClass="btn btn-raised btn-danger" ID="btn_annuler" runat="server" Text="Annuler" OnClick="btn_annuler_Click" />

    </form>
</asp:Content>
