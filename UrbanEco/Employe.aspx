<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="Employe.aspx.cs" Inherits="UrbanEco.Employe" %>

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
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlaceHolder" runat="server">

    <form runat="server" style="text-align: center;" class="container center col-12">

        <%--BORDURE VERTE--%>
        <div style="border: 3px solid green; padding: 5px 5px 5px 5px;">
            <table style="width: 100% !important;">
                        <%--EN TËTE A MARC--%>
                        <h1>Employés</h1>
                        <hr style="border-bottom: 20px solid #23282e; width: 100%;" />
                <tr>
            <asp:Label runat="server" Text="INACTIF"></asp:Label>
            <asp:CheckBox ID="Chkbx_Inactif" runat="server" OnCheckedChanged="Chkbx_Inactif_CheckedChanged" AutoPostBack="true"/>
                </tr>
                    </table>
            <%--CODE REPEATER DE PROJETS--%>
            <asp:Repeater ID="Rptr_TypeEmploye" runat="server" DataSourceID="LinqEmploye">

                <%--HEADERTEMPLATE--%>
                <HeaderTemplate>
                    <table style="width: 100% !important;">
                        <tr style="border-bottom: 5px solid #23282e">
                            <th>Type Employé</th>
                            <th>ID</th>
                            <th>Nom</th>
                            <th>Prénom</th>
                            <th>Numéro Téléphone</th>
                        </tr>
                </HeaderTemplate>

                <%--ITEMTEMPLATE--%>
                <ItemTemplate>
                    <tr style="border-bottom: 1px solid #23282e">
                        <td>
                            <asp:Label ID="lbl_ID" runat="server" Text='<%#Eval("nomType") %>' Font-Bold="true" />
                        </td>
                    </tr>

                    <%--SECOND REPEATER AVEC LES USERS--%>
                    <%--REPEATER DES ACTIF--%>
                    <asp:Repeater ID="Rptr_EmployeActif" runat="server" DataSource='<%#Eval("tbl_Employe") %>'>
                        <ItemTemplate>
                            <tr Visible='<%# (!Boolean.Parse(Eval("inactif").ToString()) && !Chkbx_Inactif.Checked) %>' runat="server">
                                <td></td>
                                <td>
                                    <asp:Label ID="lbl_idEmploye" runat="server" Text='<%#Eval("idEmploye") %>' Font-Bold="true" />
                                </td>
                                <td>
                                    <asp:Label ID="lbl_Nom" runat="server" Text='<%#Eval("nom") %>' Font-Bold="true" />
                                </td>
                                <td>
                                    <asp:Label ID="lbl_Prenom" runat="server" Text='<%#Eval("prenom") %>' Font-Bold="true" />
                                </td>
                                <td>
                                    <asp:Label ID="lbl_noTel" runat="server" Text='<%#Eval("noTel") %>' Font-Bold="true" />
                                </td>
                                <td>
                                    <asp:Button ID="Btn_Modif" CssClass="btn btn-md btn-primary" runat="server" Text="Modification" OnClick="Btn_Modif_Click" CommandArgument='<%#Eval("idEmploye") %>' />
                                </td>
                            </tr>
                            <%--TR VIDE POUR SÉPARÉ UN PEU LES SECTION--%>
                            </tr></tr>
                            <tr></tr>
                        </ItemTemplate>
                    </asp:Repeater>
                    <%--REPEATER DES INACTIF--%>
                    <asp:Repeater ID="Rptr_EmployeInactif" runat="server" DataSource='<%#Eval("tbl_Employe") %>'>
                        <ItemTemplate>
                            <tr Visible='<%# (Boolean.Parse(Eval("inactif").ToString()) && Chkbx_Inactif.Checked) %>' runat="server">
                                <td></td>
                                <td>
                                    <asp:Label ID="lbl_idEmploye" runat="server" Text='<%#Eval("idEmploye") %>' Font-Bold="true" />
                                </td>
                                <td>
                                    <asp:Label ID="lbl_Nom" runat="server" Text='<%#Eval("nom") %>' Font-Bold="true" />
                                </td>
                                <td>
                                    <asp:Label ID="lbl_Prenom" runat="server" Text='<%#Eval("prenom") %>' Font-Bold="true" />
                                </td>
                                <td>
                                    <asp:Label ID="lbl_noTel" runat="server" Text='<%#Eval("noTel") %>' Font-Bold="true" />
                                </td>
                                <td>
                                    <asp:Button ID="Btn_Modif" CssClass="btn btn-md btn-primary" runat="server" Text="Modification" OnClick="Btn_Modif_Click" CommandArgument='<%#Eval("idEmploye") %>' />
                                </td>
                            </tr>
                            <%--TR VIDE POUR SÉPARÉ UN PEU LES SECTION--%>
                            </tr></tr>
                            <tr></tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </ItemTemplate>

                <%--FOOTERTEMPLATE--%>
                <FooterTemplate>
                    <tr style="border-top: 5px solid #23282e">
                        <th>Type Employé</th>
                        <th>ID</th>
                        <th>Nom</th>
                        <th>Prénom</th>
                        <th>Numéro Téléphone</th>
                    </tr>
                    </table>
                </FooterTemplate>
            </asp:Repeater>

            <%--DATA SOURCE--%>
            <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqEmploye" ContextTypeName="UrbanEco.CoecoDataContext" TableName="tbl_TypeEmploye"></asp:LinqDataSource>
        </div>
    </form>
</asp:Content>
