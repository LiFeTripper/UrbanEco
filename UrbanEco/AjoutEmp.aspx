﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="AjoutEmp.aspx.cs" Inherits="UrbanEco.AjoutEmp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

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
            <label for="Tbx_Prenom">Prénom</label>
            <asp:TextBox ID="Tbx_Prenom" runat="server" class="form-control"></asp:TextBox>
        </div>
        <%--NOM--%>
        <div class="form-group mb-4 col-6 mx-auto">
            <label for="Tbx_Nom">Nom</label>
            <asp:TextBox ID="Tbx_Nom" runat="server" class="form-control"></asp:TextBox>
        </div>
        <%--TYPE--%>
        <div class="form-group mb-4 col-6 mx-auto">
            <label for="Ddl_TypeEmp">Type d'employé</label>
            <asp:DropDownList ID="Ddl_TypeEmp" runat="server" DataSourceID="LinqTypeEmp" DataTextField="nomType" DataValueField="idType" class="form-control"></asp:DropDownList>
            <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqTypeEmp" ContextTypeName="UrbanEco.CoecoDataContext" TableName="tbl_TypeEmploye"></asp:LinqDataSource>
        </div>
        <%--NOTEL--%>
        <div class="form-group mb-4 col-6 mx-auto">
            <label for="Tbx_noTel">Numéro de téléphone</label>
            <asp:TextBox ID="Tbx_noTel" runat="server" class="form-control"></asp:TextBox>
        </div>
        <%--EMAIL--%>
        <div class="form-group mb-4 col-6 mx-auto">
            <label for="Tbx_email">Adresse Courriel</label>
            <asp:TextBox ID="Tbx_email" runat="server" class="form-control"></asp:TextBox>
        </div>
        <%--INACTIF--%>
        <div class="form-group mb-4 col-6 mx-auto">
            <label for="Chkbx_Inactif">Inactif</label>
            <asp:CheckBox ID="Chkbx_Inactif" runat="server" class="form-control" />
        </div>
        <%--USER--%>
        <div class="form-group mb-4 col-6 mx-auto">
            <label for="Tbx_username">Nom d'utilisateur</label>
            <asp:TextBox ID="Tbx_username" runat="server" class="form-control"></asp:TextBox>
        </div>
        <%--PASSWORD--%>
        <div class="form-group mb-4 col-6 mx-auto">
            <label for="Tbx_password">Mot de passe</label>
            <asp:TextBox ID="Tbx_password" runat="server" class="form-control"></asp:TextBox>
        </div>
        <%--BOUTON--%>
        <div class="form-group mb-4 col-6 mx-auto">
            <asp:Button CssClass="btn btn-lg btn-success" ID="Btn_Enregistrer" runat="server" Text="Enregistrer" OnClick="Btn_Enregistrer_Click" />
        </div>
    </form>
</asp:Content>

 <%--<form runat="server" style="text-align: center;" class="container center col-12">
        <div style="border: 3px solid green; padding: 5px 5px 5px 5px;">

            <div>
                <h1>
                <asp:Label ID="lbl_Top" runat="server" Text="Label"></asp:Label>
                </h1>
                <hr style="border: 20px solid #23282e; width: 100% !important; margin: 0px 0px 0px 0px; padding: 0px 0px 0px 0px" />
            </div>

            <div class="row justify-content-md-center" style="margin-bottom: 100px;">
                <div class="col-md-offset-3 col-6">--%>
                    <%--PRENOM NOM TYPE EMPLOYE--%>
                    <%--<table style="width: 100% !important;">
                        <%--PRENOM--%>
                        <%--<tr>
                            <th>
                                <h5 class="input-title">Prenom</h5>
                            </th>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="Tbx_Prenom" runat="server" class="input-box"></asp:TextBox>
                            </td>
                        </tr>--%>
                        <%--NOM--%>
                        <%--<tr>
                            <th>
                                <h5 class="input-title">Nom</h5>
                            </th>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="Tbx_Nom" runat="server" class="input-box"></asp:TextBox>
                            </td>
                        </tr>--%>
                        <%--TYPE EMPLOYE--%>
                        <%--<tr>
                            <th>
                                <h5 class="input-title">Type d'Employé</h5>
                            </th>
                        </tr>
                        <tr>
                            <td>
                                <asp:DropDownList ID="Ddl_TypeEmp" runat="server" DataSourceID="LinqTypeEmp" DataTextField="nomType" DataValueField="idType" class="input-box"></asp:DropDownList>
                                <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqTypeEmp" ContextTypeName="UrbanEco.CoecoDataContext" TableName="tbl_TypeEmploye"></asp:LinqDataSource>
                            </td>
                        </tr>
                        </table>--%>

                        <%--NO TEL ET EMAIL--%>
<%--                    <table style="width: 100% !important;">--%>
                        <%--NO TEL--%>
<%--                        <tr>
                            <th>
                                <h5 class="input-title">Numéro de téléphone</h5>
                            </th>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="Tbx_noTel" runat="server" class="input-box"></asp:TextBox>
                            </td>
                        </tr>--%>
                        <%--EMAIL--%>
<%--                        <tr>
                            <th>
                                <h5 class="input-title">Email</h5>
                            </th>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="Tbx_email" runat="server" class="input-box"></asp:TextBox>
                            </td>
                        </tr>
                    </table>--%>

                    <%--USERNAME ET PASSWORD--%>
<%--                    <table style="width: 100% !important;">--%>
                        <%--USERNAME--%>
<%--                        <tr>
                            <th>
                                <h5 class="input-title">Nom d'utilisateur</h5>
                            </th>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="Tbx_username" runat="server" class="input-box"  ></asp:TextBox>
                            </td>
                        </tr>--%>
                        <%--PASSWORD--%>
<%--                        <tr>
                            <th>
                                <h5 class="input-title">Adresse Courriel</h5>
                            </th>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="Tbx_password" runat="server" class="input-box"  ></asp:TextBox>
                            </td>
                        </tr>--%>
                        <%--ACTIF/INACTIF--%>
<%--                        <tr>
                            <th>
                                <h5 class="input-title">Inactif</h5>
                            </th>
                        </tr>
                        <tr>
                            <td>
                                <asp:CheckBox ID="Chkbx_Inactif" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <asp:Button ID="Btn_Enregistrer" runat="server" Text="Enregistrer"  OnClick="Btn_Enregistrer_Click" />
                </div>
            </div>
        </div>
    </form>--%>