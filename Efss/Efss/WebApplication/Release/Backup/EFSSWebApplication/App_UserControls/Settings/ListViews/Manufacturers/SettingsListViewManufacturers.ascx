<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SettingsListViewManufacturers.ascx.cs" Inherits="APP.App_UserControls.Settings.ListViews.Manufacturers.SettingsListViewManufacturers" %>
<asp:UpdatePanel ID="UpdatePanelListView" runat="server" ChildrenAsTriggers="false"
    UpdateMode="Conditional">
    <ContentTemplate>
        <table width="100%">
            <tr>
                <td align="left">
                    <asp:Label runat="server" ID="LabelManufacturersTitle" Text="Manufacturers" CssClass="LabelForm"
                        Font-Underline="true"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" class="contentboxheader">
                    <asp:Label runat="server" ID="LabelHeaderManufacturersInformation" Text="Manufacturers Information"
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
                            <rad:ListView ID="ListViewManufacturersOverview" runat="server" ItemPlaceholderID="PlaceHolderDetails"
                                OnItemCommand="ListView_ItemCommand" LayoutTableID="tableManufacturersOverview"
                                OnSorting="ListView_Sorting" ItemTemplateRow="rowListViewDetails" DataKeyNames="ManufacturerId"
                                LayoutTableClass="listviewtable" LayoutTableDefaultHeight="350" LayoutTableTheme="rad__listview-table"
                                ResizableControl="ResizableListView">
                                <LayoutTemplate>
                                    <table cellpadding="0" cellspacing="0" class="listviewtable" id="tableManufacturersOverview"
                                        runat="server" clientidmode="Static">
                                        <thead>
                                            <tr>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonManufacturerName" runat="server" Text="<%$Resources:ListViewHeaders, ManufacturerName %>"
                                                        CommandArgument="ManufacturerName" ToolTip="<%$Resources:ToolTips, ManufacturerName%>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonModelsCount" runat="server" Text="<%$Resources:ListViewHeaders, ModelsCount%>"
                                                        CommandArgument="ModelsCount" ToolTip="<%$Resources:ToolTips, ModelsCount%>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonIsBe" runat="server" Text="<%$Resources:ListViewHeaders, Belgium %>"
                                                        CommandArgument="IsBE" ToolTip="<%$Resources:ToolTips,Belgium %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonIsFR" runat="server" Text="<%$Resources:ListViewHeaders, France%>"
                                                        CommandArgument="IsFR" ToolTip="<%$Resources:ToolTips,France %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonIsGE" runat="server" Text="<%$Resources:ListViewHeaders, Germany %>"
                                                        CommandArgument="IsGE" ToolTip="<%$Resources:ToolTips,Germany %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonIsIT" runat="server" Text="<%$Resources:ListViewHeaders, Italy%>"
                                                        CommandArgument="IsIT" ToolTip="<%$Resources:ToolTips,Italy %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonIsLU" runat="server" Text="<%$Resources:ListViewHeaders, Luxembourg %>"
                                                        CommandArgument="IsLU" ToolTip="<%$Resources:ToolTips, Luxembourg %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonIsNE" runat="server" Text="<%$Resources:ListViewHeaders, Netherlands %>"
                                                        CommandArgument="IsNE" ToolTip="<%$Resources:ToolTips, Netherlands %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonIsSP" runat="server" Text="<%$Resources:ListViewHeaders, Spain%>"
                                                        CommandArgument="IsSP" ToolTip="<%$Resources:ToolTips, Spain%>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonIsSZ" runat="server" Text="<%$Resources:ListViewHeaders, Switzerland%>"
                                                        CommandArgument="IsSZ" ToolTip="<%$Resources:ToolTips, Switzerland%>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonIsUK" runat="server" Text="<%$Resources:ListViewHeaders, Uk%>"
                                                        CommandArgument="IsUK" ToolTip="<%$Resources:ToolTips, Uk%>"></rad:ListViewHeader>
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
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("ManufacturerName")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("ModelsCount"))) %>
                                        </td>
                                        <td style="text-align: center;">
                                            <asp:Image ID="ImageBE" runat="server" ImageUrl='<%#Eval("IsBE") %>' />
                                        </td>
                                        <td style="text-align: center;">
                                            <asp:Image ID="ImageFR" runat="server" ImageUrl='<%#Eval("IsFR") %>' />
                                        </td>
                                        <td style="text-align: center;">
                                            <asp:Image ID="ImageGE" runat="server" ImageUrl='<%#Eval("IsGE") %>' />
                                        </td>
                                        <td style="text-align: center;">
                                            <asp:Image ID="ImageIT" runat="server" ImageUrl='<%#Eval("IsIT") %>' />
                                        </td>
                                        <td style="text-align: center;">
                                            <asp:Image ID="ImageLU" runat="server" ImageUrl='<%#Eval("IsLU") %>' />
                                        </td>
                                        <td style="text-align: center;">
                                            <asp:Image ID="ImageNE" runat="server" ImageUrl='<%#Eval("IsNE") %>' />
                                        </td>
                                        <td style="text-align: center;">
                                            <asp:Image ID="ImageSP" runat="server" ImageUrl='<%#Eval("IsSP") %>' />
                                        </td>
                                        <td style="text-align: center;">
                                            <asp:Image ID="ImageSZ" runat="server" ImageUrl='<%#Eval("IsSZ") %>' />
                                        </td>
                                        <td style="text-align: center;">
                                            <asp:Image ID="ImageUK" runat="server" ImageUrl='<%#Eval("IsUK") %>' />
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
