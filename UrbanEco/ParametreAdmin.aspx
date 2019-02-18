<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="ParametreAdmin.aspx.cs" Inherits="UrbanEco.ParametreAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="lib/css/parametres.css" />
    <style>
        .btn-ajouter:hover{
            cursor: pointer;
        }
        .btn-ajouter{
            cursor: default;
        }
    </style>
    <title>Co-Éco - Paramètres administrateur</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TitlePlaceholder" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
    <form runat="server">

        <%--EN-TËTE--%>
        <div class="form-group spantwo">
            <h3>Paramètres Administrateur</h3>
        </div>

        <h4 class="spantwo">Taux de kilométrage</h4>
        <div class="form-group">
            <%--Voiture--%>  
            <label for="tbx_voiture">Voiture</label>
            <asp:TextBox CssClass="form-control" runat="server" ID="tbx_voiture"></asp:TextBox>
        </div>
        <p class="bold">$/KM</p>

        <div class="form-group">
            <%--Camion--%>  
            <label for="tbx_voiture">Camion</label>
            <asp:TextBox CssClass="form-control" runat="server" ID="tbx_camion"></asp:TextBox>
        </div>
        <p class="bold">$/KM</p>

        <div class="form-group spantwo">
            <hr style="width:100%; border:2px solid black;"/>
        </div>
        
        <div class="form-group spantwo alert alert-info">
            <strong>Note*</strong> Les modifications apportées aux types de dépense (en bleu) ne sont enregistrées qu'après avoir confirmé avec le bouton ci-dessous.
        </div>
         <%--Type dépense Bureau--%>
        <h5 runat="server" class="spantwo">Type de dépense pour les employés de Bureau</h5>
        <div class="form-group">
            <label for="tbl_depBureau" class="bmd-label-floating">Nouveau type de dépense</label>
            <asp:TextBox ID="tbx_depBureau" runat="server"  CssClass="form-control"></asp:TextBox>
        </div>

        <div class="form-group">
            <asp:Button CssClass="btn btn-raised btn-success fullwidth alignementBouton" ID="btn_depBureau" runat="server" Text="Ajouter" OnClick="btn_depBureau_Click"/>                    
        </div>
        
        <div class="form-group spantwo">
            <asp:ListBox ID="lbx_depBureau" runat="server" CssClass="form-control" OnSelectedIndexChanged="lbx_depBureau_SelectedIndexChanged" AutoPostBack="true"></asp:ListBox>     
        </div>

        <div class="form-group spantwo">
            <asp:Button ID="btn_deleteDepBureau" runat="server" CssClass="btn btn-raised btn-danger fullwidth" Text="Supprimer le type de dépense sélectionnée (Bureau)" OnClick="btn_deleteDepBureau_Click"/>
        </div>

        <div class="form-group spantwo">
            <hr style="width:100%; border:2px solid black;"/>
        </div>
        
        <%--Type dépense Terrain--%>
        <h5 runat="server" class="spantwo">Type de dépense pour les employés de Terrain</h5>
        <div class="form-group">
            <label for="tbl_depTerrain" class="bmd-label-floating">Nouveau type de dépense</label>
            <asp:TextBox ID="tbx_depTerrain" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="form-group">
            <asp:Button CssClass="btn btn-raised btn-success fullwidth alignementBouton" ID="btn_depTerrain" runat="server" Text="Ajouter" OnClick="btn_depTerrain_Click"/>
        </div>

        <div class="form-group spantwo">
            <asp:ListBox ID="lbx_depTerrain" runat="server" CssClass="form-control" OnSelectedIndexChanged="lbx_depTerrain_SelectedIndexChanged" AutoPostBack="true"></asp:ListBox>     
        </div>

        <div class="form-group spantwo">
            <asp:Button ID="btn_deleteDepTerrain" runat="server" CssClass="btn btn-raised btn-danger fullwidth" Text="Supprimer le type de dépense sélectionnée (Terrain)" OnClick="btn_deleteDepTerrain_Click"/>
        </div>

        <div class="form-group spantwo">
            <hr style="width:100%; border:2px solid black;"/>
        </div>

        <%-- Date du prmier Dimanche --%>
        <h5 class="spantwo">Date du premier dimanche de l'année</h5>
        <div class="form-group spantwo">
            <label for="tbl_taux" class="">Premier dimanche de l'année</label>
            <input type="date" id="tbx_firstDimanche" class="form-control" runat="server" />
        </div>

        <div class="form-group spantwo">
            <hr style="width:100%; border:2px solid black;"/>
        </div>     

        <%-- Mot de passe admin --%>
        <h5>Mot de passe du compte Administrateur</h5>
        <div class="form-group spantwo">
            <label for="tbl_taux" class="bmd-label-floating">Nouveau mot de passe</label>
            <input type="password" id="tbx_adminMdp" class="form-control" runat="server" value="123456"/>
        </div>
        
        <div class="form-group spantwo">
            <hr style="width:100%; border:2px solid black;"/>
        </div>

        <%-- Configuration des rappels --%>
        <h5 class="spantwo">Configuration des rappels</h5>
        <div class="form-group">
            <%-- Jour de rappel --%>
            <label for="cb_jourRappel" class="bmd-label-floating">Jour du rappel</label>
            <select id="cb_jourRappel" class="form-control" runat="server">
                <option>Lundi</option>
                <option>Mardi</option>
                <option>Mercredi</option>
                <option>Jeudi</option>
                <option>Vendredi</option>
                <option>Samedi</option>
                <option>Dimanche</option>
            </select>
        </div>

        <div class="form-group">
             <%-- Heure de rappel --%>
            <label for="tbx_heureRappel" class="bmd-label-floating">Heure de rappel</label>
            <input type="time" id="tbx_heureRappel" class="form-control" runat="server"/>
        </div>

        <div class="form-group spantwo">
            <%-- Objet du courriel --%>
            <label for="tbx_objet" class="bmd-label-floating">Objet du courriel</label>
            <input type="text" id="tbx_objet" class="form-control" runat="server"/>
        </div>

        <div class="form-group spantwo">
            <%-- Contenu du courriel --%>
            <label for="ta_contenu" class="bmd-label-floating">Contenu du courriel</label>
            <textarea id="ta_contenu" class="form-control" runat="server"></textarea>
        </div>

        <div class="form-group">
            <%-- Rappel actif bureau --%>
            <div class="checkbox">
                <label>
                    <input runat="server" id="ckb_rappelBureau" type="checkbox">Rappel Bureau Actif
                </label>
            </div>
        </div>

        <div class="form-group">
            <%-- Rappel actif bureau --%>
            <div class="checkbox">
                <label>
                    <input runat="server" id="ckb_rappelTerrain" type="checkbox">Rappel Terrain Actif
                </label>
            </div>
        </div>

        <div class="form-group spantwo">
            <hr style="width:100%; border:2px solid black;"/>
        </div>

        <h5 class="spantwo">Configurations avancées</h5>

        <div class="form-group">
            <%-- email --%>
            <label for="ta_contenu" class="bmd-label-floating">Email de rappel</label>
            <input type="email" id="tbx_email" class="form-control" runat="server"/>
        </div>

        <div class="form-group">
            <%-- mot de passe --%>
            <label for="tbx_mdpEmail" class="bmd-label-floating">Changer mot de passe du email</label>
            <input type="password" id="tbx_mdpEmail" class="form-control" runat="server"/>
        </div>

        <div class="form-group">
            <%-- Serveur SMTP --%>
            <label for="tbx_smtp" class="bmd-label-floating">Serveur SMTP</label>
            <input type="text" id="tbx_smtp" class="form-control" runat="server"/>
        </div>
        
        <div class="form-group">
            <label for="tbx_port" class="bmd-label-floating">Port SMTP</label>
            <input type="number" id="tbx_port" class="form-control" runat="server"/>
        </div>

        <div class="form-group spantwo">
            <div class="checkbox">
                <label>
                    <input runat="server" id="chk_ssl" type="checkbox">SMTP SSL
                </label>
            </div>
        </div>

        <div class="form-group spantwo">
            <hr style="width:100%; border:2px solid black;"/>
        </div>

        
        <%--BOUTON--%>
        <asp:button cssclass="btn btn-raised btn-success" id="btn_envoyer" runat="server" text="Confirmer les modifications" OnClick="btn_envoyer_Click"/>
        <asp:button cssclass="btn btn-raised btn-danger" id="btn_annuler" runat="server" text="Annuler les modifications" OnClick="btn_annuler_Click"/>

    </form>
</asp:Content>
