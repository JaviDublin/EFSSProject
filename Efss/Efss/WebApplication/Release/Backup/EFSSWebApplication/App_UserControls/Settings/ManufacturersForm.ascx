<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ManufacturersForm.ascx.cs" Inherits="APP.App_UserControls.Settings.ManufacturersForm" %>
<%-- Control Wrapper --%>
<div class="div-Application-Content">
    <asp:UpdatePanel runat="server" ID="UpdatePanelManufacturers" UpdateMode="Conditional"
        ChildrenAsTriggers="false">
        <ContentTemplate>
            <uc:UCNavigationPanel runat="server" ID="NavigationPanelManufacturers" OnNavigationMenuClick="NavigationMenuClick" />
            <asp:MultiView runat="server" ID="MultiViewManufacturers" ActiveViewIndex="0">
                <asp:View runat="server" ID="Manufacturers">
                    <uc:UCSettingsListViewManufacturers runat="server" ID="ListViewManufacturers" OnSearchModels="SearchModels" />
                </asp:View>
                <asp:View runat="server" ID="Models">
                    <uc:UCSettingsListViewModels runat="server" ID="ListViewModels" />
                </asp:View>
            </asp:MultiView>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
