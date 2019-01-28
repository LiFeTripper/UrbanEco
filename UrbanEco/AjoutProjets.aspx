<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="AjoutProjets.aspx.cs" Inherits="UrbanEco.Projets" MaintainScrollPositionOnPostback="true" %>

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

        .asp-table {
            table-layout: fixed;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="TitlePlaceHolder" runat="server">
    <h1>
        <asp:Label ID="lbl_Top" runat="server" Text="Label"></asp:Label>
    </h1>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="BodyPlaceHolder" runat="server">

    <form runat="server">

        <%--ALERT PROJECT NAME EMPTY--%>
        <div runat="server" id="AlertDiv" visible="false" class="alert alert-danger alert-dismissable">
            <button type="button" class="close" data-dismiss="alert">&times;</button>
            <strong>Attention!</strong>
            <br />
            Veuillez entrer un nom de projet !
        </div>

        <%--Titre--%>
        <div class="form-group mb-4 col-6 mx-auto" runat="server">
            <asp:Table CssClass="asp-table" runat="server" Style="width: 100% !important;">
                <asp:TableRow>
                    <asp:TableHeaderCell CssClass="form-control">
                        Titre du projet <b style="color:red">*</b>
                    </asp:TableHeaderCell>
                    <asp:TableCell>
                        <asp:TextBox ID="Tbx_Titre" runat="server" class="form-control"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>

        <%--Description--%>
        <div class="form-group mb-4 col-6 mx-auto" runat="server">
            <asp:Table CssClass="asp-table" runat="server" Style="width: 100% !important;">
                <asp:TableRow>
                    <asp:TableHeaderCell CssClass="form-control">
                        Description
                    </asp:TableHeaderCell>
                    <asp:TableCell>
                        <asp:TextBox ID="Tbx_Description" runat="server" class="form-control"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>

        <%--Responsable--%>
        <div class="form-group mb-4 col-6 mx-auto" runat="server">
            <asp:Table CssClass="asp-table" runat="server" Style="width: 100% !important;">
                <asp:TableRow>
                    <asp:TableHeaderCell CssClass="form-control">
                        Responsable
                    </asp:TableHeaderCell>
                    <asp:TableCell>
                        <asp:DropDownList ID="Ddl_Responsable" runat="server" DataSourceID="LinqEmployes" DataTextField="personne" DataValueField="idEmploye" class="form-control"></asp:DropDownList>
                        <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqEmployes" ContextTypeName="UrbanEco.CoecoDataContext" Select="new (prenom + ' ' + nom as personne, idEmploye)" TableName="tbl_Employe"></asp:LinqDataSource>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>

        <%--Approbation feuille de temps checkbox--%>
        <div class="form-group mb-4 col-6 mx-auto">
            <table style="width: 100% !important;">
                <tr class="mb-3">
                    <%--CHECKBOX INACTIF OU ACTIF--%>
                    <td style="width: 50%;">
                        <label class="switch" style="float: right;">
                            <asp:CheckBox ID="Chkbx_App" runat="server" />
                            <span class="slider round"></span>
                        </label>
                    </td>
                    <td>
                        <h4 style="float: left;">Approbation</h4>
                    </td>
                </tr>
            </table>
        </div>

        <%--Status--%>
        <div class="form-group mb-4 col-6 mx-auto" runat="server">
            <asp:Table CssClass="asp-table" runat="server" Style="width: 100% !important;">
                <asp:TableRow>
                    <asp:TableHeaderCell CssClass="form-control">
                        Status <b style="color:red">*</b>
                    </asp:TableHeaderCell>
                    <asp:TableCell>
                        <asp:DropDownList ID="Ddl_Status" runat="server" DataSourceID="LinqStatus" DataTextField="nomStatus" DataValueField="idStatus" class="form-control"></asp:DropDownList>
                        <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqStatus" ContextTypeName="UrbanEco.CoecoDataContext" Select="new (nomStatus, idStatus)" TableName="tbl_Status" OrderBy="idStatus"></asp:LinqDataSource>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>

        <%--Heures Allouées--%>
        <div class="form-group mb-4 col-6 mx-auto" runat="server">
            <asp:Table CssClass="asp-table" runat="server" Style="width: 100% !important;">
                <asp:TableRow>
                    <asp:TableHeaderCell CssClass="form-control">
                        Heures Allouées
                    </asp:TableHeaderCell>
                    <asp:TableCell>
                        <asp:TextBox ID="Tbx_HeuresAlloues" runat="server" class="form-control" placeholder="0" TextMode="Number"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>

        <%--Date de début--%>
        <div class="form-group mb-4 col-6 mx-auto" runat="server">
            <asp:Table CssClass="asp-table" runat="server" Style="width: 100% !important; table-layout: fixed;">
                <asp:TableRow>
                    <asp:TableHeaderCell CssClass="form-control">
                        Date de début
                    </asp:TableHeaderCell>
                    <asp:TableCell>
                        <input type="date" style="margin: auto" runat="server" id="Cal_DateDebut" class="form-control" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>

        <%--Date de fin--%>
        <div class="form-group mb-4 col-6 mx-auto" runat="server">
            <asp:Table CssClass="asp-table" runat="server" Style="width: 100% !important; table-layout: fixed;">
                <asp:TableRow Style="width: 100%;">
                    <asp:TableHeaderCell CssClass="form-control">
                        Date de fin
                    </asp:TableHeaderCell>
                    <asp:TableCell>
                        <input type="date" style="margin: auto" runat="server" id="Cal_DateFin" class="form-control col-sm-12" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>


        <div class="form-group mb-4 col-6 mx-auto">
            <table style="width: 100% !important;">
                <tr class="mb-3">
                    <%--CHECKBOX INACTIF OU ACTIF--%>
                    <td style="width: 50%;">
                        <label class="switch" style="float: right;">
                            <asp:CheckBox ID="ChkBx_Archivé" runat="server" />
                            <span class="slider round"></span>
                        </label>
                    </td>
                    <td>
                        <h4 style="float: left;">Archivé</h4>
                    </td>
                </tr>
            </table>
        </div>


        <div class="form-group mb-4 mt-4 col-6 mx-auto">
            <asp:Button ID="Btn_Annuler" CausesValidation="false" runat="server" Text="Annuler" Style="width: 40% !important; float: left;" CssClass="btn btn-lg btn-danger input-box" OnClick="Btn_Annuler_Click" />
            <asp:Button ID="Btn_Enregistrer" runat="server" Text="Enregistrer" Style="width: 40% !important; float: right;" CssClass="btn btn-lg btn-success input-box" OnClick="Btn_Enregister_Click" />
        </div>
    </form>
</asp:Content>
