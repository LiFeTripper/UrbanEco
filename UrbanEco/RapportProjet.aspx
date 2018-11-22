<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="RapportProjet.aspx.cs" Inherits="UrbanEco.RapportProjet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .center {
            margin: auto;
            width: 50%;
        }

        .input-box {
            width: 100% !important;
            font-size: 17px;
            margin-bottom: 30px;
        }

        .input-title {
            text-align: left !important;
        }

        .table-custom {
            width: 800px !important;
        }

        .table-custom > table {
            width: 100% !important;
        }

        .font-repeater-level-1{
            font-size:20px !important;
        }

        .font-repeater-level-2{
            font-size:15px !important;
        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
    <form runat="server" style="text-align: center;" class="container center col-12">
        <div>
            <h1>Rapport par projet
            </h1>
            <hr style="border: 20px solid #23282e; width: 100% !important; margin: 0px 0px 0px 0px; padding: 0px 0px 0px 0px" />
        </div>

        <div class="row justify-content-md-center" style="margin-bottom: 20px;">
            <div class="col-md-offset-3 col-6">

                <table style="width: 100% !important;">
                    <tr>
                        <th>
                            <%--<h3>Projet associé</h3>--%>
                        </th>
                    </tr>
                    <tr>
                        <th>
                            <h5 class="input-title">Nom du projet</h5>
                        </th>
                    </tr>
                    <tr>
                        <td>
                            <asp:DropDownList CssClass="input-box" OnSelectedIndexChanged="lst_projet_SelectedIndexChanged" DataTextField="titre" DataValueField="idProjet" ID="lst_projet" runat="server" AutoPostBack="true"></asp:DropDownList>
                        </td>
                    </tr>

                    <tr>
                        <th>
                            <h5 style="float: left; width: 49% !important;" class="input-title">Sous-Catégorie</h5>
                            <h5 style="float: right; width: 49% !important;" class="input-title">Inclus dans le rapport</h5>
                        </th>
                    </tr>
                    <tr>
                        <td>
                            <div class="justify-content-lg-center input-group mb-3 col-12">
                                <select id="SelectCat" multiple="multiple">

                                    <asp:Repeater ID="repParentCat" runat="server">
                                        <ItemTemplate>

                                            <option value='<%#Eval("idProjetCat") %>' <%# CategorieSelected(Eval("idProjetCat")) %> class="font-repeater-level-1"><%#Eval("titre")%> </option>

                                            <asp:Repeater ID="repTest" runat="server" DataSource='<%#Eval("tbl_ProjetCat2") %>'>
                                                <ItemTemplate>

                                                    <option value='<%#Eval("idProjetCat") %>' <%# CategorieSelected(Eval("idProjetCat")) %> class="font-repeater-level-2">&nbsp;&nbsp;<%#Eval("titre") %></option>

                                                </ItemTemplate>
                                            </asp:Repeater>

                                        </ItemTemplate>
                                    </asp:Repeater>
                                </select>
                                <input hidden="hidden" type="text" runat="server" id="hiddenFieldCat" />

                                <asp:LinqDataSource ID="LinqCategorie" runat="server" ContextTypeName="UrbanEco.CoecoDataContext" EntityTypeName="" Select="new (idProjetCat, idProjet, idCatMaitre, titre, description)" TableName="tbl_ProjetCat">
                                </asp:LinqDataSource>

                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            <h5 style="float: left; width: 49% !important; text-align: left;">Date de début</h5>
                            <h5 style="margin-left: 15px; float: left; width: 49% !important; text-align: left;">Date de fin</h5>
                        </th>
                    </tr>
                    <tr>
                        <td>
                            <input style="float: left; width: 49% !important; margin: auto" type="date" id="date_debut" runat="server" />
                            <input style="float: right; width: 49% !important; margin: auto" type="date" id="date_fin" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <h5 class="center" style="margin: auto !important;" id="dateFormated" runat="server"></h5>
                        </td>
                    </tr>
                </table>
            </div>

        </div>

        <%--On change for date--%>
        <script>


            //UpdateDateFormat();

            //input.onchange = function () {               
            //    UpdateDateFormat();
            //    UpdateDateRep();
            //}

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
            }

        </script>

        <div class="row justify-content-md-center">
            <div class="col-md-offset-3 col-6">

                <table style="width: 100% !important;">
                    <%--                    <tr>
                        <th>
                            <h3></h3>
                        </th>
                    </tr>--%>
                    <tr>
                        <th>
                            <h5 style="float: left; width: 49% !important;" class="input-title">Employés</h5>
                            <h5 style="float: right; width: 49% !important;" class="input-title">Inclus dans le rapport</h5>
                        </th>
                    </tr>
                    <tr>
                        <td>
                            <!--MULTISELECT-->
                            <div class="justify-content-lg-center input-group mb-3 col-12">
                                <select id="Multiselection" multiple="multiple">
                                    <optgroup label='Bureau'>
                                        <asp:Repeater runat="server" ID="RepBureau" >
                                                <ItemTemplate>
                                                    <option value='<%#Eval("idEmploye") %>' <%# EmployeSelected(Eval("idEmploye")) %> ><%# String.Format("{0} {1}", Eval("nom"), Eval("prenom")) %></option>
                                                </ItemTemplate>
                                        </asp:Repeater>
                                    </optgroup>
                                    <optgroup label='Terrain'>
                                        <asp:Repeater runat="server" ID="RepTerrain" >
                                                <ItemTemplate>
                                                    <option value='<%#Eval("idEmploye") %>' <%# EmployeSelected(Eval("idEmploye")) %>  ><%# String.Format("{0} {1}", Eval("nom"), Eval("prenom")) %></option>
                                                </ItemTemplate>
                                        </asp:Repeater>
                                    </optgroup>
                                </select>
                            </div>

                            <input hidden="hidden" type="text" runat="server" id="hiddenFieldEmploye" />
