<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="AjoutDepense.aspx.cs" Inherits="UrbanEco.AjoutDepense" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="TitlePlaceHolder" runat="server">
    <h1>Ajouter une dépense</h1>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
    <form runat="server">

        <%--EN-TËTE--%>
        <div class="form-group mb-4 col-6 mx-auto">
            <h3>Projet associé</h3>
        </div>

        <%--Projet--%>
        <div class="form-group mb-4 col-6 mx-auto" runat="server">
            <asp:table runat="server" style="width: 100% !important;">
                <asp:TableRow>    
                    <asp:TableHeaderCell CssClass="form-control">
                        Nom du projet
                    </asp:TableHeaderCell>    
                    <asp:TableCell>
                        <asp:DropDownList CssClass="form-control" OnSelectedIndexChanged="tbx_projet_SelectedIndexChanged" name="idProjet" ID="tbx_projet" runat="server" DataTextField="titre" DataValueField="idProjet" AutoPostBack="true"></asp:DropDownList>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:table>
        </div>

        <%--SOUS-CATÉGORIE--%>
        <div class="form-group mb-4 col-6 mx-auto" runat="server" id="SProjet" visible="false">
            <asp:table runat="server" style="width: 100% !important;">
                <asp:TableRow>    
                    <asp:TableHeaderCell CssClass="form-control" style="width:100%;">
                        Sous-catégorie
                    </asp:TableHeaderCell>    
                    <asp:TableCell>
                        <asp:DropDownList CssClass="form-control" Enabled="false" ID="tbx_categorie" runat="server" DataTextField="text" DataValueField="value" AutoPostBack="true"></asp:DropDownList>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:table>
        </div>

        <%--DATE--%>
<%--        <div class="form-group mb-4 col-6 mx-auto">
            <label for="Ddl_TypeEmp">Date</label>
            <input type="date" id="Calendar" style="margin: auto; width:50%; float:left;" class="form-control" runat="server" />
        </div>--%>

        <div class="form-group mb-4 col-6 mx-auto">
            <label for="Ddl_TypeEmp">Date</label>
            <asp:table runat="server" id="Ddl_TypeEmp" style="width: 100% !important;">
                <%--DATE--%>
                <asp:TableRow>    
                    <asp:TableCell>
                        <input type="date" id="Calendar" style="width:100%;" class="form-control" runat="server" />
                    </asp:TableCell>
                    <asp:TableHeaderCell CssClass="form-control">
                        <div id="dateFormated" runat="server" style="width:100%; font-size:15px;"></div>
                    </asp:TableHeaderCell>
                </asp:TableRow>
            </asp:table>
        </div>

        <%--On change for date--%>
        <script>
            var input = document.getElementById('<%=Calendar.ClientID%>')

            UpdateDateFormat();

            input.onchange = function () {
                UpdateDateFormat();
                UpdateDateRep();
            }

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
<%--                var dateRep = document.getElementById('<%=rep_date.ClientID%>')--%>
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

        <div class="form-group mb-4 col-6 mx-auto">
            <hr style="width:100%; border:2px solid black;"/>
        </div>

        <%--EN-TËTE--%>
        <div class="form-group mb-4 col-6 mx-auto">
            <h3>Information sur la dépense</h3>
        </div>

        <%--Type de dépense--%>
        <div class="form-group mb-4 col-6 mx-auto" runat="server">
            <asp:table runat="server" style="width: 100% !important;">
                <asp:TableRow>    
                    <asp:TableHeaderCell CssClass="form-control">
                        Type de dépense
                    </asp:TableHeaderCell>    
                    <asp:TableCell>
                        <asp:DropDownList class="form-control" ID="tbx_typeDepense" runat="server" DataTextField="text" DataValueField="value" AutoPostBack="true" OnSelectedIndexChanged="tbx_typeDepense_SelectedIndexChanged"></asp:DropDownList>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:table>
        </div>

        <%--KILO--%>
