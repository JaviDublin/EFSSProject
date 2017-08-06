<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FleetDayReport.ascx.cs"
    Inherits="APP.App_UserControls.Fleet.FleetDetails.DayReport.FleetDayReport" %>
<%-- Control Wrapper --%>
<div class="div-Application-Content">
    <asp:UpdatePanel runat="server" ID="UpdatePanelDayReport" UpdateMode="Conditional"
        ChildrenAsTriggers="false">
        <ContentTemplate>
            <table width="100%">
                <tr>
                    <td align="left">
                        <asp:Label runat="server" ID="LabelActiveFleetDayTitle" Text="Active Fleet Day" CssClass="LabelForm"
                            Font-Underline="true"></asp:Label>
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
                                        ButtonCommandName="Filter" ButtonImageUrl="~/App_Images/accept.png" OnCommand="OnCommand"
                                        ButtonText="Filter" />
                                </td>
                                <td>
                                    <asp:Image runat="server" ID="ImageSeparator" ImageUrl="~/App_Styles/Images/menu-bg.jpg" />
                                </td>
                                <td align="left">
                                    File Date
                                </td>
                                <td align="left">
                                    <cc:DateTextBox runat="server" ID="txtReportDayDate" CssClass="TextBoxFormDate" Width="100px"></cc:DateTextBox>
                                    <asp:ImageButton runat="server" ID="imgreportdaydate" ImageUrl="~/App_Images/calendar.png"
                                        ImageAlign="AbsBottom" />
                                    <asp:CalendarExtender runat="server" ID="dtRDD" TargetControlID="txtReportDayDate"
                                        Format="dd/MM/yyyy" PopupButtonID="imgreportdaydate" Enabled="true" CssClass="calendarClass">
                                    </asp:CalendarExtender>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td align="left" class="contentboxheader">
                        <asp:Label runat="server" ID="LabelHeaderFleetInformation" Text="Day Active Fleet Information"
                            CssClass="LabelForm2"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="left" class="contentboxForm">
                        <asp:PlaceHolder ID="PlaceHolderData" runat="server">
                        
                            <div id="ResizableListView" class="ui-widget-content">
                                
                                            <rad:ListView ID="ListViewFleetDayReportOverview" runat="server" ItemPlaceholderID="PlaceHolderDetails"
                                                LayoutTableID="tableFleetDayReportOverview" OnSorting="ListView_Sorting" ItemTemplateRow="rowListViewDetails"
                                                DataKeyNames="RowId" LayoutTableClass="listviewtable" LayoutTableDefaultHeight="350"
                                                LayoutTableTheme="rad__listview-table" ResizableControl="ResizableListView">
                                                <LayoutTemplate>
                                                    <table cellpadding="0" cellspacing="0" class="listviewtable" id="tableFleetDayReportOverview"
                                                        runat="server" clientidmode="Static">
                                                        <thead>
                                                            <tr>
                                                                <th style="width: 150px;">
                                                                    <rad:ListViewHeader ID="LinkButtonCountryName" runat="server" Text="<%$Resources:ListViewHeaders, CountryName %>"
                                                                        CommandArgument="CountryName" ToolTip="<%$Resources:ToolTips, CountryName%>"></rad:ListViewHeader>
                                                                </th>
                                                                <th>
                                                                    <rad:ListViewHeader ID="LinkButtonregionName" runat="server" Text="<%$Resources:ListViewHeaders, RegionName %>"
                                                                        CommandArgument="RegionName" ToolTip="<%$Resources:ToolTips, RegionName%>"></rad:ListViewHeader>
                                                                </th>
                                                                <th>
                                                                    <rad:ListViewHeader ID="LinkButtonTotal" runat="server" Text="<%$Resources:ListViewHeaders, Total%>"
                                                                        CommandArgument="Total" ToolTip="<%$Resources:ToolTips, Total%>"></rad:ListViewHeader>
                                                                </th>
                                                                <th>
                                                                    <rad:ListViewHeader ID="LinkButtonTotalPCT" runat="server" Text="<%$Resources:ListViewHeaders, TotalPCT%>"
                                                                        CommandArgument="TotalPCT" ToolTip="<%$Resources:ToolTips, TotalPCT%>"></rad:ListViewHeader>
                                                                </th>

                                                                 <th>
                                                                    <rad:ListViewHeader ID="ListViewHeaderBuyBack" runat="server" Text="<%$Resources:ListViewHeaders, BuyBack%>"
                                                                        CommandArgument="BuyBack" ToolTip="<%$Resources:ToolTips, BuyBack%>"></rad:ListViewHeader>
                                                                </th>
                                                                <th>
                                                                    <rad:ListViewHeader ID="ListViewHeaderBuyBackPCT" runat="server" Text="<%$Resources:ListViewHeaders, BuyBackPCT%>"
                                                                        CommandArgument="BuyBackPCT" ToolTip="<%$Resources:ToolTips, BuyBackPCT%>"></rad:ListViewHeader>
                                                                </th>

                                                                 <th>
                                                                    <rad:ListViewHeader ID="ListViewHeaderWholeSale" runat="server" Text="<%$Resources:ListViewHeaders, WholeSale%>"
                                                                        CommandArgument="WholeSale" ToolTip="<%$Resources:ToolTips, WholeSale%>"></rad:ListViewHeader>
                                                                </th>
                                                                <th>
                                                                    <rad:ListViewHeader ID="ListViewHeaderWholeSalePCT" runat="server" Text="<%$Resources:ListViewHeaders, WholeSalePCT%>"
                                                                        CommandArgument="WholeSalePCT" ToolTip="<%$Resources:ToolTips, WholeSalePCT%>"></rad:ListViewHeader>
                                                                </th>

                                                                 <th>
                                                                    <rad:ListViewHeader ID="ListViewHeaderLease" runat="server" Text="<%$Resources:ListViewHeaders, Lease%>"
                                                                        CommandArgument="Lease" ToolTip="<%$Resources:ToolTips, Lease%>"></rad:ListViewHeader>
                                                                </th>
                                                                <th>
                                                                    <rad:ListViewHeader ID="ListViewHeaderLeasePCT" runat="server" Text="<%$Resources:ListViewHeaders, LeasePCT%>"
                                                                        CommandArgument="LeasePCT" ToolTip="<%$Resources:ToolTips, LeasePCT%>"></rad:ListViewHeader>
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
                                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("TotalPCT")))%>
                                                        </td>
                                                         <td>
                                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("BuyBack")))%>
                                                        </td>
                                                        <td>
                                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("BuyBackPCT")))%>
                                                        </td>
                                                         <td>
                                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("WholeSale")))%>
                                                        </td>
                                                        <td>
                                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("WholeSalePCT")))%>
                                                        </td>
                                                         <td>
                                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Lease")))%>
                                                        </td>
                                                        <td>
                                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("LeasePCT")))%>
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
