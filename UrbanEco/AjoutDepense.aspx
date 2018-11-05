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

                            <asp:DropDownList class="input-box" name="idProjet" ID="DropDownList1" runat="server" DataSourceID="LinqProjet" DataTextField="titre" DataValueField="titre">
                            </asp:DropDownList>
                            <asp:LinqDataSource ID="LinqProjet" runat="server" ContextTypeName="UrbanEco.CoecoDataContext" EntityTypeName="" OrderBy="titre" Select="new (titre)" TableName="tbl_Projet">
                            </asp:LinqDataSource>

                        </td>
                    </tr>

                    <tr>
                        <th>
                            <h5 class="input-title">Sous-Catégorie</h5>
                        </th>
                    </tr>
                    <tr>
                        <td>

                            <asp:DropDownList class="input-box" ID="DropDownList2" runat="server" DataSourceID="LinqSouscatego" DataTextField="titre" DataValueField="titre">
                            </asp:DropDownList>
                            <asp:LinqDataSource ID="LinqSouscatego" runat="server" ContextTypeName="UrbanEco.CoecoDataContext" EntityTypeName="" OrderBy="titre" Select="new (titre)" TableName="tbl_ProjetCat" Where="idProjet == @idProjet">
                                <WhereParameters>
                                    <asp:Parameter DefaultValue="1" Name="idProjet" Type="Int32" />
                                </WhereParameters>
                            </asp:LinqDataSource>

                        </td>
                    </tr>

                    <tr>
                        <th>
                            <h5>Date</h5>
                        </th>
                    </tr>
                    <tr>
                        <td>
                            <asp:Calendar ID="Calendar1" runat="server" Style="margin: auto;"></asp:Calendar>
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
                            <asp:DropDownList class="input-box" ID="DropDownList3" runat="server" DataSourceID="LinqTypeDepense" DataTextField="nomDepense" DataValueField="nomDepense"></asp:DropDownList>
                            <asp:LinqDataSource ID="LinqTypeDepense" runat="server" ContextTypeName="UrbanEco.CoecoDataContext" EntityTypeName="" Select="new (nomDepense)" TableName="tbl_TypeDepense">
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
                            <asp:TextBox class="input-box" ID="tbx_montant" runat="server"></asp:TextBox>
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
                </table>
            </div>

        </div>
    </form>
</asp:Content>
