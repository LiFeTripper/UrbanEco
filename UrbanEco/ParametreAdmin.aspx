<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="ParametreAdmin.aspx.cs" Inherits="UrbanEco.ParametreAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .btn-ajouter:hover{
            cursor: pointer;
        }
        .btn-ajouter{
            cursor: default;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TitlePlaceholder" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
    <form runat="server">

        <%--EN-TËTE--%>
        <div class="form-group mb-4 col-6 mx-auto" style="text-align:center;">
            <h3>Paramètre Administrateur</h3>
        </div>        
        <div class="form-group mb-4 col-6 mx-auto">
            <label for="tbl_taux" style="font-size:20px;">Taux de kilomètrage</label>
            <asp:table runat="server" id="tbl_taux" enabled="false" style="width: 100%">
                <%--Voiture--%>
                <asp:TableRow>    
                    <asp:TableHeaderCell CssClass="form-control">Voiture</asp:TableHeaderCell>
                    <asp:TableCell>
                        <asp:TextBox CssClass="form-control" runat="server" ID="tbx_voiture"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
                <%--Camion--%>
                <asp:TableRow>
                    <asp:TableHeaderCell CssClass="form-control">Camion</asp:TableHeaderCell>
                    <asp:TableCell>
                        <asp:TextBox CssClass="form-control" runat="server" ID="tbx_camion" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:table>
        </div>
         <%--Type dépense Bureau--%>
        <div class="form-group mb-4 col-6 mx-auto">
            <h5 runat="server">Type de dépense (Bureau)</h5>
            <asp:table runat="server" id="tbl_depBureau" style="width: 100%">
                <asp:TableRow>    
                    <asp:TableCell>
                        <asp:TextBox ID="tbx_depBureau" runat="server"  CssClass="form-control"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button CssClass="btn btn-md btn-success" ID="btn_depBureau" runat="server" Text="Ajouter" style="width:100%;" />                    
                    </asp:TableCell>
                </asp:TableRow>
            </asp:table>
        </div>

        <%--Type dépense Terrain--%>
        <div class="form-group mb-4 col-6 mx-auto">
            <h5 runat="server">Type de dépense (Terrain)</h5>
            <asp:Table runat="server" ID="tbl_depTerrain" Style="width: 100%">
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:TextBox ID="tbx_depTerrain" runat="server" CssClass="form-control"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button CssClass="btn btn-md btn-success" ID="btn_depTerrain" runat="server" Text="Ajouter" style="width:100%;" />                    
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>


        </div>
        <%--DATE--%>
        <div class="form-group mb-4 col-6 mx-auto">
            <label for="Ddl_TypeEmp">Date</label>
            <input type="date" id="Calendar" style="margin: auto;" class="form-control" runat="server" />
            <%--DATE FORMATÉ--%>
        </div>
        <div class="form-group mb-4 col-6 mx-auto">
            <h5 id="dateFormated" runat="server"></h5>
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
                <%--var dateRep = document.getElementById('<%%>')--%>
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
        <div class="form-group mb-4 col-6 mx-auto">
            <h3>Information sur la dépense</h3>
        </div>
        <%--TYPE DE DÉPENSE--%>
        <div class="form-group mb-4 col-6 mx-auto">
            <label for="tbx_typeDepense">Type de dépense</label>
            <%--<asp:DropDownList class="form-control" ID="tbx_typeDepense" runat="server" DataTextField="nomDepense" DataValueField="idTypeDepense" DataSourceID="LinqTypeDepense" AutoPostBack="true" OnSelectedIndexChanged="tbx_typeDepense_SelectedIndexChanged"></asp:DropDownList>--%>
            <%--<asp:LinqDataSource ID="LinqTypeDepense" runat="server" ContextTypeName="UrbanEco.CoecoDataContext" EntityTypeName="" TableName="tbl_TypeDepense" />--%>
        </div>
        <%--KILO--%>
        <div class="form-group mb-4 col-6 mx-auto" id="km_html" runat="server" visible="true">
            <label for="tbx_montant1">Kilomètrage</label>
            <%--<asp:TextBox class="form-control" ID="tbx_montant1" runat="server" AutoPostBack="true" OnTextChanged="tbx_montant1_TextChanged"></asp:TextBox>--%>
            <h5 runat="server" id="montantTotalDepense" class="input-title" style="width: 40%; float: left; text-align: left;">* 0.47$ = </h5>
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
            <asp:button style="width: 40% !important; float: left;" cssclass="btn btn-lg btn-danger input-box" id="btn_annuler" runat="server" text="Annuler" />
            <asp:button style="width: 40% !important; float: right;" cssclass="btn btn-lg btn-success input-box" id="btn_envoyer" runat="server" text="Confirmer l'ajout" />
        </div>
    </form>
</asp:Content>
