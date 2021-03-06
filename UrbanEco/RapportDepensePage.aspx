﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="RapportDepensePage.aspx.cs" Inherits="UrbanEco.RapportDepensePage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Rapports/rapportPage.css" rel="stylesheet" />
    <link href="Rapports/rapportPage.print.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="TitlePlaceholder" runat="server">
    <h1>Rapport Dépenses</h1>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="BodyPlaceHolder" runat="server">

    <h1 id="titreImprimante">Rapport Dépenses</h1>
    <div class="infosRapport">
        <p class="spantwo"><span id="tbx_dateDebut" runat="server"></span> - <span id="tbx_dateFin" runat="server"></span></p>
        <button id="btn_Imprimer" class="btn btn-raised btn-secondary" onclick="window.print();return false;">Imprimer</button>
        
        <form class="infosRapport" runat="server">
            <asp:Button ID="btn_excel" CssClass="btn btn-raised btn-success" runat="server" Text="Exporter vers Excel" OnClick="btn_excel_Click" AutoPostBack="true"/>
            <asp:Button ID="btn_excel_csv" CssClass="btn btn-raised btn-success" runat="server" Text="Exporter en CSV" OnClick="btn_excel_csv_Click" AutoPostBack="true"/>
            <h3  ID="lbl_erreur" runat="server" class="alert alert-danger" Text="Erreur" Visible="false"></h3>
        </form>
    </div>


    <%-- Loop Through Catégories de dépense --%>
    <asp:Repeater id="rapportRepeater" runat="server">
        <ItemTemplate>
            <div class="rapport_div cat_div">
                <h3><%# Eval("Nom") %> (<%# FormatMontant(Eval("TotalDepense")) %>)</h3>
               <%-- Loop Through Dépenses --%>
                <asp:Repeater runat="server" DataSource='<%# Eval("Childs") %>'>
                    <ItemTemplate>
                        <div class="rapport_div">
                            <p><%# FormatDate(Eval("Date")) %> - <%# Eval("Nom") %> - <%# Eval("TitreProjet") %> - <%# Eval("TitreCategorie") %> (<%# FormatMontant(Eval("TotalDepense")) %>)</p>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</asp:Content>

