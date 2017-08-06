<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SettingsFormSettings.ascx.cs" Inherits="APP.App_UserControls.Settings.Forms.FormSettings.SettingsFormSettings" %>
<asp:UpdatePanel runat="server" ID="UpdatePanelSettings" UpdateMode="Conditional"
    ChildrenAsTriggers="false">
    <ContentTemplate>
        <uc:UCNavigationPanel runat="server" ID="NavigationPanelSettings" OnNavigationMenuClick="NavigationMenuClick" />
        <asp:MultiView runat="server" ID="MultiViewSettings" ActiveViewIndex="0">
            <asp:View runat="server" ID="EditCurrencies">
                <asp:UpdatePanel runat="server" ID="UpdatePanelCurrencies" UpdateMode="Conditional"
                    ChildrenAsTriggers="false">
                    <ContentTemplate>
                        <table width="100%">
                            <tr>
                                <td align="left">
                                    <asp:Label runat="server" ID="LabelCurrenciesTitle" Text="Currencies" CssClass="LabelForm"
                                        Font-Underline="true"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" class="tableFilterHeader">
                                    <table>
                                        <tr>
                                            <td>
                                                <uc:UCButtonCommand runat="server" ID="ButtonCommandSaveCurrency" CausesValidation="true"
                                                    ButtonCommandName="SaveCurrency" ButtonImageUrl="~/App_Images/SaveHS.png" OnCommand="OnCommand"
                                                    ButtonText="Save" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" class="contentboxheader">
                                    <asp:Label runat="server" ID="LabelCurrencyDetails" Text="Edit Currency Details"
                                        CssClass="LabelForm2"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" class="contentboxForm">
                                    <table>
                                        <tr>
                                            <td align="left" style="width: 120px;">
                                                Code
                                            </td>
                                            <td align="left">
                                                <asp:DropDownList runat="server" ID="DropDownListCurrency" CssClass="dropdownForm"
                                                    AutoPostBack="True" OnSelectedIndexChanged="DropDownListCurrency_SelectedIndexChanged"
                                                    Width="100px">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" style="width: 120px;">
                                                Name
                                            </td>
                                            <td align="left">
                                                <asp:TextBox runat="server" ID="TextBoxCurrencyName" Enabled="false" CssClass="TextBoxForm"
                                                    Width="100px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" style="width: 120px;">
                                                Rate
                                            </td>
                                            <td align="left">
                                                <asp:TextBox runat="server" ID="TextBoxRates" CssClass="TextBoxForm" Width="100px"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </asp:View>
            <asp:View runat="server" ID="EditDocuments">
                <asp:UpdatePanel runat="server" ID="UpdatePanelDocumentTypes" UpdateMode="Conditional"
                    ChildrenAsTriggers="false">
                    <ContentTemplate>
                        <table width="100%">
                            <tr>
                                <td align="left">
                                    <asp:Label runat="server" ID="LabelDocumentshedaer" Text="Documents" CssClass="LabelForm"
                                        Font-Underline="true"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" class="tableFilterHeader">
                                    <table>
                                        <tr>
                                            <td>
                                                <uc:UCButtonCommand runat="server" ID="ButtonCommandSaveDocument" CausesValidation="true"
                                                    ButtonCommandName="SaveDocument" ButtonImageUrl="~/App_Images/SaveHS.png" OnCommand="OnCommand"
                                                    ButtonText="Save" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" class="contentboxheader">
                                    <asp:Label runat="server" ID="LabelDocumentEdit" Text="Edit Document Details" CssClass="LabelForm2"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" class="contentboxForm">
                                    <table>
                                        <tr>
                                            <td align="left" style="width: 120px;">
                                                Document type
                                            </td>
                                            <td align="left">
                                                <asp:DropDownList runat="server" ID="DropDownListDocumentSubType" CssClass="dropdownForm"
                                                    AutoPostBack="True" OnSelectedIndexChanged="DropDownListDocumentSubType_SelectedIndexChanged"
                                                    Width="200px">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" style="width: 120px;">
                                                Prime Account
                                            </td>
                                            <td align="left">
                                                <asp:TextBox runat="server" ID="TextBoxPrimeAccountUpdate" CssClass="TextBoxForm"
                                                    Width="200px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" style="width: 120px;">
                                                Sub Account
                                            </td>
                                            <td align="left">
                                                <asp:TextBox runat="server" ID="TextBoxSubAccountUpdate" CssClass="TextBoxForm" Width="200px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" style="width: 120px;">
                                                Cost Center
                                            </td>
                                            <td align="left">
                                                <asp:TextBox runat="server" ID="TextBoxCostCenterUpdate" CssClass="TextBoxForm" Width="200px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" style="width: 120px;">
                                                Activity
                                            </td>
                                            <td align="left">
                                                <asp:TextBox runat="server" ID="TextBoxActivityUpdate" CssClass="TextBoxForm" Width="200px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" style="width: 120px;">
                                                Division
                                            </td>
                                            <td align="left">
                                                <asp:TextBox runat="server" ID="TextBoxDivisionUpdate" CssClass="TextBoxForm" Width="200px"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </asp:View>
            <asp:View runat="server" ID="InsertDocuments">
                <table width="100%">
                    <tr>
                        <td align="left">
                            <asp:Label runat="server" ID="LabelDocumentsHeaderInsert" Text="Documents" CssClass="LabelForm"
                                Font-Underline="true"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="tableFilterHeader">
                            <table>
                                <tr>
                                    <td>
                                        <uc:UCButtonCommand runat="server" ID="ButtonCommandInsert" CausesValidation="false"
                                            ButtonCommandName="InsertDocument" ButtonImageUrl="~/App_Images/Command-Insert.png"
                                            OnCommand="OnCommand" ButtonText="Insert" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="contentboxheader">
                             <asp:Label runat="server" ID="Label1" Text="Add New Document" CssClass="LabelForm2"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="contentboxForm">
                            <table>
                                <tr>
                                    <td align="left" style="width: 120px;">
                                        Document type
                                    </td>
                                    <td align="left">
                                        <asp:TextBox runat="server" ID="TextBoxDocuemntTypeAdd" CssClass="TextBoxForm" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" style="width: 120px;">
                                        Prime Account
                                    </td>
                                    <td align="left">
                                        <asp:TextBox runat="server" ID="TextBoxPrimeAccountAdd" CssClass="TextBoxForm" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" style="width: 120px;">
                                        Sub Account
                                    </td>
                                    <td align="left">
                                        <asp:TextBox runat="server" ID="TextBoxSubAccountAdd" CssClass="TextBoxForm" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" style="width: 120px;">
                                        Cost Center
                                    </td>
                                    <td align="left">
                                        <asp:TextBox runat="server" ID="TextBoxCostCenterAdd" CssClass="TextBoxForm" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" style="width: 120px;">
                                        Activity
                                    </td>
                                    <td align="left">
                                        <asp:TextBox runat="server" ID="TextBoxActivityAdd" CssClass="TextBoxForm" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" style="width: 120px;">
                                        Division
                                    </td>
                                    <td align="left">
                                        <asp:TextBox runat="server" ID="TextBoxDivisionAdd" CssClass="TextBoxForm" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </asp:View>
        </asp:MultiView>
    </ContentTemplate>
</asp:UpdatePanel>

                


               
 