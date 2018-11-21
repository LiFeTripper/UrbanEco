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
            height:30px !important;
            width: 30px !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlaceHolder" runat="server">


    <form runat="server" style="text-align: center;" class="container center col-12">
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
                            <td><input type="date" id="Calendar2" style="margin: auto;" runat="server" /></td>
                            <td><asp:Button ID="btn_Filtrer" CssClass="btn btn-md btn-primary" runat="server" OnClick="btn_Filtrer_Click" Text="Filtrer Selon Dates"  /></td>
                        </tr>
                        <tr>
                            <td>
                                <h5 class="center" style="margin: auto !important;" id="dateFormated2" runat="server"></h5>
                                 
                            </td>
                            <td><h5 class="center" style="margin: auto !important;" id="dateFormated1" runat="server"></h5></td>
                        </tr>
                    </table>
                <%--CODE REPEATER DE PROJETS--%>
                <asp:Repeater ID="Rptr_EmployeNonApprouver" runat="server">

                    <%--HEADERTEMPLATE--%>
                    <HeaderTemplate>
                        <%--USERNAME ET PASSWORD--%>
                    
                        <table style="width: 100% !important; text-align: left !important;">

                            <%--EN TËTE A MARC--%>
                            <h1>Projets</h1>
                            <tr style="width:100%;text-align:center !important;">
                                <td>
                                    <h2>Non approuvé</h2>
                                </td>
                                <td style="margin:auto;"> 
                                <asp:Button ID="Btn_ApproveTout" CssClass="btn btn-md btn-primary" runat="server" OnClick="Btn_ApproveTout_Click" Text="Approuver Tout"  /></td>
                            </tr>

                            <hr style="border-bottom: 20px solid #23282e; width: 100%;" />
                            
                        
                            
                            <tr style="border-bottom: 5px solid #23282e">
                                <th style="width:4%">
                                </th>
                                <th style="width:13%">Employé</th>
                                <th style="width:12%">Date</th>
                                <th style="width:8%">Durée (h)</th>
                                <th style="width:15%">Projet</th>
                                <th style="width:20%">Catégorie</th>
                                <th style="width:20%">Note</th>
                                <th style="width:5%">
                                </th>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td> <asp:Button ID="btnCloseOpen" runat="server" Text="Close/Open" OnClick="btnCloseOpen_Click" ViewStateMode="Inherit" />
                            </td>
                            <td>
                                <asp:Label ID="lbl_ID" runat="server" Text='<%# String.Format("{0} {1}", Eval("prenom"), Eval("nom")) %>' Font-Bold="true" /></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td><asp:Button ID="Btn_ApproveEmp" CssClass="btn btn-md btn-primary" runat="server" OnClick="Btn_ApproveEmp_Click" Text="Approuver Employé" CommandArgument='<%#Eval("idEmploye")%>' /></td>
                        </tr>
                        <tr>
                            <asp:Repeater ID="Rptr_FeuilleTempsNonApprouver" runat="server" DataSource='<%# Eval("tbl_FeuilleTemps")%>' OnLoad="Rptr_FeuilleTempsNonApprouver_Load1" >
                                <%--ITEMTEMPLATE--%>
                                
                                <ItemTemplate>
                                    <tr style="border-bottom: 1px solid #23282e" runat="server" visible='<%# !Boolean.Parse(Eval("approuver").ToString())%>'>
                                        <td></td>
                                        <td></td>
                                        <td>
                                            <asp:Label ID="lbl_Date" runat="server" Text='<%#Eval("dateCreation") %>' Font-Bold="true" />
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
                                            <asp:ImageButton ID="Btn_Approve" CssClass="btn-option" runat="server" OnClick="Btn_Approve_Click"  src="Resources/checkmark.png" Text="Approuver" CommandArgument='<%#Eval("idFeuille")%>' />
                                        </td>
                                    </tr>
                                    
                                </ItemTemplate>
                            </asp:Repeater>
                        </tr>

                    </ItemTemplate>

                    <%--FOOTERTEMPLATE--%>
                    <FooterTemplate>

                        <tr style="border-top: 5px solid #23282e">
                            <th>Employé</th>
                            <th>Date</th>
                            <th>Durée (h)</th>
                            <th>Projet</th>
                            <th>Catégorie</th>
                            <th>Note</th>
                            <th></th>
                        </tr>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
        
                <%--CODE REPEATER DE PROJETS--%>
                <asp:Repeater ID="rptr_EmployeApprouver" runat="server">

                    <%--HEADERTEMPLATE--%>
                    <HeaderTemplate>
                        <table style="width: 100% !important; text-align: left !important;">

                            <%--EN TËTE A MARC--%>
                            <hr style="border-bottom: 10px solid #23282e; width: 100%;" />
                            
                    <h2 style="margin-bottom:10px;">Approuvé</h2>
                            <tr style="border-bottom: 5px solid #23282e">
                                <th style="width:13%">Employé</th>
                                <th style="width:12%">Date</th>
                                <th style="width:10%">Durée (h)</th>
                                <th style="width:15%">Projet</th>
                                <th style="width:18%">Catégorie</th>
                                <th style="width:17%">Note</th>
                                <th style="width:15%">
                                    <%--<asp:Button ID="Btn_Ajout" CssClass="btn btn-md btn-secondary" runat="server" Text="Nouveau" />--%>
                                </th>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <asp:Label ID="lbl_ID" runat="server" Text='<%# String.Format("{0} {1}", Eval("prenom"), Eval("nom")) %>' Font-Bold="true" /></td>
                        </tr>
                        <tr>
                            <asp:Repeater ID="Rptr_FeuilleTempsApprouver" runat="server" DataSource='<%# Eval("tbl_FeuilleTemps")%>' OnLoad="Rptr_FeuilleTemps_Load">
                                <%--ITEMTEMPLATE--%>
                                <ItemTemplate>
                                    <tr style="border-bottom: 1px solid #23282e" runat="server" visible='<%# Boolean.Parse(Eval("approuver").ToString())%>'>
                                        <td></td>
                                        <td>
                                            <asp:Label ID="lbl_Date" runat="server" Text='<%#Eval("dateCreation") %>' Font-Bold="true" />
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
                        </tr>

                    </ItemTemplate>

                    <%--FOOTERTEMPLATE--%>
                    <FooterTemplate>

                        <tr style="border-top: 5px solid #23282e">
                            <th>Employé</th>
                            <th>Date</th>
                            <th>Durée (h)</th>
                            <th>Projet</th>
                            <th>Catégorie</th>
                            <th>Note</th>
                            <th></th>
                        </tr>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
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
