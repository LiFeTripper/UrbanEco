<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="Projets.aspx.cs" Inherits="UrbanEco.Projets1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .btn-option {
            height: 30px !important;
            width: 30px !important;
        }
    </style>
    <title>Co-Éco - Projets</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="TitlePlaceHolder" runat="server">
    <h1>
        <asp:Label ID="Lbl_Titre" runat="server" Text="Projets"></asp:Label>
    </h1>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="BodyPlaceHolder" runat="server">

    <form runat="server" style="text-align: center;" class="container center col-12">
        <%--EN TËTE A MARC--%>

        <table style="width: 100% !important;">              
            <tr class="mb-3">
                 <%--CHECKBOX INACTIF OU ACTIF--%>
                <td style="width: 50%;">
                    <label class="switch" style="float: right;">
                        <asp:CheckBox ID="Chkbx_Inactif" runat="server" OnCheckedChanged="Chkbx_Inactif_CheckedChanged" AutoPostBack="true" />
                        <span class="slider round"></span>
                    </label>
                </td>
                <td>
                    <h4 style="float: left;">Inactif</h4>
                </td>
            </tr>
        </table>

        <%--CODE REPEATER DE PROJETS ACTIF--%>
        <asp:Repeater ID="Rptr_ProjetsActif" runat="server" DataSourceID="LinqProjetsActif">

            <%--HEADERTEMPLATE--%>
            <HeaderTemplate>
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr visible='<%# (!Chkbx_Inactif.Checked) %>' runat="server">
                                <%--<th scope="col">ID</th>--%>
                                <th scope="col">Titre</th>
                                <th scope="col">Description</th>
                                <th scope="col">Statut</th>
                                <th scope="col">Employé Responsable</th>
<%--                                <th scope="col">Date de début</th>--%>
                                <th scope="col">
                                    <asp:Button ID="Btn_Ajout" CssClass="btn btn-raised btn-success" runat="server" Text="Nouveau Projet" OnClick="Btn_Ajout_Click" />
                                </th>
                            </tr>
                        </thead>
                        <tbody>
            </HeaderTemplate>

            <%--ITEMTEMPLATE--%>
            <ItemTemplate>

                <tr visible='<%# (!Boolean.Parse(Eval("archiver").ToString()) && !Chkbx_Inactif.Checked) %>' runat="server" class="align-middle">
<%--                    <td>
                        <asp:Label ID="lbl_ID" runat="server" Text='<%#Eval("idProjet") %>' Font-Bold="true" />
                    </td>--%>
                    <td>
                        <asp:Label ID="lbl_Titre" runat="server" Text='<%#Eval("titre") %>' />
                    </td>
                    <td>
                        <asp:Label ID="lbl_Description" runat="server" Text='<%#Eval("description") %>'/>
                    </td>
                    <td>
                        <asp:Label ID="lbl_idStatus" runat="server" Text='<%#Eval("Tbl_Status.nomStatus") %>'/>
                    </td>
                    <td>
                        <asp:Label ID="lbl_idEmployeResp" runat="server" Text='<%# String.Format("{0} {1}", Eval("Tbl_Employe.prenom"), Eval("Tbl_Employe.nom")) %>' />
                    </td>
<%--                    <td>
                        <asp:Label ID="lbl_dateDebut" runat="server" Text='<%#Eval("dateDebut") %>' Font-Bold="true" />
                    </td>--%>

                    <td>
                        <asp:ImageButton CssClass="btn-option" ID="Btn_Modif" runat="server" src="Resources/pencil.png" Style="margin-right: 10px;" OnClick="Btn_Modif_Click" CommandArgument='<%#Eval("idProjet") %>'/>
                        <asp:ImageButton CssClass="btn-option" ID="Btn_Cat" runat="server" src="Resources/folder_open.png" Style="margin-right: 10px;" OnClick="Btn_Cat_Click" CommandArgument='<%#Eval("idProjet") %>'/>
                    </td>
                </tr>
            </ItemTemplate>

            <%--FOOTERTEMPLATE--%>
            <FooterTemplate>
                </tbody>
                <thead class="t_footer2">
                    <tr visible='<%# (!Chkbx_Inactif.Checked) %>' runat="server">
                        <%--<th scope="col">ID</th>--%>
                        <th scope="col">Titre</th>
                        <th scope="col">Description</th>
                        <th scope="col">Statut</th>
                        <th scope="col">Employé Responsable</th>
