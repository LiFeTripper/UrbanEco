<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="AjoutDepense.aspx.cs" Inherits="UrbanEco.AjoutDepense" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .asp-table {
            table-layout:fixed;
        }
    </style>
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
            <asp:table CssClass="asp-table" runat="server" style="width: 100% !important;">
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
            <asp:table CssClass="asp-table" runat="server" style="width: 100% !important;">
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

        <div class="form-group mb-4 col-6 mx-auto">
            <label for="Ddl_TypeEmp">Date</label>
            <asp:table CssClass="asp-table" runat="server" id="Ddl_TypeEmp" style="width: 100% !important;">
                <%--DATE--%>
                <asp:TableRow>    
                    <asp:TableHeaderCell CssClass="form-control">
                        <div id="dateFormated" runat="server" style="width:100%; font-size:15px;"></div>
                    </asp:TableHeaderCell>
                    <asp:TableCell>
                        <input type="date" id="Calendar" style="width:100%;" class="form-control" runat="server" />
                    </asp:TableCell>
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
            <asp:table CssClass="asp-table" runat="server" style="width: 100% !important;">
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


        <div class="form-group mb-4 col-6 mx-auto" runat="server" id="km_html">
            <label for="tbl_kilo">Kilomètrage</label>
            <asp:table CssClass="asp-table" runat="server" id="tbl_kilo" style="width: 100% !important;">
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


        <div class="form-group mb-4 col-6 mx-auto" runat="server" id="montant_html">
            <label for="tbl_montant">Montant</label>
            <asp:table CssClass="asp-table" runat="server" id="tbl_montant" style="width: 100% !important;">
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
