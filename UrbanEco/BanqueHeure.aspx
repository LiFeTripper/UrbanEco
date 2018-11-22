<%@ Page Title="Gestion de la banque d'heures" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="BanqueHeure.aspx.cs" Inherits="UrbanEco.BanqueHeure" EnableViewState="True" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="TitlePlaceHolder" runat="server">
    <h1>Banques d'heures</h1>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
    <form runat="server" style="text-align: center" class="container center col-12">
        <div class="form-group mb-4 col-6 mx-auto">
            <h1 id="h1TitlePage" runat="server">Gestion de la Banque d'Heures</h1>
        </div>

        <%--ALERTE--%>
        <div class="form-group mb-4 col-6 mx-auto">
            <div runat="server" id="AlertDiv" visible="false" class="alert alert-danger alert-dismissable">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                <strong>Attention!</strong>
                <br />
                Veuillez choisir un employé avant d'activer la modification !
            </div>
        </div>
        <%--SELECTION EMPLOYÉ--%>
        <div class="form-group mb-4 col-6 mx-auto">
            <asp:DropDownList ID="ddl_empBH" runat="server" Style="width: 100%" OnSelectedIndexChanged="ddl_empBH_SelectedIndexChanged" CssClass="form-control" AutoPostBack="True" />
        </div>

        <div class="form-group mb-4 col-6 mx-auto">
            <asp:Table runat="server" ID="tbl_BH" Enabled="false" Style="width: 100%">
                <%--HEURES EN BANQUES--%>
                <asp:TableRow>    
                    <asp:TableHeaderCell CssClass="form-control">Heure en banque</asp:TableHeaderCell>
                    <asp:TableCell>
                        <asp:TextBox CssClass="form-control" runat="server" ID="tbx_nbHeureBanque"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
                <%--JOUR FÉRIÉ--%>
                <asp:TableRow>
                    <asp:TableHeaderCell CssClass="form-control">Jour ferié</asp:TableHeaderCell>
                    <asp:TableCell>
                        <asp:TextBox CssClass="form-control" runat="server" ID="tbx_nbHeureJourFerie" />
                    </asp:TableCell>
                </asp:TableRow>
                <%--VACANCES--%>
                <asp:TableRow>
                    <asp:TableHeaderCell CssClass="form-control">Vacance</asp:TableHeaderCell><asp:TableCell>
                        <asp:TextBox CssClass="form-control" runat="server" ID="tbx_nbHeureVacance" />
                    </asp:TableCell>
                </asp:TableRow>
                <%--CONGÉ PERSONNEL--%>
                <asp:TableRow>
                    <asp:TableHeaderCell CssClass="form-control">Congé personnel</asp:TableHeaderCell><asp:TableCell>
                        <asp:TextBox CssClass="form-control" runat="server" ID="tbx_nbHeureCongePerso" />
                    </asp:TableCell>
                </asp:TableRow>
                <%--CONGÉ MALADIE--%>
                <asp:TableRow>
                    <asp:TableHeaderCell CssClass="form-control">Congé maladie</asp:TableHeaderCell><asp:TableCell>
                        <asp:TextBox CssClass="form-control" runat="server" ID="tbx_nbHeureCongeMaladie" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>
        <%--BOUTON--%>
        <div class="form-group mb-4 col-6 mx-auto">
            <asp:Button ID="btn_Admin" runat="server" OnClick="btn_Admin_Click" Text="Admin" CssClass="btn btn-md btn-success" AutoPostBack="true" />
            <asp:Button ID="btn_modifBH" runat="server" OnClick="btn_modifBH_Click" Text="Activer la modification" CssClass="btn btn-md btn-success" />
        </div>
    </form>
</asp:Content>

