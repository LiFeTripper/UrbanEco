<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="True" CodeBehind="AjoutCategorie.aspx.cs" Inherits="UrbanEco.AjoutCategorie" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
    .btn-option {
        height: 30px !important;
        width: 30px !important;
    }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="TitlePlaceHolder" runat="server">
    <h1 runat="server" id="lbl_nomProjet"></h1>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlaceHolder" runat="server">

    <form runat="server" style="text-align: center;" class="container center col-12">

        <asp:Label runat="server" Visible="false" ID="lbl_noProjet"></asp:Label>
        <%--CODE REPEATER DE PROJETS ACTIF--%>
        <asp:Repeater ID="Rptr_Categorie" runat="server">

            <%--HEADERTEMPLATE--%>
            <HeaderTemplate>
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr  runat="server">
                                <%--<th scope="col">ID</th>--%>
                                <th scope="col">Sous-Projet Niveau 1</th>
                                <th scope="col">Sous-Projet Niveau 2</th>
                                <th scope="col">Description</th>
                                <th scope="col">
                                    <asp:Button class="btn btn-raised btn-success" ID="Btn_AjoutSousProjet" runat="server" Text="Ajout Sous-Projet N1" OnClick="Btn_AjoutSousProjet_Click" />
                                </th>
                            </tr>
                        </thead>

                        <tbody>
            </HeaderTemplate>

            <%--ITEMTEMPLATE--%>
            <ItemTemplate>

                <%--LIGNE DU REPEATER--%>
                <tr  class="table-SousCategorie" runat="server">
                    <td>
                        <asp:Label ID="lbl_Titre" runat="server" Text='<%#Eval("titre") %>' />
                    </td>
                    <td>
                        <%--TD VIDE CAR PAS UNE SOUS-CATÉGORIE--%>
                    </td>
                    <td>
                        <asp:Label ID="lbl_Description" runat="server" Text='<%#Eval("description") %>'  />
                    </td>
                    <%--BOUTON AJOUT SOUS-CAT POUR CETTE CATEGORIE--%>
                    <td>
                        <asp:ImageButton CssClass="btn-option" ID="Btn_ModifSousProjet" runat="server" src="Resources/Pencil.png" Style="margin-right: 10px;" OnClick="Btn_ModifSousProjet_Click_1" CommandArgument='<%# Eval("idProjetCat")%>' />
                        <asp:ImageButton CssClass="btn-option" ID="Btn_AjoutSSProjet" runat="server" src="Resources/folder_open.png" Style="margin-right: 10px;" OnClick="Btn_AjoutSSProjet_Click" CommandArgument='<%#Eval("idProjetCat") %>'/>
                    </td>
                </tr>

                <asp:Repeater ID="Rptr_SousCat" runat="server" DataSource='<%#Eval("tbl_ProjetCat2") %>'>
                    <ItemTemplate>
                        <tr runat="server">
                            <td>
                                <%--TD VIDE CAR PAS UNE CATÉGORIE--%>
                            </td>
                            <td>
                                <asp:Label ID="lbl_Titre" runat="server" Text='<%#Eval("titre") %>'/>
                            </td>
                            <td>
                                <asp:Label ID="lbl_Description" runat="server" Text='<%#Eval("description") %>'/>
                            </td>
                            <%--BOUTON AJOUT D'EMPLOYÉ DANS SOUS-CATÉGORIE--%>
                            <td>
                                <asp:ImageButton CssClass="btn-option" ID="Btn_ModifSousProjet" runat="server" src="Resources/Pencil.png" Style="margin-right: 10px;" OnClick="Btn_ModifSousProjet_Click" CommandArgument='<%# Eval("idProjetCat")%>' />
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </ItemTemplate>

            <%--FOOTERTEMPLATE--%>
            <FooterTemplate>
                </tbody>
                <thead>
                    <tr class="t_footer" runat="server">
                        <%--<th scope="col">ID</th>--%>
                        <th scope="col">Sous-Projet Niveau 1</th>
                        <th scope="col">Sous-Projet Niveau 2</th>
                        <th scope="col">Description</th>
                        <th scope="col">
                            <asp:Button class="btn btn-raised btn-success" ID="Btn_AjoutSousProjet" runat="server" Text="Ajout Sous-Projet N1" OnClick="Btn_AjoutSousProjet_Click" />
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
</asp:Content>
