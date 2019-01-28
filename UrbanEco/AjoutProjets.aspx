﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="AjoutProjets.aspx.cs" Inherits="UrbanEco.Projets" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="lib/css/ajoutProjetForm.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="TitlePlaceHolder" runat="server">
    <h1>
        <asp:Label ID="lbl_Top" runat="server" Text="Label"></asp:Label>
    </h1>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="BodyPlaceHolder" runat="server">

    <form runat="server">

        <%--ALERT FAILED AUTHENTICATION--%>
        <div runat="server" id="AlertDiv" visible="false" class="alert alert-danger alert-dismissable">
            <button type="button" class="close" data-dismiss="alert">&times;</button>
            <strong>Attention!</strong>
            <br />
            Veuillez entrer un nom de projet !
        </div>

        <%--Titre--%>
        <div class="form-group">
            <label for="Tbx_Titre" class="bmd-label-floating">Titre du projet</label>
            <asp:TextBox ID="Tbx_Titre" runat="server" CssClass="form-control" type="text"></asp:TextBox>
        </div>


        <%--Description--%>
        <div class="form-group">
            <label for="Tbx_Description" class="bmd-label-floating">Description</label>
            <asp:TextBox ID="Tbx_Description" runat="server" CssClass="form-control" type="text"></asp:TextBox>
        </div>

        <%--Status--%>
        <div class="form-group">
            <label for="Ddl_TypeEmp" class="bmd-label-floating">Statut</label>
            <asp:DropDownList ID="Ddl_Status" runat="server" DataSourceID="LinqStatus" DataTextField="nomStatus" DataValueField="idStatus" class="form-control"></asp:DropDownList>
            <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqStatus" ContextTypeName="UrbanEco.CoecoDataContext" Select="new (nomStatus, idStatus)" TableName="tbl_Status" OrderBy="idStatus"></asp:LinqDataSource>
        </div>

        <%--Heures Allouées--%>
        <div class="form-group fix-Number-Input">
            <label for="Tbx_HeuresAlloues" class="bmd-label-floating">Heures Allouées</label>
            <asp:TextBox ID="Tbx_HeuresAlloues" runat="server" CssClass="form-control" placeholder="0" TextMode="number"></asp:TextBox>
        </div>

        <%--Date de début--%>
        <div class="form-group">
            <label for="Cal_DateDebut" class="bmd-label-floating">Date de début</label>
            <input type="date" runat="server" id="Cal_DateDebut" class="form-control" />
        </div>

        <%--Date de fin--%>
        <div class="form-group">
            <label for="Cal_DateFin" class="bmd-label-floating">Date de début</label>
            <input type="date"  runat="server" id="Cal_DateFin" class="form-control" />
        </div>

        <%--Responsable--%>
        <div class="form-group">
            <label for="Ddl_TypeEmp" class="bmd-label-floating">Responsable</label>
            <asp:DropDownList ID="Ddl_Responsable" runat="server" DataSourceID="LinqEmployes" DataTextField="personne" DataValueField="idEmploye" class="form-control"></asp:DropDownList>
            <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqEmployes" ContextTypeName="UrbanEco.CoecoDataContext" Select="new (prenom + ' ' + nom as personne, idEmploye)" TableName="tbl_Employe"></asp:LinqDataSource>
        </div>

        <%--Approbation feuille de temps checkbox--%>
        <div  class="form-group monCheckbox">
            <table>
                <tr>
                    <%--CHECKBOX INACTIF OU ACTIF--%>
                    <td>
                        <label class="switch">
                            <asp:CheckBox ID="Chkbx_App" runat="server" />
                            <span class="slider round"></span>
                        </label>
                    </td>
                    <td>
                        <h5>Approbation</h5>
                    </td>
                </tr>
            </table>
        </div>



        <div  class="form-group spantwo">
            <table>
                <tr>
                    <%--CHECKBOX INACTIF OU ACTIF--%>
                    <td >
                        <label class="switch">
                            <asp:CheckBox ID="ChkBx_Archivé" runat="server" />
                            <span class="slider round"></span>
                        </label>
                    </td>
                    <td>
                        <h5>Archivé</h5>
                    </td>
                </tr>
            </table>
        </div>

        <asp:Button ID="Btn_Enregistrer" runat="server" Text="Enregistrer"  CssClass="btn btn-raised btn-success" OnClick="Btn_Enregister_Click" />
        <asp:Button ID="Btn_Annuler" CausesValidation="false" runat="server" Text="Annuler"  CssClass="btn btn-raised btn-danger" OnClick="Btn_Annuler_Click" />

    </form>
</asp:Content>
