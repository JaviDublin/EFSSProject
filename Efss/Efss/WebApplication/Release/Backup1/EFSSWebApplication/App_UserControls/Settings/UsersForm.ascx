<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UsersForm.ascx.cs" Inherits="APP.App_UserControls.Security.UsersForm" %>
<%-- Control Wrapper --%>
<div class="div-Application-Content">
    <asp:UpdatePanel ID="UpdatePanelUsers" runat="server" ChildrenAsTriggers="false"
        UpdateMode="Conditional">
        <ContentTemplate>
            <uc:UCNavigationPanel runat="server" ID="NavigationPanelUsers" OnNavigationMenuClick="NavigationMenuClick" />
            <asp:MultiView runat="server" ID="MultiViewUsers" ActiveViewIndex="0">
                <asp:View runat="server" ID="UsersList">
                    <uc:UCSettingsListViewUsers runat="server" ID="ListViewUser" OnSearchUsers="SearchUsers"
                        OnAddUsers="AddUsers" />
                </asp:View>
                <asp:View runat="server" ID="UsersDetails">
                    <uc:UCSettingsFormUsers runat="server" ID="FormUsers" />
                </asp:View>
            </asp:MultiView>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
