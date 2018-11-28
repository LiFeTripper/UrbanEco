<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="ModifCategorie.aspx.cs" Inherits="UrbanEco.ModifCategorie" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="TitlePlaceholder" runat="server">
    <h1>Modifier cette catégorie</h1>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="BodyPlaceHolder" runat="server">

    <form runat="server">
        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
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
        <div>
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
            <input hidden="hidden" type="text" runat="server" id="hiddenFieldEmploye" />
        </div>
    </form>

    <script>
        //Callback for fuck sake
        var selected = document.getElementById('<%=hiddenFieldEmploye.ClientID%>').value.split(',');

        //var numberArray = new Array;
        //for (var i in selected) {
        //    numberArray.push(parseInt(i))
        //}
        //console.log(numberArray)
        
        //ID du crisse de multi + class du css
            $('#Multiselection').multiSelect({

            //EVENT inscrit nul part guess Onchange, onSelected pis onclick avec function return click
            afterSelect: function (values) {
                //Parce que D'amours
                selected.push(values);
                console.log(selected);


                var htmlStorage = document.getElementById('<%=hiddenFieldEmploye.ClientID%>');
                //htmlStorage.attr("data-assessments", JSON.stringify(selected));
                htmlStorage.value = selected;

                console.log(htmlStorage);
            },

            afterDeselect: function (values) {
                var copy = [];

                for (var idx in selected) {
                    if (selected[idx][0] != values[0]) {
                        copy.push(selected[idx])
                    }
                }

                selected = copy;

                console.log(selected);
                var htmlHiddenFieldEmploye = document.getElementById('<%=hiddenFieldEmploye.ClientID%>');

                htmlHiddenFieldEmploye.value = selected;
            },

            selectableOptgroup: true,
            keepOrder: true
        });

        //RÉUSSI
    </script>
</asp:Content>
