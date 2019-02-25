<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="Rapport.aspx.cs" Inherits="UrbanEco.Rapport" %>

<%-- Head --%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Rapports/Rapport.css" rel="stylesheet" />
    <title>Co-Éco - Rapports</title>
    <%--<script src="Rapports/Rapport.js"></script>--%>
</asp:Content>

<%-- Title --%>
<asp:Content ID="Content3" ContentPlaceHolderID="TitlePlaceHolder" runat="server">
    <h1>Rapport Projets</h1>
</asp:Content>

<%-- Content --%>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
    <form runat="server">

        <%-- Dates --%>
        <div class="form-group">
            <label for="date_debut" class="">Date de début</label>
            <input type="date" id="date_debut" class="form-control" runat="server" />
        </div>

        <div class="form-group">
            <label for="date_fin" class="">Date de fin</label>
            <input type="date" id="date_fin" class="form-control" runat="server" />
        </div>

        <asp:Button Id="btn_Refresh" Text="Actualiser la sélection" runat="server" CssClass="hidden" />

        <%-- Projets --%>
        <div class="form-group spantwo noTopPadding">
            <div class="spantwo">
                <label class="switch">
                    <asp:CheckBox ID="chkbox_projets" runat="server" AutoPostBack="true" />
                    <span class="slider round"></span>
                </label>
            </div>
            <div class="sousTitres">
                <h5 runat="server" class="titre">Projets</h5>
                
                <h5 runat="server" class="titre">Projets sélectionnés</h5>
            </div>
            
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
        <div class="form-group spantwo noTopPadding">
            <div class="sousTitres">
                <h5>Sous-Catégorie</h5>
                <h5>Sous-catégories sélectionnées</h5>
            </div>

            <div class="select_group">
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
        <div class="form-group spantwo noTopPadding">
            <div class="spantwo">
                <label class="switch">
                    <asp:CheckBox ID="chkbox_employes" runat="server" AutoPostBack="true" />
                    <span class="slider round"></span>
                </label>
            </div>
            <div class="sousTitres">
                <h5>Employés</h5>
                <h5>Employés sélectionnés</h5>
            </div>

            <div class="select_group">

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
        <asp:Button CssClass="btn btn-raised btn-success" ID="btn_generer" runat="server" Text="Générer le rapport" OnClick="btn_generer_Click" />
        <asp:Button CssClass="btn btn-raised btn-danger" ID="btn_retour" runat="server" Text="Retour" OnClick="btn_retour_Click" />
    </form>

    <script>
        var empSelected = document.getElementById('<%=hiddenFieldEmploye.ClientID%>').value.split(',');

        var catSelected = document.getElementById('<%=hiddenFieldCat.ClientID%>').value.split(',');

        var projetSelected = document.getElementById('<%=hiddenFieldProjet.ClientID%>').value.split(',');

        <%--function UpdateDateFormat() {

            var dateFormated = document.getElementById('<%=dateFormated.ClientID%>')

            if (input.value == "") {
                dateFormated.innerText = "Veuillez sélectionner la date";
                return;
            }

            var format = FormatYear(input.value);

            dateFormated.innerText = format;
        }--%>

        function FormatYear(yearString) {

            var split = yearString.split('-');

            if (split.length != 3)
                split = yearString.split('/');

            var year = split[0];
            var month = parseInt(split[1]);
            var day = parseInt(split[2]);

            var months = ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"];

            return day + " " + months[month - 1] + " " + year;;
        }

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
        $('#BodyPlaceHolder_btn_Refresh').click();
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
        $('#BodyPlaceHolder_btn_Refresh').click();
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
