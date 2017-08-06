<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SalesReport.ascx.cs"
    Inherits="APP.App_UserControls.Invoices.SalesReport.SalesReport" %>
<%-- Control Wrapper --%>
<div class="div-Application-Content">
    <%-- Controls --%>
    <asp:UpdatePanel runat="server" ID="UpdatePanelSalesReport" UpdateMode="Conditional"
        ChildrenAsTriggers="false">
        <ContentTemplate>
         
            <uc:UCNavigationPanel runat="server" ID="NavigationPanelSalesReport" OnNavigationMenuClick="NavigationMenuClick" />
            <asp:MultiView runat="server" ID="MultiViewSalesReport" ActiveViewIndex="0">
                <asp:View runat="server" ID="Country">
                <table width="100%">
                    <tr>
                        <td align="left">
                            <asp:Label runat="server" ID="LabelInvoicesByCountryTitle" Text="Invoices By Country"
                                CssClass="LabelForm" Font-Underline="true"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="contentboxForm">
                            <uc:UCListViewCountriesSales runat="server" ID="UCCountriesSales" OnSearchBuyers="SearchBuyers"
                                Visible="true" />
                        </td>
                    </tr>
                </table>

                </asp:View>
                <asp:View runat="server" ID="Buyer">
                 <table width="100%">
                    <tr>
                        <td align="left">
                            <asp:Label runat="server" ID="Label1" Text="Invoices By Buyer" CssClass="LabelForm"
                                Font-Underline="true"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="contentboxForm">
                            <uc:UCBuyersList runat="server" ID="UCBuyersSales" OnSearchInvoices="SearchInvoices"
                                Visible="true" />
                        </td>
                    </tr>
                </table>
                </asp:View>
                <asp:View runat="server" ID="Invoice">
                <table width="100%">
                    <tr>
                        <td align="left">
                            <asp:Label runat="server" ID="Label3" Text="Invoices By Number" CssClass="LabelForm"
                                Font-Underline="true"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="contentboxForm">
                            <uc:UCInvoicesList ID="UCInvoicesList" runat="server" Visible="true" />
                        </td>
                    </tr>
                </table>
                </asp:View>
            </asp:MultiView>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
