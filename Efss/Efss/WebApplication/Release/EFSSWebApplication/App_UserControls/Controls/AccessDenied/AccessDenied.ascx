<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AccessDenied.ascx.cs" Inherits="APP.App_UserControls.Controls.AccessDenied.AccessDenied" %>
<div class="divAccessDenied">
<div style ="float :left ; margin-right :20px;">
<asp:Image ID="ImageAccessDenied" runat="server" ImageUrl="~/App_Images/exclamation.jpg" AlternateText ="Access Denied" />
</div>
<div  style ="float :left ; margin-top :20px;" >
<asp:Label ID="LabelAccessDenied"  runat ="server" Text ="Access Denied." Font-Bold ="true" Font-Size ="Large"  ></asp:Label>
</div>
</div>