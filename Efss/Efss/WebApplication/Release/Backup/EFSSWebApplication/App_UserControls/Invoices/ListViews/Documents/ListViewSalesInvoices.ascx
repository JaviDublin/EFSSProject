<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ListViewSalesInvoices.ascx.cs"
    Inherits="APP.App_UserControls.Invoices.ListViews.Documents.ListViewSalesInvoices" %>
<asp:UpdatePanel runat="server" ID="UpdatePanelListViewInvoices" UpdateMode="Conditional"
    ChildrenAsTriggers="false">
    <ContentTemplate>
        <table width="100%">
            <tr>
                <td align="left" class="contentboxheader">
                    <asp:Label runat="server" ID="Label4" Text="Invoices Information" CssClass="LabelForm2"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" class="contentboxForm">
                    <asp:PlaceHolder ID="PlaceHolderData" runat="server">
                        <%-- Resizable Container --%>
                        <div id="ResizableListView" class="ui-widget-content">
                            <rad:ListView ID="ListViewInvoicesOverView" runat="server" ItemPlaceholderID="PlaceHolderDetailsInvoices"
                                OnItemCommand="ListViewInvoicesOverview_ItemCommand" LayoutTableID="tableInvoicesOverview"
                                OnSorting="ListViewInvoicesOverview_Sorting" ItemTemplateRow="rowListViewDetailsInvoices"
                                DataKeyNames="DocItemId" LayoutTableClass="listviewtable" LayoutTableDefaultHeight="350"
                                LayoutTableTheme="rad__listview-table" ResizableControl="ResizableListView">
                                <LayoutTemplate>
                                    <table cellpadding="0" cellspacing="0" class="listviewtable" id="tableInvoicesOverview"
                                        runat="server" clientidmode="Static">
                                        <thead>
                                            <tr>
                                                <th style="width: 60px;">
                                                    <rad:ListViewHeader ID="LinkButtonCompanyCode" runat="server" Text="<%$Resources:ListViewHeaders, CompanyCode %>"
                                                        CommandArgument="CompanyCode" ToolTip="<%$Resources:ToolTips, CompanyCode%>"></rad:ListViewHeader>
                                                </th>
                                                <th style="width: 150px;">
                                                    <rad:ListViewHeader ID="LinkButtonSerial" runat="server" Text="<%$Resources:ListViewHeaders, Serial %>"
                                                        CommandArgument="Serial" ToolTip="<%$Resources:ToolTips, Serial%>"></rad:ListViewHeader>
                                                </th>
                                                <th style="width: 80px;">
                                                    <rad:ListViewHeader ID="LinkButtonPlate" runat="server" Text="<%$Resources:ListViewHeaders, Plate%>"
                                                        CommandArgument="Plate" ToolTip="<%$Resources:ToolTips, Plate%>"></rad:ListViewHeader>
                                                </th>
                                                <th style="width: 80px;">
                                                    <rad:ListViewHeader ID="LinkButtonUnit" runat="server" Text="<%$Resources:ListViewHeaders, Unit %>"
                                                        CommandArgument="Unit" ToolTip="<%$Resources:ToolTips,Unit %>"></rad:ListViewHeader>
                                                </th>
                                                <th style="width: 80px;">
                                                    <rad:ListViewHeader ID="LinkButtonBuyerCode" runat="server" Text="<%$Resources:ListViewHeaders, BuyerCode %>"
                                                        CommandArgument="BuyerCode" ToolTip="<%$Resources:ToolTips,BuyerCode %>"></rad:ListViewHeader>
                                                </th>
                                                <th style="width: 80px;">
                                                    <rad:ListViewHeader ID="LinkButtonInvoiceNumber" runat="server" Text="<%$Resources:ListViewHeaders, InvoiceNumber%>"
                                                        CommandArgument="InvoiceNumber" ToolTip="<%$Resources:ToolTips,InvoiceNumber %>"></rad:ListViewHeader>
                                                </th>
                                                <th style="width: 80px;">
                                                    <rad:ListViewHeader ID="LinkButtonInvoiceDate" runat="server" Text="<%$Resources:ListViewHeaders, InvoiceDate %>"
                                                        CommandArgument="InvoiceDate" ToolTip="<%$Resources:ToolTips,InvoiceDate %>"></rad:ListViewHeader>
                                                </th>
                                                <th style="width: 80px;">
                                                    <rad:ListViewHeader ID="LinkButtonInvoiceTotal" runat="server" Text="<%$Resources:ListViewHeaders, InvoiceTotal %>"
                                                        CommandArgument="InvoiceTotal" ToolTip="<%$Resources:ToolTips,InvoiceTotal %>"></rad:ListViewHeader>
                                                </th>
                                                <th style="width: 80px;">
                                                    <rad:ListViewHeader ID="LinkButtonInvociceStatus" runat="server" Text="<%$Resources:ListViewHeaders, InvoiceStatus %>"
                                                        CommandArgument="InvoiceStatus" ToolTip="<%$Resources:ToolTips,InvoiceStatus %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                </th>
                                                <th>
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr id="PlaceHolderDetailsInvoices" runat="server" />
                                        </tbody>
                                    </table>
                                </LayoutTemplate>
                                <ItemTemplate>
                                    <tr id="rowListViewDetailsInvoices" runat="server">
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("CompanyCode")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Serial")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Plate")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Unit")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("BuyerCode")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("InvoiceNumber")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("InvoiceDate")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("InvoiceTotal")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("InvoiceStatus")))%>
                                        </td>
                                        <td style="width: 25px; text-align: center;">
                                            <cc:ImageButtonListViewPDF ID="ImageButtonExportPDFInvoice" runat="server" />
                                        </td>
                                        <td style="width: 25px; text-align: center;">
                                            <cc:ImageButtonListViewEmail ID="ImageButtonSendEmailInvoice" runat="server" />
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
