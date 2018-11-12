<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="AjoutCat.aspx.cs" Inherits="UrbanEco.AjoutCat" %>

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
                <h1>
                    <asp:Label ID="lbl_Top" runat="server" Text="Label"></asp:Label>
                    <asp:HiddenField ID="HiddenField_Projet" runat="server" />
                </h1>
                <hr style="border: 20px solid #23282e; width: 100% !important; margin: 0px 0px 0px 0px; padding: 0px 0px 0px 0px" />
            </div>

            <div class="row justify-content-md-center" style="margin-bottom: 100px;">
                <div class="col-md-offset-3 col-6">
                    <%--CATÉGORIE NIVEAU 1 et 2--%>
                    <table style="width: 100% !important;">
                        <%--NIVEAU 1--%>
                        <tr>
                            <th>
                                <h5 class="input-title">Catégorie niveau 1</h5>
                            </th>
                        </tr>
                        <tr>
                            <td>
                                <asp:ListBox ID="Lbx_Cat1" runat="server" OnSelectedIndexChanged="Lbx_Cat1_SelectedIndexChanged" AutoPostBack="true"></asp:ListBox>
                                <asp:TextBox ID="Tbx_AjoutCat" runat="server"></asp:TextBox>
                                <asp:TextBox ID="Tbx_AjoutCatDesc" runat="server"></asp:TextBox>
                                <asp:Button ID="Btn_AjoutCat" runat="server" Text="Ajouter" OnClick="Btn_AjoutCat_Click"/>
                            </td>
                        </tr>
                        <%--NIVEAU 2--%>
                        <tr>
                            <th>
                                <h5 class="input-title">Catégorie niveau 2</h5>
                            </th>
                        </tr>
                        <tr>
                            <td>
                                <asp:ListBox ID="Lbx_Cat2" runat="server"></asp:ListBox>
                                <asp:TextBox ID="Tbx_AjoutSousCat" runat="server"></asp:TextBox>
                                <asp:TextBox ID="Tbx_AjoutSousCatDesc" runat="server"></asp:TextBox>
                                <asp:Button ID="Btn_AjoutSousCat" runat="server" Text="Ajouter" />
                            </td>
                        </tr>
                        </table>

                    </div>
                </div>
            </div>
        </form>
</asp:Content>
