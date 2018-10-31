<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="BanqueHeure.aspx.cs" Inherits="UrbanEco.BanqueHeure" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
    <form runat="server">
        <asp:DropDownList ID="ddl_empBH" runat="server"></asp:DropDownList>
        <asp:table runat="server"  ID="tb_BH" Enabled="false">
            <asp:TableRow>
                <asp:TableHeaderCell>Heure en banque</asp:TableHeaderCell>
                <asp:TableCell><asp:TextBox runat="server" ID="tb_nbHeureBanque"></asp:TextBox></asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableHeaderCell>Jour ferié</asp:TableHeaderCell>
                <asp:TableCell><asp:TextBox runat="server" id="tb_nbHeureJourFerie"/></asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableHeaderCell>Vacance</asp:TableHeaderCell>
                <asp:TableCell><asp:TextBox runat="server" id="tb_nbHeureVacance"/></asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableHeaderCell>Congé personnel</asp:TableHeaderCell>
                <asp:TableCell><asp:TextBox runat="server" id="tb_nbHeureCongePerso"/></asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableHeaderCell>Congé maladie</asp:TableHeaderCell>
                <asp:TableCell><asp:TextBox runat="server" id="tb_nbHeureCongeMaladie"/></asp:TableCell>
            </asp:TableRow>
        </asp:table>
        <asp:Button  ID="btn_modifBH" runat="server" OnClick="btn_modifBH_Click" Text="Activer la modification" />
    </form>
</asp:Content>

