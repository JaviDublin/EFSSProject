<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SettingsListViewCompanies.ascx.cs" Inherits="APP.App_UserControls.Settings.ListViews.Companies.SettingsListViewCompanies" %>
<asp:UpdatePanel ID="UpdatePanelListView" runat="server" ChildrenAsTriggers="false"
    UpdateMode="Conditional">
    <ContentTemplate>
        <table width="100%">
            <tr>
                <td align="left">
                    <asp:Label runat="server" ID="LabelCompaniesTitle" Text="Companies" CssClass="LabelForm"
                        Font-Underline="true"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" class="contentboxheader">
                    <asp:Label runat="server" ID="LabelHeaderCompaniesInformation" Text="Companies Information"
                        CssClass="LabelForm2"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" class="contentboxForm">
                    <%-- Data --%>
                    <asp:PlaceHolder ID="PlaceHolderData" runat="server">
                        <%-- Resizable Container --%>
                        <div id="ResizableListView" class="ui-widget-content">
                            <%-- ListView --%>
                            <rad:ListView ID="ListViewCompaniesOverview" runat="server" ItemPlaceholderID="PlaceHolderDetails"
                                LayoutTableID="tableCompaniesOverview" ItemTemplateRow="rowListViewDetails" DataKeyNames="CompanyId"
                                OnSorting="ListView_Sorting" LayoutTableClass="listviewtable" LayoutTableDefaultHeight="350"
                                LayoutTableTheme="rad__listview-table" ResizableControl="ResizableListView" OnItemCommand="ListView_ItemCommand">
                                <LayoutTemplate>
                                    <table cellpadding="0" cellspacing="0" class="listviewtable" id="tableCompaniesOverview"
                                        runat="server" clientidmode="Static">
                                        <thead>
                                            <tr>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonCompanyName" runat="server" Text="<%$Resources:ListViewHeaders, CompanyName %>"
                                                        CommandArgument="CompanyName" ToolTip="<%$Resources:ToolTips, CompanyName%>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonCompanyCode" runat="server" Text="<%$Resources:ListViewHeaders, CompanyCode%>"
                                                        CommandArgument="CompanyCode" ToolTip="<%$Resources:ToolTips, CompanyCode%>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonCompanyType" runat="server" Text="<%$Resources:ListViewHeaders, CompanyType %>"
                                                        CommandArgument="CompanyType" ToolTip="<%$Resources:ToolTips,CompanyType %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonCountryName" runat="server" Text="<%$Resources:ListViewHeaders, CountryName%>"
                                                        CommandArgument="CountryName" ToolTip="<%$Resources:ToolTips,CountryName %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonRegionName" runat="server" Text="<%$Resources:ListViewHeaders, RegionName %>"
                                                        CommandArgument="RegionName" ToolTip="<%$Resources:ToolTips,RegionName %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonCurrencyCode" runat="server" Text="<%$Resources:ListViewHeaders, CurrencyCode%>"
                                                        CommandArgument="CurrencyCode" ToolTip="<%$Resources:ToolTips,CurrencyCode %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonRate" runat="server" Text="<%$Resources:ListViewHeaders, Rate %>"
                                                        CommandArgument="Rate" ToolTip="<%$Resources:ToolTips, Rate %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonCountryVat" runat="server" Text="<%$Resources:ListViewHeaders, CountryVat %>"
                                                        CommandArgument="CountryVat" ToolTip="<%$Resources:ToolTips, CountryVat %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonCompanyFiscalCode" runat="server" Text="<%$Resources:ListViewHeaders, CompanyFiscalCode %>"
                                                        CommandArgument="CompanyFiscalCode" ToolTip="<%$Resources:ToolTips, CompanyFiscalCode %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonOracleCode" runat="server" Text="<%$Resources:ListViewHeaders, OracleCode %>"
                                                        CommandArgument="OracleCode" ToolTip="<%$Resources:ToolTips, OracleCode %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonGroupName" runat="server" Text="<%$Resources:ListViewHeaders, GroupName %>"
                                                        CommandArgument="GroupName" ToolTip="<%$Resources:ToolTips, GroupName %>"></rad:ListViewHeader>
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
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("CompanyName")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("CompanyCode")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("CompanyType")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("CountryName")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("RegionName")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("CurrencyCode")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Rate")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("CountryVat")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("CompanyFiscalCode")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("OracleCode")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("GroupName")))%>
                                        </td>
                                        <td style="width: 25px; text-align: center;">
                                            <cc:ImageButtonListViewEdit ID="ImageButtonEdit" runat="server" />
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </rad:ListView>
                            <%-- Pager --%>
                            <rad:ListViewPager ID="ListViewPager" runat="server" OnPagerItemCommand="OnPager_Command"
                                DefaultPageSize="Fifteen" EditButtonVisible="false" DeleteButtonVisible="false" />
                        </div>
                    </asp:PlaceHolder>
                    <%-- No Data --%>
                    <asp:PlaceHolder ID="PlaceHolderNoData" runat="server">
                        <uc:UCEmptyDataTemplate ID="UCEmptyData" runat="server" />
                    </asp:PlaceHolder>
                </td>
            </tr>
        </table>
    </ContentTemplate>
</asp:UpdatePanel>
