<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ListViewYear.ascx.cs" Inherits="APP.App_UserControls.Fleet.ListViewYear.ListViewYear" %>
<asp:UpdatePanel ID="UpdatePanelListView" runat="server" ChildrenAsTriggers="false" UpdateMode="Conditional">
    <ContentTemplate>
        <%-- Data --%>
        <asp:PlaceHolder ID="PlaceHolderData" runat="server">
            <%-- Resizable Container --%>
            <div id="ResizableListView" class="ui-widget-content">
                <%-- ListView --%>
                <rad:ListView ID="ListViewFleetYearReportOverview" runat="server" ItemPlaceholderID="PlaceHolderDetails" LayoutTableID="tableFleetYearOverview" ItemTemplateRow="rowListViewDetails" DataKeyNames="CountryId"  OnSorting="ListView_Sorting" LayoutTableClass="listviewtable" LayoutTableDefaultHeight="350" LayoutTableTheme="rad__listview-table" ResizableControl="ResizableListView" OnItemCommand="ListView_ItemCommand" >
                    <LayoutTemplate>
                        <table cellpadding="0" cellspacing="0" class="listviewtable" id="tableFleetYearOverview" runat="server" clientidmode="Static">
                            <thead>
                                <tr>
                                    <th>
                                        <rad:ListViewHeader ID="LinkButtonCountryName" runat="server" Text="<%$Resources:ListViewHeaders, CountryName %>" CommandArgument="CountryName" ToolTip="<%$Resources:ToolTips, CountryName%>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="LinkButtonTotal" runat="server" Text="<%$Resources:ListViewHeaders, Total%>" CommandArgument="Total" ToolTip="<%$Resources:ToolTips, Total%>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="LinkButtonMonth1" runat="server" Text="<%$Resources:ListViewHeaders, Month1 %>" CommandArgument="January" ToolTip="<%$Resources:ToolTips,Month1 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="LinkButtonMonth2" runat="server" Text="<%$Resources:ListViewHeaders, Month2%>" CommandArgument="February" ToolTip="<%$Resources:ToolTips,Month2 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="LinkButtonMonth3" runat="server" Text="<%$Resources:ListViewHeaders, Month3 %>" CommandArgument="March" ToolTip="<%$Resources:ToolTips,Month3 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="LinkButtonMonth4" runat="server" Text="<%$Resources:ListViewHeaders, Month4%>" CommandArgument="April" ToolTip="<%$Resources:ToolTips,Month4 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="LinkButtonMonth5" runat="server" Text="<%$Resources:ListViewHeaders, Month5 %>" CommandArgument="May" ToolTip="<%$Resources:ToolTips, Month5 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="LinkButtonMonth6" runat="server" Text="<%$Resources:ListViewHeaders, Month6 %>" CommandArgument="June" ToolTip="<%$Resources:ToolTips, Month6 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="LinkButtonCMonth7" runat="server" Text="<%$Resources:ListViewHeaders, Month7 %>" CommandArgument="July" ToolTip="<%$Resources:ToolTips, Month7 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="LinkButtonMonth8" runat="server" Text="<%$Resources:ListViewHeaders, Month8 %>" CommandArgument="August" ToolTip="<%$Resources:ToolTips, Month8 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
                                        <rad:ListViewHeader ID="LinkButtonMonth9" runat="server" Text="<%$Resources:ListViewHeaders, Month9 %>" CommandArgument="September" ToolTip="<%$Resources:ToolTips, Month9 %>"></rad:ListViewHeader>
                                    </th>
                                     <th>
                                        <rad:ListViewHeader ID="LinkButtonMonth10" runat="server" Text="<%$Resources:ListViewHeaders, Month10 %>" CommandArgument="October" ToolTip="<%$Resources:ToolTips, Month10 %>"></rad:ListViewHeader>
                                    </th>
                                     <th>
                                        <rad:ListViewHeader ID="LinkButtonMonth11" runat="server" Text="<%$Resources:ListViewHeaders, Month11 %>" CommandArgument="November" ToolTip="<%$Resources:ToolTips, Month11 %>"></rad:ListViewHeader>
                                    </th>
                                     <th>
                                        <rad:ListViewHeader ID="LinkButtonMonth12" runat="server" Text="<%$Resources:ListViewHeaders, Month12 %>" CommandArgument="December" ToolTip="<%$Resources:ToolTips, Month12 %>"></rad:ListViewHeader>
                                    </th>
                                    <th>
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
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Total")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("January")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("February")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("March")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("April")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("May")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("June")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("July")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("August")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("September")))%>
                            </td>
                             <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("October")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("November")))%>
                            </td>
                            <td>
                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("December")))%>
                            </td>
                            <td style="width: 25px; text-align: center;">
                                <cc:ImageButtonListViewEdit ID="ImageButtonEdit" runat="server" />
                            </td>
                        </tr>
                    </ItemTemplate>
                </rad:ListView>
                <%-- Pager --%>
                <rad:ListViewPager ID="ListViewPager" runat="server" OnPagerItemCommand="OnPager_Command"  DefaultPageSize="Ten"  EditButtonVisible="false" DeleteButtonVisible ="false"    />
            </div>
        </asp:PlaceHolder>
        <%-- No Data --%>
        <asp:PlaceHolder ID="PlaceHolderNoData" runat="server">
            <uc:UCEmptyDataTemplate ID="UCEmptyData" runat="server" />
        </asp:PlaceHolder>
    </ContentTemplate>
</asp:UpdatePanel>

