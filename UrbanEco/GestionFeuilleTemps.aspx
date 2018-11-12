<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="GestionFeuilleTemps.aspx.cs" Inherits="UrbanEco.GestionFeuilleTemps" %>

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



        <%--CODE REPEATER DE PROJETS--%>
        <asp:Repeater ID="Rptr_Emploe"  DataSourceID="LinqProjets" runat="server">

            <%--HEADERTEMPLATE--%>
            <HeaderTemplate>
                <table style="width: 100% !important; text-align:left !important;">

                    <%--EN TËTE A MARC--%>
                    <h1>Projets</h1>
                    <hr style="border-bottom: 20px solid #23282e; width: 100%;" />

                    <tr style="border-bottom: 5px solid #23282e">
                        <th>Employé</th>
                        <th>Date</th>
                        <th>Durée (h)</th>
                        <th>Projet</th>
                        <th>Catégorie</th>
                        <th>Note</th>
                        <th>
                            <%--<asp:Button ID="Btn_Ajout" CssClass="btn btn-md btn-secondary" runat="server" Text="Nouveau" />--%>
                        </th>
                    </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td><asp:Label ID="lbl_ID" runat="server" Text='<%# String.Format("{0} {1}", Eval("prenom"), Eval("nom")) %>' Font-Bold="true" /></td>
                </tr>
                <tr>
                    <asp:Repeater ID="Rptr_FeuilleTemps" runat="server" DataSourceID="LinqDataSource1">
                    <%--ITEMTEMPLATE--%>
                    <ItemTemplate>
                        <tr style="border-bottom: 1px solid #23282e">
                            <td></td>
                            <td>
                                <asp:Label ID="lbl_Date" runat="server" Text='<%#Eval("dateCreation") %>' Font-Bold="true"  />
                            </td>
                            <td>
                                <asp:Label ID="lbl_Duree" runat="server" Text='<%#Eval("nbHeure") %>' Font-Bold="true" />
                            </td>
                            <td>
                                <asp:Label ID="lbl_Projet" runat="server" Text='<%#Eval("tbl_Projet.titre") %>' Font-Bold="true" />
                            </td>
                            <td>
                                <asp:Label ID="lbl_Categorie" runat="server" Text='<%#Eval("tbl_ProjetCat.titre") %>' Font-Bold="true" />
                            </td>
                            <td>
                                <asp:Label ID="lbl_Note" runat="server" Text='<%#Eval("commentaire") %>' Font-Bold="true" />
                            </td>
                            <td>
                                <asp:Button ID="Btn_Modif" CssClass="btn btn-md btn-primary" OnClick="Btn_Modif_Click" runat="server" Text="Modification"  /> 
                                <asp:Button ID="Btn_Approve" CssClass="btn btn-md btn-primary" runat="server" Text="Approuver"  /> 
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
                        <th>Date</th>
                        <th>Durée (h)</th>
                        <th>Projet</th>
                        <th>Catégorie</th>
                        <th>Note</th>
                        <th>
                        </th>
                </tr>
                </table>
            </FooterTemplate>
        </asp:Repeater>

        <%--DATA SOURCE--%>
        <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqProjets" ContextTypeName="UrbanEco.CoecoDataContext" TableName="tbl_Employe"></asp:LinqDataSource>
        <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqDataSource1" ContextTypeName="UrbanEco.CoecoDataContext" TableName="tbl_FeuilleTemps"></asp:LinqDataSource>
        
    </form>
</asp:Content>
