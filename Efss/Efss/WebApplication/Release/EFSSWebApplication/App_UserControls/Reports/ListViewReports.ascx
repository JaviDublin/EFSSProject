<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ListViewReports.ascx.cs" Inherits="APP.App_UserControls.Reports.ListViewReports" %>
<%-- Control Wrapper --%>
<div class="div-Application-Content">
    <asp:UpdatePanel runat="server" ID="UpdatePanelDash" UpdateMode="Conditional" ChildrenAsTriggers="false">
        <ContentTemplate>
            <table width="100%">
                <tr>
                    <td align="left">
                        <asp:Label runat="server" ID="LabelDashboardReportTitle" Text="Dashboard Report"
                            CssClass="LabelForm" Font-Underline="true"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="left" class="tableFilterHeader">
                        <table>
                            <tr>
                                <td>
                                    <uc:UCButtonCommand runat="server" ID="ButtonCommandRun" CausesValidation="true"
                                        ButtonToolTip="Run Report" ButtonCommandName="Run" ButtonImageUrl="~/App_Images/page_excel.png"
                                        OnCommand="OnCommand" ButtonText="Export To Excel" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td align="left" class="contentboxheader">
                        <asp:Label runat="server" ID="LabelHeaderFilters" Text="Filters" CssClass="LabelForm2"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="left" class="contentboxForm">
                        <table>
                            <tr>
                                <td align="left">
                                    Country
                                </td>
                                <td align="left">
                                    <asp:DropDownList runat="server" ID="DropDownListCountries" CssClass="dropdownForm"
                                        AutoPostBack="True" OnSelectedIndexChanged="DropDownListCountries_SelectedIndexChanged"
                                        Width="250px">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    Company
                                </td>
                                <td align="left">
                                    <asp:DropDownList runat="server" ID="DropDownListCompanies" CssClass="dropdownForm"
                                        AutoPostBack="True" OnSelectedIndexChanged="DropDownListCompanies_SelectedIndexChanged"
                                        AppendDataBoundItems="true" Width="250px">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    Manufacturer
                                </td>
                                <td align="left">
                                    <asp:DropDownList runat="server" ID="DropDownListManufacturer" CssClass="dropdownForm"
                                        AppendDataBoundItems="true" AutoPostBack="True" OnSelectedIndexChanged="DropDownListManufacturer_SelectedIndexChanged"
                                        Font-Size="10px">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    Vendor
                                </td>
                                <td align="left">
                                    <asp:DropDownList runat="server" ID="DropDownListVendors" CssClass="dropdownForm"
                                        Width="300px" AppendDataBoundItems="true">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td align="left" class="contentboxheader">
                        <asp:Label runat="server" ID="LabelHeaderOptions" Text="Options" CssClass="LabelForm2"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="left" class="contentboxForm">
                        <table>
                            <tr>
                                <td>
                                    <asp:CheckBox runat="server" ID="CheckBoxBuyBack" />
                                </td>
                                <td>
                                    BuyBack
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:CheckBox runat="server" ID="CheckBoxNonReturn" />
                                </td>
                                <td>
                                    Non Return Bouns
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:CheckBox runat="server" ID="CheckBoxVolumeBonus" />
                                </td>
                                <td>
                                    Volume Bonus
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:CheckBox runat="server" ID="CheckBoxOpen" />
                                </td>
                                <td>
                                    Open
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:CheckBox runat="server" ID="CheckBoxMatched" />
                                </td>
                                <td>
                                    Matched Variance
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:CheckBox runat="server" ID="CheckBoxUnapplied" />
                                </td>
                                <td>
                                    Unapplied
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="ButtonCommandRun" />
        </Triggers>
    </asp:UpdatePanel>
</div>





