<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="BanqueHeure.aspx.cs" Inherits="UrbanEco.BanqueHeure" EnableViewState="True" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
    <form runat="server" style="text-align: center" class="container center col-12">
        <div>
            <h1>Gestion de la Banque d'Heures
            </h1>
            <hr style="border: 20px solid #23282e; width: 100% !important; margin: 0px 0px 0px 0px; padding: 0px 0px 0px 0px" />
        </div>
        <div class="row justify-content-md-center">
            <div class="col-md-offset-3 col-6">
                <table class="table-custom">
                    <tr>
                        <th><asp:DropDownList ID="ddl_empBH" runat="server"  OnSelectedIndexChanged="ddl_empBH_SelectedIndexChanged" CssClass="input-box" AutoPostBack="True">
                            </asp:DropDownList>
                            <asp:LinqDataSource ID="LinqBH" runat="server" ContextTypeName="UrbanEco.CoecoDataContext" EntityTypeName="" OrderBy="nom, prenom" Select="new (nom, prenom)" TableName="tbl_Employe">
                            </asp:LinqDataSource>
                        </th>
                    </tr>
                    <tr>
                        <td>
                            <asp:Table runat="server" ID="tbl_BH" Enabled="false" Width="100%">
                            <asp:TableRow>
                                <asp:TableHeaderCell CssClass="input-title">Heure en banque</asp:TableHeaderCell>
                                <asp:TableCell>
                                    <asp:TextBox  CssClass="input-box" runat="server" ID="tbx_nbHeureBanque"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableHeaderCell CssClass="input-title">Jour ferié</asp:TableHeaderCell>
                                <asp:TableCell>
                                    <asp:TextBox CssClass="input-box" runat="server" ID="tbx_nbHeureJourFerie" />
                                </asp:TableCell></asp:TableRow><asp:TableRow>
                                <asp:TableHeaderCell CssClass="input-title">Vacance</asp:TableHeaderCell><asp:TableCell>
                                    <asp:TextBox CssClass="input-box" runat="server" ID="tbx_nbHeureVacance" />
                                </asp:TableCell></asp:TableRow><asp:TableRow>
                                <asp:TableHeaderCell CssClass="input-title">Congé personnel</asp:TableHeaderCell><asp:TableCell >
                                    <asp:TextBox CssClass="input-box" runat="server" ID="tbx_nbHeureCongePerso" />
                                </asp:TableCell></asp:TableRow><asp:TableRow>
                                <asp:TableHeaderCell CssClass="input-title">Congé maladie</asp:TableHeaderCell><asp:TableCell>
                                    <asp:TextBox CssClass="input-box" runat="server" ID="tbx_nbHeureCongeMaladie" />
                                </asp:TableCell></asp:TableRow></asp:Table></td></tr><tr>
                        <td><asp:Button ID="btn_modifBH" runat="server"  OnClick="btn_modifBH_Click" Text="Activer la modification"  CssClass="btn btn-md btn-success" /></td>
                    </tr>
                </table>
            </div>
        </div>
    </form>
</asp:Content>

