<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CompaniesForm.ascx.cs" Inherits="APP.App_UserControls.Settings.CompaniesForm" %>
<%-- Control Wrapper --%>
<div class="div-Application-Content">
    <%-- Controls --%>
    <asp:UpdatePanel runat="server" ID="UpdatePanelCompanies" UpdateMode="Conditional"
        ChildrenAsTriggers="false">
        <ContentTemplate>
            <uc:UCNavigationPanel runat="server" ID="NavigationPanelCompanies" OnNavigationMenuClick="NavigationMenuClick" />
            <asp:MultiView runat="server" ID="MultiViewCompanies" ActiveViewIndex="0">
                <asp:View runat="server" ID="CompaniesList">
                    <uc:UCSettingsListViewCompanies runat="server" ID="ListViewCompanies" OnSearchCompanies="SearchCompanies" />
                </asp:View>
                <asp:View runat="server" ID="CompaniesDetails">
                    <uc:UCSettingsFormCompanies runat="server" ID="FormCompanies" />
                </asp:View>
            </asp:MultiView>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
