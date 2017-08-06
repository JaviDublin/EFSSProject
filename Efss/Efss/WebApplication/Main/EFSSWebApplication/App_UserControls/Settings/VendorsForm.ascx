<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="VendorsForm.ascx.cs" Inherits="APP.App_UserControls.Settings.VendorsForm" %>

<%-- Control Wrapper --%>
<div class="div-Application-Content">
<asp:UpdatePanel runat="server" ID="UpdatePanelBuyers" UpdateMode="Conditional" ChildrenAsTriggers="false">
    <ContentTemplate>
        <uc:UCNavigationPanel runat="server" ID="NavigationPanelBuyers" OnNavigationMenuClick="NavigationMenuClick" />
        <asp:MultiView runat="server" ID="MultiViewBuyers" ActiveViewIndex="0">
        <asp:View runat="server" ID="BuyersList">
            <uc:UCSettingsListViewVendors runat="server" ID="BuyersListView" OnSearchBuyer="SearchBuyer" />
        </asp:View>
        <asp:View runat="server" ID="BuyersDetails">
            <uc:UCSettingsFormBuyers runat="server" ID="BuyersForm" OnFormBuyers="FormBuyers" />
        </asp:View>
        </asp:MultiView>
    </ContentTemplate>
</asp:UpdatePanel>
</div>
