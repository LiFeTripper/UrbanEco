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

<asp:Content ID="Content2" ContentPlaceHolderID="TitlePlaceHolder" runat="server">
    <h1>
        <asp:Label ID="lbl_Top" runat="server" Text="Label"></asp:Label>
    </h1>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="BodyPlaceHolder" runat="server">

    <form runat="server">
        <div class="form-group mb-4 col-6 mx-auto">
            <label for="Tbx_Titre">Titre</label>
            <asp:TextBox ID="Tbx_Titre" runat="server" class="form-control"></asp:TextBox>
        </div>
        <div class="form-group mb-4 col-6 mx-auto">
            <label for="Tbx_Description">Description</label>
            <asp:TextBox ID="Tbx_Description" runat="server" class="form-control"></asp:TextBox>
        </div>
        <div class="form-group mb-4 col-6 mx-auto">
            <label for="Ddl_Responsable">Responsable</label>
            <asp:DropDownList ID="Ddl_Responsable" runat="server" DataSourceID="LinqEmployes" DataTextField="nom" DataValueField="idEmploye" class="form-control"></asp:DropDownList>
            <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqEmployes" ContextTypeName="UrbanEco.CoecoDataContext" Select="new (prenom, nom, idEmploye)" TableName="tbl_Employe"></asp:LinqDataSource>
        </div>
        <div class="form-group mb-4 col-6 mx-auto">
            <label for="Ddl_Status">Status</label>
            <asp:DropDownList ID="Ddl_Status" runat="server" DataSourceID="LinqStatus" DataTextField="nomStatus" DataValueField="idStatus" class="form-control"></asp:DropDownList>
            <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqStatus" ContextTypeName="UrbanEco.CoecoDataContext" Select="new (nomStatus, idStatus)" TableName="tbl_Status" OrderBy="idStatus"></asp:LinqDataSource>
        </div>
        <div class="form-group mb-4 col-6 mx-auto">
            <label for="Tbx_HeuresAlloues">Heures Allouées</label>
            <asp:TextBox ID="Tbx_HeuresAlloues" runat="server" class="form-control"></asp:TextBox>
        </div>
        <div class="form-group mb-4 col-6 mx-auto">
            <label for="Cal_DateDebut">Date de début</label>
            <input type="date" style="margin: auto" runat="server" id="Cal_DateDebut" class="form-control" />
        </div>
        <div class="form-group mb-4 col-6 mx-auto">
            <label for="Cal_DateFin">Date de fin</label>
            <input type="date" style="margin: auto" runat="server" id="Cal_DateFin" class="form-control" />
        </div>
<<<<<<< HEAD
        <div class="form-group mb-4 mt-4 col-6 mx-auto">
            <asp:Button ID="Btn_Annuler" runat="server" Text="Annuler" Style="width: 40% !important; float: left;" CssClass="btn btn-lg btn-danger input-box" OnClick="Btn_Annuler_Click"/>
            <asp:Button ID="Btn_Enregistrer" runat="server" Text="Enregistrer" Style="width: 40% !important; float: right;" CssClass="btn btn-lg btn-success input-box" OnClick="Btn_Enregister_Click"/>
            
=======
        <div class="form-group mb-4 col-6 mx-auto">
            <asp:Button ID="btn_enregistrer" CssClass="btn btn-lg btn-success" runat="server" Text="Enregistrer" OnClick="Btn_Enregister_Click"/>
>>>>>>> ff701879d5a71d92e6f67381bddebe8526e6765e
        </div>
    </form>
</asp:Content>
