<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="ModifCategorie.aspx.cs" Inherits="UrbanEco.ModifCategorie" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .asp-table {
            table-layout: fixed;
        }
    </style>
    <title>Co-Éco - modification des catégories</title>
    <link rel="stylesheet" type="text/css" href="lib/css/modifCategorie.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="TitlePlaceholder" runat="server">
    <h1>
        <asp:Label ID="Lbl_Titre" runat="server" Text="Sous-Projet"></asp:Label>
    </h1>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="BodyPlaceHolder" runat="server">

    <form runat="server">



        <%--SOUS-CATÉGORIE--%>
        <div class="form-group" runat="server">
            <label for="Tbx_Titre" class="bmd-label-floating">Titre</label>
            <asp:TextBox ID="Tbx_Titre" runat="server" class="form-control" ></asp:TextBox>
        </div>

        <div class="form-group" runat="server">
            <label for="Tbx_Description" class="bmd-label-floating">Description</label>
            <asp:TextBox ID="Tbx_Description" runat="server" class="form-control"></asp:TextBox>
        </div>

        <h5 class="spantwo titre">Assignation des employés</h5>

        <%--DIV DES EMPLOYÉS--%>
        <div class="form-group spantwo noTopPadding" id="divAjoutEmp" runat="server" >
            <select id="Multiselection" multiple="multiple">
                <optgroup label='Bureau'>
                    <asp:Repeater runat="server" ID="RepBureau">
                        <ItemTemplate>
                            <option value='<%#Eval("idEmploye") %>' <%# EmployeSelected(Eval("idEmploye")) %>><%# String.Format("{0}, {1}", Eval("nom"), Eval("prenom")) %></option>
                        </ItemTemplate>
                    </asp:Repeater>
                </optgroup>
                <optgroup label='Terrain'>
                    <asp:Repeater runat="server" ID="RepTerrain">
                        <ItemTemplate>
                            <option value='<%#Eval("idEmploye") %>' <%# EmployeSelected(Eval("idEmploye")) %>><%# String.Format("{0}, {1}", Eval("nom"), Eval("prenom")) %></option>
                        </ItemTemplate>
                    </asp:Repeater>
                </optgroup>
            </select>
        </div>

        <input type="text" runat="server" id="hiddenFieldEmployeDeselect" hidden/>
        <input type="text" runat="server" id="hiddenFieldEmploye" hidden/>
        <div class="spantwo">
            <input type="text" runat="server" id="hiddenFieldAllEmploye" hidden/>
        </div>

        <asp:Button ID="Btn_Enregistrer" runat="server" Text="Enregistrer"  CssClass="btn btn-raised btn-success" OnClick="Btn_Enregistrer_Click" />
        <asp:Button ID="Btn_Annuler" runat="server" Text="Annuler" CssClass="btn btn-raised btn-danger" OnClick="Btn_Annuler_Click" />



    </form>

    <script>
        //Callback for fuck sake
        var selected = document.getElementById('<%=hiddenFieldEmploye.ClientID%>').value.split(',');
        var deselected = document.getElementById('<%=hiddenFieldEmployeDeselect.ClientID%>').value.split(',');;
        //ID du crisse de multi + class du css
        $('#Multiselection').multiSelect({
            //EVENT sur le select
            afterSelect: function (values) {
                var copy = [];
                for (var idx in selected) {
                    if (selected[idx][0] != values[0]) {
                        copy.push(selected[idx])
                    }
                }
                copy.push(values)
                selected = copy;
                var htmlStorage = document.getElementById('<%=hiddenFieldEmploye.ClientID%>');
                htmlStorage.value = selected;
            },
            //EVENT sur le déselect
            afterDeselect: function (values) {
                //Ajustement de la liste en cas d'ajout
                var copy = [];
                for (var idx in selected) {
                    if (selected[idx][0] != values[0]) {
                        copy.push(selected[idx])
                    }
                }
                selected = copy;
                var htmlHiddenFieldEmploye = document.getElementById('<%=hiddenFieldEmploye.ClientID%>');
                htmlHiddenFieldEmploye.value = selected;
                //Ajustement de la liste de deselected pour un update
                var htmlStorageDeselect = document.getElementById('<%=hiddenFieldEmployeDeselect.ClientID%>');
                htmlStorageDeselect.value += values[0] + ",";
               
            },
            selectableOptgroup: true,
            keepOrder: true,
            selectableHeader: "<div class='form-control'>Disponible</div>",
            selectionHeader: "<div class='form-control'>Sélectionné(s)</div>",
        });
        //RÉUSSI
    </script>
</asp:Content>