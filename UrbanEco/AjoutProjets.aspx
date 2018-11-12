<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="AjoutProjets.aspx.cs" Inherits="UrbanEco.Projets" MaintainScrollPositionOnPostBack = "true"  %>

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
        <div style="border: 3px solid green; padding: 5px 5px 5px 5px;">

            <div>
                <h1>
                <asp:Label ID="lbl_Top" runat="server" Text="Label"></asp:Label>
                </h1>
                <hr style="border: 20px solid #23282e; width: 100% !important; margin: 0px 0px 0px 0px; padding: 0px 0px 0px 0px" />
            </div>

            <div class="row justify-content-md-center" style="margin-bottom: 100px;">
                <div class="col-md-offset-3 col-6">
                    <%--TITRE DESCRIPTION RESPONSABLE--%>
                    <table style="width: 100% !important;">
                        <%--TITRE--%>
                        <tr>
                            <th>
                                <h5 class="input-title">Titre</h5>
                            </th>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="Tbx_Titre" runat="server" class="input-box"></asp:TextBox>
                            </td>
                        </tr>
                        <%--DESCRIPTION--%>
                        <tr>
                            <th>
                                <h5 class="input-title">Description</h5>
                            </th>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="Tbx_Description" runat="server" class="input-box"></asp:TextBox>
                            </td>
                        </tr>
                        <%--RESPONSABLE--%>
                        <tr>
                            <th>
                                <h5 class="input-title">Responsable</h5>
                            </th>
                        </tr>
                        <tr>
                            <td>
                                <asp:DropDownList ID="Ddl_Responsable" runat="server" DataSourceID="LinqEmployes" DataTextField="nom" DataValueField="idEmploye" class="input-box"></asp:DropDownList>
                                <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqEmployes" ContextTypeName="UrbanEco.CoecoDataContext" Select="new (prenom, nom, idEmploye)" TableName="tbl_Employe"></asp:LinqDataSource>
                            </td>
                        </tr>

                        <%--STATUS--%>
                        <tr>
                            <th>
                                <h5 class="input-title">Status</h5>
                            </th>
                        </tr>
                        <tr>
                            <td>
                                <asp:DropDownList ID="Ddl_Status" runat="server" DataSourceID="LinqStatus" DataTextField="nomStatus" DataValueField="idStatus" class="input-box"></asp:DropDownList>
                                <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqStatus" ContextTypeName="UrbanEco.CoecoDataContext" Select="new (nomStatus, idStatus)" TableName="tbl_Status" OrderBy="idStatus"></asp:LinqDataSource>
                            </td>
                        </tr>
                    </table>

                    <%--HEURES DEBUT ET FIN--%>
                    <table style="width: 100% !important;">
                        <%--HEURES ALLOUÉ--%>
                        <tr>
                            <th>
                                <h5 class="input-title">Heures Allouées</h5>
                            </th>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="Tbx_HeuresAlloues" runat="server" class="input-box"  ></asp:TextBox>
                            </td>
                        </tr>
                        <%--DATE DEBUT--%>
                        <tr>
                            <th>
                                <h5 class="input-title">Date de début</h5>
                            </th>
                        </tr>
                        <tr>
                            <td>
                                <input type="date" style="margin: auto" runat="server" id="Cal_DateDebut" />
                            </td>
                        </tr>
                        <%--DATE FIN--%>
                        <tr>
                            <th>
                                <h5 class="input-title">Date de fin</h5>
                            </th>
                        </tr>
                        <tr>
                            <td>
                                <input type="date" style="margin: auto" runat="server" id="Cal_DateFin" />
                            </td>
                        </tr>
                    </table>

                    <%--LISTBOX CATÉGORIE ET EMPLOYÉS--%>
                    <table style="width: 100% !important;">
                        <%--CATÉGORIE--%>
                        <tr>
                            <th>
                                <h5 class="input-title">Catégorie</h5>
                            </th>
                        </tr>
                        <tr>
                            <td>
                                <asp:ListBox ID="ListBox2" runat="server"></asp:ListBox>
                            </td>
                        </tr>

                        <%--EMPLOYÉS--%>
                        <tr>
                            <th>
                                <h5 class="input-title">Employés</h5>
                            </th>
                        </tr>
                        <tr>
                            <td>
                                <asp:ListBox ID="ListBox1" runat="server"></asp:ListBox>
                            </td>
                        </tr>
                    </table>

                    <asp:Button ID="Btn_Enregistrer" runat="server" Text="Enregistrer"  OnClick="Btn_Enregister_Click" />
                </div>
            </div>
        </div>
    </form>
</asp:Content>
