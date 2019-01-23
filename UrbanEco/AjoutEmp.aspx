<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="AjoutEmp.aspx.cs" Inherits="UrbanEco.AjoutEmp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .asp-table {
            table-layout: fixed;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="TitlePlaceHolder" runat="server">
    <h1>
        <asp:Label ID="lbl_Top" runat="server" Text="Label"></asp:Label>
    </h1>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlaceHolder" runat="server">

    <form runat="server">
        <%--PRÉNOM--%>
        <div class="form-group mb-4 col-6 mx-auto">
            <asp:Table CssClass="asp-table" runat="server" Style="width: 100% !important;">
                <asp:TableRow>
                    <asp:TableHeaderCell CssClass="form-control">
                        Prénom <b style="color:red">*</b>
                    </asp:TableHeaderCell>
                    <asp:TableCell>
                        <asp:TextBox ID="Tbx_Prenom" runat="server" class="form-control" ></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>

        <%--NOM--%>
        <div class="form-group mb-4 col-6 mx-auto">
            <asp:Table CssClass="asp-table" runat="server" Style="width: 100% !important;">
                <asp:TableRow>
                    <asp:TableHeaderCell CssClass="form-control">
                        Nom <b style="color:red">*</b>
                    </asp:TableHeaderCell>
                    <asp:TableCell>
                        <asp:TextBox ID="Tbx_Nom" runat="server" class="form-control"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>

        <%--TYPE--%>
        <div class="form-group mb-4 col-6 mx-auto">
            <asp:Table CssClass="asp-table" runat="server" Style="width: 100% !important;">
                <asp:TableRow>
                    <asp:TableHeaderCell CssClass="form-control">
                        Type d'employé <b style="color:red">*</b>
                    </asp:TableHeaderCell>
                    <asp:TableCell>
                        <asp:DropDownList ID="Ddl_TypeEmp" runat="server" DataSourceID="LinqTypeEmp" DataTextField="nomType" DataValueField="idType" class="form-control"></asp:DropDownList>
                        <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqTypeEmp" ContextTypeName="UrbanEco.CoecoDataContext" TableName="tbl_TypeEmploye"></asp:LinqDataSource>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>

        <%--no tel--%>
        <%--<div class="form-group mb-4 col-6 mx-auto">
            <asp:Table CssClass="asp-table" runat="server" Style="width: 100% !important;">
                <asp:TableRow>
                    <asp:TableHeaderCell CssClass="form-control">
                        Numéro de téléphone
                    </asp:TableHeaderCell>
                    <asp:TableCell>
                        <asp:TextBox ID="Tbx_noTel" runat="server" class="form-control"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>--%>

        <%--email--%>
        <div class="form-group mb-4 col-6 mx-auto">
            <asp:Table CssClass="asp-table" runat="server" Style="width: 100% !important;">
                <asp:TableRow>
                    <asp:TableHeaderCell CssClass="form-control">
                        Adresse courriel
                    </asp:TableHeaderCell>
                    <asp:TableCell>
                        <asp:TextBox ID="Tbx_email" runat="server" class="form-control"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>


        <%--Username--%>
        <div class="form-group mb-4 col-6 mx-auto">
            <asp:Table CssClass="asp-table" runat="server" Style="width: 100% !important;">
                <asp:TableRow>
                    <asp:TableHeaderCell CssClass="form-control">
                        Nom d'utilisateur <b style="color:red">*</b>
                    </asp:TableHeaderCell>
                    <asp:TableCell>
                        <asp:TextBox ID="Tbx_username" runat="server" class="form-control" ></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>

        <%--password--%>
        <div class="form-group mb-4 col-6 mx-auto">
            <asp:Table CssClass="asp-table" runat="server" Style="width: 100% !important;">
                <asp:TableRow>
                    <asp:TableHeaderCell CssClass="form-control">
                        Mot de passe
                    </asp:TableHeaderCell>
                    <asp:TableCell>
                        <asp:TextBox ID="Tbx_password" runat="server" class="form-control"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>

        <%--inactif--%>
        <div class="form-group mb-4 col-6 mx-auto">
            <table style="width: 100% !important;">
                <tr class="mb-3">
                    <%--CHECKBOX INACTIF OU ACTIF--%>
                    <td style="width: 50%;">
                        <label class="switch" style="float: right;">
                            <asp:CheckBox ID="Chkbx_Inactif" runat="server" />
                            <span class="slider round"></span>
                        </label>
                    </td>
                    <td>
                        <h4 style="float: left;">Inactif</h4>
                    </td>
                </tr>
            </table>
        </div>

        <%--btn--%>
        <div class="form-group mb-4 col-6 mx-auto">
            <asp:Table CssClass="asp-table" runat="server" Style="width: 100% !important;">
                <asp:TableRow>
                    <asp:TableCell CssClass="col-md-4">
                        <asp:Button CssClass="btn btn-lg btn-danger" Style="width: 100%;" ID="btn_annuler" runat="server" Text="Annuler" OnClick="btn_annuler_Click" />
                    </asp:TableCell>
                    <asp:TableCell CssClass="col-md-4">
                            &nbsp;
                    </asp:TableCell>
                    <asp:TableCell CssClass="col-md-4">
                        <asp:Button CssClass="btn btn-lg btn-success" Style="width: 100%;" ID="Btn_Enregistrer" runat="server" Text="Enregistrer" OnClick="Btn_Enregistrer_Click" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>
    </form>
</asp:Content>