<%--                        <th scope="col">Date de début</th>--%>
                        <th scope="col">
                            <asp:Button ID="Btn_Ajout" CssClass="btn btn-raised btn-success" runat="server" Text="Nouveau Projet" OnClick="Btn_Ajout_Click" />
                        </th>
                    </tr>
                </thead>
                </table>
                    </div>
            </FooterTemplate>
        </asp:Repeater>

        <%--CODE REPEATER DE PROJETS INACTIF--%>
        <asp:Repeater ID="Rptr_ProjetsInactif" runat="server" DataSourceID="LinqProjetsInactif">

            <%--HEADERTEMPLATE--%>
            <HeaderTemplate>
                <div class="table-responsive">

                    <table class="table">
                        <thead>
                            <tr visible='<%# (Chkbx_Inactif.Checked) %>' runat="server">
                                <th scope="col">Titre</th>
                                <th scope="col">Description</th>
                                <th scope="col">Statut du projet</th>
                                <th scope="col">Employé Responsable</th>
<%--                                <th scope="col">Date de début</th>--%>
                                <th scope="col">
                                    <asp:Button ID="Btn_Ajout" CssClass="btn btn-md btn-raised btn-success" runat="server" Text="Nouveau Projet" OnClick="Btn_Ajout_Click" />
                                </th>
                            </tr>
                        </thead>
                        <tbody>
            </HeaderTemplate>

            <%--ITEMTEMPLATE--%>
            <ItemTemplate>

                <tr visible='<%# (Boolean.Parse(Eval("archiver").ToString()) && Chkbx_Inactif.Checked) %>' runat="server">
                    <td>
                        <asp:Label ID="lbl_Titre" runat="server" Text='<%#Eval("titre") %>'  />
                    </td>
                    <td>
                        <asp:Label ID="lbl_Description" runat="server" Text='<%#Eval("description") %>' />
                    </td>
                    <td>
                        <asp:Label ID="lbl_idStatus" runat="server" Text='<%#Eval("Tbl_Status.nomStatus") %>'  />
                    </td>
                    <td>
                        <asp:Label ID="lbl_idEmployeResp" runat="server" Text='<%# String.Format("{0} {1}", Eval("Tbl_Employe.prenom"), Eval("Tbl_Employe.nom")) %>' />
                    </td>
<%--                    <td>
                        <asp:Label ID="lbl_dateDebut" runat="server" Text='<%#Eval("dateDebut") %>' Font-Bold="true" />
                    </td>--%>

                    <td>
                        <asp:ImageButton CssClass="btn-option" ID="Btn_Modif" runat="server" src="Resources/pencil.png" Style="margin-right: 10px;" OnClick="Btn_Modif_Click" CommandArgument='<%#Eval("idProjet") %>'/>
                        <%--<asp:Button ID="Btn_Modif" CssClass="btn btn-md btn-primary" runat="server" Text="Modifier" OnClick="Btn_Modif_Click" CommandArgument='<%#Eval("idProjet") %>' />--%>
                        <%--<asp:Button ID="Btn_Cat" CssClass="btn btn-md btn-primary" runat="server" Text="Ajouter des catégories" OnClick="Btn_Cat_Click" CommandArgument='<%#Eval("idProjet") %>' />--%>
                    </td>
                </tr>
            </ItemTemplate>

            <%--FOOTERTEMPLATE--%>
            <FooterTemplate>
                </tbody>
                <thead >
                    <tr visible='<%# (Chkbx_Inactif.Checked) %>' runat="server">
                        <th scope="col">Titre</th>
                        <th scope="col">Description</th>
                        <th scope="col">Statut du projet</th>
                        <th scope="col">Employé Responsable</th>
                        <th scope="col">Date de début</th>
                        <th scope="col">
                            <asp:Button ID="Btn_Ajout" CssClass="btn btn-md btn-success" runat="server" Text="Nouveau" OnClick="Btn_Ajout_Click" />
                        </th>
                    </tr>
                </thead>
                </table>
                    </div>
            </FooterTemplate>
        </asp:Repeater>

        <%--DATA SOURCE--%>
        <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqProjetsActif" ContextTypeName="UrbanEco.CoecoDataContext" TableName="tbl_Projet" Where="archiver == @archiver" OrderBy="titre">
            <WhereParameters>
                <asp:Parameter DefaultValue="false" Name="archiver" Type="Boolean"></asp:Parameter>
            </WhereParameters>
        </asp:LinqDataSource>
        <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqProjetsInactif" ContextTypeName="UrbanEco.CoecoDataContext" TableName="tbl_Projet" Where="archiver == @archiver" OrderBy="titre">
            <WhereParameters>
                <asp:Parameter DefaultValue="true" Name="archiver" Type="Boolean"></asp:Parameter>
            </WhereParameters>
        </asp:LinqDataSource>
    </form>
</asp:Content>
