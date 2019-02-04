<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="Employe.aspx.cs" Inherits="UrbanEco.Employe" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .btn-option {
            height: 30px !important;
            width: 30px !important;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="TitlePlaceHolder" runat="server">
    <h1>Employés</h1>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlaceHolder" runat="server">

    <form runat="server" style="text-align: center;" class="container center col-12">

        <%--EN TËTE A MARC--%>
        <table style="width: 100% !important;">
            <tr>
                <%--CHECKBOX INACTIF OU ACTIF--%>
                <td style="width:50%;" class="mb-3">
                    <label class="switch" style="float:right;">
                        <asp:CheckBox runat="server" id="Chkbx_Inactif" OnCheckedChanged="Chkbx_Inactif_CheckedChanged" AutoPostBack="true"/>
                        <span class="slider round"></span>
                    </label>              
                </td>
                <td >
                    <h4 style="float:left;">Inactif</h4>
                </td>
            </tr>
        </table>

        <%--CODE REPEATER D'EMPLOYÉ--%>
        <asp:Repeater ID="Rptr_TypeEmploye" runat="server" DataSourceID="LinqEmploye">

            <%--HEADERTEMPLATE--%>
            <HeaderTemplate>
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr >
                                <th scope="col">Type Employé</th>
                                <%--<th scope="col">ID</th>--%>
                                <th scope="col">Nom</th>
                                <th scope="col">Prénom</th>
                                <th scope="col">Adresse Courriel</th>
                                <th scope="col">
                                    <asp:Button ID="Btn_Ajout" CssClass="btn btn-raised btn-success" runat="server" Text="Ajouter un employé" Onclick="Btn_Ajout_Click" />
                                </th>
                            </tr>
                        </thead>
                        <tbody>
            </HeaderTemplate>

            <%--ITEMTEMPLATE--%>
            <ItemTemplate>
                <tr style="border-bottom: 1px solid #23282e" class="table-SousCategorie">
                    <td>
                        <asp:Label ID="lbl_ID" runat="server" Text='<%#Eval("nomType") %>' />
                    </td>
                    <%--Ajustement pour le gris se rende au bout--%>
                    <td />
                    <td />
                    <td />
                    <td />
                    <%--<td />--%>
                </tr>

                <%--SECOND REPEATER AVEC LES USERS--%>
                <%--REPEATER DES ACTIF--%>
                <asp:Repeater ID="Rptr_EmployeActif" runat="server" DataSource='<%#Eval("tbl_Employe") %>'>
                    <ItemTemplate>
                        <tr visible='<%# (!Boolean.Parse(Eval("inactif").ToString()) && !Chkbx_Inactif.Checked) && Eval("prenom").ToString() != "Administrateur" %>' runat="server">
                            <td></td>
<%--                            <td>
                                <asp:Label ID="lbl_idEmploye" runat="server" Text='<%#Eval("idEmploye") %>' Font-Bold="true" />
                            </td>--%>
                            <td>
                                <asp:Label ID="lbl_Nom" runat="server" Text='<%#Eval("nom") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lbl_Prenom" runat="server" Text='<%#Eval("prenom") %>'  />
                            </td>
                            <td>
                                <asp:Label ID="lbl_noTel" runat="server" Text='<%#Eval("email") %>'/>
                            </td>
                            <td>
                                <asp:ImageButton CssClass="btn-option" ID="Btn_Modif" runat="server" src="Resources/pencil.png" Style="margin-right: 10px;" OnClick="Btn_Modif_Click" CommandArgument='<%#Eval("idEmploye") %>'/>
                                <%--<asp:Button ID="Btn_Modif" CssClass="btn btn-md btn-primary" runat="server" Text="Modification" OnClick="Btn_Modif_Click" CommandArgument='<%#Eval("idEmploye") %>' />--%>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
                <%--REPEATER DES INACTIF--%>
                <asp:Repeater ID="Rptr_EmployeInactif" runat="server" DataSource='<%#Eval("tbl_Employe") %>'>
                    <ItemTemplate>
                        <tr visible='<%# (Boolean.Parse(Eval("inactif").ToString()) && Chkbx_Inactif.Checked) %>' runat="server">
                            <td></td>
<%--                            <td>
                                <asp:Label ID="lbl_idEmploye" runat="server" Text='<%#Eval("idEmploye") %>' Font-Bold="true" />
                            </td>--%>
                            <td>
                                <asp:Label ID="lbl_Nom" runat="server" Text='<%#Eval("nom") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lbl_Prenom" runat="server" Text='<%#Eval("prenom") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lbl_noTel" runat="server" Text='<%#Eval("email") %>'/>
                            </td>
                            <td>
                                <asp:ImageButton CssClass="btn-option" ToolTip="Modifier cet employé" ID="Btn_Modif" runat="server" src="Resources/pencil.png" Style="margin-right: 10px;" OnClick="Btn_Modif_Click" CommandArgument='<%#Eval("idEmploye") %>'/>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </ItemTemplate>

            <%--FOOTERTEMPLATE--%>
            <FooterTemplate>
                </tbody>
                    <thead>
                        <tr class="t_footer">
                            <th scope="col">Type Employé</th>
                            <%--<th scope="col">ID</th>--%>
                            <th scope="col">Nom</th>
                            <th scope="col">Prénom</th>
                            <th scope="col">Adresse courriel</th>
                            <th scope="col">
                                <asp:Button ID="Btn_Ajout" CssClass="btn btn-raised btn-success" runat="server" Text="Ajouter un employé" Onclick="Btn_Ajout_Click" />
                            </th>
                        </tr>
                    </thead>
                </table>
                    </div>
            </FooterTemplate>
        </asp:Repeater>

        <%--DATA SOURCE--%>
        <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqEmploye" ContextTypeName="UrbanEco.CoecoDataContext" TableName="tbl_TypeEmploye"></asp:LinqDataSource>
        <%--</div>--%>
    </form>
</asp:Content>
