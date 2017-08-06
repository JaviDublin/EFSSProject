<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SettingsListViewVendors.ascx.cs" Inherits="APP.App_UserControls.Settings.ListViews.Vendors.SettingsListViewVendors" %>
<asp:UpdatePanel runat="server" ID="UpdatePanelListView" UpdateMode="Conditional"
    ChildrenAsTriggers="false">
    <ContentTemplate>
        <table width="100%">
            <tr>
                <td align="left">
                    <asp:Label runat="server" ID="LabelBuyersTitle" Text="Buyers \ Vendors"
                        CssClass="LabelForm" Font-Underline="true"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" class="tableFilterHeader">
                    <table>
                        <tr>
                            <td>
                                <uc:UCButtonCommand runat="server" ID="ButtonCommandFilter" CausesValidation="true"
                                    ButtonCommandName="Filter" ButtonImageUrl="~/App_Images/accept.png" OnCommand="OnCommand"
                                    ButtonText="Filter" />
                            </td>
                            <td>
                                <asp:Image runat="server" ID="ImageSeparator" ImageUrl="~/App_Styles/Images/menu-bg.jpg" />
                            </td>
                            <td align="left">
                                Country
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="DropDownListCountries" CssClass="dropdownForm"
                                    Width="200px" Font-Bold="True" Font-Size="11px" AppendDataBoundItems="True" AutoPostBack="True"
                                    OnSelectedIndexChanged="DropDownListCountries_SelectedIndexChanged">
                                    <asp:ListItem>ALL</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td align="left">
                                Name
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxBuyerName" CssClass="TextBoxFormDate" Width="120px"></asp:TextBox>
                            </td>
                            <td align="left">
                                Manufacturer
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="DropDownListManufacturer" CssClass="dropdownForm"
                                    Width="200px" Font-Bold="True" Font-Size="11px" AppendDataBoundItems="True" AutoPostBack="True"
                                    OnSelectedIndexChanged="DropDownListManufacturer_SelectedIndexChanged">
                                    <asp:ListItem>ALL</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td align="left">
                                Buyer Code
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxBuyerCode" CssClass="TextBoxFormDate" Width="70px"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="left" class="contentboxheader">
                    <asp:Label runat="server" ID="LabelHeaderBuyersInformation" Text="Buyers Information"
                        CssClass="LabelForm2"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" class="contentboxForm">
                    <asp:PlaceHolder ID="PlaceHolderData" runat="server">
                        <%-- Resizable Container --%>
                        <div id="ResizableListView" class="ui-widget-content">
                            <%-- ListView --%>
                            <rad:ListView ID="ListViewBuyersOverview" runat="server" ItemPlaceholderID="PlaceHolderDetails"
                                OnItemCommand="ListView_ItemCommand" LayoutTableID="tableBuyersOverview" OnSorting="ListView_Sorting"
                                ItemTemplateRow="rowListViewDetails" DataKeyNames="BuyerId" LayoutTableClass="listviewtable"
                                LayoutTableDefaultHeight="350" LayoutTableTheme="rad__listview-table" ResizableControl="ResizableListView">
                                <LayoutTemplate>
                                    <table cellpadding="0" cellspacing="0" class="listviewtable" id="tableBuyersOverview"
                                        runat="server" clientidmode="Static">
                                        <thead>
                                            <tr>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonCompanyCode" runat="server" Text="<%$Resources:ListViewHeaders, CompanyCode %>"
                                                        CommandArgument="CompanyCode" ToolTip="<%$Resources:ToolTips, CompanyCode%>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonBuyerCode" runat="server" Text="<%$Resources:ListViewHeaders, BuyerCode%>"
                                                        CommandArgument="BuyerCode" ToolTip="<%$Resources:ToolTips, BuyerCode%>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="ListViewHeaderAreaCode" runat="server" Text="<%$Resources:ListViewHeaders, AreaCode %>"
                                                        CommandArgument="AreaCode" ToolTip="<%$Resources:ToolTips, AreaCode%>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonBuyerName" runat="server" Text="<%$Resources:ListViewHeaders, BuyerName %>"
                                                        CommandArgument="BuyerName" ToolTip="<%$Resources:ToolTips,BuyerName %>"></rad:ListViewHeader>
                                                </th>
                                                <th style="width: 100px;">
                                                    <rad:ListViewHeader ID="LinkButtonManufacturerName" runat="server" Text="<%$Resources:ListViewHeaders, ManufacturerName%>"
                                                        CommandArgument="ManufacturerName" ToolTip="<%$Resources:ToolTips,ManufacturerName %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonTotalSales" runat="server" Text="<%$Resources:ListViewHeaders, TotalSales %>"
                                                        CommandArgument="TotalSales" ToolTip="<%$Resources:ToolTips,TotalSales %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonLastSaleDate" runat="server" Text="<%$Resources:ListViewHeaders, LastSaleDate%>"
                                                        CommandArgument="LastSaleDate" ToolTip="<%$Resources:ToolTips,LastSaleDate %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonTotal" runat="server" Text="<%$Resources:ListViewHeaders, Total %>"
                                                        CommandArgument="Total" ToolTip="<%$Resources:ToolTips, Total %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonBuyerType" runat="server" Text="<%$Resources:ListViewHeaders, BuyerType %>"
                                                        CommandArgument="BuyerType" ToolTip="<%$Resources:ToolTips, BuyerType %>"></rad:ListViewHeader>
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
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("CompanyCode")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("BuyerCode")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("AreaCode")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("BuyerName")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("ManufacturerName")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("TotalSales")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("LastSaleDate")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Total")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("BuyerType")))%>
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
