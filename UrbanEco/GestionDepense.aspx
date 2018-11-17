<%@ Page Title="" Language="C#" EnableEventValidation="false" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="GestionDepense.aspx.cs" Inherits="UrbanEco.ApprobationDepense" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TitlePlaceHolder" runat="server">
    <h1>Gestion des dépenses</h1>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlaceHolder" runat="server">

    <form runat="server" style="text-align: center;" class="container center col-12">

        <%--CODE REPEATER D'EMPLOYÉ--%>
        <asp:Repeater ID="Rptr_Emploe" runat="server" DataSourceID="LinqEmploye">

            <%--HEADERTEMPLATE--%>
            <HeaderTemplate>
                <div class="table-responsive">
                    <table class="table">
                        <thead class="thead-dark">
                            <tr style="border-bottom: 5px solid #23282e">
                                <th scope="col">Employé</th>
                                <th scope="col">Type de dépense</th>
                                <th scope="col">Projet</th>
                                <th scope="col">Sous-Catégorie</th>
                                <th scope="col">Montant</th>
                                <th scope="col">
                                    <asp:Button ID="btn_ajouter" runat="server" OnClick="btn_ajouter_Click1" Text="Ajouter une dépense" CssClass="btn btn-lg btn-success" />
                                </th>
                            </tr>
                        </thead>
                        <tbody>
            </HeaderTemplate>

            <%--ITEMTEMPLATE--%>
            <ItemTemplate>
                <tr style="border-bottom: 1px solid #23282e" class="table-secondary">
                    <td>
                        <asp:Label ID="lbl_ID" runat="server" Text='<%# String.Format("{0} {1}", Eval("prenom"), Eval("nom")) %>' Font-Bold="true" />
                    </td>
                    <%--Ajustement pour le gris se rende au bout--%>
                    <td />
                    <td />
                    <td />
                    <td />
                    <td />
                </tr>

                <%--CODE SECOND REPEATER DE DÉPENSE--%>
                <asp:Repeater ID="Rptr_FeuilleTemps" runat="server" OnLoad="Rptr_Depense_Load" DataSource='<%#Eval("tbl_Depense") %>'>
                    <%--ITEMTEMPLATE--%>
                    <ItemTemplate>
                        <tr style="border-bottom: 1px solid #23282e" visible='<%# !Boolean.Parse(Eval("approuver").ToString())%>' runat="server">
                            <td></td>
                            <td>
                                <asp:Label ID="lbl_nomDep" runat="server" Text='<%#Eval("tbl_TypeDepense.nomDepense") %>' Font-Bold="true" />
                            </td>
                            <td>
                                <asp:Label ID="lbl_titre" runat="server" Text='<%#Eval("tbl_ProjetCat.tbl_Projet.titre") %>' Font-Bold="true" />
                            </td>
                            <td>
                                <asp:Label ID="lbl_cat" runat="server" Text='<%#Eval("tbl_ProjetCat.titre") %>' Font-Bold="true" />
                            </td>
                            <td>
                                <asp:Label ID="lbl_montant" runat="server" Text='<%#Eval("montant","{0:#.00 $}") %>' Font-Bold="true"></asp:Label>
                            </td>
                            <td>
                                <button id="Btn_Modif" cssclass="btn-sm btn btn-success" onclick="Btn_Modif_Click" runat="server" text="Modification" style="width: 50px; height: 50px;">
                                    <img src="Resources/Pencil.png" style="width: 100% !important; height: 100% !important;" />
                                </button>
                                <%--<asp:ImageButton CssClass="btn-option" ID="Btn_Modif" runat="server" src="Resources/Pencil.png" Style="margin-right: 10px;" OnClick="Btn_Modif_Click1" CommandArgument='<%# Eval("idDepense")%>' />--%>
                                <%--<asp:ImageButton CssClass="btn-option" ID="Btn_Approve" runat="server" src="Resources/checkmark.png" OnClick="Btn_Approve_Click1" CommandArgument='<%# Eval("idDepense")%>' />--%>
                                <asp:Button ID="Btn_Approve" CssClass="btn btn-sm btn-primary" runat="server" OnClick="Btn_Approve_Click" Text="Approuver" CommandArgument='<%#Eval("idDepense") %>' />
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
                </tr>
            </ItemTemplate>

            <%--FOOTERTEMPLATE--%>
            <FooterTemplate>
                </tbody>
                        <thead class="thead-dark">
                            <tr style="border-bottom: 5px solid #23282e">
                                <th scope="col">Employé</th>
                                <th scope="col">Type de dépense</th>
                                <th scope="col">Projet</th>
                                <th scope="col">Sous-Catégorie</th>
                                <th scope="col">Montant</th>
                                <th scope="col">
                                    <asp:Button ID="btn_ajouter" runat="server" OnClick="btn_ajouter_Click1" Text="Ajouter une dépense" CssClass="btn btn-lg btn-success" />
                                </th>
                            </tr>
                        </thead>
                </table>
                </div>
            </FooterTemplate>
        </asp:Repeater>

        <%--DATASOURCE--%>
        <asp:LinqDataSource ID="LinqEmploye" runat="server" ContextTypeName="UrbanEco.CoecoDataContext" EntityTypeName="" TableName="tbl_Employe" />
    </form>
</asp:Content>
