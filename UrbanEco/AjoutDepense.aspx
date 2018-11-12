<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="AjoutDepense.aspx.cs" Inherits="UrbanEco.AjoutDepense" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
       <style>
           .center {
                margin: auto;
                width: 50%;
            }

           .input-box{
               width: 100% !important; 
               font-size: 17px; 
               margin-bottom: 30px;
           }

           .input-title {
                text-align:left !important;
           }

           .table-custom{

                width:800px !important;
            
           }

           .table-custom > table{
               width:100% !important;
           }

       </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
    <form runat="server" style="text-align:center;" class="container center col-12">
        <div>
            <h1>
                Ajouter une dépense
            </h1>
            <hr style="border: 20px solid #23282e; width: 100% !important; margin: 0px 0px 0px 0px; padding: 0px 0px 0px 0px" />
        </div>


        <div class="row justify-content-md-center" style="margin-bottom:100px;">
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
<%--                            <asp: type="date" id="Calendar" style="margin:auto;" runat="server" autopostback="true"></asp:>--%>
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
                            <asp:Button CssClass="btn btn-lg btn-success input-box" ID="btn_envoyer" runat="server" Text="Confirmer l'ajout" OnClick="btn_envoyer_Click" />
                        </td>
                    </tr>
                </table>
            </div>

        </div>
    </form>
</asp:Content>
