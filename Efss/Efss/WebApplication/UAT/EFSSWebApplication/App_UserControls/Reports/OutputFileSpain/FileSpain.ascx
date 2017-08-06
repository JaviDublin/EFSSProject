<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FileSpain.ascx.cs" Inherits="APP.App_UserControls.Reports.OutputFileSpain.FileSpain" %>

<asp:UpdatePanel runat="server" ID="UpdatePanelTextSpain" UpdateMode="Conditional"
    ChildrenAsTriggers="false">
    <ContentTemplate>
        <table width="100%">
            <tr>
                <td align="left">
                    <asp:Label runat="server" ID="LabelTaxFileTitle" Text="Spanish Tax File" CssClass="LabelForm"
                        Font-Underline="true"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" class="tableFilterHeader">
                    <table>
                        <tr>
                            <td>
                                <uc:UCButtonCommand runat="server" ID="ButtonCommandNRC" CausesValidation="true"
                                    ButtonCommandName="ExportFile" ButtonImageUrl="~/App_Images/page_add.png" OnCommand="OnCommand"
                                    ButtonText="Export Text File" />
                            </td>
                            <td>
                                <uc:UCButtonCommand runat="server" ID="ButtonCommandFilter" CausesValidation="true"
                                    ButtonCommandName="Filter" ButtonImageUrl="~/App_Images/magnifier.png" OnCommand="OnCommand"
                                    ButtonText="Search" />
                            </td>
                            <td>
                                <asp:Image runat="server" ID="ImageSeparator" ImageUrl="~/App_Styles/Images/menu-bg.jpg" />
                            </td>
                            <td>
                                <asp:LinkButton runat="server" ID="LinkLaCaixa" CssClass="linkButton-Command"></asp:LinkButton>
                            </td>
                            <td>
                                <asp:LinkButton runat="server" ID="LinkAgencia" CssClass="linkButton-Command"></asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="left" class="contentboxheader">
                    <asp:Label runat="server" ID="LabelHeaderFilters" Text="Filters" CssClass="LabelForm2"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" class="contentboxForm">
                    <table>
                        <tr>
                            <td align="left" style="width:120px;">
                                File Date
                            </td>
                            <td align="left">
                                <cc:DateTextBox runat="server" ID="txtReportFileDate" CssClass="TextBoxForm" Width="100px"></cc:DateTextBox>
                                <asp:ImageButton runat="server" ID="imgreportfiledate" ImageUrl="~/App_Images/calendar.png"
                                    ImageAlign="AbsBottom" />
                                <asp:CalendarExtender runat="server" ID="dtRDD" TargetControlID="txtReportFileDate"
                                    Format="dd/MM/yyyy" PopupButtonID="imgreportfiledate" Enabled="true" CssClass="calendarClass">
                                </asp:CalendarExtender>
                            </td>
                            <td align="left">
                            </td>
                            <td align="left">
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width:120px;">
                                Sale Number From
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxInvoiceFrom" Width="100px" CssClass="TextBoxForm"></asp:TextBox>
                            </td>
                            <td align="left">
                                To
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxInvoiceTo" Width="100px" CssClass="TextBoxForm"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width:120px;">
                                Mileage
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="DropDownListMileage" CssClass="dropdownForm"
                                    Width="100px">
                                    <asp:ListItem Value="1" Text="ALL"></asp:ListItem>
                                    <asp:ListItem Value="2" Text="< 6000"></asp:ListItem>
                                    <asp:ListItem Value="3" Text=">= 6000"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td align="left">
                                Months
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="DropDownListMonths" CssClass="dropdownForm"
                                    Width="100px">
                                    <asp:ListItem Value="1" Text="ALL"></asp:ListItem>
                                    <asp:ListItem Value="2" Text="<= 6 Months"></asp:ListItem>
                                    <asp:ListItem Value="3" Text=">  6 Months"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width:120px;">
                                Tax Type
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="DropDownListInvoiceType" CssClass="dropdownForm"
                                    Width="100px">
                                    <asp:ListItem Value="1" Text="PAY TAX"></asp:ListItem>
                                    <asp:ListItem Value="2" Text="NO TAX"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td align="left">
                                Buyer
                            </td>
                            <td align="left">
                                 <asp:DropDownList runat="server" ID="DropDownListBuyers" CssClass="dropdownForm"
                                    Width="250px" AppendDataBoundItems="true">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width:120px;">
                                File Type
                            </td>
                            <td align="left">
                               <asp:DropDownList runat="server" ID="DropDownListFileType" CssClass="dropdownForm"
                                    Width="100px">
                                    <asp:ListItem Text="NRC BANK" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="AEAT" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="NRC" Value="3"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td align="left">
                            </td>
                            <td align="left">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="left" class="contentboxheader">
                    <asp:Label runat="server" ID="LabelHeaderSerial" Text="File Information" CssClass="LabelForm2"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:UpdatePanel runat="server" ID="UpdatePanelListView" UpdateMode="Conditional"
                        ChildrenAsTriggers="false">
                        <ContentTemplate>
                            <asp:PlaceHolder ID="PlaceHolderData" runat="server">
                                <%-- Resizable Container --%>
                                <div id="ResizableListView" class="ui-widget-content">
                                    <rad:ListView ID="ListViewTaxFile" runat="server" ItemPlaceholderID="PlaceHolderDetails"
                                        LayoutTableID="tableTaxFile" OnSorting="ListView_Sorting" ItemTemplateRow="rowListViewDetails"
                                        DataKeyNames="RowId" LayoutTableClass="listviewtable" LayoutTableDefaultHeight="350"
                                        LayoutTableTheme="rad__listview-table" ResizableControl="ResizableListView">
                                        <LayoutTemplate>
                                            <table cellpadding="0" cellspacing="0" class="listviewtable" id="tableTaxFile" runat="server"
                                                clientidmode="Static">
                                                <thead>
                                                    <tr>
                                                        <th>
                                                            <rad:ListViewHeader ID="LinkButtonSerial" runat="server" Text="<%$Resources:ListViewHeaders, Serial %>"
                                                                CommandArgument="Serial" ToolTip="<%$Resources:ToolTips, Serial%>"></rad:ListViewHeader>
                                                        </th>
                                                        <th>
                                                            <rad:ListViewHeader ID="LinkButtonPlate" runat="server" Text="<%$Resources:ListViewHeaders, Plate%>"
                                                                CommandArgument="Plate" ToolTip="<%$Resources:ToolTips, Plate%>"></rad:ListViewHeader>
                                                        </th>
                                                        <th>
                                                            <rad:ListViewHeader ID="LinkButtonInvoiceNumber" runat="server" Text="<%$Resources:ListViewHeaders, InvoiceNumber%>"
                                                                CommandArgument="InvoiceNumber" ToolTip="<%$Resources:ToolTips, InvoiceNumber%>"></rad:ListViewHeader>
                                                        </th>
                                                        <th>
                                                            <rad:ListViewHeader ID="ListViewSaleDocumentNumber" runat="server" Text="<%$Resources:ListViewHeaders, SaleDocumentNumber%>"
                                                                CommandArgument="SaleDocumentNumber" ToolTip="<%$Resources:ToolTips, SaleDocumentNumber%>"></rad:ListViewHeader>
                                                        </th>
                                                        <th>
                                                            <rad:ListViewHeader ID="ListViewMileage" runat="server" Text="<%$Resources:ListViewHeaders, Mileage%>"
                                                                CommandArgument="Mileage" ToolTip="<%$Resources:ToolTips, Mileage%>"></rad:ListViewHeader>
                                                        </th>
                                                        <th>
                                                            <rad:ListViewHeader ID="ListViewMSODate" runat="server" Text="<%$Resources:ListViewHeaders, ITVSerial%>"
                                                                CommandArgument="ITVSerial" ToolTip="<%$Resources:ToolTips, ITVSerial%>"></rad:ListViewHeader>
                                                        </th>
                                                        <th>
                                                            <rad:ListViewHeader ID="LinkButtonManufacturerName" runat="server" Text="<%$Resources:ListViewHeaders, ManufacturerName%>"
                                                                CommandArgument="ManufacturerName" ToolTip="<%$Resources:ToolTips, ManufacturerName%>"></rad:ListViewHeader>
                                                        </th>
                                                        <th>
                                                            <rad:ListViewHeader ID="LinkButtonRegTaxAmount" runat="server" Text="<%$Resources:ListViewHeaders, RegTaxAmount%>"
                                                                CommandArgument="RegTaxAmount" ToolTip="<%$Resources:ToolTips, RegTaxAmount%>"></rad:ListViewHeader>
                                                        </th>
                                                        <th>
                                                            <rad:ListViewHeader ID="LinkButtonNrcDate" runat="server" Text="<%$Resources:ListViewHeaders, NrcDate%>"
                                                                CommandArgument="NrcDate" ToolTip="<%$Resources:ToolTips, NrcDate%>"></rad:ListViewHeader>
                                                        </th>
                                                        <th>
                                                            <rad:ListViewHeader ID="ListViewProcessed" runat="server" Text="<%$Resources:ListViewHeaders, Processed%>"
                                                                CommandArgument="Processed" ToolTip="<%$Resources:ToolTips, Processed%>"></rad:ListViewHeader>
                                                        </th>
                                                        <th>
                                                            <rad:ListViewHeader ID="ListViewTaxDate" runat="server" Text="<%$Resources:ListViewHeaders, FileDate%>"
                                                                CommandArgument="FileDate" ToolTip="<%$Resources:ToolTips, FileDate%>"></rad:ListViewHeader>
                                                        </th>
                                                         <th>
                                                            <rad:ListViewHeader ID="ListViewHeader1" runat="server" Text="<%$Resources:ListViewHeaders, IsCorrect%>"
                                                                CommandArgument="IsCorrect" ToolTip="<%$Resources:ToolTips, IsCorrect%>"></rad:ListViewHeader>
                                                        </th>

                                                         <th>
                                                            <rad:ListViewHeader ID="ListViewHeader2" runat="server" Text="<%$Resources:ListViewHeaders, IsExported%>"
                                                                CommandArgument="IsExported" ToolTip="<%$Resources:ToolTips, IsExported%>"></rad:ListViewHeader>
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
                                                <td style="text-align: center;">
                                                    <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Serial")))%>
                                                </td>
                                                <td style="text-align: center;">
                                                    <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Plate")))%>
                                                </td>
                                                <td style="text-align: center;">
                                                    <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("InvoiceNumber")))%>
                                                </td>
                                                <td style="text-align: center;">
                                                    <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("SaleDocumentNumber")))%>
                                                </td>
                                                <td style="text-align: center;">
                                                    <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Mileage")))%>
                                                </td>
                                                <td style="text-align: center;">
                                                    <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("ITVSerial")))%>
                                                </td>
                                                <td style="text-align: center;">
                                                    <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("ManufacturerName")))%>
                                                </td>
                                                <td style="text-align: center;">
                                                    <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("RegTaxAmount")))%>
                                                </td>
                                                <td style="text-align: center;">
                                                    <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("NrcDate")))%>
                                                </td>
                                                <td style="text-align: center;">
                                                    <asp:Image ID="ImageNE" runat="server" ImageUrl='<%#Eval("Processed") %>' />
                                                </td>
                                                <td style="text-align: center;">
                                                    <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("FileDate")))%>
                                                </td>
                                                 <td style="text-align: center;">
                                                    <asp:Image ID="Image1" runat="server" ImageUrl='<%#Eval("IsCorrect") %>' />
                                                </td>
                                                <td style="text-align: center;">
                                                    <asp:Image ID="Image2" runat="server" ImageUrl='<%#Eval("IsExported") %>' />
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
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </ContentTemplate>
    <Triggers>
        <asp:PostBackTrigger ControlID="ButtonCommandNRC" />
    </Triggers>
</asp:UpdatePanel>

