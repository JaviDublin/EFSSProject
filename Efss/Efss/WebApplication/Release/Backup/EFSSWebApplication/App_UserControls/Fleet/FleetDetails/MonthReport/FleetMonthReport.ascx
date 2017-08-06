<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FleetMonthReport.ascx.cs" Inherits="APP.App_UserControls.Fleet.FleetDetails.MonthReport.FleetMonthReport" %>

<%-- Control Wrapper --%>
<div class="div-Application-Content">
    <asp:UpdatePanel runat="server" ID="UpdatePanelMonthReport" UpdateMode="Conditional"
        ChildrenAsTriggers="false">
        <ContentTemplate>
            <table width="100%">
                <tr>
                    <td align="left">
                        <asp:Label runat="server" ID="LabelActiveFleetMonthTitle" Text="Active Fleet Month"
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
[Import.ActiveFleetMonthReport] 
group by DateYear 
order by DateYear desc"></asp:SqlDataSource>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td align="left" class="contentboxheader">
                        <asp:Label runat="server" ID="LabelHeaderFleetInformation" Text="Month Active Fleet Information"
                            CssClass="LabelForm2"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="left" class="contentboxForm">
                        <asp:PlaceHolder ID="PlaceHolderData" runat="server">
                            <div id="ResizableListView" class="ui-widget-content">
                                <rad:ListView ID="ListViewFleetMonthReportOverview" runat="server" ItemPlaceholderID="PlaceHolderDetails"
                                    LayoutTableID="tableFleetMonthReportOverview" OnSorting="ListView_Sorting" ItemTemplateRow="rowListViewDetails"
                                    DataKeyNames="RowId" LayoutTableClass="listviewtable" LayoutTableDefaultHeight="350"
                                    LayoutTableTheme="rad__listview-table" ResizableControl="ResizableListView">
                                    <LayoutTemplate>
                                        <table cellpadding="0" cellspacing="0" class="listviewtable" id="tableFleetMonthReportOverview"
                                            runat="server" clientidmode="Static">
                                            <thead>
                                                <tr>
                                                    <th>
                                                        <rad:ListViewHeader ID="LinkButtonCountryName" runat="server" Text="<%$Resources:ListViewHeaders, CountryName %>"
                                                            CommandArgument="CountryName" ToolTip="<%$Resources:ToolTips, CountryName%>"></rad:ListViewHeader>
                                                    </th>
                                                    <th style="width: 150px;">
                                                        <rad:ListViewHeader ID="LinkButtonregionName" runat="server" Text="<%$Resources:ListViewHeaders, RegionName %>"
                                                            CommandArgument="RegionName" ToolTip="<%$Resources:ToolTips, RegionName%>"></rad:ListViewHeader>
                                                    </th>
                                                    <th>
                                                        <rad:ListViewHeader ID="LinkButtonTotal" runat="server" Text="<%$Resources:ListViewHeaders, Total%>"
                                                            CommandArgument="Total" ToolTip="<%$Resources:ToolTips, Total%>"></rad:ListViewHeader>
                                                    </th>
                                                    <th>
                                                        <rad:ListViewHeader ID="LinkButtonActive" runat="server" Text="<%$Resources:ListViewHeaders, Active%>"
                                                            CommandArgument="Active" ToolTip="<%$Resources:ToolTips, Active%>"></rad:ListViewHeader>
                                                    </th>
                                                    <th>
                                                        <rad:ListViewHeader ID="LinkButtonConversion" runat="server" Text="<%$Resources:ListViewHeaders, Conversion%>"
                                                            CommandArgument="Conversion" ToolTip="<%$Resources:ToolTips, Conversion%>"></rad:ListViewHeader>
                                                    </th>
                                                    <th>
                                                        <rad:ListViewHeader ID="LinkButtonDelivered" runat="server" Text="<%$Resources:ListViewHeaders, Delivered%>"
                                                            CommandArgument="Delivered" ToolTip="<%$Resources:ToolTips, Delivered%>"></rad:ListViewHeader>
                                                    </th>
                                                    <th>
                                                        <rad:ListViewHeader ID="LinkButtonInactive" runat="server" Text="<%$Resources:ListViewHeaders, Inactive%>"
                                                            CommandArgument="Inactive" ToolTip="<%$Resources:ToolTips, Inactive%>"></rad:ListViewHeader>
                                                    </th>
                                                    <th>
                                                        <rad:ListViewHeader ID="LinkButtonSuspend" runat="server" Text="<%$Resources:ListViewHeaders, Suspend%>"
                                                            CommandArgument="Suspend" ToolTip="<%$Resources:ToolTips, Suspend%>"></rad:ListViewHeader>
                                                    </th>
                                                    <th>
                                                        <rad:ListViewHeader ID="LinkButtonFuture" runat="server" Text="<%$Resources:ListViewHeaders, Future%>"
                                                            CommandArgument="Future" ToolTip="<%$Resources:ToolTips, Future%>"></rad:ListViewHeader>
                                                    </th>
                                                    <th>
                                                        <rad:ListViewHeader ID="LinkButtonOther" runat="server" Text="<%$Resources:ListViewHeaders, Other%>"
                                                            CommandArgument="Other" ToolTip="<%$Resources:ToolTips, Other%>"></rad:ListViewHeader>
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr id="PlaceholderDetails" runat="server" />
                                            </tbody>
                                        </table>
                                    </LayoutTemplate>
                                    <ItemTemplate>
                                        <tr id="rowListViewDetails" runat="server">
                                            <td>
                                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("CountryName")))%>
                                            </td>
                                            <td>
                                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("RegionName")))%>
                                            </td>
                                            <td>
                                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Total")))%>
                                            </td>
                                            <td>
                                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Active")))%>
                                            </td>
                                            <td>
                                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Conversion")))%>
                                            </td>
                                            <td>
                                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Delivered")))%>
                                            </td>
                                            <td>
                                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Inactive")))%>
                                            </td>
                                            <td>
                                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Suspend")))%>
                                            </td>
                                            <td>
                                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Future")))%>
                                            </td>
                                            <td>
                                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Other")))%>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </rad:ListView>
                                <%-- Pager --%>
                                <rad:ListViewPager ID="ListViewPager" runat="server" OnPagerItemCommand="OnPager_Command"
                                    DefaultPageSize="Ten" EditButtonVisible="false" DeleteButtonVisible="false" />
                            </div>
                        </asp:PlaceHolder>
                        <asp:PlaceHolder ID="PlaceHolderNoData" runat="server">
                            <uc:UCEmptyDataTemplate ID="UCEmptyData" runat="server" />
                        </asp:PlaceHolder>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="ButtonCommandExport" />
        </Triggers>
    </asp:UpdatePanel>
</div>
