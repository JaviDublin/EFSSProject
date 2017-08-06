<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SettingsListViewUsers.ascx.cs" Inherits="APP.App_UserControls.Settings.ListViews.Users.SettingsListViewUsers" %>
<asp:UpdatePanel ID="UpdatePanelListView" runat="server" ChildrenAsTriggers="false"
    UpdateMode="Conditional">
    <ContentTemplate>
        <table width="100%">
            <tr>
                <td align="left">
                    <asp:Label runat="server" ID="LabelUsersTitle" Text="Users" CssClass="LabelForm"
                        Font-Underline="true"></asp:Label>
                </td>
            </tr>
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
                                Racf Id
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxRacfId" CssClass="TextBoxFormDate" Width="80px"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="left" class="contentboxheader">
                    <asp:Label runat="server" ID="LabelHeaderDetails" Text="Users Information" CssClass="LabelForm2"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" class="contentboxForm">
                    <%-- Data --%>
                    <asp:PlaceHolder ID="PlaceHolderData" runat="server">
                        <%-- Resizable Container --%>
                        <div id="ResizableListView" class="ui-widget-content">
                            <rad:ListView ID="ListViewUsersOverview" runat="server" ItemPlaceholderID="PlaceHolderDetails"
                                OnItemCommand="ListView_ItemCommand" LayoutTableID="tableUsersOverview" OnSorting="ListView_Sorting"
                                ItemTemplateRow="rowListViewDetails" DataKeyNames="UserId" LayoutTableClass="listviewtable"
                                LayoutTableDefaultHeight="350" LayoutTableTheme="rad__listview-table" ResizableControl="ResizableListView">
                                <LayoutTemplate>
                                    <table cellpadding="0" cellspacing="0" class="listviewtable" id="tableUsersOverview"
                                        runat="server" clientidmode="Static">
                                        <thead>
                                            <tr>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonRacfid" runat="server" Text="<%$Resources:ListViewHeaders, Racfid %>"
                                                        CommandArgument="Racfid" ToolTip="<%$Resources:ToolTips, Racfid%>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonFirstname" runat="server" Text="<%$Resources:ListViewHeaders, Firstname%>"
                                                        CommandArgument="Firstname" ToolTip="<%$Resources:ToolTips, Firstname%>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonSurname" runat="server" Text="<%$Resources:ListViewHeaders, Surname %>"
                                                        CommandArgument="Surname" ToolTip="<%$Resources:ToolTips,Surname %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonEmail" runat="server" Text="<%$Resources:ListViewHeaders, Email%>"
                                                        CommandArgument="Email" ToolTip="<%$Resources:ToolTips,Email %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonLastLoggedIn" runat="server" Text="<%$Resources:ListViewHeaders, LastLoggedIn %>"
                                                        CommandArgument="LastLoggedIn" ToolTip="<%$Resources:ToolTips,LastLoggedIn %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonLastActivity" runat="server" Text="<%$Resources:ListViewHeaders, LastActivity%>"
                                                        CommandArgument="LastActivity" ToolTip="<%$Resources:ToolTips,LastActivity %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonApproved" runat="server" Text="<%$Resources:ListViewHeaders, Approved %>"
                                                        CommandArgument="Approved" ToolTip="<%$Resources:ToolTips, Approved %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonLockedOut" runat="server" Text="<%$Resources:ListViewHeaders, LockedOut %>"
                                                        CommandArgument="LockedOut" ToolTip="<%$Resources:ToolTips, LockedOut %>"></rad:ListViewHeader>
                                                </th>
                                                <th>
                                                    <rad:ListViewHeader ID="LinkButtonIsDeleted" runat="server" Text="<%$Resources:ListViewHeaders, IsDeleted%>"
                                                        CommandArgument="IsDeleted" ToolTip="<%$Resources:ToolTips, IsDeleted%>"></rad:ListViewHeader>
                                                </th>
                                                <th style="width: 25px;">
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
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Racfid")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Firstname"))) %>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Surname"))) %>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("Email"))) %>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("LastLoggedIn")))%>
                                        </td>
                                        <td>
                                            <%# HttpUtility.HtmlEncode(Convert.ToString(Eval("LastActivity")))%>
                                        </td>
                                        <td style="text-align: center;">
                                            <asp:Image ID="ImageApproved" runat="server" ImageUrl='<%#Eval("ApprovedImageUrl") %>' />
                                        </td>
                                        <td style="text-align: center;">
                                            <asp:Image ID="ImageLockedOut" runat="server" ImageUrl='<%#Eval("LockedOutImageUrl") %>' />
                                        </td>
                                        <td style="text-align: center;">
                                            <asp:Image ID="ImageIsDeleted" runat="server" ImageUrl='<%#Eval("IsDeletedImageUrl") %>' />
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
