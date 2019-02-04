<%@ Page Title="Gestion de la banque d'heures" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="BanqueHeure.aspx.cs" Inherits="UrbanEco.BanqueHeure" EnableViewState="True" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Co-Éco - Banque d'heures</title>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="TitlePlaceHolder" runat="server">
    <h1>Banques d'heures</h1>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
    <form runat="server" style="text-align: center" class="container center col-12">

        <div class="form-group mb-4 col-6 mx-auto">
            <h1 id="h1TitlePage" runat="server">Gestion de la banque d'heures de</h1>
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

        <%-- Entrer le nombre d'heure par semaine pour cet employé --%>
        <div class="col-md-5 mx-auto">
            <asp:Label ID="Label1" runat="server" Text="Nombre d'heures à faire chaque semaine : "></asp:Label>
            <asp:TextBox CssClass="form-control col-md-2 float-right" runat="server" ID="tbx_heureMinimum" Enabled="false"></asp:TextBox>
        </div>

        <div class="form-group mb-4 col-6 mx-auto">
            <asp:Table runat="server" ID="tbl_BH" Enabled="false" Style="width: 100%">
                <%--HEURES EN BANQUES--%>
                <asp:TableRow>
                    <asp:TableCell></asp:TableCell>
                    <asp:TableHeaderCell>Heures utilisées</asp:TableHeaderCell>
                    <asp:TableHeaderCell>Heures actuelles</asp:TableHeaderCell>
                    <asp:TableHeaderCell>Heures initiales</asp:TableHeaderCell>

                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableHeaderCell CssClass="form-control">Heures en banque</asp:TableHeaderCell>
                    <asp:TableCell>
                        <asp:TextBox CssClass="form-control" Enabled="false" runat="server" ID="tbx_nbHeureBanqueU"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox CssClass="form-control" runat="server" ID="tbx_nbHeureBanque"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox CssClass="form-control" runat="server" ID="tbx_nbHeureBanqueI"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
                <%--JOUR FÉRIÉ--%>
                <asp:TableRow>
                    <asp:TableHeaderCell CssClass="form-control">Jours feriés</asp:TableHeaderCell>
                    <asp:TableCell>
                        <asp:TextBox CssClass="form-control" Enabled="false" runat="server" ID="tbx_nbHeureJourFerieU"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox CssClass="form-control" runat="server" ID="tbx_nbHeureJourFerie" />
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox CssClass="form-control" runat="server" ID="tbx_nbHeureJourFerieI" />
                    </asp:TableCell>
                </asp:TableRow>
                <%--VACANCES--%>
                <asp:TableRow>
                    <asp:TableHeaderCell CssClass="form-control">Vacance</asp:TableHeaderCell>
                    <asp:TableCell>
                        <asp:TextBox CssClass="form-control" Enabled="false" runat="server" ID="tbx_nbHeureVacanceU"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox CssClass="form-control" runat="server" ID="tbx_nbHeureVacance" />
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox CssClass="form-control" runat="server" ID="tbx_nbHeureVacanceI" />
                    </asp:TableCell>
                </asp:TableRow>
                <%--CONGÉ PERSONNEL--%>
                <asp:TableRow>

                    <asp:TableHeaderCell CssClass="form-control">Congés personnels</asp:TableHeaderCell>
                    <asp:TableCell>
                        <asp:TextBox CssClass="form-control" Enabled="false" runat="server" ID="tbx_nbHeureCongePersoU"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox CssClass="form-control" runat="server" ID="tbx_nbHeureCongePerso" />
                    </asp:TableCell>

                    <asp:TableCell>
                        <asp:TextBox CssClass="form-control" runat="server" ID="tbx_nbHeureCongePersoI" />
                    </asp:TableCell>
                </asp:TableRow>
                <%--CONGÉ MALADIE--%>
                <asp:TableRow>
                    <asp:TableHeaderCell CssClass="form-control">Congés maladie</asp:TableHeaderCell>
                    <asp:TableCell>
                        <asp:TextBox CssClass="form-control" Enabled="false" runat="server" ID="tbx_nbHeureCongeMaladieU"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox CssClass="form-control" runat="server" ID="tbx_nbHeureCongeMaladie" />
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox CssClass="form-control" runat="server" ID="tbx_nbHeureCongeMaladieI" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>
        <%--BOUTON--%>
        <div class="form-group mb-4 col-6 mx-auto">
            <%--<asp:Button ID="btn_Admin" runat="server" OnClick="btn_Admin_Click" Text="Admin" CssClass="btn btn-md btn-success" AutoPostBack="true" />--%>
            <asp:Button ID="btn_modifBH" runat="server" OnClick="btn_modifBH_Click" Text="Activer la modification" CssClass="btn btn-md btn-success" />

            <asp:Button ID="btn_Annuler" runat="server" OnClick="btn_Annuler_Click" Text="Annuler" CssClass="btn btn-md btn-danger" Visible="false" />
            <asp:Button ID="btn_Sauvegarder" runat="server" OnClick="btn_Sauvegarder_Click" Text="Sauvegarder" CssClass="btn btn-md btn-success" Visible="false" />
        </div>
        <div>
            <asp:Button ID="btn_modifBHI" runat="server" OnClick="btn_modifBHI_Click" Text="Activer la modification des heures initiales" CssClass="btn btn-md btn-warning" Visible="false" />
        </div>
    </form>
</asp:Content>

