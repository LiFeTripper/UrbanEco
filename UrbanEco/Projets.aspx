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
        <div style="border: 3px solid green; padding: 5px 5px 5px 5px;">

            <div>
                <h1>Projets
                </h1>
                <hr style="border: 20px solid #23282e; width: 100% !important; margin: 0px 0px 0px 0px; padding: 0px 0px 0px 0px" />
            </div>
        </div>

        <%--<div class="row justify-content-md-center" style="margin-bottom: 100px;">--%>
            <div>
            <%--<div class="col-md-offset-3 col-6">--%>
                <div>
                <%--CODE REPEATER DE PROJETS--%>
                <asp:Repeater ID="Rptr_Projets" runat="server" DataSourceID="LinqProjets">
                    <HeaderTemplate>

                        <table style="width: 80% !important;">
                            <%--TITRE--%>
                            <tr>
                                <th>ID</th>
                                <th>Titre</th>
                                <th>Description</th>
                                <th>idStatus</th>
                                <th>idEmployeResp</th>
                                <th>
                                    <asp:Button ID="Btn_Ajout" runat="server" Text="Nouveau" Onclick="Btn_Ajout_Click"/>
                                </th>
                            </tr>

                    </HeaderTemplate>
                    <ItemTemplate>

                            <tr>
                                <td>
                                    <asp:Label ID="lbl_ID" runat="server" Text='<%#Eval("idProjet") %>' Font-Bold="true"/>
                                </td>
                                <td>
                                    <asp:Label ID="lbl_Titre" runat="server" Text='<%#Eval("titre") %>' Font-Bold="true"/>
                                </td>
                                <td>
                                    <asp:Label ID="lbl_Description" runat="server" Text='<%#Eval("description") %>' Font-Bold="true"/>
                                </td>
                                <td>
                                    <asp:Label ID="lbl_idStatus" runat="server" Text='<%#Eval("idStatus") %>' Font-Bold="true"/>
                                </td>
                                <td>
                                    <asp:Label ID="lbl_idEmployeResp" runat="server" Text='<%#Eval("idEmployeResp") %>' Font-Bold="true"/>
                                </td>
                                <td>
                                    <asp:Button ID="Btn_Modif" CssClass="btn btn-md btn-primary"  runat="server" Text="Modification" Onclick="Btn_Modif_Click" CommandArgument='<%#Eval("idProjet") %>'/>
                                </td>
                            </tr>
                        
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
                    <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqProjets" ContextTypeName="UrbanEco.CoecoDataContext" Select="new (titre, description, idStatus, idEmployeResp, idProjet)" TableName="tbl_Projet"></asp:LinqDataSource>
            </div>
        </div>
    </form>
</asp:Content>