<%--        <div class="form-group mb-4 col-6 mx-auto" id="km_html" runat="server" visible="true">
            <label for="tbx_montant1">Kilomètrage</label>
            <asp:TextBox class="form-control" ID="tbx_montant1" runat="server" AutoPostBack="true" OnTextChanged="tbx_montant1_TextChanged"></asp:TextBox>
            <h5 runat="server" id="montantTotalDepense" class="input-title" style="width: 40%; float: left; text-align: left;">* 0.47$ = </h5>
        </div>--%>

        <div class="form-group mb-4 col-6 mx-auto" runat="server" id="km_html">
            <label for="tbl_kilo">Kilomètrage</label>
            <asp:table runat="server" id="tbl_kilo" style="width: 100% !important;">
                <asp:TableRow>    
                    <asp:TableCell>
                        <asp:TextBox CssClass="form-control" id="tbx_nbKm" runat="server" style="width:100%; font-size:15px;" OnTextChanged="tbx_nbKm_TextChanged" AutoPostBack="true"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableHeaderCell CssClass="form-control">
                        <div runat="server" id="prixKm" style=" float:left; text-align:left;"></div>
                        <div runat="server" id="prixTotalKm" style=" float:right; text-align:left;"></div>
                    </asp:TableHeaderCell>    
                </asp:TableRow>
            </asp:table>
        </div>

        <%--MONTANT--%>
<%--        <div class="form-group mb-4 col-6 mx-auto" id="montant_htm1l" runat="server" visible="false">
            <label for="tbx_montant2">Montant</label>
            <asp:TextBox class="form-control" ID="tbx_montant2" runat="server" AutoPostBack="true"></asp:TextBox>
        </div>--%>

        <div class="form-group mb-4 col-6 mx-auto" runat="server" id="montant_html">
            <label for="tbl_montant">Montant</label>
            <asp:table runat="server" id="tbl_montant" style="width: 100% !important;">
                <asp:TableRow>    
                    <asp:TableHeaderCell CssClass="form-control">
                        Montant
                    </asp:TableHeaderCell>  
                    <asp:TableCell>
                        <asp:TextBox CssClass="form-control" id="tbx_montantNormal" runat="server" style="width:100%; font-size:15px;" OnTextChanged="tbx_nbKm_TextChanged" AutoPostBack="true"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:table>
        </div>

        <%--NOTES--%>
        <div class="form-group mb-4 col-6 mx-auto" id="Div1" runat="server">
            <label for="tbx_note">Note</label>
            <asp:TextBox class="form-control" ID="tbx_note" runat="server" Rows="3" AutoPostBack="true" TextMode="MultiLine"></asp:TextBox>
        </div>

        <%--EN-TËTE--%>
<%--        <div class="form-group mb-4 col-6 mx-auto">
            <h3>Récapitulatif de la dépense</h3>
        </div>--%>
        <%--RÉCAPITULATIF--%>
<%--        <div class="form-group mb-4 col-6 mx-auto">
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
        </div>--%>
        <%--MESSAGES--%>
        <div class="form-group mb-4 col-6 mx-auto">
            <div class="alert alert-success" runat="server" id="alert_success" visible="false">
                <strong>Succès!</strong>  Votre dépense a bien été ajouté !
            </div>
            <div class="alert alert-danger" runat="server" id="alert_failed" visible="false">
                <strong>Erreur!</strong>  Votre dépense n'as pas pu être ajouté à la base de donnée !
            </div>
            <div class="alert alert-warning" runat="server" id="alert_warning" visible="false">
                <strong>Attention!</strong>  Votre dépense a déjà été ajouté à la base de donnée !
            </div>
        </div>
        <%--BOUTON--%>
        <div class="form-group mb-4 col-6 mx-auto">
            <asp:Button Style="width: 40% !important; float: left;" CssClass="btn btn-lg btn-danger input-box" ID="btn_annuler" runat="server" Text="Annuler" OnClick="btn_annuler_Click" />
            <asp:Button Style="width: 40% !important; float: right;" CssClass="btn btn-lg btn-success input-box" ID="btn_envoyer" runat="server" Text="Confirmer l'ajout" OnClick="btn_envoyer_Click" />
        </div>
    </form>
</asp:Content>

<%--<form runat="server" style="text-align:center;" class="container center col-12">--%>
<%--<div>
            <h1>
                Ajouter une dépense
            </h1>
            <hr style="border: 20px solid #23282e; width: 100% !important; margin: 0px 0px 0px 0px; padding: 0px 0px 0px 0px" />
        </div>--%>

