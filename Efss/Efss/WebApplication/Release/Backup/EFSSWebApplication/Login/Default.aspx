<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="APP.Login.Default" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <!--[if lte IE 7]><style type ="text/css">.rad__div-Login-Row-Right-DropDown{height: 35px; margin-left:20px; padding-left: 20px; margin-top: 20px; margin-right: 20px; margin-bottom: 20px;}</style><![endif]-->
</asp:Content>
<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolderContent" runat="server">
    <rad:Panel ID="PanelLogin" runat="server" CssClass="panel-Login">
        <rad:Login ID="Login" runat="server"  OnLoggedInCommand="OnLoggedIn_Command" LoginApplicationLogoUrl="~/App_Images/EFSSLogo.png" />
    </rad:Panel>
</asp:Content>
