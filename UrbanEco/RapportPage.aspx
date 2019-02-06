<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="RapportPage.aspx.cs" Inherits="UrbanEco.RapportPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Rapports/rapportPage.css" rel="stylesheet" />
    <title>Co-Éco - Rapports</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="TitlePlaceholder" runat="server">
    Rapport
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="BodyPlaceHolder" runat="server">

    <h1>Rapport</h1>
    <span>Rapport <%# Eval("") %> à <%# Eval("") %></span>

    <asp:repeater id="rapportRepeater" runat="server">
        <itemtemplate>
            <%-- Loop Through Projects --%>
            <%# Eval("Nom") %> - <%# formatHeure(Eval("NbHeure")) %>
            <asp:repeater runat="server" DataSource='<%# Eval("Child") %>' >
                <itemtemplate>
                    <%-- Loop Through Categories --%>
                    <div class="rapport_div cat_div">
                        <%# Eval("Nom") %> - <%# formatHeure(Eval("NbHeure")) %>
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
