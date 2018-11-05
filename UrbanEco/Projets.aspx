<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="Projets.aspx.cs" Inherits="UrbanEco.Projets" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .center {
            margin: auto;
            width: 50%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TitlePlaceholder" runat="server">
    Ajouter un projet
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlaceHolder" runat="server">



    <form runat="server" class="center" style="text-align: center;">
        <div style="border: 3px solid green; padding: 5px 5px 5px 5px;">
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
                        <asp:TextBox ID="Tbx_Titre" runat="server"></asp:TextBox>
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
                        <asp:TextBox ID="Tbx_Description" runat="server"></asp:TextBox>
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
                        <asp:DropDownList ID="Ddl_Responsable" runat="server" DataSourceID="LinqEmployes" DataTextField="nom" DataValueField="idEmploye"></asp:DropDownList>
                        <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqEmployes" ContextTypeName="UrbanEco.CoecoDataContext" Select="new (prenom, nom, idEmploye)" TableName="tbl_Employe"></asp:LinqDataSource>
                    </td>
                </tr>

                <%--STATUS--%>
                <tr>
                    <th>
                        <h5 style="padding-right: 200px;">Status</h5>
                    </th>
                </tr>
                <tr>
                    <td>
                        <asp:DropDownList ID="Ddl_Status" runat="server" DataSourceID="LinqStatus" DataTextField="nomStatus" DataValueField="idStatus"></asp:DropDownList>
                        <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqStatus" ContextTypeName="UrbanEco.CoecoDataContext" Select="new (nomStatus, idStatus)" TableName="tbl_Status" OrderBy="idStatus"></asp:LinqDataSource>
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
                        <asp:TextBox ID="Tbx_HeuresAlloues" runat="server"></asp:TextBox>
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
                        <asp:Calendar ID="Dtp_DateDebut" runat="server"></asp:Calendar>
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
                        <asp:Calendar ID="Dtp_DateFin" runat="server"></asp:Calendar>
                    </td>
                </tr>
            </table>


            <asp:Button ID="AddProject" runat="server" Text="Créer Projet" OnClick="AddProject_Click" />
        </div>
    </form>
</asp:Content>
