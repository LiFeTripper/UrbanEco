<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="RapportPage.aspx.cs" Inherits="UrbanEco.RapportPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="TitlePlaceholder" runat="server">
    Rapport Dépense
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="BodyPlaceHolder" runat="server">

    <h1>Rapport</h1>
    <p><span id="tbx_dateDebut" runat="server"></span> - <span id="tbx_dateFin" runat="server"></span></p>

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
