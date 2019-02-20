<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="RapportDepense.aspx.cs" Inherits="UrbanEco.RapportDepense" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Rapports/Rapport.css" rel="stylesheet" />
    <title>Coeco - Rapport Depense</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="TitlePlaceholder" runat="server">
    <h1>Rapport Dépense</h1>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="BodyPlaceHolder" runat="server">

    <form runat="server">
        <%-- Dates --%>
        <div class="form-group">
            <label for="date_debut" class="">Date de début</label>
            <input type="date" id="date_debut" class="form-control" runat="server" />
        </div>

        <div class="form-group">
            <label for="date_fin" class="">Date de fin</label>
            <input type="date" id="date_fin" class="form-control" runat="server" />
        </div>

        <%-- CatégorieDepense --%>
        <div class="form-group spantwo noTopPadding">
            <div class="sousTitres">
                <h5 runat="server" class="titre">Catégories De Dépenses</h5>
                <h5 runat="server" class="titre">Catégories choisies</h5>
            </div>
            <div class="select_group">
                <div class="input-group">
                    <select id="catDepenseMultiselect" multiple="multiple">
                        <asp:Repeater ID="repeaterTypeDepense" runat="server">
                            <ItemTemplate>
                                <option value="<%# Eval("idTypeDepense") %>">
                                    <%# Eval("nomDepense") %>
                                </option>
                            </ItemTemplate>
                        </asp:Repeater>
                    </select>
                </div>

                <input hidden="hidden" type="text" runat="server" id="hiddenFieldTypeDepense" />
                <asp:LinqDataSource ID="datasourceTypeDepenses" runat="server" ContextTypeName="UrbanEco.CoecoDataContext" EntityTypeName="" TableName="tbl_TypeDepense"></asp:LinqDataSource>
            </div>
        </div>

        <%-- Employés --%>
        <div class="form-group spantwo noTopPadding">
            <div class="sousTitres">
                <h5>Employés</h5>
                <h5>Employés choisis</h5>
            </div>
            <div class="select_group">
                <div class="input-group">
                    <select id="employeMultiselect" multiple="multiple">
                        <asp:Repeater ID="repeaterEmploye" runat="server">
                            <ItemTemplate>
                                <option value="<%# Eval("idEmploye") %>">
                                    <%# Eval("prenom") %> <%# Eval("nom") %>
                                </option>
                            </ItemTemplate>
                        </asp:Repeater>
                    </select>

                    <input hidden="hidden" type="text" runat="server" id="hiddenFieldEmploye" />
                    <asp:LinqDataSource ID="datasourceEmployes" runat="server" ContextTypeName="UrbanEco.CoecoDataContext" EntityTypeName="" TableName="tbl_Employe"></asp:LinqDataSource>
                </div>
            </div>
        </div>

        <asp:Button CssClass="btn btn-raised btn-success" ID="btn_generer" runat="server" Text="Générer le rapport" OnClick="GenererRapport" />

    </form>

    <script>
        let typeDepenseSelected = document.getElementById('<%=hiddenFieldTypeDepense.ClientID%>').value.split(',');
        let empSelected = document.getElementById('<%=hiddenFieldEmploye.ClientID%>').value.split(',');
        
        $('#catDepenseMultiselect').multiSelect({
        //EVENT inscrit nul part guess Onchange, onSelected pis onclick avec function return click
        afterSelect: function (values) {
            //Parce que D'amours
            typeDepenseSelected.push(values);
            console.log(typeDepenseSelected);


            var htmlStorage = document.getElementById('<%=hiddenFieldTypeDepense.ClientID%>');
            //htmlStorage.attr("data-assessments", JSON.stringify(selected));
            htmlStorage.value = typeDepenseSelected;

            console.log(htmlStorage);
        },

        afterDeselect: function (values) {
            var copy = [];

            for (var idx in typeDepenseSelected) {
                if (typeDepenseSelected[idx][0] != values[0]) {
                    copy.push(typeDepenseSelected[idx])
                }
            }

            typeDepenseSelected = copy;

            console.log(typeDepenseSelected);
            var htmlHiddenFieldEmploye = document.getElementById('<%=hiddenFieldTypeDepense.ClientID%>');

            htmlHiddenFieldEmploye.value = typeDepenseSelected;
        },

        selectableOptgroup: true,
        keepOrder: true
    });

    $('#employeMultiselect').multiSelect({
        //EVENT inscrit nul part guess Onchange, onSelected pis onclick avec function return click
        afterSelect: function (values) {
            //Parce que D'amours
            empSelected.push(values);
            console.log(empSelected);


            var htmlStorage = document.getElementById('<%=hiddenFieldEmploye.ClientID%>');
            //htmlStorage.attr("data-assessments", JSON.stringify(selected));
            htmlStorage.value = empSelected;

            console.log(htmlStorage);
        },

        afterDeselect: function (values) {
            var copy = [];

            for (var idx in empSelected) {
                if (empSelected[idx][0] != values[0]) {
                    copy.push(empSelected[idx])
                }
            }

            empSelected = copy;

            console.log(empSelected);
            var htmlHiddenFieldEmploye = document.getElementById('<%=hiddenFieldEmploye.ClientID%>');

            htmlHiddenFieldEmploye.value = empSelected;
        },

        selectableOptgroup: true,
        keepOrder: true
    });
    </script>
</asp:Content>