<%--                            <asp:Button ID="BtnTesting" runat="server" Text="Button" OnClick="BtnTesting_Click"/>--%>
                            <!--Multiselect javascript-->
                            <script>
                                //Callback for fuck sake
                                var selected = document.getElementById('<%=hiddenFieldEmploye.ClientID%>').value.split(',');

                                var catSelected = document.getElementById('<%=hiddenFieldCat.ClientID%>').value.split(',');

                                //ID du crisse de multi + class du css
                                $('#Multiselection').multiSelect({
                                    //EVENT inscrit nul part guess Onchange, onSelected pis onclick avec function return click
                                    afterSelect: function (values) {
                                        //Parce que D'amours
                                        selected.push(values);
                                        console.log(selected);


                                        var htmlStorage = document.getElementById('<%=hiddenFieldEmploye.ClientID%>');
                                        //htmlStorage.attr("data-assessments", JSON.stringify(selected));
                                        htmlStorage.value = selected;

                                        console.log(htmlStorage);
                                    },

                                    afterDeselect: function (values) {
                                        var copy = [];

                                        for (var idx in selected) {
                                            if (selected[idx][0] != values[0]) {
                                                copy.push(selected[idx])
                                            }
                                        }

                                        selected = copy;

                                        console.log(selected);
                                        var htmlHiddenFieldEmploye = document.getElementById('<%=hiddenFieldEmploye.ClientID%>');

                                        htmlHiddenFieldEmploye.value = selected;
                                    },

                                    selectableOptgroup: true,
                                    keepOrder: true
                                });

                                //ID du crisse de multi + class du css
                                $('#SelectCat').multiSelect({
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

                                //RÉUSSI
                            </script>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="alert alert-success" runat="server" id="alert_success" visible="false">
                                <strong>Succès!</strong>  Votre dépense a bien été ajouté !
                            </div>
                            <div class="alert alert-danger" runat="server" id="alert_failed" visible="false">
                                <strong>Erreur!</strong>  Votre dépense n'as pas pu être ajouté à la base de donnée !
                            </div>
                            <div class="alert alert-warning" runat="server" id="alert_warning" visible="false">
                                <strong>Attention!</strong>  Votre dépense a déjà été ajouté à la base de donnée !
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Button Style="width: 40% !important; float: left;" CssClass="btn btn-lg btn-danger input-box" ID="btn_retour" runat="server" Text="Retour" OnClick="btn_retour_Click" />
                            <asp:Button Style="width: 40% !important; float: right;" CssClass="btn btn-lg btn-success input-box" ID="btn_generer" runat="server" Text="Généré le rapport" OnClick="btn_generer_Click" />
                        </td>
                    </tr>
                </table>
            </div>

        </div>
    </form>
</asp:Content>
