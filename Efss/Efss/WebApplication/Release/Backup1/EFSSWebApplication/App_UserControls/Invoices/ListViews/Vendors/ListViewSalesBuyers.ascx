<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ListViewSalesBuyers.ascx.cs" Inherits="APP.App_UserControls.Invoices.ListViews.Vendors.ListViewSalesBuyers" %>
<asp:UpdatePanel runat="server" ID="UpdatePanelListViewBuyers" UpdateMode="Conditional"
    ChildrenAsTriggers="false">
    <ContentTemplate>
        <table width="100%">
            <tr>
                <td align="left" class="contentboxheader">
                    <asp:Label runat="server" ID="Label2" Text="Buyer Invoices Information" CssClass="LabelForm2"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" class="contentboxForm">
                    <asp:PlaceHolder ID="PlaceHolderData" runat="server">
                        <%-- Resizable Container --%>
                        <div id="ResizableListView" class="ui-widget-content">
                            <rad:ListView ID="ListViewBuyersOverView" runat="server" ItemPlaceholderID="PlaceHolderDetailsBuyer"
                                OnItemCommand="ListViewBuyersOverview_ItemCommand" LayoutTableID="tableBuyersOverview"
                                OnSorting="ListViewBuyersOverview_Sorting" ItemTemplateRow="rowListViewDetailsBuyer"
                                DataKeyNames="BuyerId" LayoutTableClass="listviewtable" LayoutTableDefaultHeight="350"
                                LayoutTableTheme="rad__listview-table" ResizableControl="ResizableListView">
                                <LayoutTemplate>
                                    <table cellpadding="0" cellspacing="0" class="listviewtable" id="tableBuyersOverview"
                                        runat="server" clientidmode="Static">
                                        <thead>
                                            <tr>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonBuyerCode" runat="server" Text="<%$Resources:ListViewHeaders, BuyerCode %>"
                                                        CommandArgument="BuyerCode" ToolTip="<%$Resources:ToolTips, BuyerCode%>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonBuyerName" runat="server" Text="<%$Resources:ListViewHeaders, BuyerName %>"
                                                        CommandArgument="BuyerName" ToolTip="<%$Resources:ToolTips, BuyerName%>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonFileDateBuyer" runat="server" Text="<%$Resources:ListViewHeaders, FileDate %>"
                                                        CommandArgument="FileDate" ToolTip="<%$Resources:ToolTips, FileDate%>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonTotalInvoicesBuyer" runat="server" Text="<%$Resources:ListViewHeaders, TotalInvoices%>"
                                                        CommandArgument="TotalInvoices" ToolTip="<%$Resources:ToolTips, TotalInvoices%>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonFleetCoBuyer" runat="server" Text="<%$Resources:ListViewHeaders, FleetCo %>"
                                                        CommandArgument="FleetCo" ToolTip="<%$Resources:ToolTips,FleetCo %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonOpCoBuyer" runat="server" Text="<%$Resources:ListViewHeaders, OpCo%>"
                                                        CommandArgument="OpCo" ToolTip="<%$Resources:ToolTips,OpCo %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonOriginalBuyer" runat="server" Text="<%$Resources:ListViewHeaders, Original %>"
                                                        CommandArgument="Original" ToolTip="<%$Resources:ToolTips,Original %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonCreditNotesBuyer" runat="server" Text="<%$Resources:ListViewHeaders, CreditNotes%>"
                                                        CommandArgument="CreditNotes" ToolTip="<%$Resources:ToolTips,CreditNotes %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonBuyBackBuyer" runat="server" Text="<%$Resources:ListViewHeaders, BuyBack %>"
                                                        CommandArgument="BuyBack" ToolTip="<%$Resources:ToolTips, BuyBack %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonWholesaleBuyer" runat="server" Text="<%$Resources:ListViewHeaders, WholeSale %>"
                                                        CommandArgument="WholeSale" ToolTip="<%$Resources:ToolTips, WholeSale %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonWreckBuyer" runat="server" Text="<%$Resources:ListViewHeaders, Wreck %>"
                                                        CommandArgument="Wreck" ToolTip="<%$Resources:ToolTips, Wreck %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonEmail" runat="server" Text="<%$Resources:ListViewHeaders, Email %>"
                                                        CommandArgument="Email" ToolTip="<%$Resources:ToolTips, Email %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                </th>
                                                <th>
                                                </th>
                                                <th>
                                                </th>
                                                <th>
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr id="PlaceholderDetailsBuyer" runat="server" />
                                        </tbody>
                                    </table>
                                </LayoutTemplate>
                                <ItemTemplate>
                                    <tr id="rowListViewDetailsBuyer" runat="server">
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("BuyerCode")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("BuyerName")))%>
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
                                        <td style="width:300px;">
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Email")))%>
                                        </td>
                                        <td>
                                            <cc:ImageButtonListViewDisplay ID="ImageButtonEditBuyer" runat="server" />
                                        </td>
                                        <td>
                                            <cc:ImageButtonListViewExcel ID="ImageButtonExportExcel" runat="server" />
                                        </td>
                                        <td>
                                            <cc:ImageButtonListViewPDF ID="ImageButtonExportPDF" runat="server" />
                                        </td>
                                        <td>
                                            <cc:ImageButtonListViewEmail ID="ImageButtonSendEmail" runat="server" />
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
