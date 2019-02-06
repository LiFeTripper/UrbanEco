<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="ParametreAdmin.aspx.cs" Inherits="UrbanEco.ParametreAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
        <div class="form-group mb-4 col-6 mx-auto" style="text-align:center;">
            <h3>Paramètres Administrateur</h3>
        </div>        
        <div class="form-group mb-4 col-6 mx-auto">
            <label for="tbl_taux" style="font-size:20px;">Taux de kilométrage</label>
            <asp:table runat="server" id="tbl_taux" style="width: 100%">
                <%--Voiture--%>
                <asp:TableRow>    
                    <asp:TableHeaderCell CssClass="form-control btn-info">Voiture</asp:TableHeaderCell>
                    <asp:TableCell>
                        <asp:TextBox CssClass="form-control" runat="server" ID="tbx_voiture"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableHeaderCell CssClass="form-control">$/KM</asp:TableHeaderCell>
                </asp:TableRow>
                <%--Camion--%>
                <asp:TableRow>
                    <asp:TableHeaderCell CssClass="form-control btn-info">Camion</asp:TableHeaderCell>
                    <asp:TableCell>
                        <asp:TextBox CssClass="form-control" runat="server" ID="tbx_camion" />
                    </asp:TableCell>
                    <asp:TableHeaderCell CssClass="form-control">$/KM</asp:TableHeaderCell>
                </asp:TableRow>
            </asp:table>
        </div>

        <div class="form-group mb-4 col-6 mx-auto">
            <hr style="width:100%; border:2px solid black;"/>
        </div>
        
        <div class="form-group mb-4 col-6 mx-auto alert alert-info">
            <strong>Note*</strong> Les modifications apportées aux types de dépense (en bleu) ne sont enregistrées qu'après avoir confirmé avec le bouton ci-dessous.
        </div>
         <%--Type dépense Bureau--%>
        <div class="form-group mb-4 col-6 mx-auto">
            <h5 runat="server">Type de dépense pour les employés de Bureau</h5>
            <label for="tbl_depBureau">Nouveau type de dépense</label>
            <asp:table runat="server" id="tbl_depBureau" style="width: 100%">
                <asp:TableRow>    
                    <asp:TableCell>
                        <asp:TextBox ID="tbx_depBureau" runat="server"  CssClass="form-control"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button CssClass="btn btn-md btn-success" ID="btn_depBureau" runat="server" Text="Ajouter" style="width:100%;" OnClick="btn_depBureau_Click"/>                    
                    </asp:TableCell>
                </asp:TableRow>
            </asp:table>

            <asp:ListBox ID="lbx_depBureau" runat="server" CssClass="form-control" OnSelectedIndexChanged="lbx_depBureau_SelectedIndexChanged" AutoPostBack="true"></asp:ListBox>     
        </div>

        <div class="form-group mb-4 col-6 mx-auto">
            <asp:Button ID="btn_deleteDepBureau" runat="server" style="width:100%;" CssClass="btn btn-md btn-danger" Text="Supprimer le type de dépense sélectionnée (Bureau)" OnClick="btn_deleteDepBureau_Click"/>
        </div>

        <div class="form-group mb-4 col-6 mx-auto">
            <hr style="width:100%; border:2px solid black;"/>
        </div>
        
        <%--Type dépense Terrain--%>
        <div class="form-group mb-4 col-6 mx-auto" style="margin-top:15px;">
            <h5 runat="server">Type de dépense pour les employés de Terrain</h5>
            <label for="tbl_depTerrain">Nouveau type de dépense</label>
            <asp:Table runat="server" ID="tbl_depTerrain" Style="width: 100%">
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:TextBox ID="tbx_depTerrain" runat="server" CssClass="form-control"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button CssClass="btn btn-md btn-success" ID="btn_depTerrain" runat="server" Text="Ajouter" style="width:100%;" OnClick="btn_depTerrain_Click"/>                    
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>

            <asp:ListBox ID="lbx_depTerrain" runat="server" CssClass="form-control" OnSelectedIndexChanged="lbx_depTerrain_SelectedIndexChanged" AutoPostBack="true"></asp:ListBox>     
        </div>

        <div class="form-group mb-4 col-6 mx-auto">
            <asp:Button ID="btn_deleteDepTerrain" runat="server" style="width:100%;" CssClass="btn btn-md btn-danger" Text="Supprimer le type de dépense sélectionnée (Terrain)" OnClick="btn_deleteDepTerrain_Click"/>
        </div>

        <div class="form-group mb-4 col-6 mx-auto">
            <hr style="width:100%; border:2px solid black;"/>
        </div>

        <div class="form-group mb-4 col-6 mx-auto">
            <label for="tbl_taux" style="font-size: 20px;">Date du premier dimanche de l'année</label>
            <asp:Table runat="server" ID="Table1" Style="width: 100%; table-layout:fixed;">
                <asp:TableRow>
                    <asp:TableHeaderCell CssClass="form-control">Premier dimanche de l'année</asp:TableHeaderCell>
                    <asp:TableCell>
                        <input type="date" id="tbx_firstDimanche" style="width:100%;" class="form-control" runat="server" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>

        <div class="form-group mb-4 col-6 mx-auto">
            <hr style="width:100%; border:2px solid black;"/>
        </div>     
        <%-- Mot de passe admin --%>
        <div class="form-group mb-4 col-6 mx-auto">
            <label for="tbl_taux" style="font-size: 20px;">Mot de passe du compte Administrateur</label>
            <asp:Table runat="server" ID="tbl_mdpAdmin" Style="width: 100%; table-layout:fixed;">
                <asp:TableRow>
                    <asp:TableHeaderCell CssClass="form-control">Nouveau mot de passe</asp:TableHeaderCell>
                    <asp:TableCell>
                        <input type="password" id="tbx_adminMdp" style="width:100%;" class="form-control" runat="server" value="123456"/>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>
        
        <div class="form-group mb-4 col-6 mx-auto">
            <hr style="width:100%; border:2px solid black;"/>
        </div>
        <%-- Configuration des rappels --%>
        <div class="form-group mb-4 col-6 mx-auto">
            <label for="Table2" style="font-size: 20px;">Configuration des rappels</label>
            <asp:Table runat="server" ID="Table2" Style="width: 100%; table-layout:fixed;">
                <asp:TableRow>
                    <%-- Jour de rappel --%>
                    <asp:TableHeaderCell CssClass="form-control">Jour du rappel</asp:TableHeaderCell>
                    <asp:TableCell>
                        <select id="cb_jourRappel" style="width:100%;" class="form-control" runat="server">
                            <option>Lundi</option>
                            <option>Mardi</option>
                            <option>Mercredi</option>
                            <option>Jeudi</option>
                            <option>Vendredi</option>
                            <option>Samedi</option>
                            <option>Dimanche</option>
                        </select>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <%-- Heure de rappel --%>
                    <asp:TableHeaderCell CssClass="form-control">Heure de rappel</asp:TableHeaderCell>
                    <asp:TableCell>
                        <input type="time" id="tbx_heureRappel" style="width:100%;" class="form-control" runat="server"/>
                    </asp:TableCell>
                </asp:TableRow>

                <asp:TableRow>
                    <%-- Objet du courriel --%>
                    <asp:TableHeaderCell CssClass="form-control">Objet du courriel</asp:TableHeaderCell>
                    <asp:TableCell>
                        <input type="text" id="tbx_objet" style="width:100%;" class="form-control" runat="server"/>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <%-- Contenu du courriel --%>
                    <asp:TableHeaderCell CssClass="form-control">Contenu du courriel</asp:TableHeaderCell>
                    <asp:TableCell>
                        <textarea id="ta_contenu" style="width:100%;" class="form-control" runat="server"></textarea>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <%-- Rappel actif bureau --%>
                    <asp:TableHeaderCell CssClass="form-control">Rappel Bureau Actif</asp:TableHeaderCell>
                    <asp:TableCell>
                        <input type="checkbox" id="ckb_rappelBureau" style="width:100%;" class="form-control" runat="server"/>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <%-- Rappel actif terrain --%>
                    <asp:TableHeaderCell CssClass="form-control">Rappel Terrain Actif</asp:TableHeaderCell>
                    <asp:TableCell>
                        <input type="checkbox" id="ckb_rappelTerrain" style="width:100%;" class="form-control" runat="server"/>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>

            <label for="Table3" style="font-size: 20px;">Configurations avancées</label>
            <asp:Table runat="server" ID="Table3" Style="width: 100%; table-layout:fixed;">
                <asp:TableRow>
                    <%-- email --%>
                    <asp:TableHeaderCell CssClass="form-control">Email de rappel</asp:TableHeaderCell>
                    <asp:TableCell>
                        <input type="email" id="tbx_email" style="width:100%;" class="form-control" runat="server"/>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <%-- mot de passe --%>
                    <asp:TableHeaderCell CssClass="form-control">Changer mot de passe du email</asp:TableHeaderCell>
                    <asp:TableCell>
                        <input type="password" id="tbx_mdpEmail" style="width:100%;" class="form-control" runat="server"/>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <%-- Serveur SMTP --%>
                    <asp:TableHeaderCell CssClass="form-control">Serveur SMTP</asp:TableHeaderCell>
                    <asp:TableCell>
                        <input type="text" id="tbx_smtp" style="width:100%;" class="form-control" runat="server"/>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <%-- Port SMTP --%>
                    <asp:TableHeaderCell CssClass="form-control">Port SMTP</asp:TableHeaderCell>
                    <asp:TableCell>
                        <input type="number" id="tbx_port" style="width:100%;" class="form-control" runat="server"/>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <%-- SMTP SSL --%>
                    <asp:TableHeaderCell CssClass="form-control">SMTP SSL</asp:TableHeaderCell>
                    <asp:TableCell>
                        <input type="checkbox" id="chk_ssl" style="width:100%;" class="form-control" runat="server"/>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>

        <div class="form-group mb-4 col-6 mx-auto">
            <hr style="width:100%; border:2px solid black;"/>
        </div>

        
        <%--BOUTON--%>
        <div class="form-group mb-4 col-6 mx-auto">
            <asp:button style="width: 40% !important; float: left;" cssclass="btn btn-lg btn-danger input-box" id="btn_annuler" runat="server" text="Annuler les modifications" OnClick="btn_annuler_Click"/>
            <asp:button style="width: 40% !important; float: right;" cssclass="btn btn-lg btn-success input-box" id="btn_envoyer" runat="server" text="Confirmer les modifications" OnClick="btn_envoyer_Click"/>
        </div>
    </form>
</asp:Content>
