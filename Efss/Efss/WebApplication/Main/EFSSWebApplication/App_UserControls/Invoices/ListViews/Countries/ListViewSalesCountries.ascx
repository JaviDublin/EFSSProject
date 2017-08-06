<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ListViewSalesCountries.ascx.cs" Inherits="APP.App_UserControls.Invoices.ListViews.Countries.ListViewSalesCountries" %>
<asp:UpdatePanel runat="server" ID="UpdatePanelListView" UpdateMode="Conditional"
    ChildrenAsTriggers="false">
    <ContentTemplate>
        <table width="100%">
            <tr>
                <td align="left" class="tableFilterHeader">
                    <table>
                        <tr>
                            <td>
                                <uc:UCButtonCommand runat="server" ID="ButtonCommandFilter" CausesValidation="true"
                                    ButtonCommandName="Filter" ButtonText="Filter" ButtonImageUrl="~/App_Images/accept.png"
                                    OnCommand="OnCommand" />
                            </td>
                            <td>
                                <asp:Image runat="server" ID="ImageSeparator" ImageUrl="~/App_Styles/Images/menu-bg.jpg" />
                            </td>
                            <td align="left">
                                File Date
                            </td>
                            <td align="left">
                                <cc:DateTextBox runat="server" ID="TextBoxFileDate" Width="100px" CssClass="TextBoxFormDate"></cc:DateTextBox>
                                <asp:ImageButton runat="server" ID="imgcalendarFileDate" ImageUrl="~/App_Images/calendar.png"
                                    ImageAlign="AbsBottom" />
                                <asp:CalendarExtender ID="dtPickerFrom" runat="server" TargetControlID="TextBoxFileDate"
                                    CssClass="calendarClass" PopupButtonID="imgcalendarFileDate" Format="dd/MM/yyyy"
                                    Enabled="true">
                                </asp:CalendarExtender>
                            </td>
                            <td align="left">
                                Invoice Date
                            </td>
                            <td align="left">
                                <cc:DateTextBox runat="server" ID="TextBoxInvoiceDate" Width="100px" CssClass="TextBoxFormDate"></cc:DateTextBox>
                                <asp:ImageButton runat="server" ID="ImageButtonInvoiceDate" ImageUrl="~/App_Images/calendar.png"
                                    ImageAlign="AbsBottom" />
                                <asp:CalendarExtender ID="dtPickerInvoiceDate" runat="server" CssClass="calendarClass"
                                    TargetControlID="TextBoxInvoiceDate" PopupButtonID="ImageButtonInvoiceDate" Format="dd/MM/yyyy"
                                    Enabled="true">
                                </asp:CalendarExtender>
                            </td>
                        </tr>
                        
                    </table>
                </td>
            </tr>
            <tr>
                            <td align="left" class="contentboxheader">
                                <asp:Label runat="server" ID="LabelHeaderCountryInvoicesInfo" Text="Country Invoices Information"
                                    CssClass="LabelForm2"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="contentboxForm">
                                <%-- Data --%>
                                <asp:PlaceHolder ID="PlaceHolderData" runat="server">
                                    <%-- Resizable Container --%>
                                    <div id="ResizableListView" class="ui-widget-content">
                                        <rad:ListView ID="ListViewFilesOverView" runat="server" ItemPlaceholderID="PlaceHolderDetails"
                                            OnItemCommand="ListViewFilesOverview_ItemCommand" LayoutTableID="tableFilesOverview"
                                            OnSorting="ListViewFilesOverview_Sorting" ItemTemplateRow="rowListViewDetails"
                                            DataKeyNames="CountryId" LayoutTableClass="listviewtable" LayoutTableDefaultHeight="350"
                                            LayoutTableTheme="rad__listview-table" ResizableControl="ResizableListView">
                                            <LayoutTemplate>
                                                <table cellpadding="0" cellspacing="0" class="listviewtable" id="tableFilesOverview"
                                                    runat="server" clientidmode="Static">
                                                    <thead>
                                                        <tr>
                                                            <th>
                                                                <rad:ListViewHeader ID="LinkButtonCountryName" runat="server" Text="<%$Resources:ListViewHeaders, CountryName %>"
                                                                    CommandArgument="CountryName" ToolTip="<%$Resources:ToolTips, CountryName%>"></rad:ListViewHeader>
                                                            </th>
                                                            <th>
                                                                <rad:ListViewHeader ID="LinkButtonFileDate" runat="server" Text="<%$Resources:ListViewHeaders, FileDate %>"
                                                                    CommandArgument="FileDate" ToolTip="<%$Resources:ToolTips, FileDate%>"></rad:ListViewHeader>
                                                            </th>
                                                            <th>
                                                                <rad:ListViewHeader ID="LinkButtonTotalInvoices" runat="server" Text="<%$Resources:ListViewHeaders, TotalInvoices%>"
                                                                    CommandArgument="TotalInvoices" ToolTip="<%$Resources:ToolTips, TotalInvoices%>"></rad:ListViewHeader>
                                                            </th>
                                                            <th>
                                                                <rad:ListViewHeader ID="LinkButtonFleetCo" runat="server" Text="<%$Resources:ListViewHeaders, FleetCo %>"
                                                                    CommandArgument="FleetCo" ToolTip="<%$Resources:ToolTips,FleetCo %>"></rad:ListViewHeader>
                                                            </th>
                                                            <th>
                                                                <rad:ListViewHeader ID="LinkButtonOpCo" runat="server" Text="<%$Resources:ListViewHeaders, OpCo%>"
                                                                    CommandArgument="OpCo" ToolTip="<%$Resources:ToolTips,OpCo %>"></rad:ListViewHeader>
                                                            </th>
                                                            <th>
                                                                <rad:ListViewHeader ID="LinkButtonOriginal" runat="server" Text="<%$Resources:ListViewHeaders, Original %>"
                                                                    CommandArgument="Original" ToolTip="<%$Resources:ToolTips,Original %>"></rad:ListViewHeader>
                                                            </th>
                                                            <th>
                                                                <rad:ListViewHeader ID="LinkButtonCreditNotes" runat="server" Text="<%$Resources:ListViewHeaders, CreditNotes%>"
                                                                    CommandArgument="CreditNotes" ToolTip="<%$Resources:ToolTips,CreditNotes %>"></rad:ListViewHeader>
                                                            </th>
                                                            <th>
                                                                <rad:ListViewHeader ID="LinkButtonBuyBack" runat="server" Text="<%$Resources:ListViewHeaders, BuyBack %>"
                                                                    CommandArgument="BuyBack" ToolTip="<%$Resources:ToolTips, BuyBack %>"></rad:ListViewHeader>
                                                            </th>
                                                            <th>
                                                                <rad:ListViewHeader ID="LinkButtonWholesale" runat="server" Text="<%$Resources:ListViewHeaders, WholeSale %>"
                                                                    CommandArgument="WholeSale" ToolTip="<%$Resources:ToolTips, WholeSale %>"></rad:ListViewHeader>
                                                            </th>
                                                            <th>
                                                                <rad:ListViewHeader ID="LinkButtonWreck" runat="server" Text="<%$Resources:ListViewHeaders, Wreck %>"
                                                                    CommandArgument="Wreck" ToolTip="<%$Resources:ToolTips, Wreck %>"></rad:ListViewHeader>
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
                                                        <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("FileDate")))%>
                                                    </td>
                                                    <td>
                                                        <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("TotalInvoices")))%>
                                                    </td>
                                                    <td>
                                                        <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("FleetCo")))%>
                                                    </td>
                                                    <td>
                                                        <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("OpCo")))%>
                                                    </td>
                                                    <td>
                                                        <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Original")))%>
                                                    </td>
                                                    <td>
                                                        <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("CreditNotes")))%>
                                                    </td>
                                                    <td>
                                                        <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("BuyBack")))%>
                                                    </td>
                                                    <td>
                                                        <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("WholeSale")))%>
                                                    </td>
                                                    <td>
                                                        <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Wreck")))%>
                                                    </td>
                                                    <td style="width: 25px; text-align: center;">
                                                        <cc:ImageButtonListViewEdit ID="ImageButtonEdit" runat="server" />
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
                            </td>
                        </tr>
        </table>
    </ContentTemplate>
</asp:UpdatePanel>
    