<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="RapportDepense.aspx.cs" Inherits="UrbanEco.RapportDepense" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="RapportDepenses/Multiselect.js"></script>
    <title>Coeco - Rapport Depense</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="TitlePlaceholder" runat="server">
    Rapport Dépense
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="BodyPlaceHolder" runat="server">

    <form runat="server">
        <%-- Dates --%>
        <div class="row justify-content-center">
            <div class="date_inputs">
                <h5>Date de début</h5>
                <input class="form-control" type="date" id="date_debut" runat="server" />
                <h5>Date de fin</h5>
                <input class="form-control" type="date" id="date_fin" runat="server" />
            </div>
        </div>

        <asp:Button Text="text" runat="server" />

        <%-- CatégorieDepense --%>
        <div class="row justify-content-center">
            <div class="select_group">
                <h5>Catégorie de dépenses</h5>
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
        <div class="row justify-content-center">
            <div class="select_group">
                <h5>Employés</h5>

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

        <asp:Button Text="Generer Rapport" runat="server" OnClick="GenererRapport" />
    </form>

    <script>
        $('#catDepenseMultiselect').multiSelect({
        //EVENT inscrit nul part guess Onchange, onSelected pis onclick avec function return click
        afterSelect: function (values) {
            //Parce que D'amours
            empSelected.push(values);
            console.log(empSelected);


            var htmlStorage = document.getElementById('<%=hiddenFieldTypeDepense.ClientID%>');
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
            var htmlHiddenFieldEmploye = document.getElementById('<%=hiddenFieldTypeDepense.ClientID%>');

            htmlHiddenFieldEmploye.value = empSelected;
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
