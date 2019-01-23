<%@ Page Title="Ajout de feuille de temps" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="AjoutFT.aspx.cs" Inherits="UrbanEco.AjoutFT" %>

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

        .asp-table {
            table-layout: fixed;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TitlePlaceHolder" runat="server">
    <h1>Ajout de Feuille de Temps</h1>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlaceHolder" runat="server">



    <form runat="server" style="text-align: center;" class="container center col-12">

        <div class="form-group mb-4 col-6 mx-auto" runat="server" id="tbl_employe" visible="false">
            <asp:Table CssClass="asp-table" runat="server" Style="width: 100% !important;">
                <asp:TableRow>
                    <asp:TableHeaderCell CssClass="form-control">
                        Employés <b style="color:red">*</b>
                    </asp:TableHeaderCell>
                    <asp:TableCell>
                        <asp:DropDownList CssClass="form-control" OnSelectedIndexChanged="ddl_employe_SelectedIndexChanged" ID="ddl_employe" runat="server" AutoPostBack="true" DataTextField="text" DataValueField="value"></asp:DropDownList>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>

        <div class="form-group mb-4 col-6 mx-auto" runat="server" >
            <asp:Table CssClass="asp-table" runat="server" Style="width: 100% !important;">
                <asp:TableRow>
                    <asp:TableHeaderCell CssClass="form-control">
                        Projets <b style="color:red">*</b>
                    </asp:TableHeaderCell>
                    <asp:TableCell>
                        <asp:DropDownList CssClass="form-control" OnSelectedIndexChanged="tbx_projet_SelectedIndexChanged" name="idProjet" ID="tbx_projet" runat="server" DataTextField="text" DataValueField="value" AutoPostBack="true" Visible="true"></asp:DropDownList>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>

        <div class="form-group mb-4 col-6 mx-auto" runat="server">
            <asp:Table CssClass="asp-table" runat="server" Style="width: 100% !important;">
                <asp:TableRow>
                    <asp:TableHeaderCell CssClass="form-control">
                        Sous-Catégorie
                    </asp:TableHeaderCell>
                    <asp:TableCell>
                        <asp:DropDownList CssClass="form-control" Enabled="false" ID="tbx_categorie" runat="server" DataTextField="text" DataValueField="value" AutoPostBack="true"></asp:DropDownList>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>

        <div class="form-group mb-4 col-6 mx-auto" runat="server">
            <asp:Table CssClass="asp-table" runat="server" Style="width: 100% !important;">
                <asp:TableRow>
                    <asp:TableHeaderCell CssClass="form-control">
                        Durée (hrs) <b style="color:red">*</b>
                    </asp:TableHeaderCell>
                    <asp:TableCell>
                        <asp:TextBox ID="tbx_nbHeure" runat="server" CssClass="form-control"></asp:TextBox>
<%--                        <asp:RegularExpressionValidator ID="heureCheck" runat="server" Display="Dynamic" ControlToValidate="tbx_nbHeure" ErrorMessage="Nombre d'heure invalide" ValidationExpression="^-?([0-9]{0,2}(\.[0-5])?|100(\.00?)?)$"></asp:RegularExpressionValidator>--%>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>

        <div class="form-group mb-4 col-6 mx-auto" runat="server">
            <asp:Table CssClass="asp-table" runat="server" Style="width: 100% !important;">
                <asp:TableRow>
                    <asp:TableHeaderCell CssClass="form-control">
                        Commentaire
                    </asp:TableHeaderCell>
                    <asp:TableCell>
                        <textarea id="txa_comments" cols="50" rows="4" runat="server" style="width: 100%;" class="form-control"></textarea>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>


        <div class="form-group mb-4 col-6 mx-auto" runat="server" style="margin-bottom: 0px;">
            <asp:Table CssClass="asp-table" runat="server" Style="width: 100% !important;">
                <asp:TableRow CssClass="col-md-12">
                    <asp:TableHeaderCell CssClass="form-control">
                        <b style="color:red; float:right;">*</b><h5  id="dateFormated" runat="server"></h5>
                    </asp:TableHeaderCell>
                    <asp:TableCell>
                        <input type="date" id="DateCreation" style="margin: auto;" runat="server" class="form-control" />
                    </asp:TableCell>
                </asp:TableRow>

            </asp:Table>
        </div>

        <div class="form-group mb-4 col-6 mx-auto" runat="server" style="margin-bottom: 0px;">
            <asp:Table CssClass="asp-table" runat="server" Style="width: 100% !important;">
                <asp:TableRow CssClass="col-md-12">
                    <asp:TableCell CssClass="col-md-4">
                        <asp:Button ID="btn_annuler" CssClass="btn btn-lg btn-danger col-md-12" runat="server" Text="Annuler" OnClick="btn_annuler_Click" />
                    </asp:TableCell>
                    <asp:TableCell CssClass="col-md-4">
                        &nbsp;
                    </asp:TableCell>
                    <asp:TableCell CssClass="col-md-4">
                        <asp:Button ID="Btn_Enreg" CssClass="btn btn-lg btn-success col-md-12" runat="server" Text="Enregistrer" OnClick="Btn_Enreg_Click" />
                    </asp:TableCell>
                </asp:TableRow>

            </asp:Table>
        </div>

        <%--On change for date--%>
        <script>
            var input = document.getElementById('<%=DateCreation.ClientID%>')
            console.log(input);
            UpdateDateFormat();

            input.onchange = function () {
                //UpdateDateFormat();
                //UpdateDateRep();
            }

            function UpdateDateFormat() {

                var dateFormated = document.getElementById('<%=dateFormated.ClientID%>')

                if (input.value != "") {
                    dateFormated.innerText = "Veuillez sélectionner la date";
                    return;
                }

                //var format = FormatYear(input.value);

                //dateFormated.innerText = format;


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
        
    </form>
</asp:Content>
