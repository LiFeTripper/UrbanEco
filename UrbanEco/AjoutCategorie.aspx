﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="True" CodeBehind="AjoutCategorie.aspx.cs" Inherits="UrbanEco.AjoutCategorie" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="TitlePlaceHolder" runat="server">
    <h1>Catégorie</h1>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlaceHolder" runat="server">

    <form runat="server" style="text-align: center;" class="container center col-12">

        <asp:Label runat="server" Visible="true" ID="lbl_noProjet"></asp:Label>
        <%--CODE REPEATER DE PROJETS ACTIF--%>
        <asp:Repeater ID="Rptr_Categorie" runat="server">

            <%--HEADERTEMPLATE--%>
            <HeaderTemplate>
                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead class="thead-dark">
                            <tr style="border-bottom: 5px solid #23282e" runat="server">
                                <th scope="col">ID</th>
                                <th scope="col">Titre</th>
                                <th scope="col">Description</th>
                                <th scope="col">
                                    <asp:Button ID="Btn_AjoutCat" CssClass="btn btn-md btn-secondary" runat="server" Text="Nouveau" />
                                </th>
                            </tr>
                        </thead>
                        <tbody>
            </HeaderTemplate>

            <%--ITEMTEMPLATE--%>
            <ItemTemplate>
                <tr style="border-bottom: 1px solid #23282e" runat="server">
                    <td>
                        <asp:Label ID="lbl_ID" runat="server" Text='<%#Eval("idProjetCat") %>' Font-Bold="true" />
                    </td>
                    <td>
                        <asp:Label ID="lbl_Titre" runat="server" Text='<%#Eval("titre") %>' Font-Bold="true" />
                    </td>
                    <td>
                        <asp:Label ID="lbl_Description" runat="server" Text='<%#Eval("description") %>' Font-Bold="true" />
                    </td>
                    <%--BOUTON AJOUT SOUS-CAT POUR CETTE CATEGORIE--%>
                    <td>
                        <asp:Button ID="Btn_AjoutSousCat" CssClass="btn btn-md btn-secondary" runat="server" Text="Nouveau" CommandArgument='<%#Eval("idProjetCat") %>' OnClientClick="Send(); return false;" />
                        <asp:HiddenField ID="HiddenField_Titre" runat="server" />
                        <asp:HiddenField ID="HiddenField_Desc" runat="server" />
                    </td>
                </tr>
            </ItemTemplate>

            <%--FOOTERTEMPLATE--%>
            <FooterTemplate>
                </tbody>
                <thead class="thead-dark">
                    <tr style="border-bottom: 5px solid #23282e" runat="server">
                        <th scope="col">ID</th>
                        <th scope="col">Titre</th>
                        <th scope="col">Description</th>
                        <th scope="col">
                            <asp:Button ID="Btn_Ajout" CssClass="btn btn-md btn-secondary" runat="server" Text="Nouveau" />
                        </th>
                    </tr>
                </thead>
                </table>
                    </div>
            </FooterTemplate>
        </asp:Repeater>

        <%--DATASOURCE--%>
        <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqProjetsCat" ContextTypeName="UrbanEco.CoecoDataContext" TableName="tbl_ProjetCat">
        </asp:LinqDataSource>
    </form>


    <%--FONCTION JAVASCRIPT DU BOOTBOX--%>
    <script>
        function Send() {
            bootbox.dialog({
                title: 'Nouvelle Catégorie pour ce projet',
                message: "<p>Veuillez entrez les informations de la nouvelle catégorie :</p>" +

                    "<p><label for='Tbx_AjoutCat1'>Nom de la catégorie :</label></p>" +
                    "<p><input type='text' id='Tbx_AjoutCat1'/></p>" +
                    "<p><label for='Tbx_AjoutCatDesc1'>Description de la catégorie :</label></p>" +
                    "<p><input type='text' id='Tbx_AjoutCatDesc1'/></p>",

                buttons: {
                    ok: {
                        label: "Ajouter",
                        className: 'btn-info',
                        callback: function () {

                            var cat = document.getElementById('Tbx_AjoutCat1');
                            var desc = document.getElementById('Tbx_AjoutCatDesc1');

                            var categorie = cat.value;
                            var description = desc.value;

                            document.getElementById('HiddenField_Titre').textContent = categorie;
                            document.getElementById('HiddenField_Desc').textContent = description;
                            document.getElementById('lbl_noProjet').value = categorie;
                            Btn_AjoutSousCat();
                        }
                    },
                    cancel: {
                        label: "Annuler",
                        className: 'btn-danger',
                        callback: function () {
                            Example.show('Pas de nouvelle catégorie ajoutée');
                        }
                    },
                }
            });
        }
    </script>
</asp:Content>