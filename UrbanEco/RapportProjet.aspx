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
                            <h5 style="float: right; width: 49% !important;" class="input-title">Sélectionné(s)</h5>
                        </th>
                    </tr>
                    <tr>
                        <td>
                            <%--<asp:DropDownList CssClass="input-box" Enabled="false" ID="tbx_categorie" runat="server"  DataTextField="titre" DataValueField="idProjetCat" autopostback="true"></asp:DropDownList>--%>
                            <asp:ListBox Style="float: left; width: 45% !important;" CssClass="input-box" Enabled="false" DataTextField="text" DataValueField="value" ID="tbx_categorie" runat="server"></asp:ListBox>
                            <table style="width: 7% !important; float: left;">
                                <tr>
                                    <td>
                                        <asp:Button ID="SelectCat" runat="server" Text=">" CssClass="btn btn-sm btn-primary" OnClick="SelectCat_Click" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 30px;"></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Button ID="DeSelectCat" runat="server" Text="<" CssClass="btn btn-sm btn-primary" OnClick="DeSelectCat_Click" />
                                    </td>
                                </tr>
                            </table>
                            <asp:ListBox Style="float: left; width: 45% !important;" CssClass="input-box" Enabled="false" DataTextField="text" DataValueField="value" ID="tbx_categorie_selected" runat="server"></asp:ListBox>
                            <%--<asp:CheckBoxList style="text-align:left; float:left;" CssClass="input-box" Enabled="false"  DataTextField="titre" DataValueField="idProjetCat" ID="tbx_categorie" runat="server"></asp:CheckBoxList>--%>

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

            function UpdateDateRep() {
                var dateRep = document.getElementById('<%=rep_date.ClientID%>')
                var format = FormatYear(input.value);
                dateRep.innerText = format;
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
                            <h5 class="input-title">Employés</h5>
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
                                                    <option value='<%#Eval("idEmploye") %>' <%# IsSelected(Eval("idEmploye"), this) %> ><%# String.Format("{0} {1}", Eval("nom"), Eval("prenom")) %></option>
                                                </ItemTemplate>
                                        </asp:Repeater>
                                    </optgroup>
                                    <optgroup label='Terrain'>
                                        <asp:Repeater runat="server" ID="RepTerrain" >
                                                <ItemTemplate>
                                                    <option value='<%#Eval("idEmploye") %>' <%# IsSelected(Eval("idEmploye"), this) %>  ><%# String.Format("{0} {1}", Eval("nom"), Eval("prenom")) %></option>
                                                </ItemTemplate>
                                        </asp:Repeater>
                                    </optgroup>
                                </select>
                            </div>

                            <input type="text" runat="server" id="array" />
                            <asp:Button ID="test" runat="server" Text="Show Array" OnClick="test_Click"/>

                            <!--Multiselect javascript-->
                            <script>
                                //Callback for fuck sake
                                var selected = document.getElementById('<%=array.ClientID%>').value.split(',');

                                var test = selected;



                                //ID du crisse de multi + class du css
                                $('#Multiselection').multiSelect({
                                    //EVENT inscrit nul part guess Onchange, onSelected pis onclick avec function return click
                                    afterSelect: function (values) {
                                        //Parce que D'amours
                                        selected.push(values);
                                        console.log(selected);


                                        var htmlStorage = document.getElementById('<%=array.ClientID%>');
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
                                        var htmlStorage = document.getElementById('<%=array.ClientID%>');
                                        //htmlStorage.attr("data-assessments", JSON.stringify(selected));
                                        htmlStorage.value = selected;
                                    },

                                    selectableOptgroup: true,
                                    keepOrder: true,
                                    selected: test,
                                });

                                function IsSelected(idEmploye) {

                                }

                                //RÉUSSI
                            </script>
                        </td>
                    </tr>

                    <div id="km_html" runat="server" visible="true">
                        <tr>
                            <th>
                                <h5 class="input-title">Kilomètrage</h5>
                            </th>
                        </tr>
                        <tr>
                            <td style="width: 60%; float: left;">
                                <%--<asp:TextBox class="input-box" ID="tbx_montant1" runat="server" autopostback="true" OnTextChanged="tbx_montant1_TextChanged"></asp:TextBox>--%>                               
                            </td>
                            <td style="width: 40%; float: left; text-align: left;">
                                <h5 runat="server" id="montantTotalDepense" class="input-title">* 0.47$ = </h5>
                            </td>
                        </tr>
                    </div>

                    <div id="montant_html" runat="server" visible="false">
                        <tr>
                            <th>
                                <h5 class="input-title">Montant</h5>
                            </th>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox class="input-box" ID="tbx_montant2" runat="server" AutoPostBack="true"></asp:TextBox>
                            </td>
                        </tr>
                    </div>

                    <tr>
                        <th>
                            <h5 class="input-title">Note</h5>
                        </th>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox class="input-box" ID="tbx_note" runat="server" Rows="3" AutoPostBack="true" TextMode="MultiLine"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <h5 class="input-title">Récapitulatif de votre dépense</h5>
                            <table style="width: 100%">
                                <tr style="width: 100%">
                                    <td id="rep_nomEmployer" style="text-align: left;" runat="server"></td>
                                    <td id="rep_date" style="text-align: right;" runat="server"></td>
                                </tr>
                                <tr style="width: 100%">
                                    <td id="rep_projet" style="text-align: left;" runat="server"></td>
                                    <td id="rep_categorie" style="text-align: right;" runat="server"></td>
                                </tr>
                                <tr style="width: 100%">
                                    <td id="rep_typeDepense" style="text-align: left;" runat="server"></td>
                                    <td id="rep_montant" style="text-align: right;" runat="server"></td>
                                </tr>
                            </table>

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
                            <asp:Button Style="width: 40% !important; float: left;" CssClass="btn btn-lg btn-danger input-box" ID="btn_annuler" runat="server" Text="Annuler" OnClick="btn_annuler_Click" />
                            <asp:Button Style="width: 40% !important; float: right;" CssClass="btn btn-lg btn-success input-box" ID="btn_envoyer" runat="server" Text="Confirmer l'ajout" OnClick="btn_envoyer_Click" />
                        </td>
                    </tr>
                </table>
            </div>

        </div>
    </form>
</asp:Content>
