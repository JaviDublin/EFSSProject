<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TransactionsYear.ascx.cs"
    Inherits="APP.App_UserControls.Fleet.TransactionsYear" %>
<%-- Control Wrapper --%>
<div class="div-Application-Content">
    <asp:UpdatePanel ID="UpdatePanelFleetYear" runat="server" ChildrenAsTriggers="false"
        UpdateMode="Conditional">
        <ContentTemplate>
            <uc:UCNavigationPanel runat="server" ID="NavigationPanelYearTransactions" OnNavigationMenuClick="NavigationMenuClick" />
            <asp:MultiView runat="server" ID="MultiViewYearTransactions" ActiveViewIndex="0">
                <asp:View runat="server" ID="Country">
                    <table width="100%">
                        <tr>
                            <td align="left">
                                <asp:Label runat="server" ID="LabelTransactionsYearTitle" Text="Year Transactions By Country"
                                    CssClass="LabelForm" Font-Underline="true"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="tableFilterHeader">
                                <table>
                                    <tr>
                                        <td>
                                            <uc:UCButtonCommand runat="server" ID="ButtonCommandExport" CausesValidation="false"
                                                ButtonCommandName="Export" ButtonImageUrl="~/App_Images/page_excel.png" OnCommand="OnCommand"
                                                ButtonText="Export To Excel" />
                                        </td>
                                        <td>
                                            <uc:UCButtonCommand runat="server" ID="ButtonCommandFilter" CausesValidation="true"
                                                ButtonCommandName="Filter" ButtonText="Filter" ButtonImageUrl="~/App_Images/accept.png"
                                                OnCommand="OnCommand" />
                                        </td>
                                        <td>
                                            <asp:Image runat="server" ID="ImageSeparator" ImageUrl="~/App_Styles/Images/menu-bg.jpg" />
                                        </td>
                                        <td align="left">
                                            Year
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList runat="server" ID="DropDownListYears" CssClass="dropdownForm" Width="80px"
                                                DataSourceID="sdsYearReport" DataTextField="DateYear" DataValueField="DateYear"
                                                Font-Bold="True" Font-Size="11px">
                                            </asp:DropDownList>
                                            <asp:SqlDataSource runat="server" ID="sdsYearReport" ConnectionString="<%$ ConnectionStrings:RAD.Properties.Settings.ApplicationDataBase %>"
                                                SelectCommand="select DateYear from 
[Import.ActiveFleetYearADReport] 
group by DateYear 
order by DateYear desc"></asp:SqlDataSource>
                                        </td>
                                        <td align="left">
                                            File
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList runat="server" ID="DropDownListFile" CssClass="dropdownForm" DataSourceID="sdsFiles"
                                                DataTextField="Notes" DataValueField="FileId" Width="250px" Font-Bold="True"
                                                Font-Size="11px">
                                            </asp:DropDownList>
                                            <asp:SqlDataSource runat="server" ID="sdsFiles" ConnectionString="<%$ ConnectionStrings:RAD.Properties.Settings.ApplicationDataBase %>"
                                                SelectCommand="select FileId , Notes from [Application.Files] where FileCode in ('FYTDA','FYTDD')">
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="contentboxheader">
                                <asp:Label runat="server" ID="Label3" Text="Year Transactions Information" CssClass="LabelForm2"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="contentboxForm">
                                <uc:ListViewYear runat="server" ID="ListViewYearOverView" Visible="true" OnSearchByManufacturer="SearchByManufacturer" />
                            </td>
                        </tr>
                    </table>
                </asp:View>
                <asp:View runat="server" ID="Manufacturer">
                    <table width="100%">
                        <tr>
                            <td align="left">
                                <asp:Label runat="server" ID="Label1" Text="Year Transactions By Manufacurer" CssClass="LabelForm"
                                    Font-Underline="true"></asp:Label>
                            </td>
                        </tr>
                         <tr>
                            <td align="left" class="tableFilterHeader">
                                <table>
                                    <tr>
                                        <td>
                                            <uc:UCButtonCommand runat="server" ID="ButtonExcelManufacturer" CausesValidation="false"
                                                ButtonCommandName="ExportManufacturer" ButtonImageUrl="~/App_Images/page_excel.png" OnCommand="OnCommand"
                                                ButtonText="Export To Excel" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="contentboxheader">
                                <asp:Label runat="server" ID="Label2" Text="Year Transactions Information" CssClass="LabelForm2"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="contentboxForm">
                                <uc:ListViewYearManufacturer runat="server" ID="ListViewYearOverViewMFG" Visible="true" />
                            </td>
                        </tr>
                    </table>
                </asp:View>
            </asp:MultiView>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="ButtonCommandExport" />
              <asp:PostBackTrigger ControlID="ButtonExcelManufacturer" />
        </Triggers>
    </asp:UpdatePanel>
</div>
