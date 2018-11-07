<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="AjoutDepense.aspx.cs" Inherits="UrbanEco.AjoutDepense" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
       <style>
           .center {
                margin: auto;
                width: 50%;
            }

           .input-box{
               width: 100% !important; 
               font-size: 17px; 
               margin-bottom: 30px;
           }

           .input-title {
                text-align:left !important;
           }

           .table-custom{

                width:800px !important;
            
           }

           .table-custom > table{
               width:100% !important;
           }

       </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
    <form runat="server" style="text-align:center;" class="container center col-12">
        <div>
            <h1>
                Ajouter une dépense
            </h1>
            <hr style="border: 20px solid #23282e; width: 100% !important; margin: 0px 0px 0px 0px; padding: 0px 0px 0px 0px" />
        </div>


        <div class="row justify-content-md-center" style="margin-bottom:100px;">
            <div class="col-md-offset-3 col-6">

                <table style="width: 100% !important;">
                    <tr>
                        <th>
                            <h3>Projet associé</h3>
                        </th>
                    </tr>
                    <tr>
                        <th>
                            <h5 class="input-title">Nom du projet</h5>
                        </th>
                    </tr>
                    <tr>
                        <td>
                            <asp:DropDownList CssClass="input-box"  OnSelectedIndexChanged="tbx_projet_SelectedIndexChanged" name="idProjet" ID="tbx_projet" runat="server" DataTextField="titre" DataValueField="idProjet" AutoPostBack="true"></asp:DropDownList>
                        </td>
                    </tr>

                    <tr>
                        <th>
                            <h5 class="input-title">Sous-Catégorie</h5>
                        </th>
                    </tr>
                    <tr>
                        <td>
                            <asp:DropDownList CssClass="input-box" Enabled="false" ID="tbx_categorie" runat="server"  DataTextField="titre" DataValueField="idProjetCat" autopostback="true"></asp:DropDownList>
                        </td>
                    </tr>

                    <tr>
                        <th>
                            <h5>Date</h5>
                        </th>
                    </tr>
                    <tr>
                        <td>
                            <input type="date" id="Calendar" style="margin:auto;" runat="server"/>
                            <!--<asp:Calendar ID="Calendar1" runat="server" Style="margin: auto;"></asp:Calendar>-->
                        </td>
                    </tr>
                </table>
            </div>

        </div>



        <div class="row justify-content-md-center">
            <div class="col-md-offset-3 col-6">

                <table style="width: 100% !important;">
                    <tr>
                        <th>
                            <h3>Information sur la dépense</h3>
                        </th>
                    </tr>
                    <tr>
                        <th>
                            <h5 class="input-title">Type de dépense</h5>
                        </th>
                    </tr>
                    <tr>
                        <td>
                            <asp:DropDownList class="input-box" ID="tbx_typeDepense" runat="server" DataTextField="nomDepense" DataValueField="idTypeDepense" DataSourceID="LinqTypeDepense"></asp:DropDownList>
                            <asp:LinqDataSource ID="LinqTypeDepense" runat="server" ContextTypeName="UrbanEco.CoecoDataContext" EntityTypeName="" TableName="tbl_TypeDepense">
                            </asp:LinqDataSource>
                        </td>
                    </tr>

                    <tr>
                        <th>
                            <h5 class="input-title">Montant</h5>
                        </th>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox class="input-box" ID="tbx_montant" runat="server" Rows="5"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            <h5 class="input-title">Note</h5>
                        </th>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox class="input-box" ID="tbx_note" runat="server" Rows="5"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <h5 class="input-title">Récapitulatif de votre dépense</h5>
                            <table>
                                <tr>
                                    <td id="rep_nomEmployer" runat="server"></td>
                                    <td id="rep_projet" runat="server"></td>
                                    <td id="rep_categorie" runat="server"></td>
                                    <td id="rep_date" runat="server"></td>
                                    <td id="rep_typeDepense" runat="server"></td>
                                    <td id="rep_montant" runat="server"></td>
                                </tr>
                            </table>

                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="alert alert-success" runat="server" id="alert_success" visible="false">
                              <strong>Succès!</strong>  Votre dépense a bien été ajouté !
                            </div>
                            <div class="alert alert-danger" runat="server" id="alert_failed" visible="false">
                              <strong>Erreur!</strong>  Votre dépense n'as pas pu être ajouté à la base de donnée !
                            </div>
                            <div class="alert alert-warning" runat="server" id="alert_warning" visible="false">
                              <strong>Attention!</strong>  Votre dépense a déjà été ajouté à la base de donnée !
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Button CssClass="btn btn-lg btn-success input-box" ID="btn_envoyer" runat="server" Text="Confirmer l'ajout" OnClick="btn_envoyer_Click" />
                        </td>
                    </tr>
                </table>
            </div>

        </div>
    </form>
</asp:Content>
