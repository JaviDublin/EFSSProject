<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SettingsFormBuyers.ascx.cs" Inherits="APP.App_UserControls.Settings.Forms.FormBuyers.SettingsFormBuyers" %>
<asp:UpdatePanel runat="server" ID="UpdatePanelForm" UpdateMode="Conditional" ChildrenAsTriggers="false">
    <ContentTemplate>
        <table width="100%">
            <tr>
                <td align="left">
                    <asp:Label runat="server" ID="LabelBuyerDetailsTitle" Text="Buyer Details" CssClass="LabelForm"
                        Font-Underline="true"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" class="tableFilterHeader">
                    <table>
                        <tr>
                            <td>
                                <uc:UCButtonCommand runat="server" ID="ButtonCommandSave" CausesValidation="true"
                                    ButtonCommandName="Save" ButtonImageUrl="~/App_Images/SaveHS.png" OnCommand="OnCommand"
                                    ButtonText="Save" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="left" class="contentboxheader">
                    <asp:Label runat="server" ID="LabelHeaderGeneral" Text="General" CssClass="LabelForm2"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" class="contentboxForm">
                    <table>
                        <tr>
                            <td align="left" style="width:120px;">
                                Name
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxBuyerName" Enabled="false" CssClass="TextBoxForm"
                                    Width="200px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width:120px;">
                                Country
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxCountry" Enabled="false" CssClass="TextBoxForm"
                                    Width="200px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width:120px;">
                                Code
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxVendorCode" Enabled="false" CssClass="TextBoxForm"
                                    Width="200px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width:120px;">
                                Hertz ID
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxId" Enabled="false" CssClass="TextBoxForm"
                                    Width="200px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width:120px;">
                                Buyer Type
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="DropDownListBuyerType" CssClass="dropdownForm"
                                    Width="200px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width:120px;">
                                Tax Code
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxTaxCode" Enabled="false" CssClass="TextBoxForm"
                                    Width="200px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width:120px;">
                                Fiscal Code
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxFiscalCode" Enabled="false" CssClass="TextBoxForm"
                                    Width="200px"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="left" class="contentboxheader">
                    <asp:Label runat="server" ID="LabelHeaderAddress" Text="Address" CssClass="LabelForm2"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" class="contentboxForm">
                    <table>
                        <tr>
                            <td align="left" style="width:120px;">
                                Address 1
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxAddr1" Enabled="false" CssClass="TextBoxForm"
                                    Width="300px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width:120px;">
                                Address 2
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxAddr2" Enabled="false" CssClass="TextBoxForm"
                                    Width="300px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                Address 3
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxAddr3" Enabled="false" CssClass="TextBoxForm"
                                    Width="300px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width:120px;">
                                Address 4
                            </td>
                            <td align="left" style="width:120px;">
                                <asp:TextBox runat="server" ID="TextBoxAddr4" Enabled="false" CssClass="TextBoxForm"
                                    Width="300px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width:120px;">
                                Address 5
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxAddr5" Enabled="false" CssClass="TextBoxForm"
                                    Width="300px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width:120px;">
                                Address 6
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxAddr6" Enabled="false" CssClass="TextBoxForm"
                                    Width="300px"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="left" class="contentboxheader">
                    <asp:Label runat="server" ID="LabelHeaderContact" Text="Contact" CssClass="LabelForm2"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" class="contentboxForm">
                    <table>
                        <tr>
                            <td align="left" style="width:120px;">
                                Contact Type
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="DropDownListContactType" CssClass="dropdownForm"
                                    AutoPostBack="True" OnSelectedIndexChanged="DropDownListContactType_SelectedIndexChanged"
                                    Width="200px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width:120px;">
                                Contact Name
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxContactName" CssClass="TextBoxForm" Width="200px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width:120px;">
                                Email
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxContactEmail" CssClass="TextBoxForm" Width="200px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width:120px;">
                                Phone
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxContactPhone" CssClass="TextBoxForm" Width="200px"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        </td> </tr> </table>
    </ContentTemplate>
</asp:UpdatePanel>
