<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="Employe.aspx.cs" Inherits="UrbanEco.Employe" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
    <form runat="server" id="form1">
        <asp:GridView ID="GridView1" runat="server"></asp:GridView>
        <asp:GridView ID="GridView2" runat="server"></asp:GridView>
        <asp:GridView ID="GridView3" runat="server"></asp:GridView>
    </form>
    
    
</asp:Content>
