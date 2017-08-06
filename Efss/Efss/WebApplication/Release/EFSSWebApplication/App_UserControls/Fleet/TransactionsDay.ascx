<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TransactionsDay.ascx.cs"
    Inherits="APP.App_UserControls.Fleet.TransactionsDay" %>
<%-- Control Wrapper --%>
<div class="div-Application-Content">
    <asp:UpdatePanel runat="server" ID="UpdatePanelDayTransactions" UpdateMode="Conditional"
        ChildrenAsTriggers="false">
        <ContentTemplate>
            <uc:UCNavigationPanel runat="server" ID="NavigationPanelDayTransactions" OnNavigationMenuClick="NavigationMenuClick" />
            <asp:MultiView runat="server" ID="MultiViewDayTransactions" ActiveViewIndex="0">
                <asp:View runat="server" ID="Country">
                    <table width="100%">
                        <tr>
                            <td align="left">
                                <asp:Label runat="server" ID="LabelTransactionsMonthTitle" Text="Month Transactions By Country"
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
                                            Month
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList runat="server" ID="DropDownListMonths" CssClass="dropdownForm"
                                                Width="120px" Font-Bold="True" Font-Size="11px">
                                                <asp:ListItem Value="1" Text="January"></asp:ListItem>
                                                <asp:ListItem Value="2" Text="February"></asp:ListItem>
                                                <asp:ListItem Value="3" Text="March"></asp:ListItem>
                                                <asp:ListItem Value="4" Text="April"></asp:ListItem>
                                                <asp:ListItem Value="5" Text="May"></asp:ListItem>
                                                <asp:ListItem Value="6" Text="June"></asp:ListItem>
                                                <asp:ListItem Value="7" Text="July"></asp:ListItem>
                                                <asp:ListItem Value="8" Text="August"></asp:ListItem>
                                                <asp:ListItem Value="9" Text="September"></asp:ListItem>
                                                <asp:ListItem Value="10" Text="October"></asp:ListItem>
                                                <asp:ListItem Value="11" Text="November"></asp:ListItem>
                                                <asp:ListItem Value="12" Text="December"></asp:ListItem>
                                            </asp:DropDownList>
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
[Import.ActiveFleetMonthADReport] 
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
                                                SelectCommand="select FileId , Notes from [Application.Files] where FileCode in ('FCMAR','FCMDR')">
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="contentboxheader">
                                <asp:Label runat="server" ID="LabelHeaderFleetInformation" Text="Month Transactions Information"
                                    CssClass="LabelForm2"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="contentboxForm">
                                <uc:ListViewDay ID="ListViewDayOverView" runat="server" Visible="true" OnSearchByManufacturer="SearchByManufacturer">
                                </uc:ListViewDay>
                            </td>
                        </tr>
                    </table>
                </asp:View>
                <asp:View runat="server" ID="Manufacturer">
                    <table width="100%">
                        <tr>
                            <td align="left">
                                <asp:Label runat="server" ID="Label1" Text="Month Transactions By Manufacturer" CssClass="LabelForm"
                                    Font-Underline="true"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="tableFilterHeader">
                                <table>
                                    <tr>
                                        <td>
                                            <uc:UCButtonCommand runat="server" ID="ButtonExcelManufacturer" CausesValidation="false"
                                                ButtonCommandName="ExportManufacturer" ButtonImageUrl="~/App_Images/page_excel.png"
                                                OnCommand="OnCommand" ButtonText="Export To Excel" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="contentboxheader">
                                <asp:Label runat="server" ID="Label2" Text="Month Transactions Information" CssClass="LabelForm2"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="contentboxForm">
                                <uc:ListViewDayManufacturer runat="server" ID="ListViewDayOverViewMFG" Visible="true" />
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
