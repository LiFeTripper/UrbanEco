<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="GestionDepense.aspx.cs" Inherits="UrbanEco.ApprobationDepense" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
           .center {
                margin: auto;
                width: 50%;
            }

           .input-box{
               width: 100% !important; 
               font-size: 17px; 
               margin-bottom: 30px;
           }

           .input-title {
                text-align:left !important;
           }

           .table-custom{

                width:800px !important;
            
           }

           .table-custom > table{
               width:100% !important;
           }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
    <form runat="server" style="text-align: center;" class="container center col-12">
        <div>
            <h1>Gestion des dépenses
            </h1>
            <hr style="border: 20px solid #23282e; width: 100% !important; margin: 0px 0px 0px 0px; padding: 0px 0px 0px 0px" />
        </div>
        


    </form>

</asp:Content>
