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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlaceHolder" runat="server">

    <form runat="server" style="text-align: center;" class="container center col-12">
        <div style="border: 3px solid green; padding: 5px 5px 5px 5px;">

            <div>
                <h1>
                    <asp:Label ID="lbl_Top" runat="server" Text="Ajout de Feuille de Temps"></asp:Label>
                </h1>
                <hr style="border: 20px solid #23282e; width: 100% !important; margin: 0px 0px 0px 0px; padding: 0px 0px 0px 0px" />
            </div>

            <div runat="server" id="alert_failed" visible="false" class="alert alert-danger" style="width:100%;">Une erreur est survenue !</div>

            <div class="row justify-content-md-center" style="margin-bottom: 100px;">
                <div class="col-md-offset-3 col-6">
                    <table style="width: 100% !important;">

                        <tr>
                            <th>
                                <h5 class="input-title">Projet</h5>
                            </th>
                        </tr>
                        <tr>
                            <td>
                                <asp:DropDownList CssClass="input-box" OnSelectedIndexChanged="tbx_projet_SelectedIndexChanged" name="idProjet" ID="tbx_projet" runat="server" DataTextField="titre" DataValueField="idProjet" AutoPostBack="true"></asp:DropDownList>
                            </td>
                        </tr>

                        <tr>
                            <th>
                                <h5 class="input-title">Sous-Catégorie</h5>
                            </th>
                        </tr>
                        <tr>
                            <td>
                                <asp:DropDownList CssClass="input-box" Enabled="false" ID="tbx_categorie" runat="server" DataTextField="titre" DataValueField="idProjetCat" AutoPostBack="true"></asp:DropDownList>
                            </td>
                        </tr>
                    </table>

                    <%--NO TEL ET EMAIL--%>
                    <table style="width: 100% !important;">
                        <%--NO TEL--%>
                        <tr>
                            <th>
                                <h5 class="input-title">Durée (hrs)</h5>
                            </th>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="tbx_nbHeure" runat="server" class="input-box"></asp:TextBox>
                            </td>
                        </tr>
                        <%--EMAIL--%>
                        <tr>
                            <th>
                                <h5 class="input-title">Commentaire</h5>
                            </th>
                        </tr>
                        <tr>
                            <td>
                                <textarea id="txa_comments" cols="50" rows="4" runat="server" style="width: 100%;"></textarea>
                            </td>
                        </tr>
                    </table>

                    <%--USERNAME ET PASSWORD--%>
                    <table style="width: 100% !important;">
                        <tr>
                            <th>
                                <h5>Date</h5>
                            </th>
                        </tr>
                        <tr>
                            <td>
                                <input type="date" id="Calendar1" style="margin: auto;" runat="server" />
                                

                            </td>
                        </tr>
                        <tr>
                            <td>
                                <h5 class="center" style="margin: auto !important;" id="dateFormated" runat="server"></h5>
                            </td>
                            
                        </tr>
                        <tr>
                            <td>
                                
                                <asp:Button ID="Btn_Enreg" style="margin-top:20px" runat="server" Text="Enregistrer" OnClick="Btn_Enreg_Click"/>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <%--On change for date--%>
           <script>
               var input = document.getElementById('<%=Calendar1.ClientID%>')
               console.log(input);
               UpdateDateFormat();

               input.onchange = function () {
                   UpdateDateFormat();
                   //UpdateDateRep();
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
        </div>
    </form>
</asp:Content>
