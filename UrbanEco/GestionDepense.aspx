<%@ Page Title="" Language="C#" EnableEventValidation="false" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="GestionDepense.aspx.cs" Inherits="UrbanEco.ApprobationDepense" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Co-Éco - Gestion des dépenses</title>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TitlePlaceHolder" runat="server">
    
    <style>
        .btn-option {
            height: 30px !important;
            width: 30px !important;
        }
    </style>
    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlaceHolder" runat="server">

    <form runat="server" style="text-align: center;" class="container center col-12">
        <%--CODE REPEATER D'EMPLOYÉ--%>
        <asp:Repeater ID="Rptr_Emploe" runat="server">

            <%--HEADERTEMPLATE--%>
            <HeaderTemplate>
                <div class="table-responsive">
                    <table class="table">
                        <thead class="">
                            <tr>
                                <th scope="col">Employé</th>
                                <th scope="col">Type de dépense</th>
                                <th scope="col">Projet</th>
                                <th scope="col">Sous-Catégorie</th>
                                <th scope="col">Montant</th>
                                <th scope="col">
                                    <asp:Button ID="btn_ajouter" runat="server" OnClick="btn_ajouter_Click1" Text="Ajouter une dépense" CssClass="btn btn-raised btn-success" />
                                </th>
                            </tr>
                        </thead>
                        <tbody>
            </HeaderTemplate>

            <%--ITEMTEMPLATE--%>
            <ItemTemplate>
                <tr class="table-SousCategorie">
                    <td>
                        <asp:Label ID="lbl_ID" runat="server" Text='<%# String.Format("{0} {1}", Eval("prenom"), Eval("nom")) %>' />
                    </td>
                    <%--Ajustement pour le gris se rende au bout--%>
                    <td />
                    <td />
                    <td />
                    <td />
                    <td>
                        <asp:Button ID="btn_approverEmploye" CssClass="btn btn-raised btn-primary" Visible='<%# IsAdmin() %>' runat="server" Text="Approuver l'employé" OnClick="btn_approverEmploye_Click" CommandArgument='<%#Eval("idEmploye") %>'/>
                    </td>
                </tr>

                <%--CODE SECOND REPEATER DE DÉPENSE--%>
                <asp:Repeater ID="Rptr_FeuilleTemps" runat="server" OnLoad="Rptr_Depense_Load" DataSource='<%#Eval("tbl_Depense") %>'>
                    <%--ITEMTEMPLATE--%>
                    <ItemTemplate>
                        <tr  visible='<%# !Boolean.Parse(Eval("approuver").ToString())%>' runat="server">
                            <td></td>
                            <td>
                                <asp:Label ID="lbl_nomDep" runat="server" Text='<%#Eval("typeDepense") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lbl_titre" runat="server" Text='<%#Eval("tbl_ProjetCat.tbl_Projet.titre") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lbl_cat" runat="server" Text='<%#Eval("tbl_ProjetCat.titre") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lbl_montant" runat="server" Text='<%#Eval("montant","{0:#.00 $}") %>' ></asp:Label>
                            </td>
                            <td>

                                <asp:ImageButton CssClass="btn-option" ID="Btn_Modif" runat="server" src="Resources/Pencil.png" Style="margin-right: 10px;" OnClick="Btn_Modif_Click" CommandArgument='<%# Eval("idDepense")%>' />
                                <asp:ImageButton CssClass="btn-option" Visible='<%# IsAdmin() %>' ID="Btn_Approve" runat="server" src="Resources/checkmark.png" OnClick="Btn_Approve_Click" CommandArgument='<%# Eval("idDepense")%>' />
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
                </tr>
            </ItemTemplate>

            <%--FOOTERTEMPLATE--%>
            <FooterTemplate>
                </tbody>
                        <thead>
                            <tr class="t_footer">
                                <th scope="col">Employé</th>
                                <th scope="col">Type de dépense</th>
                                <th scope="col">Projet</th>
                                <th scope="col">Sous-Catégorie</th>
                                <th scope="col">Montant</th>
                                <th scope="col">
                                    <asp:Button ID="btn_ajouter" runat="server" OnClick="btn_ajouter_Click1" Text="Ajouter une dépense" CssClass="btn btn-raised btn-success" />
                                </th>
                            </tr>
                        </thead>
                </table>
                </div>
            </FooterTemplate>
        </asp:Repeater>

        <%--DATASOURCE--%>
        <%--<asp:LinqDataSource ID="LinqEmploye" runat="server" ContextTypeName="UrbanEco.CoecoDataContext" EntityTypeName="" TableName="tbl_Employe" OrderBy="prenom, nom" />--%>
    </form>
</asp:Content>
