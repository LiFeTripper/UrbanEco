<%@ Page Title="Co-Éco" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="AjoutFT.aspx.cs" Inherits="UrbanEco.AjoutFT" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="lib/css/ajoutFDT.css" />
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

        .asp-table {
            table-layout: fixed;
        }
    </style>
    <title>Co-Éco - Ajout de feuilles de temps</title>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TitlePlaceHolder" runat="server">
    <h1>Ajout d'une feuille de temps</h1>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlaceHolder" runat="server">

    <form runat="server">

        <div class="form-group" runat="server" id="tbl_employe" visible="false">
            <label for="ddl_employe" class="bmd-label-floating">Employé</label>
            <asp:DropDownList CssClass="form-control" OnSelectedIndexChanged="ddl_employe_SelectedIndexChanged" ID="ddl_employe" runat="server" AutoPostBack="true" DataTextField="text" DataValueField="value"></asp:DropDownList>
        </div>

        <div class="form-group" runat="server">
            <label for="idProjet" class="bmd-label-floating">Projet</label>
            <asp:DropDownList CssClass="form-control" OnSelectedIndexChanged="tbx_projet_SelectedIndexChanged" name="idProjet" ID="tbx_projet" runat="server" DataTextField="text" DataValueField="value" AutoPostBack="true" Visible="true"></asp:DropDownList>
        </div>

        <div class="form-group" runat="server">
            <label for="tbx_heures" class="bmd-label-floating">Durée(hrs/mins)</label>
            <div class="monInputListeHeures">
                <asp:DropDownList ID="tbx_heures" runat="server" CssClass="form-control">
                    <asp:ListItem Selected="True" Value="0">0</asp:ListItem>
                    <asp:ListItem Value="1">1</asp:ListItem>
                    <asp:ListItem Value="2">2</asp:ListItem>
                    <asp:ListItem Value="3">3</asp:ListItem>
                    <asp:ListItem Value="4">4</asp:ListItem>
                    <asp:ListItem Value="5">5</asp:ListItem>
                    <asp:ListItem Value="6">6</asp:ListItem>
                    <asp:ListItem Value="7">7</asp:ListItem>
                    <asp:ListItem Value="8">8</asp:ListItem>
                </asp:DropDownList>
                <asp:DropDownList ID="tbx_minutes" runat="server" CssClass="form-control" >
                    <asp:ListItem Selected="True" Value="0">0</asp:ListItem>
                    <asp:ListItem Value="0.25">0.25</asp:ListItem>
                    <asp:ListItem Value="0.50">0.50</asp:ListItem>
                    <asp:ListItem Value="0.75">0.75</asp:ListItem>
                </asp:DropDownList>
            </div>
            
        </div>

        <div class="form-group" runat="server">
            <label for="tbx_categorie" class="bmd-label-floating">Sous-Catégorie</label>
            <asp:DropDownList CssClass="form-control" Enabled="false" ID="tbx_categorie" runat="server" DataTextField="text" DataValueField="value" AutoPostBack="true"></asp:DropDownList>
        </div>

        <div class="form-group" runat="server">
            <label for="DateCreation" class="bmd-label-floating">Date</label>
            <input type="date" id="DateCreation" runat="server" class="form-control" onchange="ChangeDate" />

        </div>

        <div class="form-group" runat="server">
            <label for="txa_comments" class="bmd-label-floating">Note</label>
            <textarea id="txa_comments" cols="50" rows="2" runat="server" class="form-control"></textarea>
        </div>

        <asp:Button ID="Btn_Enreg" CssClass="btn btn-raised btn-success" runat="server" Text="Enregistrer" OnClick="Btn_Enreg_Click" />

        <asp:Button ID="btn_annuler" CssClass="btn btn-raised btn-danger" runat="server" Text="Annuler" OnClick="btn_annuler_Click" />

    </form>
</asp:Content>
