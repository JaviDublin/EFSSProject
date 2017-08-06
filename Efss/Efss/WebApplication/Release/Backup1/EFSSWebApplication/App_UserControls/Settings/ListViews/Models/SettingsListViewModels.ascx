<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SettingsListViewModels.ascx.cs" Inherits="APP.App_UserControls.Settings.ListViews.Models.SettingsListViewModels" %>
<asp:UpdatePanel ID="UpdatePanelListView" runat="server" ChildrenAsTriggers="false"
    UpdateMode="Conditional">
    <ContentTemplate>
        <table width="100%">
            <tr>
                <td align="left">
                    <asp:Label runat="server" ID="LabelModelsTitle" Text="Models" CssClass="LabelForm"
                        Font-Underline="true"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" class="tableFilterHeader">
                    <table>
                        <tr>
                            <td>
                                <uc:UCButtonCommand runat="server" ID="ButtonCommandExport" CausesValidation="false"
                                    ButtonCommandName="Export" ButtonImageUrl="~/App_Images/page_excel.png" OnCommand="OnCommand"
                                    ButtonText="Export To Excel" />
                            </td>
                            <td>
                                <uc:UCButtonCommand runat="server" ID="ButtonCommandFilter" CausesValidation="true"
                                    ButtonCommandName="Filter" ButtonImageUrl="~/App_Images/accept.png" OnCommand="OnCommand"
                                    ButtonText="Filter" />
                            </td>
                            <td>
                                <asp:Image runat="server" ID="ImageSeparator" ImageUrl="~/App_Styles/Images/menu-bg.jpg" />
                            </td>
                            <td align="left">
                                Company
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="DropDownListCompanyCode" runat="server" DataSourceID="sdsCompanies"
                                    DataTextField="CompanyCode" DataValueField="CompanyId" AppendDataBoundItems="True"
                                    Width="250px" CssClass="dropdownForm" Font-Bold="True" Font-Size="11px">
                                    <asp:ListItem Text="ALL" Value="-1"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="sdsCompanies" runat="server" ConnectionString="<%$ ConnectionStrings:RAD.Properties.Settings.ApplicationDataBase %>"
                                    SelectCommand="SELECT [CompanyId], 
