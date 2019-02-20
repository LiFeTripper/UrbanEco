﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="RapportPage.aspx.cs" Inherits="UrbanEco.RapportPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Rapports/rapportPage.css" rel="stylesheet" />
    <link href="Rapports/rapportPage.print.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="TitlePlaceholder" runat="server">
    <h1>Rapport</h1>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
    
    <div id="infosRapport">
        <p class="spantwo"><span id="tbx_dateDebut" runat="server"></span> - <span id="tbx_dateFin" runat="server"></span></p>
        <button id="btn_Imprimer" class="btn btn-raised btn-secondary" onclick="window.print();return false;">Imprimer</button>
        <form runat="server">
            <asp:Button ID="btn_excel" CssClass="btn btn-raised btn-success" runat="server" Text="Exporter vers Excel" OnClick="btn_excel_Click"/>
            <h2 id="lbl_erreur" class="alert alert-danger" visible="false" runat="server" text="Erreur"></h2>
            <h2 id="lbl_success" class="alert alert-success" visible="false" runat="server" text="Succès"></h2>
        </form>
    </div>
    
    <asp:repeater id="rapportRepeater" runat="server">
        <itemtemplate>
            <%-- Loop Through Projects --%>
            <h3><%# Eval("Nom") %> (<%# formatHeure(Eval("NbHeure")) %>)</h3>
            <asp:repeater runat="server" DataSource='<%# Eval("Child") %>' >
                <itemtemplate>
                    <%-- Loop Through Categories --%>
                    <div class="rapport_div cat_div">
                        <h5><%# Eval("Nom") %> (<%# formatHeure(Eval("NbHeure")) %>)</h5>
                        <asp:repeater runat="server" DataSource='<%# Eval("Child") %>' >
                            <itemtemplate>
                                <div class="rapport_div">
                                    <%-- Loop Through Employes --%>
                                    <%# Eval("Nom") %> - <%# formatHeure(Eval("NbHeure")) %>
                                </div>
                            </itemtemplate>
                        </asp:repeater>
                    </div>
                </itemtemplate>
            </asp:repeater>
        </itemtemplate>
    </asp:repeater>
</asp:Content>
