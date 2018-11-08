<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="Projets.aspx.cs" Inherits="UrbanEco.Projets1" %>

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

            <%--CODE REPEATER DE PROJETS--%>
            <asp:Repeater ID="Rptr_Projets" runat="server" DataSourceID="LinqProjets">
                
                <%--HEADERTEMPLATE--%>
                <HeaderTemplate>
                    <table style="width: 100% !important;">
                        
                        <%--EN TËTE A MARC--%>
                        <h1>Projets</h1>
                        <hr style="border-bottom: 20px solid #23282e; width: 100%;" />

                        <tr style="border-bottom: 5px solid #23282e">
                            <th>ID</th>
                            <th>Titre</th>
                            <th>Description</th>
                            <th>Status du projet</th>
                            <th>Employé Responsable</th>
                            <th>Date de début</th>
                            <th>
                                <asp:Button ID="Btn_Ajout" CssClass="btn btn-md btn-secondary" runat="server" Text="Nouveau" OnClick="Btn_Ajout_Click" />
                            </th>
                        </tr>
                </HeaderTemplate>
                
                <%--ITEMTEMPLATE--%>
                <ItemTemplate>
                    <tr style="border-bottom: 1px solid #23282e">
                        <td>
                            <asp:Label ID="lbl_ID" runat="server" Text='<%#Eval("idProjet") %>' Font-Bold="true" />
                        </td>
                        <td>
                            <asp:Label ID="lbl_Titre" runat="server" Text='<%#Eval("titre") %>' Font-Bold="true" />
                        </td>
                        <td>
                            <asp:Label ID="lbl_Description" runat="server" Text='<%#Eval("description") %>' Font-Bold="true" />
                        </td>
                        <td>
                            <asp:Label ID="lbl_idStatus" runat="server" Text='<%#Eval("Tbl_Status.nomStatus") %>' Font-Bold="true" />
                        </td>
                        <td>
                            <asp:Label ID="lbl_idEmployeResp" runat="server" Text='<%# String.Format("{0} {1}", Eval("Tbl_Employe.prenom"), Eval("Tbl_Employe.nom")) %>' Font-Bold="true" />
                        </td>
                        <td>
                            <asp:Label ID="lbl_dateDebut" runat="server" Text='<%#Eval("dateDebut") %>' Font-Bold="true" />
                        </td>
                        <td>
                            <asp:Button ID="Btn_Modif" CssClass="btn btn-md btn-primary" runat="server" Text="Modification" OnClick="Btn_Modif_Click" CommandArgument='<%#Eval("idProjet") %>' />
                        </td>
                    </tr>
                </ItemTemplate>

                <%--FOOTERTEMPLATE--%>
                <FooterTemplate>
                    
                    <tr style="border-top: 5px solid #23282e">
                            <th>ID</th>
                            <th>Titre</th>
                            <th>Description</th>
                            <th>Status du projet</th>
                            <th>Employé Responsable</th>
                            <th>Date de début</th>
                            <th>
                                <asp:Button ID="Btn_Ajout" CssClass="btn btn-md btn-secondary" runat="server" Text="Nouveau" OnClick="Btn_Ajout_Click" />
                            </th>
                        </tr>
                    </table>
                </FooterTemplate>
            </asp:Repeater>

            <%--DATA SOURCE--%>
            <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqProjets" ContextTypeName="UrbanEco.CoecoDataContext" TableName="tbl_Projet"></asp:LinqDataSource>
        </div>
    </form>
</asp:Content>
