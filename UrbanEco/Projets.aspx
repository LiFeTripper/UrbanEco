<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="Projets.aspx.cs" Inherits="UrbanEco.Projets1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .center {
            margin: auto;
            width: 50%;
        }

        .input-box {
            width: 100% !important;
            font-size: 17px;
            margin-bottom: 30px;
        }

        .input-title {
            text-align: left !important;
        }

        .table-custom {
            width: 800px !important;
        }

        .table-custom > table {
            width: 100% !important;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlaceHolder" runat="server">

    <form runat="server" style="text-align: center;" class="container center col-12">

        <%--BORDURE VERTE--%>
        <div style="border: 3px solid green; padding: 5px 5px 5px 5px;">
            <%--EN TËTE A MARC--%>
            <table style="width: 100% !important;">
                <tr>
                    <td>
                        <h1>Employés</h1>
                    </td>
                </tr>
                <tr>
                    <td>
                        <hr style="border-bottom: 20px solid #23282e; width: 100%;" />
                    </td>
                </tr>
                <tr>
                    <%--CHECKBOX INACTIF OU ACTIF--%>
                    <asp:Label runat="server" Text="INACTIF"></asp:Label>
                    <asp:CheckBox ID="Chkbx_Inactif" runat="server" OnCheckedChanged="Chkbx_Inactif_CheckedChanged" AutoPostBack="true" />
                </tr>
            </table>

            <%--CODE REPEATER DE PROJETS ACTIF--%>
            <asp:Repeater ID="Rptr_ProjetsActif" runat="server" DataSourceID="LinqProjetsActif" >
                
                <%--HEADERTEMPLATE--%>
                <HeaderTemplate>
                    <table style="width: 100% !important;">
                        <tr style="border-bottom: 5px solid #23282e" Visible='<%# (!Chkbx_Inactif.Checked) %>' runat="server">
                            <th>ID</th>
                            <th>Titre</th>
                            <th>Description</th>
                            <th>Status du projet</th>
                            <th>Employé Responsable</th>
                            <th>Date de début</th>
                            <th>
                                <asp:Button ID="Btn_Ajout" CssClass="btn btn-md btn-secondary" runat="server" Text="Nouveau" OnClick="Btn_Ajout_Click" />
                            </th>
                        </tr>
                </HeaderTemplate>
                
                <%--ITEMTEMPLATE--%>
                <ItemTemplate>
                    <tr style="border-bottom: 1px solid #23282e" Visible='<%# (!Boolean.Parse(Eval("archiver").ToString()) && !Chkbx_Inactif.Checked) %>' runat="server">
                        <td>
                            <asp:Label ID="lbl_ID" runat="server" Text='<%#Eval("idProjet") %>' Font-Bold="true" />
                        </td>
                        <td>
                            <asp:Label ID="lbl_Titre" runat="server" Text='<%#Eval("titre") %>' Font-Bold="true"/>
                        </td>
                        <td>
                            <asp:Label ID="lbl_Description" runat="server" Text='<%#Eval("description") %>' Font-Bold="true" />
                        </td>
                        <td>
                            <asp:Label ID="lbl_idStatus" runat="server" Text='<%#Eval("Tbl_Status.nomStatus") %>' Font-Bold="true" />
                        </td>
                        <td>
                            <asp:Label ID="lbl_idEmployeResp" runat="server" Text='<%# String.Format("{0} {1}", Eval("Tbl_Employe.prenom"), Eval("Tbl_Employe.nom")) %>' Font-Bold="true" />
                        </td>
                        <td>
                            <asp:Label ID="lbl_dateDebut" runat="server" Text='<%#Eval("dateDebut") %>' Font-Bold="true" />
                        </td>
                        <td>
                            <asp:Button ID="Btn_Modif" CssClass="btn btn-md btn-primary" runat="server" Text="Modification" OnClick="Btn_Modif_Click" CommandArgument='<%#Eval("idProjet") %>' />
                            <asp:Button ID="Btn_Cat" CssClass="btn btn-md btn-primary" runat="server" Text="Catégorie" OnClick="Btn_Cat_Click" CommandArgument='<%#Eval("idProjet") %>'/>
                        </td>
                    </tr>
                </ItemTemplate>

                <%--FOOTERTEMPLATE--%>
                <FooterTemplate>
                    
                    <tr style="border-top: 5px solid #23282e" Visible='<%# (!Chkbx_Inactif.Checked) %>' runat="server">
                            <th>ID</th>
                            <th>Titre</th>
                            <th>Description</th>
                            <th>Status du projet</th>
                            <th>Employé Responsable</th>
                            <th>Date de début</th>
                            <th>
                                <asp:Button ID="Btn_Ajout" CssClass="btn btn-md btn-secondary" runat="server" Text="Nouveau" OnClick="Btn_Ajout_Click" />
                            </th>
                        </tr>
                    </table>
                </FooterTemplate>
            </asp:Repeater>

            <%--CODE REPEATER DE PROJETS INACTIF--%>
            <asp:Repeater ID="Rptr_ProjetsInactif" runat="server" DataSourceID="LinqProjetsInactif"  >
                
                <%--HEADERTEMPLATE--%>
                <HeaderTemplate>
                    <table style="width: 100% !important;">
                        <tr style="border-bottom: 5px solid #23282e" Visible='<%# (Chkbx_Inactif.Checked) %>' runat="server">
                            <th>ID</th>
                            <th>Titre</th>
                            <th>Description</th>
                            <th>Status du projet</th>
                            <th>Employé Responsable</th>
                            <th>Date de début</th>
                            <th>
                                <asp:Button ID="Btn_Ajout" CssClass="btn btn-md btn-secondary" runat="server" Text="Nouveau" OnClick="Btn_Ajout_Click" />
                            </th>
                        </tr>
                </HeaderTemplate>
                
                <%--ITEMTEMPLATE--%>
                <ItemTemplate>
                    <tr style="border-bottom: 1px solid #23282e" Visible='<%# (Boolean.Parse(Eval("archiver").ToString()) && Chkbx_Inactif.Checked) %>' runat="server">
                        <td>
                            <asp:Label ID="lbl_ID" runat="server" Text='<%#Eval("idProjet") %>' Font-Bold="true" />
                        </td>
                        <td>
                            <asp:Label ID="lbl_Titre" runat="server" Text='<%#Eval("titre") %>' Font-Bold="true"/>
                        </td>
                        <td>
                            <asp:Label ID="lbl_Description" runat="server" Text='<%#Eval("description") %>' Font-Bold="true" />
                        </td>
                        <td>
                            <asp:Label ID="lbl_idStatus" runat="server" Text='<%#Eval("Tbl_Status.nomStatus") %>' Font-Bold="true" />
                        </td>
                        <td>
                            <asp:Label ID="lbl_idEmployeResp" runat="server" Text='<%# String.Format("{0} {1}", Eval("Tbl_Employe.prenom"), Eval("Tbl_Employe.nom")) %>' Font-Bold="true" />
                        </td>
                        <td>
                            <asp:Label ID="lbl_dateDebut" runat="server" Text='<%#Eval("dateDebut") %>' Font-Bold="true" />
                        </td>
                        <td>
                            <asp:Button ID="Btn_Modif" CssClass="btn btn-md btn-primary" runat="server" Text="Modification" OnClick="Btn_Modif_Click" CommandArgument='<%#Eval("idProjet") %>' />
                            <asp:Button ID="Btn_Cat" CssClass="btn btn-md btn-primary" runat="server" Text="Catégorie" OnClick="Btn_Cat_Click" CommandArgument='<%#Eval("idProjet") %>'/>
                        </td>
                    </tr>
                </ItemTemplate>

                <%--FOOTERTEMPLATE--%>
                <FooterTemplate>
                    
                    <tr style="border-top: 5px solid #23282e" Visible='<%# (Chkbx_Inactif.Checked) %>' runat="server">
                            <th>ID</th>
                            <th>Titre</th>
                            <th>Description</th>
                            <th>Status du projet</th>
                            <th>Employé Responsable</th>
                            <th>Date de début</th>
                            <th>
                                <asp:Button ID="Btn_Ajout" CssClass="btn btn-md btn-secondary" runat="server" Text="Nouveau" OnClick="Btn_Ajout_Click" />
                            </th>
                        </tr>
                    </table>
                </FooterTemplate>
            </asp:Repeater>

            <%--DATA SOURCE--%>
            <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqProjetsActif" ContextTypeName="UrbanEco.CoecoDataContext" TableName="tbl_Projet" Where="archiver == @archiver">
                <WhereParameters>
                    <asp:Parameter DefaultValue="false" Name="archiver" Type="Boolean"></asp:Parameter>
                </WhereParameters>
            </asp:LinqDataSource>
            <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqProjetsInactif" ContextTypeName="UrbanEco.CoecoDataContext" TableName="tbl_Projet" Where="archiver == @archiver">
                <WhereParameters>
                    <asp:Parameter DefaultValue="true" Name="archiver" Type="Boolean"></asp:Parameter>
                </WhereParameters>
            </asp:LinqDataSource>
        </div>
    </form>
</asp:Content>
