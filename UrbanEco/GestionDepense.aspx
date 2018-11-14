<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="GestionDepense.aspx.cs" Inherits="UrbanEco.ApprobationDepense" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .center {
            margin: auto;
            width: 50%;
        }

        .input-box {
            width: 100% !important;
            font-size: 17px;
            margin-bottom: 30px;
        }

        .input-title {
            text-align: left !important;
        }

        .table-custom {
            width: 800px !important;
        }

        .table-custom > table {
            width: 100% !important;
        }

        .btn-option {
            height:30px !important;
            width: 30px !important;
        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
    <form runat="server" style="text-align: center;" class="container center col-12">
        <%--        <div>
            <h1>Gestion des dépenses
            </h1>
            <hr style="border: 20px solid #23282e; width: 100% !important; margin: 0px 0px 0px 0px; padding: 0px 0px 0px 0px" />
        </div>--%>
        <%--CODE REPEATER DE PROJETS--%>
        <asp:Repeater ID="Rptr_Emploe" runat="server" DataSourceID="LinqEmploye">

            <%--HEADERTEMPLATE--%>
            <HeaderTemplate>
                <table style="width: 100% !important; text-align: left !important;">

                    <%--EN TËTE A MARC--%>
                    <h1>Gestion des dépenses</h1>
                    <hr style="border-bottom: 20px solid #23282e; width: 100%;" />

                    <tr style="border-bottom: 5px solid #23282e">
                        <th>Employé</th>
                        <th>Type de dépense</th>
                        <th>Projet</th>
                        <th>Sous-Catégorie</th>
                        <th>Montant</th>
                        <th>&nbsp;</th>
                    </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <asp:Label ID="lbl_ID" runat="server" Text='<%# String.Format("{0} {1}", Eval("prenom"), Eval("nom")) %>' Font-Bold="true" /></td>
                </tr>
                <tr>
                    <asp:Repeater ID="Rptr_FeuilleTemps" runat="server" DataSource='<%# Eval("tbl_Depense")%>'>
                        <%--ITEMTEMPLATE--%>
                        <ItemTemplate>
                            <tr style="border-bottom: 1px solid #23282e">
                                <td></td>
                                <td>
                                    <asp:Label ID="lbl_Date" runat="server" Text='<%#Eval("tbl_TypeDepense.nomDepense") %>' Font-Bold="true" />
                                </td>
                                <td>
                                    <asp:Label ID="lbl_Duree" runat="server" Text='<%#Eval("tbl_ProjetCat.tbl_Projet.titre") %>' Font-Bold="true" />
                                </td>
                                <td>
                                    <asp:Label ID="lbl_Projet" runat="server" Text='<%#Eval("tbl_ProjetCat.titre") %>' Font-Bold="true" />
                                </td>
                                <td>
                                    <asp:Label ID="lbl_Note" runat="server" Text='<%#Eval("montant","{0:#.00 $}") %>' Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: right !important;">
                                    <%--<button ID="Btn_Modif" CssClass="btn-sm btn btn-success" OnClick="Btn_Modif_Click" runat="server" Text="Modification" style="width:50px; height:50px;"><img src="Resources/Pencil.png" style="width:100% !important; height:100% !important;"/></button>--%>
                                    <asp:ImageButton CssClass="btn-option" ID="Btn_Modif" runat="server" src="Resources/Pencil.png"  style="margin-right:10px;" OnClick="Btn_Modif_Click1" CommandArgument='<%# Eval("idDepense")%>'/>
                                    <asp:ImageButton CssClass="btn-option" ID="Btn_Approve" runat="server" src="Resources/checkmark.png" OnClick="Btn_Approve_Click1" CommandArgument='<%# Eval("idDepense")%>'/>
                                    <%--<asp:Button ID="Btn_Approve" CssClass="btn btn-sm btn-primary" runat="server" OnClick="Btn_Approve_Click" Text="Approuver" CommandArgument='<%#Eval("idDepense") %>' />--%>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tr>

            </ItemTemplate>

            <%--FOOTERTEMPLATE--%>
            <FooterTemplate>

                <tr style="border-top: 5px solid #23282e">
                    <th>Employé</th>
                    <th>Type de dépense</th>
                    <th>Projet</th>
                    <th>Sous-Catégorie</th>
                    <th>Montant</th>
                    <th>&nbsp;</th>
                </tr>
                </table>
            </FooterTemplate>
        </asp:Repeater>



        <asp:LinqDataSource ID="LinqEmploye" runat="server" ContextTypeName="UrbanEco.CoecoDataContext" EntityTypeName="" TableName="tbl_Employe">
        </asp:LinqDataSource>



    </form>

</asp:Content>
