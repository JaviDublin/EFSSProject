<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SettingsFormEmail.ascx.cs" Inherits="APP.App_UserControls.Settings.Forms.FormEmail.SettingsFormEmail" %>
<%-- Control Wrapper --%>
<div class="div-Application-Content">
    <asp:UpdatePanel runat="server" ID="UpdatePanelEmails" UpdateMode="Conditional" ChildrenAsTriggers="false">
        <ContentTemplate>
            <table width="100%">
                <tr>
                    <td align="left">
                        <asp:Label runat="server" ID="LabelEmailSettingsTitle" Text="Email Settings" CssClass="LabelForm"
                            Font-Underline="true"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="left" class="tableFilterHeader">
                        <table>
                            <tr>
                                <td>
                                    <uc:UCButtonCommand runat="server" ID="ButtonCommandSaveEmail" CausesValidation="true"
                                        ButtonCommandName="SaveEmail" ButtonImageUrl="~/App_Images/SaveHS.png" OnCommand="OnCommand"
                                        ButtonText="Save" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td align="left" class="contentboxheader">
                        <asp:Label runat="server" ID="LabelHeaderDetails" Text="Details" CssClass="LabelForm2"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="left" class="contentboxForm">
                        <table>
                            <tr>
                                <td align="left" style="width:120px;">
                                    Email Address
                                </td>
                                <td align="left">
                                    <asp:DropDownList runat="server" ID="DropDownListEmails" AutoPostBack="True" CssClass="dropdownForm"
                                        OnSelectedIndexChanged="DropDownListEmails_SelectedIndexChanged" Width="400px">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="width:120px;">
                                    Subject
                                </td>
                                <td align="left">
                                    <asp:TextBox runat="server" ID="TextBoxSubject" CssClass="TextBoxForm" Width="400px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="width:120px;">
                                    Message header
                                </td>
                                <td align="left">
                                    <asp:TextBox runat="server" ID="TextBoxHeader" CssClass="TextBoxForm" Width="400px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" valign="top" style="width:120px;">
                                    Body
                                </td>
                                <td align="left">
                                    <asp:TextBox runat="server" ID="TextBoxBody" CssClass="TextBoxForm" TextMode="MultiLine"
                                        Wrap="true" Width="400px" Height="150px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="width:120px;">
                                    Footer
                                </td>
                                <td align="left">
                                    <asp:TextBox runat="server" ID="TextBoxFooter" CssClass="TextBoxForm" Width="400px"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>

               