[CompanyCode] + '-' +
[CompanyName] as &quot;CompanyCode&quot; FROM [Dimension.Companies] ORDER BY [CountryId]"></asp:SqlDataSource>
                            </td>
                            <td align="left">
                                Model Year
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="DropDownListMModelYear" CssClass="dropdownForm"
                                    Width="70px" Font-Bold="True" Font-Size="11px" AppendDataBoundItems="True" DataSourceID="sdsModelYear"
                                    DataTextField="ModelYearLong" DataValueField="ModelYear">
                                    <asp:ListItem>ALL</asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource runat="server" ID="sdsModelYear" ConnectionString="<%$ ConnectionStrings:RAD.Properties.Settings.ApplicationDataBase %>"
                                    SelectCommand="select ModelYear ,
                                                                case when
                                                                CONVERT(INT,SUBSTRING(ModelYear,1,1)) &gt; 7 then '19' + ModelYear else
                                                                '20' + ModelYear end as &quot;ModelYearLong&quot;
                                                                from [Dimension.Models]
                                                                group by ModelYear
                                                                order by 
                                                                case when
                                                                CONVERT(INT,SUBSTRING(ModelYear,1,1)) &gt; 7 then '19' + ModelYear else
                                                                '20' + ModelYear end desc"></asp:SqlDataSource>
                            </td>
                            <td align="right" style="width:200px;">
                                <asp:Label runat="server" ID="LabelManufacturerInformation" Font-Bold="true" Font-Underline="true"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="left" class="contentboxheader">
                    <asp:Label runat="server" ID="LabelHeaderModelsInformation" Text="Models Information"
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
                            <rad:ListView ID="ListViewModelsOverview" runat="server" ItemPlaceholderID="PlaceHolderDetails"
                                LayoutTableID="tableModelsOverview" OnSorting="ListView_Sorting" ItemTemplateRow="rowListViewDetails"
                                DataKeyNames="ModelDetailId" LayoutTableClass="listviewtable" LayoutTableDefaultHeight="350"
                                LayoutTableTheme="rad__listview-table" ResizableControl="ResizableListView">
                                <LayoutTemplate>
                                    <table cellpadding="0" cellspacing="0" class="listviewtable" id="tableModelsOverview"
                                        runat="server" clientidmode="Static">
                                        <thead>
                                            <tr>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonCompanyCode" runat="server" Text="<%$Resources:ListViewHeaders, CompanyCode %>"
                                                        CommandArgument="CompanyCode" ToolTip="<%$Resources:ToolTips, CompanyCode%>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonModelCode" runat="server" Text="<%$Resources:ListViewHeaders, ModelCode%>"
                                                        CommandArgument="ModelCode" ToolTip="<%$Resources:ToolTips, ModelCode%>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonModelYear" runat="server" Text="<%$Resources:ListViewHeaders, ModelYear %>"
                                                        CommandArgument="ModelYear" ToolTip="<%$Resources:ToolTips,ModelYear %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonTasModelCode" runat="server" Text="<%$Resources:ListViewHeaders, TasModelCode%>"
                                                        CommandArgument="TasModelCode" ToolTip="<%$Resources:ToolTips,TasModelCode %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonModelGroup" runat="server" Text="<%$Resources:ListViewHeaders, ModelGroup %>"
                                                        CommandArgument="ModelGroup" ToolTip="<%$Resources:ToolTips,ModelGroup %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonManufacturerName" runat="server" Text="<%$Resources:ListViewHeaders, ManufacturerName%>"
                                                        CommandArgument="ManufacturerName" ToolTip="<%$Resources:ToolTips,ManufacturerName %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonModelDescription" runat="server" Text="<%$Resources:ListViewHeaders, ModelDescription %>"
                                                        CommandArgument="ModelDescription" ToolTip="<%$Resources:ToolTips, ModelDescription %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonRateClass" runat="server" Text="<%$Resources:ListViewHeaders, RateClass %>"
                                                        CommandArgument="RateClass" ToolTip="<%$Resources:ToolTips, RateClass %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonEngineSize" runat="server" Text="<%$Resources:ListViewHeaders, EngineSize%>"
                                                        CommandArgument="EngineSize" ToolTip="<%$Resources:ToolTips, EngineSize%>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonFuelType" runat="server" Text="<%$Resources:ListViewHeaders, FuelType%>"
                                                        CommandArgument="FuelType" ToolTip="<%$Resources:ToolTips, FuelType%>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonEstimatedCap" runat="server" Text="<%$Resources:ListViewHeaders, EstimatedCap%>"
                                                        CommandArgument="EstimatedCap" ToolTip="<%$Resources:ToolTips, EstimatedCap%>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonEstimatedDeprRate" runat="server" Text="<%$Resources:ListViewHeaders, EstimatedDeprRate%>"
                                                        CommandArgument="EstimatedDeprRate" ToolTip="<%$Resources:ToolTips, EstimatedDeprRate%>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonEstimatedVBAmtPeriod" runat="server" Text="<%$Resources:ListViewHeaders, EstimatedVBAmtPeriod%>"
                                                        CommandArgument="EstimatedVBAmtPeriod" ToolTip="<%$Resources:ToolTips, EstimatedVBAmtPeriod%>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonEstimatedVolBonus" runat="server" Text="<%$Resources:ListViewHeaders, EstimatedVolBonus%>"
                                                        CommandArgument="EstimatedVolBonus" ToolTip="<%$Resources:ToolTips, EstimatedVolBonus%>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonFastSpec" runat="server" Text="<%$Resources:ListViewHeaders, FastSpec%>"
                                                        CommandArgument="FastSpec" ToolTip="<%$Resources:ToolTips, FastSpec%>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonReceivableStoreDate" runat="server" Text="<%$Resources:ListViewHeaders, ReceivableStoreDate%>"
                                                        CommandArgument="ReceivableStoredDate" ToolTip="<%$Resources:ToolTips, ReceivableStoreDate%>"></rad:ListViewHeader>
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
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("ModelCode")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("ModelYear")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("TasModelCode")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("ModelGroup")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("ManufacturerName")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("ModelDescription")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("RateClass")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("EngineSize")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("FuelType")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("EstimatedCap")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("EstimatedDeprRate")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("EstimatedVBAmtPeriod")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("EstimatedVolBonus")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("FastSpec")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("ReceivableStoreDate")))%>
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
    </Triggers>
</asp:UpdatePanel>
