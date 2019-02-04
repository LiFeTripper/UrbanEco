<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="ModifCategorie.aspx.cs" Inherits="UrbanEco.ModifCategorie" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .asp-table {
            table-layout: fixed;


        }
    </style>
    <title>Co-Éco - modification des catégories</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="TitlePlaceholder" runat="server">
    <h1>
        <asp:Label ID="Lbl_Titre" runat="server" Text="Sous-Projet"></asp:Label>
    </h1>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="BodyPlaceHolder" runat="server">

    <form runat="server">



        <%--SOUS-CATÉGORIE--%>
        <div class="form-group mb-4 col-6 mx-auto" runat="server">
            <asp:Table CssClass="asp-table" runat="server" Style="width: 100% !important;">
                <asp:TableRow>
                    <asp:TableHeaderCell CssClass="form-control" Style="width: 100%;">
                         Titre <b style="color:red">*</b>
                    </asp:TableHeaderCell>
                    <asp:TableCell>
                        <asp:TextBox ID="Tbx_Titre" runat="server" class="form-control" ></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>

        <div class="form-group mb-4 col-6 mx-auto" runat="server">
            <asp:Table CssClass="asp-table" runat="server" Style="width: 100% !important;">
                <asp:TableRow>
                    <asp:TableHeaderCell CssClass="form-control" Style="width: 100%;">
                        Description
                    </asp:TableHeaderCell>
                    <asp:TableCell>
                        <asp:TextBox ID="Tbx_Description" runat="server" class="form-control"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>

        </div>

        <%--DIV DES EMPLOYÉS--%>
        <div class="form-group mb-4 col-6 mx-auto" id="divAjoutEmp" runat="server" >
            <asp:Table CssClass="asp-table mx-auto" runat="server" Style="width: 100% !important;">
                <asp:TableRow>
                    <asp:TableHeaderCell CssClass="form-control col-lg-12" style="text-align:center;">
                        Assignation des employés
                    </asp:TableHeaderCell>
                </asp:TableRow>
                <asp:TableRow CssClass="align-content-center mx-auto">
                    <asp:TableCell CssClass="align-content-center mx-auto">
                        <div class="justify-content-lg-center input-group mb-3 col-12">
                            <select id="Multiselection" multiple="multiple" style="height:500px !important;">
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
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>

            <input type="text" runat="server" id="hiddenFieldEmployeDeselect" hidden/>
            <input type="text" runat="server" id="hiddenFieldEmploye" hidden/>
            <input type="text" runat="server" id="hiddenFieldTotal" hidden/>

        <div class="form-group mb-4 col-6 mx-auto" runat="server">
            <asp:Table CssClass="asp-table" runat="server" Style="width: 100% !important;">
                <asp:TableRow>
                    <asp:TableCell CssClass="col-md-4">
                        <%--<asp:Button ID="Btn_Annuler" runat="server" Text="Annuler" Style="width: 100% !important; float: left;" CssClass="btn btn-lg btn-danger input-box" OnClick="Btn_Annuler_Click" />--%>
                    </asp:TableCell>
                    <asp:TableCell CssClass="col-md-4">
                        &nbsp;            
                    </asp:TableCell>
                    <asp:TableCell CssClass="col-md-4">
                        <asp:Button ID="Btn_Enregistrer" runat="server" Text="Enregistrer" Style="width: 100% !important; float: right;" CssClass="btn btn-lg btn-success input-box" OnClick="Btn_Enregistrer_Click" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
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
