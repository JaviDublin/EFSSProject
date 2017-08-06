<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ButtonCommand.ascx.cs" Inherits="Insight.App_UserControls.Controls.Commands.ButtonCommand" %>
<div class="div-ButtonCommand">
    <cc:LinkButtonExcludeProgress ID="LinkButtonCommand" runat="server" CommandName="Save" OnCommand="LinkButtonCommand_Command" CssClass="linkButton-Command">
    </cc:LinkButtonExcludeProgress>
</div>