<%--<div class="row justify-content-md-center" style="margin-bottom:20px;">
            <div class="col-md-offset-3 col-6">

                <table style="width: 100% !important;">
                    <tr>
                        <th>
                            <h3>Projet associé</h3>
                        </th>
                    </tr>
                    <tr>
                        <th>
                            <h5 class="input-title">Nom du projet</h5>
                        </th>
                    </tr>
                    <tr>
                        <td>
                            <asp:DropDownList CssClass="input-box"  OnSelectedIndexChanged="tbx_projet_SelectedIndexChanged" name="idProjet" ID="tbx_projet" runat="server" DataTextField="titre" DataValueField="idProjet" AutoPostBack="true"></asp:DropDownList>
                        </td>
                    </tr>

                    <tr>
                        <th>
                            <h5 class="input-title">Sous-Catégorie</h5>
                        </th>
                    </tr>
                    <tr>
                        <td>
                            <asp:DropDownList CssClass="input-box" Enabled="false" ID="tbx_categorie" runat="server"  DataTextField="titre" DataValueField="idProjetCat" autopostback="true"></asp:DropDownList>
                        </td>
                    </tr>

                    <tr>
                        <th>
                            <h5>Date</h5>
                        </th>
                    </tr>
                    <tr>
                        <td>
                            <input type="date" ID="Calendar" style="margin:auto;" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <h5 class="center" style="margin:auto !important;" id="dateFormated" runat="server"></h5>
                        </td>
                    </tr>
                </table>
            </div>
        </div>--%>

<%--On change for date--%>
<%--        <script>

        </script>--%>

<%--        <div class="row justify-content-md-center">
            <div class="col-md-offset-3 col-6">

                <table style="width: 100% !important;">
                    <tr>
                        <th>
                            <h3>Information sur la dépense</h3>
                        </th>
                    </tr>
                    <tr>
                        <th>
                            <h5 class="input-title">Type de dépense</h5>
                        </th>
                    </tr>
                    <tr>
                        <td>
                            <asp:DropDownList class="input-box" ID="tbx_typeDepense" runat="server" DataTextField="nomDepense" DataValueField="idTypeDepense" DataSourceID="LinqTypeDepense" autopostback="true" OnSelectedIndexChanged="tbx_typeDepense_SelectedIndexChanged"></asp:DropDownList>
                            <asp:LinqDataSource ID="LinqTypeDepense" runat="server" ContextTypeName="UrbanEco.CoecoDataContext" EntityTypeName="" TableName="tbl_TypeDepense">
                            </asp:LinqDataSource>
                        </td>
                    </tr>

                    <div id="km_html" runat="server" visible="true">
                        <tr>
                            <th>
                                <h5 class="input-title">Kilomètrage</h5>
                            </th>
                        </tr>
                        <tr>
                            <td style="width:60%; float:left;">
                                <asp:TextBox class="input-box" ID="tbx_montant1" runat="server" autopostback="true" OnTextChanged="tbx_montant1_TextChanged"></asp:TextBox>                               
                            </td>
                            <td style="width:40%; float:left; text-align:left;">
                                <h5 runat="server" id="montantTotalDepense" class="input-title"> * 0.47$ = </h5>                              
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
                                <asp:TextBox class="input-box" ID="tbx_montant2" runat="server" autopostback="true"></asp:TextBox>
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
                            <asp:TextBox class="input-box" ID="tbx_note" runat="server" Rows="3" autopostback="true" TextMode="MultiLine"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <h5 class="input-title">Récapitulatif de votre dépense</h5>
                            <table style="width:100%">
                                <tr style="width:100%">
                                    <td id="rep_nomEmployer" style="text-align:left;" runat="server"></td>
                                    <td id="rep_date" style="text-align:right;" runat="server"></td>
                                </tr>
                                <tr style="width:100%">
                                    <td id="rep_projet" style="text-align:left;" runat="server"></td>
                                    <td id="rep_categorie" style="text-align:right;" runat="server"></td>
                                </tr>
                                <tr style="width:100%">
                                    <td id="rep_typeDepense" style="text-align:left;" runat="server"></td>
                                    <td id="rep_montant" style="text-align:right;" runat="server"></td>
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
                            <asp:Button style="width:40% !important; float:left;" CssClass="btn btn-lg btn-danger input-box" ID="btn_annuler" runat="server" Text="Annuler" OnClick="btn_annuler_Click" />
                            <asp:Button style="width:40% !important; float:right;" CssClass="btn btn-lg btn-success input-box" ID="btn_envoyer" runat="server" Text="Confirmer l'ajout" OnClick="btn_envoyer_Click" />
                        </td>
                    </tr>
                </table>
            </div>--%>
<%--</div>--%>
<%--</form>--%>