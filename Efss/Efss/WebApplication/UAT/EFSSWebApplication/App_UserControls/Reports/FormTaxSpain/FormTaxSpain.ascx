<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FormTaxSpain.ascx.cs" Inherits="APP.App_UserControls.Reports.FormTaxSpain.FormTaxSpain" %>
<asp:UpdatePanel runat="server" ID="UpdatePanelForm" UpdateMode="Conditional" ChildrenAsTriggers="false">
    <ContentTemplate>
        <table width="100%">
            <tr>
                <td align="left">
                    <asp:Label runat="server" ID="LabelSpanishFleetTitle" Text="Spanish Fleet" CssClass="LabelForm"
                        Font-Underline="true"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" class="tableFilterHeader">
                    <table>
                        <tr>
                            <td>
                                <uc:UCButtonCommand runat="server" ID="ButtonCommandFilter" CausesValidation="true"
                                    ButtonCommandName="Filter" ButtonImageUrl="~/App_Images/magnifier.png" OnCommand="OnCommand"
                                    ButtonText="Search" />
                            </td>
                            <td>
                                    <asp:Image runat="server" ID="ImageSeparator" ImageUrl="~/App_Styles/Images/menu-bg.jpg" />
                             </td>
                            <td align="left">
                                 Plate
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxPlate" CssClass="TextBoxForm" Width="80px"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
          
            <tr>
                <td align="left" class="contentboxheader">
                    <asp:Label runat="server" ID="LabelHeaderFleetInformation" Text="Fleet Information"
                        CssClass="LabelForm2"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" class="contentboxForm">
                    <asp:PlaceHolder ID="PlaceHolderData" runat="server">
                        <div id="ResizableListView" class="ui-widget-content">
                            <rad:ListView ID="ListViewFleetSP" runat="server" ItemPlaceholderID="PlaceHolderDetails"
                                LayoutTableID="tableFleetSP" OnSorting="ListView_Sorting" OnItemCommand="ListView_ItemCommand"
                                ItemTemplateRow="rowListViewDetails" DataKeyNames="RowId" LayoutTableClass="listviewtable"
                                LayoutTableDefaultHeight="350" LayoutTableTheme="rad__listview-table" ResizableControl="ResizableListView">
                                <LayoutTemplate>
                                    <table cellpadding="0" cellspacing="0" class="listviewtable" id="tableFleetSP" runat="server"
                                        clientidmode="Static">
                                        <thead>
                                            <tr>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonSerial" runat="server" Text="<%$Resources:ListViewHeaders, Serial %>"
                                                        CommandArgument="Serial" ToolTip="<%$Resources:ToolTips, Serial%>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="ListViewHeaderUnit" runat="server" Text="<%$Resources:ListViewHeaders, Unit %>"
                                                        CommandArgument="Unit" ToolTip="<%$Resources:ToolTips, Serial%>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="ListViewHeader2" runat="server" Text="<%$Resources:ListViewHeaders, Plate %>"
                                                        CommandArgument="Plate" ToolTip="<%$Resources:ToolTips, Plate%>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="ListViewHeaderCO2" runat="server" Text="<%$Resources:ListViewHeaders, CO2 %>"
                                                        CommandArgument="CO2" ToolTip="<%$Resources:ToolTips, CO2%>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="ListViewHeaderITVSerial" runat="server" Text="<%$Resources:ListViewHeaders, ITVSerial %>"
                                                        CommandArgument="ITVSerial" ToolTip="<%$Resources:ToolTips, ITVSerial%>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="ListViewHeaderTaxCode" runat="server" Text="<%$Resources:ListViewHeaders, TaxCode %>"
                                                        CommandArgument="TaxCode" ToolTip="<%$Resources:ToolTips, TaxCode%>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="ListViewHeaderTaxPCT" runat="server" Text="<%$Resources:ListViewHeaders, TaxPCT %>"
                                                        CommandArgument="TaxPCT" ToolTip="<%$Resources:ToolTips, TaxPCT%>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="ListViewHeader1" runat="server" Text="<%$Resources:ListViewHeaders, VehicleCode %>"
                                                        CommandArgument="VehicleCode" ToolTip="<%$Resources:ToolTips, VehicleCode%>"></rad:ListViewHeader>
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
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Unit")))%>
                                        </td>
                                        <td style="text-align: center;">
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Plate")))%>
                                        </td>
                                        <td style="text-align: center;">
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("CO2")))%>
                                        </td>
                                        <td style="text-align: center;">
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("ITVSerial")))%>
                                        </td>
                                        <td style="text-align: center;">
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("TaxCode")))%>
                                        </td>
                                        <td style="text-align: center;">
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("TaxPCT")))%>
                                        </td>
                                        <td style="text-align: center;">
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("VehicleCode")))%>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </rad:ListView>
                            <rad:ListViewPager ID="ListViewPager" runat="server" OnPagerItemCommand="OnPager_Command"
                                DefaultPageSize="Ten" EditButtonVisible="false" DeleteButtonVisible="false" />
                        </div>
                    </asp:PlaceHolder>
                    <asp:PlaceHolder ID="PlaceHolderNoData" runat="server">
                        <uc:UCEmptyDataTemplate ID="UCEmptyData" runat="server" />
                    </asp:PlaceHolder>
                </td>
            </tr>
        </table>
    </ContentTemplate>
</asp:UpdatePanel>
