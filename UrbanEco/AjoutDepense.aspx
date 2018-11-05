<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="AjoutDepense.aspx.cs" Inherits="UrbanEco.AjoutDepense" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
       <style>
           .center {
                margin: auto;
                width: 50%;
            }
       </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TitlePlaceholder" runat="server">
    Ajouter une dépense
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
    <form runat="server" style="text-align:center;" class="center">
        <div>
            <table>
                <tr>
                    <th>
                        <h3>Projet associé</h3>
                    </th>
                </tr>
                <tr>
                    <th>
                        <h5 style="padding-right: 320px;">Nom du projet</h5>
                    </th>
                </tr>
                <tr>
                    <td>

                        <asp:DropDownList Style="width: 100% !important; font-size: 17px; margin-bottom: 30px;" name="idProjet" ID="DropDownList1" runat="server" DataSourceID="LinqProjet" DataTextField="titre" DataValueField="titre">
                        </asp:DropDownList>
                        <asp:LinqDataSource ID="LinqProjet" runat="server" ContextTypeName="UrbanEco.CoecoDataContext" EntityTypeName="" OrderBy="titre" Select="new (titre)" TableName="tbl_Projet">
                        </asp:LinqDataSource>

                    </td>
                </tr>

                <tr>
                    <th>
                        <h5 style="padding-right: 320px;">Sous-Catégorie</h5>
                    </th>
                </tr>
                <tr>
                    <td>

                        <asp:DropDownList Style="width: 100% !important; font-size: 17px; margin-bottom: 30px;" ID="DropDownList2" runat="server" DataSourceID="LinqSouscatego" DataTextField="titre" DataValueField="titre">
                        </asp:DropDownList>
                        <asp:LinqDataSource ID="LinqSouscatego" runat="server" ContextTypeName="UrbanEco.CoecoDataContext" EntityTypeName="" OrderBy="titre" Select="new (titre)" TableName="tbl_ProjetCat" Where="idProjet == @idProjet">
                            <WhereParameters>
                                <asp:Parameter DefaultValue="1" Name="idProjet" Type="Int32" />
                            </WhereParameters>
                        </asp:LinqDataSource>

                    </td>
                </tr>

                <tr>
                    <th>
                        <h5 style="padding-right: 320px;">Date</h5>
                    </th>
                </tr>
                <tr>
                    <td>

                        <asp:Calendar ID="Calendar1" runat="server" Style="margin: auto;"></asp:Calendar>

                    </td>
                </tr>
            </table>
        </div>
        <div>

            <table>
                <tr>
                    <th>
                        <h3>Information sur la dépense</h3>
                    </th>
                </tr>
                <tr>
                    <th>
                        <h5 style="padding-right: 320px;">Nom du projet</h5>
                    </th>
                </tr>
                <tr>
                    <td></td>
                </tr>

                <tr>
                    <th>
                        <h5 style="padding-right: 320px;">Sous-Catégorie</h5>
                    </th>
                </tr>
                <tr>
                    <td></td>
                </tr>
            </table>
        </div>
    </form>
</asp:Content>
