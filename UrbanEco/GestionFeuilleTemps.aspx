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

        .asp-table {
            table-layout:fixed;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="TitlePlaceHolder" runat="server">
      <h1>Gestion des feuilles de temps</h1> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlaceHolder" runat="server">

    <form runat="server" style="text-align: center;" class="container center col-12">

        <%--Filtre--%>
        
        <div class="form-group mb-4 col-12 mx-auto">
            <asp:Table runat="server" CssClass="col-md-8 asp-table" style="float:left;" ID="filtre">
                <asp:TableRow>
                    <asp:TableHeaderCell CssClass="form-control">
                        Filtrer par date
                    </asp:TableHeaderCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Table CssClass="col-md-6 asp-table" style="float:left;" runat="server">
                            <asp:TableRow>
                                <asp:TableHeaderCell CssClass="form-control">
                        Date minimale
                                </asp:TableHeaderCell>
                                <asp:TableCell>
                                    <input class="form-control" type="date" id="Calendar1" style="margin: auto;" runat="server" />
                                </asp:TableCell>

                            </asp:TableRow>
                        </asp:Table>
                        <asp:Table CssClass="col-md-6 asp-table" style="float:left;" runat="server">
                            <asp:TableRow>
                                <asp:TableHeaderCell CssClass="form-control">
                        Date minimale
                                </asp:TableHeaderCell>
                                <asp:TableCell>
                                    <input class="form-control" type="date" id="Calendar2" style="margin: auto;" runat="server" />
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </asp:TableCell>
                </asp:TableRow>  
                <asp:TableRow>
                    <asp:TableCell>
                        <h5 class="col-md-4" style="float:left; text-align:center;" id="dateFormated2" runat="server"></h5>                    
                        <h5 class="col-md-4" style="float:left; text-align:center;" runat="server">&nbsp;au&nbsp;</h5>                    
                        <h5 class="col-md-4" style="float:left; text-align:center;" id="dateFormated1" runat="server"></h5>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Button style="float:left;" ID="btn_removefilter" CssClass="btn btn-md btn-danger form-control col-md-4" runat="server" OnClick="btn_removefilter_Click" Text="Supprimer le filtre" />
                        <div style="float:left;" class="col-md-4">&nbsp;</div>
                        <asp:Button style="float:left;" ID="btn_Filtrer" CssClass="btn btn-md btn-primary form-control col-md-4" runat="server" OnClick="btn_Filtrer_Click" Text="Appliquer le filtre" />
                    </asp:TableCell>
                </asp:TableRow>  
                <asp:TableRow>
                    <asp:TableCell>
                        <div runat="server" visible="false" id="alert_dateOrder" class="alert alert-danger" style="width:100%"><b>Attention !</b> La date maximal est plus petite que la date minimale.</div>
                        <div runat="server" visible="false" id="alert_missingDate" class="alert alert-danger" style="width:100%"><b>Attention !</b> Les deux dates sont requises pour le filtre.</div>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>

            <asp:Table runat="server" CssClass="col-md-4  mx-auto" style="float:left; width:100%;">
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Button ID="btn_ajouterFT" CssClass="btn btn-lg btn-success  mx-auto" runat="server" Text="Ajouter une feuille de temps" OnClick="btn_ajouterFT_Click"/>
                    </asp:TableCell>
                </asp:TableRow>

            </asp:Table>
        </div>

        <p style="height:20px;"></p>
        <div style="margin-top:15px;">

            <asp:Table runat="server" CssClass="col-md-12" Style="margin-top:150px !important;">
                <asp:TableRow>
                    <asp:TableCell Style="float: left; width: 50%;" CssClass="thead-dark">
                        <h2 style="margin-bottom: 10px; float: right; width: 50%;" runat="server" id="lbl_attente" visible="true">En attente</h2>
                        <h2 style="margin-bottom: 10px; float: right; width: 50%;" runat="server" id="lbl_approved" visible="false">Approuvées</h2>
                    </asp:TableCell>
                    <asp:TableCell Style="float: left; width: 50%;">
                        <table style="width: 100% !important; float: left;">
                            <tr>
                                <%--CHECKBOX INACTIF OU ACTIF--%>
                                <td style="width: 30%;" class="mb-3">
                                    <label class="switch" style="float: right;">
                                        <asp:CheckBox runat="server" ID="chbx_approved" OnCheckedChanged="chbx_approved_CheckedChanged" AutoPostBack="true" />
                                        <span class="slider round"></span>
                                    </label>
                                </td>
                                <td>
                                    <h4 style="float: left;">Afficher les feuilles de temps approuvées</h4>
                                </td>
                            </tr>
                        </table>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>

        </div>

        <%--CODE REPEATER DE FEUILLES DE TEMPS NON-APPROUVER--%>
        <asp:Repeater ID="Rptr_EmployeNonApprouver" runat="server">

            <%--HEADERTEMPLATE--%>
            <HeaderTemplate>
                <div class="table-responsive">
                    <table class="table">
                        <thead class="thead-dark">
                            <tr style="border-bottom: 5px solid #23282e">
                                <%--<th style="width: 4%" scope="col"></th>--%>
                                <th style="width: 13%" scope="col">Employé</th>
                                <th style="width: 8%" scope="col">Date</th>
                                <th style="width: 8%" scope="col">Durée (h)</th>
                                <th style="width: 15%" scope="col">Projet</th>
                                <th style="width: 22%" scope="col">Catégorie</th>
                                <th style="width: 20%" scope="col">Note</th>
                                <th style="width: 5%" scope="col">
                                    <asp:Button ID="Btn_ApproveTout" CssClass="btn btn-md btn-primary" Visible=<%# isVisible() %> runat="server" OnClick="Btn_ApproveTout_Click" Text="Approuver Tout" />
                                </th>
                            </tr>
                        </thead>
                        <tbody>
            </HeaderTemplate>

            <%--ITEMTEMPLATE--%>
            <ItemTemplate>
                <tr class="table-secondary">
<%--                    <td>
                        <asp:Button runat="server" CssClass="btn btn-sm btn-secondary" Text="Plus/Moins" ID="btn_trash" enabled="false"/>
                    </td>--%>
                    <td>
                        <asp:Label ID="lbl_ID" runat="server" Text='<%# String.Format("{0} {1}", Eval("prenom"), Eval("nom")) %>' Font-Bold="true" />
                    </td>
                    <%--TD VIDE POUR LA COLORATION DES COLONES--%>
                    <td></td>
                    <%--TOTAL DURÉE--%>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text='<%# CalculerTotalHeureEmploye(Eval("tbl_FeuilleTemps")) %>' Font-Bold="true" />
                    </td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>
                        <asp:Button ID="Btn_ApproveEmp" Visible=<%# isVisible() %> CssClass="btn btn-md btn-primary" runat="server" OnClick="Btn_ApproveEmp_Click" Text="Approuver Employé" CommandArgument='<%#Eval("idEmploye")%>' />
                    </td>
                </tr>
                <tr class="collapse" id="collapseAjout">
                    <%--SECOND REPEATER DES FEUILLES DE TEMPS--%>
                    <asp:Repeater ID="Rptr_FeuilleTempsNonApprouver" runat="server" DataSource='<%# Eval("tbl_FeuilleTemps")%>' OnLoad="Rptr_FeuilleTempsNonApprouver_Load1">
                        <%--ITEMTEMPLATE--%>
                        <ItemTemplate>
                            <tr style="border-bottom: 1px solid #23282e" runat="server" visible='<%# ShowFT(Container.DataItem, "Attente") %>'>
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
                                    <asp:ImageButton ID="Btn_Approve" Visible=<%# isVisible(Container.DataItem) %> CssClass="btn-option" runat="server" OnClick="Btn_Approve_Click" src="Resources/checkmark.png" Text="Approuver" CommandArgument='<%#Eval("idFeuille")%>' />
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
                        <%--<th style="width: 4%" scope="col"></th>--%>
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

        <%--CODE REPEATER DE FEUILLES DE TEMPS APPROUVÉES--%>
        <asp:Repeater ID="rptr_EmployeApprouver" runat="server" visible="false">

            <%--HEADERTEMPLATE--%>
            <HeaderTemplate>
                <div class="table-responsive">
                <table class="table">
                    <thead class="thead-dark">
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
                        <asp:Label ID="lbl_ID" runat="server" Text='<%# String.Format("{0} {1}", Eval("prenom"), Eval("nom")) %>' Font-Bold="true" />
                    </td>
                </tr>    
                    <%--SECOND REPEATER DE FEUILLE DE TEMPS--%>
                    <asp:Repeater ID="Rptr_FeuilleTempsApprouver" runat="server" DataSource='<%# Eval("tbl_FeuilleTemps")%>' OnLoad="Rptr_FeuilleTemps_Load">
                        <%--ITEMTEMPLATE--%>
                        <ItemTemplate>
                            <tr style="border-bottom: 1px solid #23282e" runat="server" visible='<%# ShowFT(Container.DataItem, "Approuver")%>'>
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
