<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="InvoicesForm.ascx.cs" Inherits="APP.App_UserControls.Payables.InvoicesForm" %>
<asp:UpdatePanel runat="server" ID="UpdatePanelForm" UpdateMode="Conditional" ChildrenAsTriggers="false">
    <ContentTemplate>
        <table width="100%">
            <tr>
                <td align="left">
                    <asp:Label runat="server" ID="LabelManualInvoicesTitle" Text="Manual Invoices" CssClass="LabelForm"
                        Font-Underline="true"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" class="tableFilterHeader">
                    <table>
                        <tr>
                            <%-- <td>
                                <a href="file://hescfs05/Finance/Financial%20Operations/Fleet%20Accounting/Downloads/Manual%20Invoices/">
                                    Open Folder</a>
                            </td>
                            <td>
                                <uc:UCButtonCommand runat="server" ID="ButtonCommandImport" CausesValidation="true"
                                    ButtonToolTip="Import Excel File" ButtonCommandName="Import" ButtonImageUrl="~/App_Images/accept.png"
                                    OnCommand="OnCommand" ButtonText="Import Excel File" />
                            </td>--%>
                            <td>
                                <uc:UCButtonCommand runat="server" ID="ButtonCommandSave" CausesValidation="true"
                                    ButtonToolTip="Save" ButtonCommandName="Save" ButtonImageUrl="~/App_Images/SaveHS.png"
                                    OnCommand="OnCommand" ButtonText="Save" />
                            </td>
                            <td>
                                <asp:Image runat="server" ID="ImageSeparator" ImageUrl="~/App_Styles/Images/menu-bg.jpg" />
                            </td>
                            <td>
                                <uc:UCButtonCommand runat="server" ID="ButtonCommandExport" CausesValidation="false"
                                    ButtonToolTip="Export To Excel" ButtonCommandName="Export" ButtonImageUrl="~/App_Images/page_excel.png"
                                    OnCommand="OnCommand" ButtonText="Export To Excel" />
                            </td>
                            <td>
                                <uc:UCButtonCommand runat="server" ID="UCButtonCommandExportPDF" CausesValidation="false"
                                    ButtonToolTip="Export To PDF" ButtonCommandName="ExportPDF" ButtonImageUrl="~/App_Images/page_white_acrobat.png"
                                    OnCommand="OnCommand" ButtonText="Export To PDF" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="left" class="contentboxheader">
                    <asp:Label runat="server" ID="LabelHeaderInvoiceDetails" Text="Invoice Details" CssClass="LabelForm2"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" class="contentboxForm">
                    <table>
                        <tr>
                            <td align="left" style="width: 120px;">
                                Country
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="DropDownListCountries" OnSelectedIndexChanged="DropDownListCountries_SelectedIndexChanged"
                                    AutoPostBack="True" CssClass="dropdownForm" Width="250px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 120px;">
                                Company
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="DropDownListCompanies" AutoPostBack="True" CssClass="dropdownForm"
                                    Width="250px" OnSelectedIndexChanged="DropDownListCompanies_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 120px;">
                                Document Type
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="DropDownListDocumentType" AutoPostBack="True"
                                    CssClass="dropdownForm">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 120px;">
                                Invoice Type
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="DropDownListInvoiceType" AutoPostBack="True"
                                    CssClass="dropdownForm">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 120px;">
                                Invoice Date
                            </td>
                            <td align="left">
                                <cc:DateTextBox runat="server" ID="TextBoxDatePicker" MaxLength="10" Wrap="false"
                                    CssClass="TextBoxForm" Width="100px"></cc:DateTextBox>
                                <asp:ImageButton runat="server" ID="imgcalendar" ImageUrl="~/App_Images/calendar.png"
                                    ImageAlign="AbsBottom" />
                                <asp:CalendarExtender runat="server" ID="dtPicker" TargetControlID="TextBoxDatePicker"
                                    Format="dd/MM/yyyy" PopupButtonID="imgcalendar" Enabled="true" CssClass="calendarClass">
                                </asp:CalendarExtender>
                                <asp:CustomValidator ID="ValidateDate" runat="server" ControlToValidate="TextBoxDatePicker"
                                    ValidateEmptyText="true" Display="Dynamic" ToolTip="<%$Resources:ToolTips, DateSelect %>"></asp:CustomValidator>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="left" class="contentboxheader">
                    <asp:Label runat="server" ID="LabelHeaderBillingDetails" Text="Billing Details" CssClass="LabelForm2"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" class="contentboxForm">
                    <table>
                        <tr>
                            <td align="left" style="width: 120px;">
                                Vendor Name
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="DropDownListBuyers" CssClass="dropdownForm"
                                    Width="300px" AutoPostBack="True" OnSelectedIndexChanged="DropDownListBuyers_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="DropDownListManufacturerCode" CssClass="dropdownForm"
                                    Width="50px" AutoPostBack="true" OnSelectedIndexChanged="DropDownListManufacturerCode_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="DropDownListAddress" CssClass="dropdownForm"
                                    Width="300px" AutoPostBack="true">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 120px;">
                                Tax Code
                            </td>
                            <td align="left" colspan="3">
                                <asp:DropDownList runat="server" ID="DropDownListTaxCode" CssClass="dropdownForm"
                                    AutoPostBack="True">
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="left" class="contentboxheader">
                    <asp:Label runat="server" ID="Label1" Text="Invoice  Content" CssClass="LabelForm2"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" class="contentboxForm">
                    <table>
                        <tr>
                            <td align="left" style="width: 120px;">
                                Invoice Text
                            </td>
                            <td align="left" colspan="4">
                                <asp:TextBox runat="server" ID="TextBoxMessage" CssClass="TextBoxForm" Width="487px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" style="width: 120px;">
                                Invoice Serials
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxSerials" CssClass="TextBoxForm" Width="180px"
                                    TextMode="MultiLine" Wrap="true" Height="150px"></asp:TextBox>
                            </td>
                            <td style="width: 60px;">
                            </td>
                            <td align="left" valign="top">
                                Amounts
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxAmounts" CssClass="TextBoxForm" Width="180px"
                                    TextMode="MultiLine" Wrap="true" Height="150px"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="left" class="contentboxheader">
                    <asp:Label runat="server" ID="LabelHeaderSerial" Text="Serials Information" CssClass="LabelForm2"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:UpdatePanel runat="server" ID="UpdatePanelListView" UpdateMode="Conditional"
                        ChildrenAsTriggers="false">
                        <ContentTemplate>
                            <asp:PlaceHolder ID="PlaceHolderData" runat="server" Visible="false">
                                <%-- Resizable Container --%>
                                <div id="ResizableListView" class="ui-widget-content">
                                    <rad:ListView ID="ListViewSerialsOverView" runat="server" ItemPlaceholderID="PlaceHolderDetails"
                                        LayoutTableID="tableSerialsOverview" OnSorting="ListView_Sorting" ItemTemplateRow="rowListViewDetails"
                                        DataKeyNames="RowId" LayoutTableClass="listviewtable" LayoutTableDefaultHeight="350"
                                        LayoutTableTheme="rad__listview-table" ResizableControl="ResizableListView">
                                        <LayoutTemplate>
                                            <table cellpadding="0" cellspacing="0" class="listviewtable" id="tableSerialsOverview"
                                                runat="server" clientidmode="Static">
                                                <thead>
                                                    <tr>
                                                        <th>
                                                            <rad:ListViewHeader ID="LinkButtonCompanyCode" runat="server" Text="<%$Resources:ListViewHeaders, CompanyCode %>"
                                                                CommandArgument="CompanyCode" ToolTip="<%$Resources:ToolTips, CompanyCode%>"></rad:ListViewHeader>
                                                        </th>
                                                        <th>
                                                            <rad:ListViewHeader ID="LinkButtonInvoiceType" runat="server" Text="<%$Resources:ListViewHeaders, InvoiceType%>"
                                                                CommandArgument="InvoiceType" ToolTip="<%$Resources:ToolTips, InvoiceType%>"></rad:ListViewHeader>
                                                        </th>
                                                        <th>
                                                            <rad:ListViewHeader ID="LinkButtonSerial" runat="server" Text="<%$Resources:ListViewHeaders, Serial %>"
                                                                CommandArgument="Serial" ToolTip="<%$Resources:ToolTips, Serial%>"></rad:ListViewHeader>
                                                        </th>
                                                        <th>
                                                            <rad:ListViewHeader ID="LinkButtonAmount" runat="server" Text="<%$Resources:ListViewHeaders, Amount%>"
                                                                CommandArgument="Amount" ToolTip="<%$Resources:ToolTips,InvoiceNumber %>"></rad:ListViewHeader>
                                                        </th>
                                                        <th>
                                                            <rad:ListViewHeader ID="LinkButtonInvoiceDate" runat="server" Text="<%$Resources:ListViewHeaders, InvoiceDate %>"
                                                                CommandArgument="InvoiceDate" ToolTip="<%$Resources:ToolTips,InvoiceDate %>"></rad:ListViewHeader>
                                                        </th>
                                                        <th>
                                                            <rad:ListViewHeader ID="LinkButtonBuyerName" runat="server" Text="<%$Resources:ListViewHeaders, BuyerName %>"
                                                                CommandArgument="BuyerName" ToolTip="<%$Resources:ToolTips,BuyerName %>"></rad:ListViewHeader>
                                                        </th>
                                                        <th>
                                                            <rad:ListViewHeader ID="ListViewManufacturerName" runat="server" Text="<%$Resources:ListViewHeaders, ManufacturerName %>"
                                                                CommandArgument="ManufacturerName" ToolTip="<%$Resources:ToolTips,ManufacturerName %>"></rad:ListViewHeader>
                                                        </th>
                                                        <th>
                                                            <rad:ListViewHeader ID="LinkButtonInvoiceNumber" runat="server" Text="<%$Resources:ListViewHeaders, InvoiceNumber%>"
                                                                CommandArgument="InvoiceNumber" ToolTip="<%$Resources:ToolTips,InvoiceNumber %>"></rad:ListViewHeader>
                                                        </th>
                                                        <%--   <th>
                                                            <rad:ListViewHeader ID="LinkButtonIsValid" runat="server" Text="<%$Resources:ListViewHeaders, IsValid%>"
                                                                CommandArgument="IsValid" ToolTip="<%$Resources:ToolTips,IsValid %>"></rad:ListViewHeader>
                                                        </th>
                                                        <th>
                                                            <rad:ListViewHeader ID="LinkButtonIsDuplicate" runat="server" Text="<%$Resources:ListViewHeaders, IsDuplicate%>"
                                                                CommandArgument="IsDuplicate" ToolTip="<%$Resources:ToolTips,IsDuplicate %>"></rad:ListViewHeader>
                                                        </th>--%>
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
                                                    <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("InvoiceType")))%>
                                                </td>
                                                <td>
                                                    <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Serial")))%>
                                                </td>
                                                <td>
                                                    <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Amount")))%>
                                                </td>
                                                <td>
                                                    <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("InvoiceDate")))%>
                                                </td>
                                                <td>
                                                    <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("BuyerName")))%>
                                                </td>
                                                <td>
                                                    <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("ManufacturerName")))%>
                                                </td>
                                                <td>
                                                    <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("InvoiceNumber")))%>
                                                </td>
                                                <%--  <td style="text-align: center;">
                                                    <asp:Image ID="ImageisValid" runat="server" ImageUrl='<%#Eval("IsValid") %>' />
                                                </td>
                                                <td style="text-align: center;">
                                                    <asp:Image ID="ImageIsDuplicate" runat="server" ImageUrl='<%#Eval("IsDuplicate") %>' />
                                                </td>--%>
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
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </ContentTemplate>
    <Triggers>
        <asp:PostBackTrigger ControlID="ButtonCommandExport" />
        <asp:PostBackTrigger ControlID="UCButtonCommandExportPDF" />
    </Triggers>
</asp:UpdatePanel>
