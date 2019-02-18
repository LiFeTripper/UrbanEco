<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="RapportDepensePage.aspx.cs" Inherits="UrbanEco.RapportDepensePage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Rapports/rapportPage.css" rel="stylesheet" />
    <link href="Rapports/rapportPage.print.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="TitlePlaceholder" runat="server">

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
    <h1>Rapport de Dépense</h1>
    <button id="btn_Imprimer" class="btn btn-raised btn-success" onclick="window.print();return false;">Imprimer</button>
    <p><span id="tbx_dateDebut" runat="server"></span> - <span id="tbx_dateFin" runat="server"></span></p>

    <%-- Loop Through Catégories de dépense --%>
    <asp:Repeater id="rapportRepeater" runat="server">
        <ItemTemplate>
            <div class="rapport_div cat_div">
                <h3><%# Eval("Nom") %> (<%# FormatMontant(Eval("TotalDepense")) %> $)</h3>
               <%-- Loop Through Dépenses --%>
                <asp:Repeater runat="server" DataSource='<%# Eval("Childs") %>'>
                    <ItemTemplate>
                        <div class="rapport_div">
                            <p><%# Eval("Nom") %> (<%# FormatMontant(Eval("TotalDepense")) %> $)</p>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</asp:Content>

