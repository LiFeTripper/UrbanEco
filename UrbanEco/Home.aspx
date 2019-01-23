<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="UrbanEco.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="TitlePlaceHolder" runat="server">
    <h1>Accueil</h1>
    <label id="Lbl_HelloUser" runat="server" text="Bonjour"></label>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
    <form runat="server">
        <div class="col-md-12">
            <span runat="server" class="alert alert-warning" style="width: 100%;" id="alert_warning_sunday" visible="false"><b>L'année se termine bientôt !</b> N'oublier pas d'aller changer la date du premier dimanche dans l'onglet "Paramètre Administrateur".</span>
            <span runat="server" class="alert alert-danger" style="width: 100%;" id="alert_danger_sunday" visible="false"><b>Le premier dimanche de l'année est expiré !</b> Veuillez aller la mettre à jour dans l'onglet "Paramètre Administrateur".</span>
        </div>

        <div class="col-md-8" style="float: left;" runat="server" id="tbl_resume">
            <%--CODE REPEATER DE FEUILLES DE TEMPS NON-APPROUVER--%>

            <label for="rpt_employe" runat="server" id="lbl_resume" style="font-size: 25px;">Résumé de la semaine du </label>
            <asp:Repeater ID="rpt_employe" runat="server">


                <%--HEADERTEMPLATE--%>
                <HeaderTemplate>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <%--<th style="width: 4%" scope="col"></th>--%>
                                    <th style="width: 13%" scope="col">Projet en charge</th>
                                    <th style="width: 8%" scope="col">Employé</th>
                                    <th style="width: 8%" scope="col">Durée (h)</th>

                                    <th style="width: 5%" scope="col">
                                        <%--<asp:Button ID="Btn_ApproveTout" CssClass="btn btn-md btn-primary" runat="server" OnClick="Btn_ApproveTout_Click" Text="Approuver Tout" />--%>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                </HeaderTemplate>

                <%--ITEMTEMPLATE--%>
                <ItemTemplate>
                    <tr class="table-secondary">
                        <%--                    <td>
                        <asp:Button runat="server" CssClass="btn btn-sm btn-secondary" Text="Plus/Moins" ID="btn_trash" enabled="false"/>
                    </td>--%>
                        <td>
                            <%--<asp:Label ID="lbl_ID" runat="server" Text='<%# String.Format("{0} {1}", Eval("prenom"), Eval("nom")) %>' Font-Bold="true" />--%>
                            <asp:Label ID="lbl_ID" runat="server" Text='<%# Eval("titre") %>' Font-Bold="true" />
                        </td>
                        <%--TD VIDE POUR LA COLORATION DES COLONES--%>
                        <td></td>
                        <%--TOTAL DURÉE--%>
                        <td>
                            <%--<asp:Label ID="Label1" runat="server" Text='<%# CalculerTotalHeureEmploye(Eval("tbl_FeuilleTemps")) %>' Font-Bold="true" />--%>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <%--SECOND REPEATER DES FEUILLES DE TEMPS--%>
                        <asp:Repeater runat="server" DataSource='<%# Eval("tbl_FeuilleTemps")%>'>
                            <%--ITEMTEMPLATE--%>
                            <ItemTemplate>
                                <tr style="border-bottom: 1px solid #23282e" runat="server" visible='<%# InList(Eval("idEmploye"), Eval("idProjet")) %>'>
                                    <%--<td></td>--%>
                                    <td></td>
                                    <td>
                                        <asp:Label ID="lbl_Date" runat="server" Text='<%# GetEmployeName(Eval("idEmploye")) %>'/>
                                    </td>
                                    <td>
                                        <asp:Label ID="lbl_Duree" runat="server" Text='<%#CalculerTotalHeureEmploye(Eval("idEmploye"), Eval("idProjet"))%>'/>

                                    </td>
                                    <td>
                                        <%--<asp:ImageButton ID="Btn_Modif" CssClass=" btn-option" OnClick="Btn_Modif_Click1" runat="server" Text="Modification" src="Resources/pencil.png" CommandArgument='<%#Eval("idFeuille")%>' />--%>
                                        <%--<asp:ImageButton ID="Btn_Approve" CssClass="btn-option" runat="server" OnClick="Btn_Approve_Click" src="Resources/checkmark.png" Text="Approuver" CommandArgument='<%#Eval("idFeuille")%>' />--%>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tr>
                </ItemTemplate>

                <%--FOOTERTEMPLATE--%>
                <FooterTemplate>
                    </tbody>
                    <thead>
                        <tr class="t_footer">
                            <th style="width: 13%" scope="col">Projet en charge</th>
                            <th style="width: 8%" scope="col">Employé</th>
                            <th style="width: 8%" scope="col">Durée (h)</th>
                            <th style="width: 5%" scope="col"></th>
                        </tr>
                    </thead>
                </table>
                </div>
                </FooterTemplate>
            </asp:Repeater>
        </div>
        <div class="col-md-4" style="float:left;">
            <asp:Button ID="btn_download" CssClass="btn btn-lg btn-success" runat="server" Text="Télécharger le guide d'utilisateur" OnClick="btn_download_Click" style="float:right;" />
        </div>

    </form>
</asp:Content>
