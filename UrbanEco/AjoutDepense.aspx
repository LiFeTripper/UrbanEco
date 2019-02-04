<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="AjoutDepense.aspx.cs" Inherits="UrbanEco.AjoutDepense" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="lib/css/ajoutDepenseForm.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="TitlePlaceHolder" runat="server">
    <h1>Ajouter une dépense</h1>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
    <form runat="server">

        <%--EN-TËTE--%>
        <div class="form-group spantwo">
            <h3>Projet associé</h3>
        </div>

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
        <div class="spantwo">
            <h3>Information sur la dépense</h3>
        </div>

        <%--Type de dépense--%>
        <div class="form-group" runat="server">
            <label for="ddlEmp" class="bmd-label-floating">Type De Dépense</label>
            <asp:DropDownList ID="tbx_typeDepense" runat="server" DataTextField="text" DataValueField="value" AutoPostBack="true" class="form-control" OnSelectedIndexChanged="tbx_typeDepense_SelectedIndexChanged"></asp:DropDownList>
        </div>



        <div class="form-group" runat="server" id="km_html">
            <div class="form-group">
                <label for="tbl_kilo" class="bmd-label-floating">Kilomètrage</label>
                <asp:TextBox CssClass="form-control" id="tbx_nbKm" runat="server"  OnTextChanged="tbx_nbKm_TextChanged" AutoPostBack="true" TextMode="Number"></asp:TextBox>
            </div>

            <div class="form-group">
                <div runat="server" id="prixKm"></div>
            </div>

            <div class="form-group">
                <div runat="server" id="prixTotalKm"></div>
            </div>
        </div>
        
        


        <div class="form-group mb-4 col-6 mx-auto" runat="server" id="montant_html">
            <%--<label for="tbl_montant">Montant</label>--%>
            <asp:table CssClass="asp-table" runat="server" id="tbl_montant" style="width: 100% !important;">
                <asp:TableRow>    
                    <asp:TableHeaderCell CssClass="form-control">
                        Montant <b style="color:red">*</b>
                    </asp:TableHeaderCell>  
                    <asp:TableCell>
                        <asp:TextBox CssClass="form-control" id="tbx_montantNormal" runat="server" style="width:100%; font-size:15px;" OnTextChanged="tbx_nbKm_TextChanged" AutoPostBack="true"  TextMode="Number"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:table>
        </div>

        <%--NOTES--%>
        <div class="" id="Div1" runat="server">
            <label for="tbx_note">Note</label>
            <asp:TextBox class="form-control" ID="tbx_note" runat="server" Rows="3" AutoPostBack="true" TextMode="MultiLine"></asp:TextBox>
        </div>

        File upload facture
        <div class="form-group mb-4 col-6 mx-auto" runat="server">
            <script type="text/javascript">
                function showpreview(input) {

                    if (input.files && input.files[0]) {

                        var reader = new FileReader();
                        reader.onload = function (e) {
                            $('#imgpreview').css('visibility', 'visible');
                            $('#imgpreview').attr('src', e.target.result);
                        }
                        reader.readAsDataURL(input.files[0]);
                    }

                }

            </script>
            <label for="fupl_facture">Ajouter une facture</label>
            <asp:FileUpload ID="fuimage" runat="server" onchange="showpreview(this);" />
            <img id="imgpreview" src="" height="200" width="200" style="border-width: 0px; visibility: hidden;"/>
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
            <asp:Button Style="width: 40% !important; float: left;" CssClass="btn btn-lg btn-raised btn-danger input-box" ID="btn_annuler" runat="server" Text="Annuler" OnClick="btn_annuler_Click" />
            <asp:Button Style="width: 40% !important; float: right;" CssClass="btn btn-lg btn-raised btn-success input-box" ID="btn_envoyer" runat="server" Text="Confirmer" OnClick="btn_envoyer_Click" />
        </div>
    </form>
</asp:Content>
