<%@ Page Title="Co-Éco" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="AjoutDepense.aspx.cs" Inherits="UrbanEco.AjoutDepense" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="lib/css/ajoutDepenseForm.css" />
    <title>Co-Éco - Ajout de dépenses</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="TitlePlaceHolder" runat="server">
    <h1>Ajouter une dépense</h1>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
    <form runat="server">

        <%--Employé--%>
        <div id="divEmp" runat="server" visible="false" class="form-group">
            <label for="ddlEmp" class="bmd-label-floating">Nom de l'employé</label>
            <asp:DropDownList ID="ddlEmp" name="idEmploye" runat="server" OnSelectedIndexChanged="ddlEmp_SelectedIndexChanged" DataTextField="text" DataValueField="value" AutoPostBack="true" class="form-control"></asp:DropDownList>
        </div>

        <%--Projet--%>
        <div class="form-group" runat="server">
            <label for="ddlEmp" class="bmd-label-floating">Nom du projet</label>
            <asp:DropDownList ID="tbx_projet" OnSelectedIndexChanged="tbx_projet_SelectedIndexChanged" name="idProjet" runat="server" DataTextField="titre" DataValueField="idProjet" AutoPostBack="true" class="form-control"></asp:DropDownList>
        </div>

        <%--SOUS-CATÉGORIE--%>

        <div class="form-group spantwo" runat="server" id="SProjet" visible="false">
            <label for="ddlEmp" class="bmd-label-floating">Sous-Catégorie</label>
            <asp:DropDownList ID="tbx_categorie" Enabled="false" name="idProjet" runat="server" DataTextField="text" DataValueField="value" AutoPostBack="true" class="form-control"></asp:DropDownList>
        </div>

        <div class="form-group">
            <label for="Calendar" class="bmd-label-floating">Modifier date de facturation</label>
            <input type="date" id="Calendar" class="form-control" runat="server" />
        </div>

        <div class="form-group bold alignEnd">
            <div id="dateFormated" runat="server"></div>
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

        <%--EN-TËTE--%>
        <h3 class="spantwo">Informations sur la dépense</h3>

        <%--Type de dépense--%>
        <div class="form-group spantwo" runat="server">
            <label for="ddlEmp" class="bmd-label-floating">Type de dépense</label>
            <asp:DropDownList ID="tbx_typeDepense" runat="server" DataTextField="text" DataValueField="value" AutoPostBack="true" class="form-control" OnSelectedIndexChanged="tbx_typeDepense_SelectedIndexChanged"></asp:DropDownList>
        </div>

        <div class="form-group spantwo champKilometrage" runat="server" id="km_html">
            <div class="form-group">
                <label for="tbx_nbKm" class="bmd-label-floating">Kilométrage</label>
                <asp:TextBox CssClass="form-control" id="tbx_nbKm" runat="server"  type="number" OnTextChanged="tbx_nbKm_TextChanged" AutoPostBack="false"></asp:TextBox>
            </div>

            <div class="form-group flexEnd">
                <label for="prixKm" class="bmd-label-floating">Taux</label>
                <div runat="server" id="prixKm"></div>
            </div>

            <div class="form-group flexEnd">
                <label for="prixTotalKm" class="bmd-label-floating">Total</label>
                <div runat="server" id="prixTotalKm"></div>
            </div>

            <div class="flexEnd">
                 <asp:Button CssClass="btn btn-raised btn-info boutonCalculer" ID="btnCalculer" runat="server" Text="Calculer"  />
            </div>
        </div>
        
        


        <div class="form-group" runat="server" id="montant_html">
            <label for="tbx_montantNormal" class="bmd-label-floating">Montant ($)</label>
            <asp:TextBox CssClass="form-control" id="tbx_montantNormal" runat="server" OnTextChanged="tbx_nbKm_TextChanged" AutoPostBack="false" type="number"></asp:TextBox>
        </div>


        <%--NOTES--%>
        <div class="" id="Div1" runat="server">
            <label for="tbx_note" class="bmd-label-floating">Note</label>
            <asp:TextBox class="form-control" ID="tbx_note" runat="server" Rows="1" AutoPostBack="true" TextMode="MultiLine"></asp:TextBox>
        </div>

        <div class="form-group" runat="server">
            <script type="text/javascript">
                function showpreview(input) {

                    if (input.files && input.files[0]) {

                        var reader = new FileReader();
                        reader.onload = function (e) {
                            var image = document.getElementById('<%=imgpreview.ClientID%>');
                            var source = document.getElementById('<%=base64img.ClientID%>');
                            image.style.visibility = "visible";
                            image.src = e.target.result;
                            source.value = e.target.result;
                        }
                        reader.readAsDataURL(input.files[0]);
                    }
                }
            </script>
            <label for="fupl_facture">Ajouter une facture</label>
            <asp:FileUpload ID="fuimage" runat="server" onchange="showpreview(this);"/>
            <img id="imgpreview" runat="server" src="" height="200" width="500" style="border-width: 0px; visibility: hidden;"/>
            <input id="base64img" runat="server" type="hidden" />
        </div>

        <%--MESSAGES--%>
        <div class="form-group spantwo">
            <div class="alert alert-success" runat="server" id="alert_success" visible="false">
                <strong>Succès!</strong>  Votre dépense a bien été ajoutée !
            </div>
            <div class="alert alert-danger" runat="server" id="alert_failed" visible="false">
                <strong>Erreur!</strong>  Votre dépense n'as pas pu être ajoutée à la base de donnée !
            </div>
            <div class="alert alert-warning" runat="server" id="alert_warning" visible="false">
                <strong>Attention!</strong>  Votre dépense a déjà été ajoutée à la base de donnée !
            </div>
        </div>
        <%--BOUTON--%>
        <asp:Button CssClass="btn btn-raised btn-success" ID="btn_envoyer" runat="server" Text="Confirmer" OnClick="btn_envoyer_Click" />
        <asp:Button CssClass="btn btn-raised btn-danger" ID="btn_annuler" runat="server" Text="Annuler" OnClick="btn_annuler_Click" />
    </form>
</asp:Content>
