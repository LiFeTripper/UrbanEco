<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="RapportDepensePage.aspx.cs" Inherits="UrbanEco.RapportDepensePage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="TitlePlaceholder" runat="server">

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
    <h1>Rapport de Dépense</h1>
    <p><span id="tbx_dateDebut" runat="server"></span> - <span id="tbx_dateFin" runat="server"></span></p>

    <%-- Loop Through Catégories de dépense --%>
    <asp:Repeater runat="server">
        <ItemTemplate>
            <div class="rapport_div cat_div">
                <h3><%# Eval("Nom") %>(<%# Eval("NbHeure") %> $)</h3>
               <%-- Loop Through Dépenses --%>
                <asp:Repeater runat="server">
                    <ItemTemplate>
                        <div class="rapport_div">
                            <p><%# Eval("Nom") %>(<%# Eval("NbHeure") %> $)</p>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</asp:Content>

