<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="Rapport.aspx.cs" Inherits="UrbanEco.Rapport" %>

<%-- Head --%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Rapports/Rapport.css" rel="stylesheet" />

    <script src="Rapports/Rapport.js"></script>
</asp:Content>

<%-- Title --%>
<asp:Content ID="Content3" ContentPlaceHolderID="TitlePlaceHolder" runat="server">
    <h1>Rapport par projet</h1>
</asp:Content>

<%-- Content --%>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
    <form runat="server" style="text-align: center;" class="container center col-12">

        <%--Projet--%>
        <div class="form-group mb-4 col-6 mx-auto">
            <asp:Table CssClass="asp-table" runat="server" Style="width: 100% !important;">
                <asp:TableRow>
                    <asp:TableHeaderCell CssClass="form-control">
                        Nom du projet
                    </asp:TableHeaderCell>
                    <asp:TableCell>
                        <asp:DropDownList CssClass="form-control" OnSelectedIndexChanged="lst_projet_SelectedIndexChanged" DataTextField="titre" DataValueField="idProjet" ID="lst_projet" runat="server" AutoPostBack="true"></asp:DropDownList>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>

        <%-- Dates --%>
        <div class="row justify-content-center">
            <div class="date_inputs">
                <h5>Date de début</h5>
                <input class="form-control" type="date" id="date_debut" runat="server" />
                <h5>Date de fin</h5>
                <input class="form-control" type="date" id="date_fin" runat="server" />
            </div>
        </div>
        


        <%-- Projets --%>
        <div class="row justify-content-center">
            <div class="select_group">
                <div class="input-group">
                    <select id="projetMultiSelect" multiple="multiple">
                        <asp:Repeater ID="rptr_projets" runat="server">
                            <ItemTemplate>
                                <option value='<%#Eval("idProjet") %>' <%# ProjetSelected(Eval("idProjet")) %> class="font-repeater-level-1"><%#Eval("titre")%> </option>
                            </ItemTemplate>
                        </asp:Repeater>
                    </select>
                </div>

                <asp:LinqDataSource ID="Linq_Projets" runat="server" ContextTypeName="UrbanEco.CoecoDataContext" EntityTypeName="" OrderBy="titre" TableName="tbl_Projet"></asp:LinqDataSource>
                <input hidden="hidden" type="text" runat="server" id="hiddenFieldProjet" />
            </div>
        </div>

        <%-- Catégories --%>
        <div class="row justify-content-center">
            <div class="select_group">
                <h5>Sous-Catégorie</h5>
                <h5>Inclus dans le rapport</h5>

                <div class="input-group">
                    <select id="catMultiSelect" multiple="multiple">
                        <asp:Repeater ID="repParentCat" runat="server">
                            <ItemTemplate>
                                <option value='<%#Eval("value") %>' <%# CategorieSelected(Eval("value")) %> class="font-repeater-level-1"><%#Eval("text")%> </option>
                            </ItemTemplate>
                        </asp:Repeater>
                    </select>

                    <input hidden="hidden" type="text" runat="server" id="hiddenFieldCat" />
                    <asp:LinqDataSource ID="LinqCategorie" runat="server" ContextTypeName="UrbanEco.CoecoDataContext" EntityTypeName="" Select="new (idProjetCat, idProjet, idCatMaitre, titre, description)" TableName="tbl_ProjetCat">
                    </asp:LinqDataSource>
                </div>
            </div>
        </div>

        <%-- Employés --%>
        <div class="row justify-content-md-center">
            <div class="select_group">
                <h5>Employés</h5>
                <h5>Inclus dans le rapport</h5>

                <div class="input-group">
                    <select id="empMultiSelect" multiple="multiple">
                        <optgroup label='Bureau'>
                            <asp:Repeater runat="server" ID="RepBureau">
                                <ItemTemplate>
                                    <option value='<%#Eval("idEmploye") %>' <%# EmployeSelected(Eval("idEmploye")) %>><%# String.Format("{0} {1}", Eval("nom"), Eval("prenom")) %></option>
                                </ItemTemplate>
                            </asp:Repeater>
                        </optgroup>
                        <optgroup label='Terrain'>
                            <asp:Repeater runat="server" ID="RepTerrain">
                                <ItemTemplate>
                                    <option value='<%#Eval("idEmploye") %>' <%# EmployeSelected(Eval("idEmploye")) %>><%# String.Format("{0} {1}", Eval("nom"), Eval("prenom")) %></option>
                                </ItemTemplate>
                            </asp:Repeater>
                        </optgroup>
                    </select>
                </div>

                <input hidden="hidden" type="text" runat="server" id="hiddenFieldEmploye" />
            </div>
        </div>

        <%-- Bottom Inputs --%>
        <div>
            <div class="alert alert-success" runat="server" id="alert_success" visible="false">
                <strong>Succès!</strong>  Votre dépense a bien été ajouté !
            </div>
            <div class="alert alert-danger" runat="server" id="alert_failed" visible="false">
                <strong>Erreur!</strong>  Votre dépense n'as pas pu être ajouté à la base de donnée !
            </div>
            <div class="alert alert-warning" runat="server" id="alert_warning" visible="false">
                <strong>Attention!</strong>  Votre dépense a déjà été ajouté à la base de donnée !
            </div>

            <asp:Button CssClass="btn btn-lg btn-danger input-box" ID="btn_retour" runat="server" Text="Retour" OnClick="btn_retour_Click" />
            <asp:Button CssClass="btn btn-lg btn-success input-box" ID="btn_generer" runat="server" Text="Généré le rapport" OnClick="btn_generer_Click" />
        </div>
    </form>

    <script>
        <%--var empSelected = document.getElementById('<%=hiddenFieldEmploye.ClientID%>').value.split(',');

        var catSelected = document.getElementById('<%=hiddenFieldCat.ClientID%>').value.split(',');

        var projetSelected = document.getElementById('<%=hiddenFieldProjet.ClientID%>').value.split(',');

        function UpdateDateFormat() {

            var dateFormated = document.getElementById('<%=dateFormated.ClientID%>')

            if (input.value == "") {
                dateFormated.innerText = "Veuillez sélectionner la date";
                return;
            }

            var format = FormatYear(input.value);

            dateFormated.innerText = format;
        }

        function FormatYear(yearString) {

            var split = yearString.split('-');

            if (split.length != 3)
                split = yearString.split('/');

            var year = split[0];
            var month = parseInt(split[1]);
            var day = parseInt(split[2]);

            var months = ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"];

            return day + " " + months[month - 1] + " " + year;;
        }--%>

        //ID du crisse de multi + class du css
