<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="True" CodeBehind="AjoutCategorie.aspx.cs" Inherits="UrbanEco.AjoutCategorie" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="TitlePlaceHolder" runat="server">
    <h1>Catégorie</h1>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlaceHolder" runat="server">

    <form runat="server" style="text-align: center;" class="container center col-12">

        <asp:Label runat="server" Visible="false" ID="lbl_noProjet"></asp:Label>
        <%--CODE REPEATER DE PROJETS ACTIF--%>
        <asp:Repeater ID="Rptr_Categorie" runat="server">

            <%--HEADERTEMPLATE--%>
            <HeaderTemplate>
                <div class="table-responsive">
                    <table class="table">
                        <thead class="thead-dark">
                            <tr style="border-bottom: 5px solid #23282e" runat="server">
                                <th scope="col">ID</th>
                                <th scope="col">Titre Catégorie</th>
                                <th scope="col">Titre Sous-CatégorieDescription</th>
                                <th scope="col">Description</th>
                                <th scope="col">
                                    <%--<button class="btn btn-primary" data-toggle="collapse" data-target="#collapseAjoutCat" aria-expanded="false" aria-controls="collapseExample" onclick="return false;">Ajouter</button>--%>
                                    <asp:Button class="btn btn-primary" ID="Btn_AjoutSousProjet" runat="server" Text="Ajout" OnClick="Btn_AjoutSousProjet_Click" />
                                </th>
                            </tr>
                        </thead>

                        <tbody>
            </HeaderTemplate>

            <%--ITEMTEMPLATE--%>
            <ItemTemplate>

                <%--MENU COLLAPSE DE CATÉGORIE
                <tr class="collapse" id="collapseAjoutCat">
                    <form>
                        <td>PREMIERE COLONE VIDE</td>
                        <td>
                            <div class="form-group col-12 mx-auto">
                                <label for="Tbx_Titre">Titre</label>
                                <input type="text" class="form-control" id="Text1" placeholder="Titre" runat="server">
                            </div>
                        </td>
                        <td>TROISIEME COLONE VIDE</td>
                        <td>
                            <div class="form-group mb-4 col-12 mx-auto">
                                <label for="Tbx_Description">Description</label>
                                <input type="text" class="form-control" id="Text2" placeholder="Description" runat="server">
                            </div>
                        </td>
                        <td>
                            <div class="form-group mb-4 col-12 mx-auto">
                                <asp:Button class="btn btn-success" ID="Btn_AjoutCat" runat="server" Text="Ajouter" OnClick="Btn_AjoutCat_Click" />
                                <button class="btn btn-danger" id="Btn_AnnulerCat" data-toggle="collapse" data-target="#collapseAjout">Annuler</button>
                            </div>
                        </td>
                    </form>
                </tr>--%>

                <%--LIGNE DU REPEATER--%>
                <tr style="border-bottom: 1px solid #23282e" runat="server" class="table-secondary">
                    <td>
                        <asp:Label ID="lbl_ID" runat="server" Text='<%#Eval("idProjetCat") %>' Font-Bold="true" />
                    </td>
                    <td>
                        <asp:Label ID="lbl_Titre" runat="server" Text='<%#Eval("titre") %>' Font-Bold="true" />
                    </td>
                    <td>
                        <%--TD VIDE CAR PAS UNE SOUS-CATÉGORIE--%>
                    </td>
                    <td>
                        <asp:Label ID="lbl_Description" runat="server" Text='<%#Eval("description") %>' Font-Bold="true" />
                    </td>
                    <%--BOUTON AJOUT SOUS-CAT POUR CETTE CATEGORIE--%>
                    <td>
                        <%--<button class="btn btn-primary" data-toggle="collapse" data-target="#collapseAjout" aria-expanded="false" aria-controls="collapseExample" onclick="return false;">Ajouter</button>--%>
                        <asp:Button class="btn btn-primary" ID="Btn_AjoutSSProjet" runat="server" Text="Ajout" OnClick="Btn_AjoutSSProjet_Click" CommandArgument='<%#Eval("idProjetCat") %>' />
                        <asp:Button class="btn btn-primary" ID="Btn_ModifSousProjet" runat="server" Text="Modification" OnClick="Btn_ModifSousProjet_Click" CommandArgument='<%#Eval("idProjetCat") %>' />
                    </td>
                </tr>

                <%--MENU COLLAPSE DE SOUS-CATÉGORIE
                <tr class="collapse" id="collapseAjout">
                    <form>
                        <td>PREMIERE COLONE VIDE</td>
                        <td>
                            <div class="form-group col-12 mx-auto">
                                <label for="Tbx_Titre">Titre</label>
                                <input type="text" class="form-control" id="Tbx_Titre" placeholder="Titre" runat="server">
                            </div>
                        </td>
                        <td>TROISIEME COLONE VIDE</td>
                        <td>
                            <div class="form-group mb-4 col-12 mx-auto">
                                <label for="Tbx_Description">Description</label>
                                <input type="text" class="form-control" id="Tbx_Description" placeholder="Description" runat="server">
                            </div>
                        </td>
                        <td>
                            <div class="form-group mb-4 col-12 mx-auto">
                                <asp:Button class="btn btn-success" ID="Btn_AjoutSousCat" runat="server" Text="Ajouter" OnClientClick="valeurCollapse()" OnClick="Btn_AjoutSousCat_Click" CommandArgument='<%#Eval("idProjetCat") %>' />
                                <button class="btn btn-danger" id="Btn_Annuler" data-toggle="collapse" data-target="#collapseAjout">Annuler</button>
                            </div>
                        </td>
                    </form>
                </tr>--%>


                <asp:Repeater ID="Rptr_SousCat" runat="server" DataSource='<%#Eval("tbl_ProjetCat2") %>'>
                    <ItemTemplate>
                        <tr style="border-bottom: 1px solid #23282e" runat="server">
                            <td>
                                <asp:Label ID="lbl_ID" runat="server" Text='<%#Eval("idProjetCat") %>' Font-Bold="true" />
                            </td>
                            <td>
                                <%--TD VIDE CAR PAS UNE CATÉGORIE--%>
                            </td>
                            <td>
                                <asp:Label ID="lbl_Titre" runat="server" Text='<%#Eval("titre") %>' Font-Bold="true" />
                            </td>
                            <td>
                                <asp:Label ID="lbl_Description" runat="server" Text='<%#Eval("description") %>' Font-Bold="true" />
                            </td>
                            <%--BOUTON AJOUT D'EMPLOYÉ DANS SOUS-CATÉGORIE--%>
                            <td>
                                <%--<button class="btn btn-primary" data-toggle="collapse" data-target="#collapseEmp" aria-expanded="false" aria-controls="collapseExample" onclick="return false;">Employés</button>--%>
                                <asp:Button class="btn btn-primary" ID="Btn_ModifSSProjet" runat="server" Text="Modification" OnClick="Btn_ModifSousProjet_Click" CommandArgument='<%#Eval("idProjetCat") %>' />
                            </td>
                        </tr>

                        <%--MENU COLLAPSE D'AJOUT D'EMPT
                <tr class="collapse" id="collapseEmp">
                    <form>
                        MULTISELECT
                            <div class="justify-content-lg-center input-group mb-3 col-12">
                                <select id="Multiselection" multiple="multiple">
                                    <optgroup label='Bureau'>
                                        <option value="Mathieu"></option>
                                    </optgroup>
                                    <optgroup label='Terrain'>
                                        <option value="Marc"></option>
                                    </optgroup>
                                </select>
                            </div>

                    </form>
                </tr>--%>
                    </ItemTemplate>
                </asp:Repeater>
            </ItemTemplate>

            <%--FOOTERTEMPLATE--%>
            <FooterTemplate>
                </tbody>
                <thead class="thead-dark">
                    <tr style="border-bottom: 5px solid #23282e" runat="server">
                        <th scope="col">ID</th>
                        <th scope="col">Titre Catégorie</th>
                        <th scope="col">Titre Sous-CatégorieDescription</th>
                        <th scope="col">Description</th>
                        <th scope="col">
                            <asp:Button class="btn btn-primary" ID="Btn_AjoutSousProjet" runat="server" Text="Ajout" OnClick="Btn_AjoutSousProjet_Click" />
                        </th>
                    </tr>
                </thead>
                </table>
                    </div>
            </FooterTemplate>
        </asp:Repeater>

        <%--DATASOURCE--%>
        <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqProjetsCat" ContextTypeName="UrbanEco.CoecoDataContext" TableName="tbl_ProjetCat">
        </asp:LinqDataSource>
    </form>


    <%--FONCTION JAVASCRIPT DU BOOTBOX--%>
    <script>
        //function Send() {
        //    bootbox.dialog({
        //        title: 'Nouvelle Catégorie pour ce projet',
        //        message: "<p>Veuillez entrez les informations de la nouvelle catégorie :</p>" +

        //            "<p><label for='Tbx_AjoutCat1'>Nom de la catégorie :</label></p>" +
        //            "<p><input type='text' id='Tbx_AjoutCat1'/></p>" +
        //            "<p><label for='Tbx_AjoutCatDesc1'>Description de la catégorie :</label></p>" +
        //            "<p><input type='text' id='Tbx_AjoutCatDesc1'/></p>",

        //        buttons: {
        //            ok: {
        //                label: "Ajouter",
        //                className: 'btn-info',
        //                callback: function () {

        //                    var cat = document.getElementById('Tbx_AjoutCat1');
        //                    var desc = document.getElementById('Tbx_AjoutCatDesc1');

        //                    var categorie = cat.value;
        //                    var description = desc.value;

        //                    document.getElementById('HiddenField_Titre').textContent = categorie;
        //                    document.getElementById('HiddenField_Desc').textContent = description;
        //                    document.getElementById('lbl_noProjet').value = categorie;
        //                    Btn_AjoutSousCat();
        //                }
        //            },
        //            cancel: {
        //                label: "Annuler",
        //                className: 'btn-danger',
        //                callback: function () {
        //                    Example.show('Pas de nouvelle catégorie ajoutée');
        //                }
        //            },
        //        }
        //    });

    </script>
</asp:Content>
