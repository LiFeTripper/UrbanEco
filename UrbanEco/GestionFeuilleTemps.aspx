<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="GestionFeuilleTemps.aspx.cs" Inherits="UrbanEco.GestionFeuilleTemps" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<title>Co-Éco - Gestion des dépenses</title>    
<link rel="stylesheet" type="text/css" href="lib/css/gestionFeuilleDeTemps.css" />
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

    <form runat="server" class="container center col-12">
        <div id="filtreDate" class="form-group" runat="server">
            <div class="form-group spantwo titreFiltre">
                <h3>Filtrer Par Date</h3>
            </div>

            <div class="form-group">
                <label for="Calendar1">Data Minimum</label>
                <input class="form-control" type="date" id="Calendar1" runat="server" />
            </div>

            <div class="form-group">
                <label for="Calendar2">Data Maximum</label>
                <input class="form-control" type="date" id="Calendar2" runat="server" />
            </div>

            <div class="form-group">
                <asp:Button ID="btn_Filtrer" CssClass="btn btn-raised btn-md btn-primary form-control" runat="server" OnClick="btn_Filtrer_Click" Text="Appliquer le filtre" />
            </div>

            <div class="form-group">
                <asp:Button ID="btn_removefilter" CssClass="btn btn-md btn-raised btn-danger form-control" runat="server" OnClick="btn_removefilter_Click" Text="Supprimer le filtre" />
            </div>

            <div runat="server" visible="false" id="alert_dateOrder" class="alert alert-danger spantwo"><b>Attention !</b> La date maximal est plus petite que la date minimale.</div>
            <div runat="server" visible="false" id="alert_aucun" class="alert alert-danger spantwo"><b>Attention !</b> Aucune feuille de temps trouvée.</div>
            <div runat="server" visible="false" id="alert_missingDate" class="alert alert-danger spantwo"><b>Attention !</b> Les deux dates sont requises pour le filtre.</div>
        </div>

        <div id="ajoutFDT">

            

            <h2>Feuilles de temps en attente</h2>

            <div class="form-group">
                <asp:Button ID="btn_ajouterFT" CssClass="btn btn-md btn-raised btn-success" runat="server" Text="Ajouter une feuille de temps" OnClick="btn_ajouterFT_Click"/>
            </div>

        </div>

        
        

        <%--CODE REPEATER DE FEUILLES DE TEMPS NON-APPROUVER--%>
        <asp:Repeater ID="Rptr_EmployeNonApprouver" runat="server">

            <%--HEADERTEMPLATE--%>
            <HeaderTemplate>
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <%--<th style="width: 4%" scope="col"></th>--%>
                                <th style="width: 13%" scope="col">Employé</th>
                                <th style="width: 8%" scope="col">Date</th>
                                <th style="width: 8%" scope="col">Durée (h)</th>
                                <th style="width: 15%" scope="col">Projet</th>
                                <th style="width: 22%" scope="col">Catégorie</th>
                                <th style="width: 20%" scope="col">Note</th>
                                <th style="width: 5%" scope="col">
                                    <asp:Button ID="Btn_ApproveTout" CssClass="btn btn-raised btn-success" Visible=<%# isVisible(Container.DataItem) %> runat="server" OnClick="Btn_ApproveTout_Click" Text="Approuver Tout" />
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
                        <asp:Label ID="lbl_ID" runat="server" Text='<%# String.Format("{0} {1}", Eval("prenom"), Eval("nom")) %>' />
                    </td>
                    <%--TD VIDE POUR LA COLORATION DES COLONES--%>
                    <td></td>
                    <%--TOTAL DURÉE--%>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text='<%# CalculerTotalHeureEmploye(Eval("tbl_FeuilleTemps")) %>' />
                    </td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>
                        <asp:Button ID="Btn_ApproveEmp" Visible=<%# isVisible(Container.DataItem) %> CssClass="btn btn-raised btn-primary btn-Approuver" runat="server" OnClick="Btn_ApproveEmp_Click" Text="Approuver Employé" CommandArgument='<%#Eval("idEmploye")%>' />
                    </td>
                </tr>
                <tr class="collapse" id="collapseAjout">
                    <%--SECOND REPEATER DES FEUILLES DE TEMPS--%>
                    <asp:Repeater ID="Rptr_FeuilleTempsNonApprouver" runat="server" DataSource='<%# TrierFT(Eval("tbl_FeuilleTemps"))%>' OnLoad="Rptr_FeuilleTempsNonApprouver_Load1">
                        <%--ITEMTEMPLATE--%>
                        <ItemTemplate>
                            <tr runat="server" visible='<%# ShowFT(Container.DataItem, "Attente") %>'>
                                <td></td>
                                <td>
                                    <asp:Label ID="lbl_Date" runat="server" Text='<%# formatRemoveHour(Eval("dateCreation")) %>' />
                                </td>
                                <td>
                                    <asp:Label ID="lbl_Duree" runat="server" Text='<%#Eval("nbHeure") %>' />
                                </td>
                                <td>
                                    <asp:Label ID="lbl_Projet" runat="server" Text='<%#Eval("tbl_Projet.titre") %>'/>
                                </td>
                                <td>
                                    <asp:Label ID="lbl_Categorie" runat="server" Text='<%#Eval("tbl_ProjetCat.titre") %>' />
                                </td>
                                <td>
                                    <asp:Label ID="lbl_Note" runat="server" Text='<%#Eval("commentaire") %>' />
                                </td>
                                <td>
                                    <asp:ImageButton ID="Btn_Modif" Visible=<%# isModifVisible(Container.DataItem)%> CssClass=" btn-option" OnClick="Btn_Modif_Click1" runat="server" Text="Modification" src="Resources/pencil.png" CommandArgument='<%#Eval("idFeuille")%>' />
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
                <thead >
                    <tr class="t_footer">
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
        <script>
            function MessageErreur(valeur) {
                var params = valeur.split(";;;");
                alert("Cet employé (" + params[0] + ") n'est plus associé au sous-projet (" + params[1] + ") du projet (" + params[2] + ").\n\nVeuillez réassigner l'employé au sous-projet pour réactiver la modification de cette feuille de temps. \nVous pourrez ensuite retirer l'employé de la catégorie à nouveau.\n\nMerci!");
            }
        </script>
    </form>

</asp:Content>
