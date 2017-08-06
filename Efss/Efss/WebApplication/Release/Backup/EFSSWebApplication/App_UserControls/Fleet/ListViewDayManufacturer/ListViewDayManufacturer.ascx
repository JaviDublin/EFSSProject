<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ListViewDayManufacturer.ascx.cs" Inherits="APP.App_UserControls.Fleet.ListViewDayManufacturer.ListViewDayManufacturer" %>
<asp:UpdatePanel ID="UpdatePanelListView" runat="server" ChildrenAsTriggers="false"
    UpdateMode="Conditional">
    <ContentTemplate>
        <%-- Data --%>
        <asp:PlaceHolder ID="PlaceHolderData" runat="server">
            <%-- Resizable Container --%>
            <div id="ResizableListView" class="ui-widget-content">
                <%-- ListView --%>
                <rad:ListView ID="ListViewFleetDayReportOverview" runat="server" ItemPlaceholderID="PlaceHolderDetails"
                    LayoutTableID="tableFleetDayOverview" ItemTemplateRow="rowListViewDetails" DataKeyNames="ManufacturerId"
                    OnSorting="ListView_Sorting" LayoutTableClass="listviewtable" LayoutTableDefaultHeight="350"
                    LayoutTableTheme="rad__listview-table" ResizableControl="ResizableListView" OnItemCommand="ListView_ItemCommand">
                    <LayoutTemplate>
                        <table cellpadding="0" cellspacing="0" class="listviewtable" id="tableFleetDayOverview"
                            runat="server" clientidmode="Static">
                            <thead>
                                <tr>
                                    <th>
                                        <rad:ListViewHeader ID="LinkButtonCountryCode" runat="server" Text="CODE"
                                            CommandArgument="CountryCode" ToolTip="<%$Resources:ToolTips, CountryCode%>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="LinkButtonManufacturerName" runat="server" Text="<%$Resources:ListViewHeaders, ManufacturerName %>"
                                            CommandArgument="ManufacturerName" ToolTip="<%$Resources:ToolTips, ManufacturerName%>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="LinkButtonTotal" runat="server" Text="<%$Resources:ListViewHeaders, Total%>"
                                            CommandArgument="Total" ToolTip="<%$Resources:ToolTips, Total%>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="LinkButtonDay1" runat="server" Text="<%$Resources:ListViewHeaders, Day1 %>"
                                            CommandArgument="D1" ToolTip="<%$Resources:ToolTips,Day1 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="LinkButtonDay2" runat="server" Text="<%$Resources:ListViewHeaders, Day2%>"
                                            CommandArgument="D2" ToolTip="<%$Resources:ToolTips,Day2 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="LinkButtonDay3" runat="server" Text="<%$Resources:ListViewHeaders, Day3 %>"
                                            CommandArgument="D3" ToolTip="<%$Resources:ToolTips,Day3 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="LinkButtonDay4" runat="server" Text="<%$Resources:ListViewHeaders, Day4%>"
                                            CommandArgument="D4" ToolTip="<%$Resources:ToolTips,Day4 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="LinkButtonDay5" runat="server" Text="<%$Resources:ListViewHeaders, Day5 %>"
                                            CommandArgument="D5" ToolTip="<%$Resources:ToolTips, Day5 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="LinkButtonDay6" runat="server" Text="<%$Resources:ListViewHeaders, Day6 %>"
                                            CommandArgument="D6" ToolTip="<%$Resources:ToolTips, Day6 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="LinkButtonDay7" runat="server" Text="<%$Resources:ListViewHeaders, Day7 %>"
                                            CommandArgument="D7" ToolTip="<%$Resources:ToolTips, Day7 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="LinkButtonDay8" runat="server" Text="<%$Resources:ListViewHeaders, Day8 %>"
                                            CommandArgument="D8" ToolTip="<%$Resources:ToolTips, Day8 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="LinkButtonDay9" runat="server" Text="<%$Resources:ListViewHeaders, Day9 %>"
                                            CommandArgument="D9" ToolTip="<%$Resources:ToolTips, Day9 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="LinkButtonDay10" runat="server" Text="<%$Resources:ListViewHeaders, Day10 %>"
                                            CommandArgument="D10" ToolTip="<%$Resources:ToolTips, Day10 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="LinkButtonDay11" runat="server" Text="<%$Resources:ListViewHeaders, Day11 %>"
                                            CommandArgument="D11" ToolTip="<%$Resources:ToolTips, Day11 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="LinkButtonDay12" runat="server" Text="<%$Resources:ListViewHeaders, Day12 %>"
                                            CommandArgument="D12" ToolTip="<%$Resources:ToolTips, Day12 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="ListViewDay13" runat="server" Text="<%$Resources:ListViewHeaders, Day13 %>"
                                            CommandArgument="D13" ToolTip="<%$Resources:ToolTips,Day13 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="ListViewDay14" runat="server" Text="<%$Resources:ListViewHeaders, Day14%>"
                                            CommandArgument="D14" ToolTip="<%$Resources:ToolTips,Day14 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="ListViewDay15" runat="server" Text="<%$Resources:ListViewHeaders, Day15 %>"
                                            CommandArgument="D15" ToolTip="<%$Resources:ToolTips,Day15 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="ListViewDay16" runat="server" Text="<%$Resources:ListViewHeaders, Day16%>"
                                            CommandArgument="D16" ToolTip="<%$Resources:ToolTips,Day16 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="ListViewDay17" runat="server" Text="<%$Resources:ListViewHeaders, Day17 %>"
                                            CommandArgument="D17" ToolTip="<%$Resources:ToolTips, Day17 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="ListViewDay18" runat="server" Text="<%$Resources:ListViewHeaders, Day18 %>"
                                            CommandArgument="D18" ToolTip="<%$Resources:ToolTips, Day18 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="ListViewDay19" runat="server" Text="<%$Resources:ListViewHeaders, Day19 %>"
                                            CommandArgument="D19" ToolTip="<%$Resources:ToolTips, Day19 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="ListViewDay20" runat="server" Text="<%$Resources:ListViewHeaders, Day20 %>"
                                            CommandArgument="D20" ToolTip="<%$Resources:ToolTips, Day20 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="ListViewDay21" runat="server" Text="<%$Resources:ListViewHeaders, Day21 %>"
                                            CommandArgument="D21" ToolTip="<%$Resources:ToolTips, Day21 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="ListViewDay22" runat="server" Text="<%$Resources:ListViewHeaders, Day22 %>"
                                            CommandArgument="D22" ToolTip="<%$Resources:ToolTips, Day22 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="ListViewDay23" runat="server" Text="<%$Resources:ListViewHeaders, Day23 %>"
                                            CommandArgument="D23" ToolTip="<%$Resources:ToolTips, Day23 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="ListViewDay24" runat="server" Text="<%$Resources:ListViewHeaders, Day24 %>"
                                            CommandArgument="D24" ToolTip="<%$Resources:ToolTips, Day24 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="ListViewDay25" runat="server" Text="<%$Resources:ListViewHeaders, Day25 %>"
                                            CommandArgument="D25" ToolTip="<%$Resources:ToolTips,Day25 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="ListViewDay26" runat="server" Text="<%$Resources:ListViewHeaders, Day26 %>"
                                            CommandArgument="D26" ToolTip="<%$Resources:ToolTips,Day26 %>"></rad:ListViewHeader>
                                   
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="ListViewDay27" runat="server" Text="<%$Resources:ListViewHeaders, Day27 %>"
                                            CommandArgument="D27" ToolTip="<%$Resources:ToolTips,Day27 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="ListViewDay28" runat="server" Text="<%$Resources:ListViewHeaders, Day28%>"
                                            CommandArgument="D28" ToolTip="<%$Resources:ToolTips,Day28 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="ListViewDay29" runat="server" Text="<%$Resources:ListViewHeaders, Day29 %>"
                                            CommandArgument="D29" ToolTip="<%$Resources:ToolTips, Day29 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="ListViewDay30" runat="server" Text="<%$Resources:ListViewHeaders, Day30 %>"
                                            CommandArgument="D30" ToolTip="<%$Resources:ToolTips, Day30 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="ListViewDay31" runat="server" Text="<%$Resources:ListViewHeaders, Day31 %>"
                                            CommandArgument="D31" ToolTip="<%$Resources:ToolTips, Day31 %>"></rad:ListViewHeader>
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
                             <td style="width:25px;">
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("CountryCode")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("ManufacturerName")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Total")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("D1")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("D2")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("D3")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("D4")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("D5")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("D6")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("D7")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("D8")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("D9")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("D10")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("D11")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("D12")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("D13")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("D14")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("D15")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("D16")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("D17")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("D18")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("D19")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("D20")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("D21")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("D22")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("D23")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("D24")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("D25")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("D26")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("D27")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("D28")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("D29")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("D30")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("D31")))%>
                            </td>
                          
                        </tr>
                    </ItemTemplate>
                </rad:ListView>
                <%-- Pager --%>
                <rad:ListViewPager ID="ListViewPager" runat="server" OnPagerItemCommand="OnPager_Command"
                    DefaultPageSize="Ten" EditButtonVisible="false" DeleteButtonVisible="false" />
            </div>
        </asp:PlaceHolder>
        <%-- No Data --%>
        <asp:PlaceHolder ID="PlaceHolderNoData" runat="server">
            <uc:UCEmptyDataTemplate ID="UCEmptyData" runat="server" />
        </asp:PlaceHolder>
    </ContentTemplate>
</asp:UpdatePanel>