<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="ModifCategorie.aspx.cs" Inherits="UrbanEco.ModifCategorie" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="TitlePlaceholder" runat="server">
    <h1>Modifier cette catégorie</h1>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="BodyPlaceHolder" runat="server">

    <form runat="server">
        <%--DIV DES TITRE--%>
        <div>
            <div class="form-group mb-4 col-6 mx-auto">
                <label for="Tbx_Titre">Titre</label>
                <asp:TextBox ID="Tbx_Titre" runat="server" class="form-control"></asp:TextBox>
            </div>
            <div class="form-group mb-4 col-6 mx-auto">
                <label for="Tbx_Description">Description</label>
                <asp:TextBox ID="Tbx_Description" runat="server" class="form-control"></asp:TextBox>
            </div>
            <div class="form-group mb-4 mt-4 col-6 mx-auto">
                <asp:Button ID="Btn_Annuler" runat="server" Text="Annuler" Style="width: 40% !important; float: left;" CssClass="btn btn-lg btn-danger input-box" OnClick="Btn_Annuler_Click" />
                <asp:Button ID="Btn_Enregistrer" runat="server" Text="Enregistrer" Style="width: 40% !important; float: right;" CssClass="btn btn-lg btn-success input-box" OnClick="Btn_Enregistrer_Click" />
            </div>
        </div>

        <%--DIV DES EMPLOYÉS--%>
        <div class="form-group mb-4 mt-3 col-6 mx-auto" runat="server" id="Div_Multiselect">
            <h1 class="align-content-center">Sélection des employés</h1>
            <!--MULTISELECT-->
            <div class="justify-content-lg-center input-group mb-3 col-12">
                <select id="Multiselection" multiple="multiple">
                    <optgroup label='Bureau'>
                        <asp:Repeater runat="server" ID="RepBureau">
                            <ItemTemplate>
                                <option value='<%#Eval("idEmploye") %>' <%# EmployeSelected(Eval("idEmploye")) %>><%# String.Format("{0} {1}", Eval("nom"), Eval("prenom")) %></option>
                            </ItemTemplate>
                        </asp:Repeater>
                    </optgroup>
                    <optgroup label='Terrain'>
                        <asp:Repeater runat="server" ID="RepTerrain">
                            <ItemTemplate>
                                <option value='<%#Eval("idEmploye") %>' <%# EmployeSelected(Eval("idEmploye")) %>><%# String.Format("{0} {1}", Eval("nom"), Eval("prenom")) %></option>
                            </ItemTemplate>
                        </asp:Repeater>
                    </optgroup>
                </select>
            </div>
            <input type="text" runat="server" id="hiddenFieldEmployeDeselect" />
            <input type="text" runat="server" id="hiddenFieldEmploye" />
            <input type="text" runat="server" id="hiddenFieldTotal" />
        </div>
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
                htmlStorageDeselect.value = deselected;
            },

            selectableOptgroup: true,
            keepOrder: true,
            selectableHeader: "<div class='custom-header'>Disponible</div>",
            selectionHeader: "<div class='custom-header'>Sélectionné</div>",
        });
        //RÉUSSI
    </script>
</asp:Content>
