<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="GestionFeuilleTemps.aspx.cs" Inherits="UrbanEco.GestionFeuilleTemps" EnableEventValidation="false" %>

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

        .btn-option {
            height: 30px !important;
            width: 30px !important;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="TitlePlaceHolder" runat="server">
    <h1>Gestion des feuilles de temps</h1>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlaceHolder" runat="server">

    <form runat="server" style="text-align: center;" class="container center col-12">

        <%--OVERHEAD DES DATES--%>
        <table style="width: 100% !important;">
            <tr>
                <th>
                    <h5>Date minimale</h5>
                </th>
                <th>
                    <h5>Date maximale</h5>
                </th>
            </tr>
            <tr>
                <td>
                    <input type="date" id="Calendar1" style="margin: auto;" runat="server" />
                </td>
                <td>
                    <input type="date" id="Calendar2" style="margin: auto;" runat="server" /></td>
                <td>
                    <asp:Button style="float:right;" ID="btn_Filtrer" CssClass="btn btn-md btn-primary" runat="server" OnClick="btn_Filtrer_Click" Text="Filtrer Selon Dates" />

                </td>
            </tr>
            <tr>
                <td>
                    <h5 class="center" style="margin: auto !important;" id="dateFormated2" runat="server"></h5>
                </td>
                <td>
                    <h5 class="center" style="margin: auto !important;" id="dateFormated1" runat="server"></h5>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>
                    <asp:Button style="float:right;" ID="btn_ajouterFT" CssClass="btn btn-md btn-success" runat="server" Text="Ajouter une feuille de temps" OnClick="btn_ajouterFT_Click"/>
                </td>
            </tr>
        </table>


        <%--CODE REPEATER DE FEUILLES DE TEMPS NON-APPROUVER--%>
        <asp:Repeater ID="Rptr_EmployeNonApprouver" runat="server">

            <%--HEADERTEMPLATE--%>
            <HeaderTemplate>
                <div class="table-responsive">
                    <table class="table">
                        <thead class="thead-dark">
                            <h2 style="margin-bottom: 10px;" class="mt-4">En attente</h2>
                        </thead>
                        <thead class="thead-dark">
                            <tr style="border-bottom: 5px solid #23282e">
                                <th style="width: 4%" scope="col"></th>
                                <th style="width: 13%" scope="col">Employé</th>
                                <th style="width: 8%" scope="col">Date</th>
                                <th style="width: 8%" scope="col">Durée (h)</th>
                                <th style="width: 15%" scope="col">Projet</th>
                                <th style="width: 22%" scope="col">Catégorie</th>
                                <th style="width: 20%" scope="col">Note</th>
                                <th style="width: 5%" scope="col">
                                    <asp:Button ID="Btn_ApproveTout" CssClass="btn btn-md btn-primary" runat="server" OnClick="Btn_ApproveTout_Click" Text="Approuver Tout" />
                                </th>
                            </tr>
                        </thead>
                        <tbody>
            </HeaderTemplate>

            <%--ITEMTEMPLATE--%>
            <ItemTemplate>
                <tr class="table-secondary">
                    <td>
                        <asp:Button runat="server" CssClass="btn btn-sm btn-secondary" Text="Plus/Moins" ID="btn_trash" enabled="false"/>
                        <%--<button class="btn btn-primary" data-toggle="collapse" data-target="#collapseAjout" aria-expanded="false" aria-controls="collapseExample" onclick="return false;">Ajouter</button>--%>
                    </td>
                    <td>
                        <asp:Label ID="lbl_ID" runat="server" Text='<%# String.Format("{0} {1}", Eval("prenom"), Eval("nom")) %>' Font-Bold="true" />

                    </td>
                    <%--TD VIDE POUR LA COLORATION DES COLONES--%>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>
                        <asp:Button ID="Btn_ApproveEmp" CssClass="btn btn-md btn-primary" runat="server" OnClick="Btn_ApproveEmp_Click" Text="Approuver Employé" CommandArgument='<%#Eval("idEmploye")%>' />
                    </td>
                </tr>
                <tr class="collapse" id="collapseAjout">
                    <%--SECOND REPEATER DES FEUILLES DE TEMPS--%>
                    <asp:Repeater ID="Rptr_FeuilleTempsNonApprouver" runat="server" DataSource='<%# Eval("tbl_FeuilleTemps")%>' OnLoad="Rptr_FeuilleTempsNonApprouver_Load1">
                        <%--ITEMTEMPLATE--%>
                        <ItemTemplate>
                            <tr style="border-bottom: 1px solid #23282e" runat="server" visible='<%# !Boolean.Parse(Eval("approuver").ToString())%>'>
                                <td></td>
                                <td></td>
                                <td>
                                    <asp:Label ID="lbl_Date" runat="server" Text='<%# formatRemoveHour(Eval("dateCreation")) %>' Font-Bold="true" />
                                </td>
                                <td>
                                    <asp:Label ID="lbl_Duree" runat="server" Text='<%#Eval("nbHeure") %>' Font-Bold="true" />
                                </td>
                                <td>
                                    <asp:Label ID="lbl_Projet" runat="server" Text='<%#Eval("tbl_Projet.titre") %>' Font-Bold="true" />
                                </td>
                                <td>
                                    <asp:Label ID="lbl_Categorie" runat="server" Text='<%#Eval("tbl_ProjetCat.titre") %>' Font-Bold="true" />
                                </td>
                                <td>
                                    <asp:Label ID="lbl_Note" runat="server" Text='<%#Eval("commentaire") %>' Font-Bold="true" />
                                </td>
                                <td>
                                    <asp:ImageButton ID="Btn_Modif" CssClass=" btn-option" OnClick="Btn_Modif_Click1" runat="server" Text="Modification" src="Resources/pencil.png" CommandArgument='<%#Eval("idFeuille")%>' />
                                    <asp:ImageButton ID="Btn_Approve" CssClass="btn-option" runat="server" OnClick="Btn_Approve_Click" src="Resources/checkmark.png" Text="Approuver" CommandArgument='<%#Eval("idFeuille")%>' />
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tr>
            </ItemTemplate>

            <%--FOOTERTEMPLATE--%>
            <FooterTemplate>
                </tbody>
                <thead class="thead-dark">
                    <tr style="border-bottom: 5px solid #23282e">
                        <th style="width: 4%" scope="col"></th>
                        <th style="width: 13%" scope="col">Employé</th>
                        <th style="width: 12%" scope="col">Date</th>
                        <th style="width: 8%" scope="col">Durée (h)</th>
                        <th style="width: 15%" scope="col">Projet</th>
                        <th style="width: 20%" scope="col">Catégorie</th>
                        <th style="width: 20%" scope="col">Note</th>
                        <th style="width: 5%" scope="col"></th>
                    </tr>
                </thead>
                </table>
                </div>
            </FooterTemplate>
        </asp:Repeater>

        <div style="margin-top:15px;margin-bottom:15px;">&nbsp;</div>

        <%--CODE REPEATER DE FEUILLES DE TEMPS APPROUVÉES--%>
        <asp:Repeater ID="rptr_EmployeApprouver" runat="server" >

            <%--HEADERTEMPLATE--%>
            <HeaderTemplate>
                <div class="table-responsive">
                <table class="table">
                    <thead class="thead-dark">
                    <h2 style="margin-bottom: 10px;">Approuvé</h2>
                    <tr style="border-bottom: 5px solid #23282e">
                        <th style="width: 13%" scope="col">Employé</th>
                        <th style="width: 8%" scope="col">Date</th>
                        <th style="width: 10%" scope="col">Durée (h)</th>
                        <th style="width: 15%" scope="col">Projet</th>
                        <th style="width: 20%" scope="col">Catégorie</th>
                        <th style="width: 17%" scope="col">Note</th>
                        <th style="width: 15%" scope="col">
                            <%--<asp:Button ID="Btn_Ajout" CssClass="btn btn-md btn-secondary" runat="server" Text="Nouveau" />--%>
                        </th>
                    </tr>
                        </thead>
                        <tbody>
            </HeaderTemplate>

            <%--ITEMTEMPLATE--%>
            <ItemTemplate>
                <tr>
                    <td>
                        <asp:Label ID="lbl_ID" runat="server" Text='<%# String.Format("{0} {1}", Eval("prenom"), Eval("nom")) %>' Font-Bold="true" /></td>
                </tr>    
                    <%--SECOND REPEATER DE FEUILLE DE TEMPS--%>
                    <asp:Repeater ID="Rptr_FeuilleTempsApprouver" runat="server" DataSource='<%# Eval("tbl_FeuilleTemps")%>' OnLoad="Rptr_FeuilleTemps_Load">
                        <%--ITEMTEMPLATE--%>
                        <ItemTemplate>
                            <tr style="border-bottom: 1px solid #23282e" runat="server" visible='<%# Boolean.Parse(Eval("approuver").ToString())%>'>
                                <td></td>
                                <td>
                                    <asp:Label ID="lbl_Date" runat="server" Text='<%# formatRemoveHour(Eval("dateCreation")) %>' Font-Bold="true" />
                                </td>
                                <td>
                                    <asp:Label ID="lbl_Duree" runat="server" Text='<%#Eval("nbHeure") %>' Font-Bold="true" />
                                </td>
                                <td>
                                    <asp:Label ID="lbl_Projet" runat="server" Text='<%#Eval("tbl_Projet.titre") %>' Font-Bold="true" />
                                </td>
                                <td>
                                    <asp:Label ID="lbl_Categorie" runat="server" Text='<%#Eval("tbl_ProjetCat.titre") %>' Font-Bold="true" />
                                </td>
                                <td>
                                    <asp:Label ID="lbl_Note" runat="server" Text='<%#Eval("commentaire") %>' Font-Bold="true" />
                                </td>
                                <td></td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
            </ItemTemplate>

            <%--FOOTERTEMPLATE--%>
            <FooterTemplate>
                </tbody>
                <thead class="thead-dark">
                    <tr style="border-top: 5px solid #23282e">
                        <th>Employé</th>
                        <th>Date</th>
                        <th>Durée (h)</th>
                        <th>Projet</th>
                        <th>Catégorie</th>
                        <th>Note</th>
                        <th></th>
                    </tr>
                </thead>
                </table>
                </div>
            </FooterTemplate>
        </asp:Repeater>

        <%--JAVASCRIPT--%>
        <script>
            var input1 = document.getElementById('<%=Calendar1.ClientID%>')
            var input2 = document.getElementById('<%=Calendar2.ClientID%>')

            UpdateDateFormat(1);
            UpdateDateFormat(2);

            input1.onchange = function () {
                UpdateDateFormat(1);
            }

            input2.onchange = function () {
                UpdateDateFormat(2);
            }

            function UpdateDateFormat(int) {
                if (int == 1) {

                    var dateFormated = document.getElementById('<%=dateFormated2.ClientID%>')
                    if (input1.value == "") {
                        dateFormated.innerText = "Veuillez sélectionner la date";
                        return;
                    }

                    var format = FormatYear(input1.value);

                    dateFormated.innerText = format;
                }

                else {
                    var dateFormated = document.getElementById('<%=dateFormated1.ClientID%>')
                    if (input2.value == "") {
                        dateFormated.innerText = "Veuillez sélectionner la date";
                        return;
                    }

                    var format = FormatYear(input2.value);

                    dateFormated.innerText = format;
                }



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
