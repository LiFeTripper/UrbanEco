<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="Projets.aspx.cs" Inherits="UrbanEco.Projets" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
    
    <form runat="server">
        <%--TITRE DESCRIPTION RESPONSABLE--%>
        <table>
            <%--TITRE--%>
            <tr>
                <th>
                    <h5 style="padding-right: 200px;">Titre</h5>
                </th>
            </tr>
            <tr>
                <td>
                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                </td>
            </tr>
            <%--DESCRIPTION--%>
            <tr>
                <th>
                    <h5 style="padding-right: 200px;">Description</h5>
                </th>
            </tr>
            <tr>
                <td>
                    <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                </td>
            </tr>
            <%--RESPONSABLE--%>
            <tr>
                <th>
                    <h5 style="padding-right: 200px;">Responsable</h5>
                </th>
            </tr>
            <tr>
                <td>
                    <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                </td>
            </tr>
        </table>

        <%--HEURES DEBUT ET FIN--%>
                <table>
            <%--HEURES ALLOUÉ--%>
            <tr>
                <th>
                    <h5 style="padding-right: 200px;">Heures Allouées</h5>
                </th>
            </tr>
            <tr>
                <td>
                    <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
                </td>
            </tr>
            <%--DATE DEBUT--%>
            <tr>
                <th>
                    <h5 style="padding-right: 200px;">Date de début</h5>
                </th>
            </tr>
            <tr>
                <td>
                    <asp:Calendar ID="Calendar1" runat="server"></asp:Calendar>
                </td>
            </tr>
            <%--DATE FIN--%>
            <tr>
                <th>
                    <h5 style="padding-right: 200px;">Date de fin</h5>
                </th>
            </tr>
            <tr>
                <td>
                    <asp:Calendar ID="Calendar2" runat="server"></asp:Calendar>
                </td>
            </tr>
        </table>

         <%--CATEGORIES ARCHIVE ET EMPLOYÉS--%>
                <table>
            <%--CATÉGORIE--%>
            <tr>
                <th>
                    <h5 style="padding-right: 200px;">Catégories</h5>
                </th>
            </tr>
            <tr>
                <td>
                    <asp:ListBox ID="ListBox1" runat="server" DataSourceID="LinqCategorie" DataTextField="titre" DataValueField="titre"></asp:ListBox>
                <asp:LinqDataSource ID="LinqCategorie" runat="server" ContextTypeName="UrbanEco.CoecoDataContext" EntityTypeName="" Select="new (titre)" TableName="tbl_ProjetCat">
                </asp:LinqDataSource>
                <asp:LinqDataSource ID="LinqProjet" runat="server" ContextTypeName="UrbanEco.CoecoDataContext" EntityTypeName="" OrderBy="idCat" Select="new (titre)" TableName="tbl_ProjetCat">
                </asp:LinqDataSource>
                </td>
            </tr>
            <%--ARCHIVE--%>
            <tr>
                <th>
                    <h5 style="padding-right: 200px;">Archive</h5>
                </th>
            </tr>
            <tr>
                <td>
                    <asp:CheckBox ID="CheckBox1" runat="server" />
                </td>
            </tr>
            <%--EMPLOYÉS--%>
            <tr>
                <th>
                    <h5 style="padding-right: 200px;">Employés associés</h5>
                </th>
            </tr>
            <tr>
                <td>
                    <asp:ListBox ID="ListBox2" runat="server" DataSourceID="LinqEmploye" DataTextField="prenom" DataValueField="prenom"></asp:ListBox>
                <asp:LinqDataSource ID="LinqEmploye" runat="server" ContextTypeName="UrbanEco.CoecoDataContext" EntityTypeName="" OrderBy="nom" Select="new (prenom, nom)" TableName="tbl_Employe">
                </asp:LinqDataSource>
                </td>
            </tr>
        </table>

    </form>
</asp:Content>
