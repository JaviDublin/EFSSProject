<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SettingsFormCompanies.ascx.cs" Inherits="APP.App_UserControls.Settings.Forms.FormCompanies.SettingsFormCompanies" %>
<asp:UpdatePanel runat="server" ID="UpdatePanelForm" UpdateMode="Conditional" ChildrenAsTriggers="false">
    <ContentTemplate>
        <table width="100%">
            <tr>
                <td align="left">
                    <asp:Label runat="server" ID="LabelCompaniesDetailsTitle" Text="Companies Details"
                        CssClass="LabelForm" Font-Underline="true"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" class="tableFilterHeader">
                    <table>
                        <tr>
                            <td>
                                <uc:UCButtonCommand runat="server" ID="ButtonCommandSave" CausesValidation="true"
                                    ButtonCommandName="Save" ButtonText="Save" ButtonImageUrl="~/App_Images/SaveHS.png"
                                    OnCommand="OnCommand" />
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
                                Company Name
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxCompanyName" Enabled="false" CssClass="TextBoxForm"
                                    Width="250px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width:120px;">
                                Country
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxCountryName" Enabled="false" CssClass="TextBoxForm"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width:120px;">
                                Company code
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxCompanyCode" Enabled="false" CssClass="TextBoxForm"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width:120px;">
                                Type
                            </td>
                            <td align="left" style="width:120px;">
                                <asp:TextBox runat="server" ID="TextBoxCompanyType" Enabled="false" CssClass="TextBoxForm"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width:120px;">
                                Country Tax Code
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxCompanyFiscalCode" CssClass="TextBoxForm"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width:120px;">
                                Country Vat Rate
                            </td>
                            <td align="left">
                                <cc:NumericTextBox runat="server" ID="TextBoxCountryVatRate" CssClass="TextBoxForm"></cc:NumericTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width:120px;">
                                Region
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxCompanyRegion" Enabled="false" CssClass="TextBoxForm"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width:120px;">
                                Local Currency
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxCompanyCurrency" Enabled="false" CssClass="TextBoxForm"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width:120px;">
                                Currency Rate
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxRate" Enabled="false" CssClass="TextBoxForm"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width:120px;">
                                Oracle Code
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxOracleCode" Enabled="false" CssClass="TextBoxForm"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width:120px;">
                                Group
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxGroup" Enabled="false" CssClass="TextBoxForm"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </ContentTemplate>
</asp:UpdatePanel>