$('#empMultiSelect').multiSelect({
    //EVENT inscrit nul part guess Onchange, onSelected pis onclick avec function return click
    afterSelect: function (values) {
        //Parce que D'amours
        empSelected.push(values);
        console.log(empSelected);


        var htmlStorage = document.getElementById('<%=hiddenFieldEmploye.ClientID%>');
        //htmlStorage.attr("data-assessments", JSON.stringify(selected));
        htmlStorage.value = empSelected;

        console.log(htmlStorage);
    },

    afterDeselect: function (values) {
        var copy = [];

        for (var idx in empSelected) {
            if (empSelected[idx][0] != values[0]) {
                copy.push(empSelected[idx])
            }
        }

        empSelected = copy;

        console.log(empSelected);
        var htmlHiddenFieldEmploye = document.getElementById('<%=hiddenFieldEmploye.ClientID%>');

        htmlHiddenFieldEmploye.value = empSelected;
    },

    selectableOptgroup: true,
    keepOrder: true
});

//ID du crisse de multi + class du css
$('#catMultiSelect').multiSelect({
    //EVENT inscrit nul part guess Onchange, onSelected pis onclick avec function return click
    afterSelect: function (values) {
        //Parce que D'amours
        catSelected.push(values);
        console.log("Caegories : " + catSelected);


        var htmlhiddenFieldCat = document.getElementById('<%=hiddenFieldCat.ClientID%>');
        //htmlStorage.attr("data-assessments", JSON.stringify(selected));
        htmlhiddenFieldCat.value = catSelected;

        console.log(htmlhiddenFieldCat);
    },

    afterDeselect: function (values) {
        var copy = [];

        for (var idx in catSelected) {
            if (catSelected[idx][0] != values[0]) {
                copy.push(catSelected[idx])
            }
        }

        catSelected = copy;

        console.log(catSelected);
        var htmlhiddenFieldCat = document.getElementById('<%=hiddenFieldCat.ClientID%>');

        htmlhiddenFieldCat.value = catSelected;
    },

    selectableOptgroup: true,
    keepOrder: true
});

//ID du crisse de multi + class du css
$('#projetMultiSelect').multiSelect({
    //EVENT inscrit nul part guess Onchange, onSelected pis onclick avec function return click
    afterSelect: function (values) {
        //Parce que D'amours
        projetSelected.push(values);
        //console.log("Caegories : " + catSelected);


        var htmlhiddenFieldCat = document.getElementById('<%=hiddenFieldProjet.ClientID%>');
        //htmlStorage.attr("data-assessments", JSON.stringify(selected));
        htmlhiddenFieldCat.value = projetSelected;

        console.log(htmlhiddenFieldCat);
    },

    afterDeselect: function (values) {
        var copy = [];

        for (var idx in projetSelected) {
            if (projetSelected[idx][0] != values[0]) {
                copy.push(projetSelected[idx])
            }
        }

        projetSelected = copy;

        console.log(catSelected);
        var htmlhiddenFieldCat = document.getElementById('<%=hiddenFieldProjet.ClientID%>');

        htmlhiddenFieldCat.value = projetSelected;
    },

    selectableOptgroup: true,
    keepOrder: true
});
    </script>
</asp:Content>
