<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FleetDashboardForm.ascx.cs" Inherits="APP.App_UserControls.Reports.FleetDashboardForm" %>
<%-- Control Wrapper --%>
<div class="div-Application-Content">
    <asp:UpdatePanel ID="UpdatePanelListView" runat="server" ChildrenAsTriggers="false"
        UpdateMode="Conditional">
        <ContentTemplate>
            <table width="100%">
                <tr>
                    <td align="left">
                        <asp:Label runat="server" ID="LabelDashboardTitle" Text="Dashboard Report" CssClass="LabelForm"
                            Font-Underline="true"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="left" class="tableFilterHeader">
                        <table>
                            <tr>
                                <td>
                                    <uc:UCButtonCommand runat="server" ID="ButtonCommandExport" CausesValidation="false"
                                        ButtonToolTip="Export Report To Excel" ButtonCommandName="Export" ButtonImageUrl="~/App_Images/page_excel.png"
                                        OnCommand="OnCommand" ButtonText="Export Report" />
                                </td>
                                <td>
                                    <uc:UCButtonCommand runat="server" ID="ButtonCommandExportFile" CausesValidation="true"
                                        ButtonToolTip="Export Original File (to Excel)" ButtonCommandName="ExportFile"
                                        ButtonImageUrl="~/App_Images/page_go.png" OnCommand="OnCommand" ButtonText="Export Full File" />
                                </td>
                                <td>
                                    <uc:UCButtonCommand runat="server" ID="ButtonCommandSave" CausesValidation="true"
                                        ButtonToolTip="Save" ButtonCommandName="Save" ButtonImageUrl="~/App_Images/SaveHS.png"
                                        OnCommand="OnCommand" ButtonText="Save" />
                                </td>
                                <td>
                                    <uc:UCButtonCommand runat="server" ID="ButtonCommandFilter" CausesValidation="true"
                                        ButtonToolTip="Filter" ButtonCommandName="Filter" ButtonImageUrl="~/App_Images/accept.png"
                                        OnCommand="OnCommand" ButtonText="Filter" />
                                </td>
                                <td>
                                    <asp:Image runat="server" ID="ImageSeparator" ImageUrl="~/App_Styles/Images/menu-bg.jpg" />
                                </td>
                                <td align="left">
                                    Country
                                </td>
                                <td align="left">
                                    <asp:DropDownList runat="server" ID="DropDownListCountries" Width="150px" CssClass="dropdownForm" Font-Bold="true" Font-Size="11px">
                                    </asp:DropDownList>
                                </td>
                                <td align="left">
                                    Invoice Type
                                </td>
                                <td align="left">
                                    <asp:DropDownList runat="server" ID="DropDownListInvoiceType" Width="170px" CssClass="dropdownForm" Font-Bold="true" Font-Size="11px">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td align="left" class="contentboxheader">
                        <asp:Label runat="server" ID="LabelHeaderDashboardDetails" Text="Dashboard Details"
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
                                <rad:ListView runat="server" ID="ListViewDashboard" ItemPlaceholderID="PlaceHolderDetails"
                                    LayoutTableID="tableDashboardOverview" OnSorting="ListView_Sorting" ItemTemplateRow="rowListViewDetails"
                                    DataKeyNames="ManufacturerId" LayoutTableClass="listviewtable" LayoutTableDefaultHeight="350"
                                    LayoutTableTheme="rad__listview-table" ResizableControl="ResizableListView" OnItemDataBound="ListView_ItemDataBound">
                                    <LayoutTemplate>
                                        <table cellpadding="0" cellspacing="0" class="listviewtable" id="tableDashboardOverview"
                                            runat="server" clientidmode="Static">
                                            <thead>
                                                <tr>
                                                    <th>
                                                        <rad:ListViewHeader runat="server" ID="LinkButtonManufacturerName" Text="<%$Resources:ListViewHeaders, Manufacturer %>"
                                                            ToolTip="<%$Resources:ToolTips, Manufacturer%>" CommandArgument="ManufacturerName"></rad:ListViewHeader>
                                                    </th>
                                                    <th>
                                                        <rad:ListViewHeader runat="server" ID="LinkButtonCNK" Text="CNK" ToolTip="CNK Value"
                                                            CommandArgument="CNK"></rad:ListViewHeader>
                                                    </th>
                                                    <th>
                                                        <rad:ListViewHeader runat="server" ID="ListViewHeaderCurrent" Text="<%$Resources:ListViewHeaders, Current %>" ToolTip="<%$Resources:ToolTips, Current%>"
                                                            CommandArgument="Current"></rad:ListViewHeader>
                                                    </th>
                                                    <th>
                                                        <rad:ListViewHeader runat="server" ID="ListViewHeaderPayment" Text="<%$Resources:ListViewHeaders, No_Payment_Due %>"
                                                            ToolTip="<%$Resources:ToolTips, No_Payment_Due%>" CommandArgument="Payment"></rad:ListViewHeader>
                                                    </th>
                                                    <th>
                                                        <rad:ListViewHeader runat="server" ID="ListViewHeader07" Text="0-7" ToolTip="0-7"
                                                            CommandArgument="Age_0_7"></rad:ListViewHeader>
                                                    </th>
                                                    <th>
                                                        <rad:ListViewHeader runat="server" ID="ListViewHeader830" Text="8-30" ToolTip="8-30"
                                                            CommandArgument="Age_8_30"></rad:ListViewHeader>
                                                    </th>
                                                    <th>
                                                        <rad:ListViewHeader runat="server" ID="ListViewHeader3160" Text="31-60" ToolTip="31-60"
                                                            CommandArgument="Age_31_60"></rad:ListViewHeader>
                                                    </th>
                                                    <th>
                                                        <rad:ListViewHeader runat="server" ID="ListViewHeader6190" Text="61-90" ToolTip="61-90"
                                                            CommandArgument="Age_61_90"></rad:ListViewHeader>
                                                    </th>
                                                    <th>
                                                        <rad:ListViewHeader runat="server" ID="ListViewHeader91120" Text="91-120" ToolTip="91-120"
                                                            CommandArgument="Age_91_120"></rad:ListViewHeader>
                                                    </th>
                                                    <th>
                                                        <rad:ListViewHeader runat="server" ID="ListViewHeader121180" Text="121-180" ToolTip="121-180"
                                                            CommandArgument="Age_121_180"></rad:ListViewHeader>
                                                    </th>
                                                    <th>
                                                        <rad:ListViewHeader runat="server" ID="ListViewHeader181360" Text="181-360" ToolTip="181-360"
                                                            CommandArgument="Age_181_360"></rad:ListViewHeader>
                                                    </th>
                                                    <th>
                                                        <rad:ListViewHeader runat="server" ID="ListViewHeader360" Text="360+" ToolTip="360+"
                                                            CommandArgument="Age_360"></rad:ListViewHeader>
                                                    </th>
                                                    <th style="width: 40px;">
                                                        <rad:ListViewHeader runat="server" ID="ListViewHeaderNotes" Text="<%$Resources:ListViewHeaders, Notes %>" ToolTip="<%$Resources:ToolTips, Notes%>"
                                                            CommandArgument="Notes"></rad:ListViewHeader>
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
                                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("ManufacturerName")))%>
                                            </td>
                                            <td align="center">
                                                <asp:TextBox runat="server" ID="TextBoxCNK" Width="100px" Text='<%#Eval("CNK")%>'
                                                    CssClass="controls"></asp:TextBox>
                                            </td>
                                            <td>
                                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Current")))%>
                                            </td>
                                            <td>
                                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Payment")))%>
                                            </td>
                                            <td>
                                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Age_0_7")))%>
                                            </td>
                                            <td>
                                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Age_8_30")))%>
                                            </td>
                                            <td>
                                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Age_31_60")))%>
                                            </td>
                                            <td>
                                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Age_61_90")))%>
                                            </td>
                                            <td>
                                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Age_91_120")))%>
                                            </td>
                                            <td>
                                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Age_121_180")))%>
                                            </td>
                                            <td>
                                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Age_181_360")))%>
                                            </td>
                                            <td>
                                                <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Age_360")))%>
                                            </td>
                                            <td style="width:40px;">

                                               <div style="width:39px;">
                                                    <asp:Image ID="ImageHover" runat="server" ImageUrl="~/App_Images/listview-hover.gif" />
                                                
                                                <asp:PopupControlExtender ID="PopupControlExtenderAccounts" runat="server" TargetControlID="ImageHover"
                                                    PopupControlID="PanelHover" Position="Top" OffsetX="-250" OffsetY="0">
                                                </asp:PopupControlExtender>

                                              <%--  <asp:DragPanelExtender runat="server" ID="DragPanel" TargetControlID="PanelHover"
                                                    DragHandleID="PanelHover">
                                                </asp:DragPanelExtender>--%>
                                                
                                                <asp:Panel ID="PanelHover" runat="server" CssClass="panel-DynamicHover-Accounts">
                                                    <div class="div-ModalClose">
                                                        <asp:Image ID="ImageClose" runat="server" ImageUrl="~/App_Images/modal-close.gif" />
                                                    </div>
                                                    <asp:Panel ID="PanelDynamicContent" runat="server" CssClass="panel-HoverAccounts">
                                                        <asp:TextBox ID="TextBoxNotes" runat="server" TextMode="MultiLine" Text='<%#Eval("Notes")%>'
                                                            Width="250px" Height="50px" />
                                                    </asp:Panel>
                                                </asp:Panel>
                                               </div>

                                                
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
        <Triggers>
            <asp:PostBackTrigger ControlID="ButtonCommandExport" />
            <asp:PostBackTrigger ControlID="ButtonCommandExportFile" />
        </Triggers>
    </asp:UpdatePanel>
</div>
