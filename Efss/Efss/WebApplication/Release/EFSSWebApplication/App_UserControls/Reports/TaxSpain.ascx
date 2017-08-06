<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TaxSpain.ascx.cs" Inherits="APP.App_UserControls.Reports.TaxSpain" %>
<%-- Control Wrapper --%>
<div class="div-Application-Content">
<asp:UpdatePanel runat="server" ID="UpdatePanelTaxSpain" UpdateMode="Conditional"
    ChildrenAsTriggers="false">
    <ContentTemplate>
        <uc:UCNavigationPanel runat="server" ID="NavigationPanelSpain" OnNavigationMenuClick="NavigationMenuClick" />
        <asp:MultiView runat="server" ID="MultiViewTaxSpain" ActiveViewIndex="0">
            <asp:View runat="server" ID="RegTaxAmount">
                <uc:TextFileSpain runat="server" ID="SpanishFile" />
            </asp:View>
            <asp:View runat="server" ID="TaxForm">
                <uc:TaxFormSpain runat="server" ID="SpanishForm" />
            </asp:View>
            <asp:View runat="server" ID="SpanisFilesUpload">
                <uc:TaxFileUpload runat="server" ID="SpanishFileUpload" />
            </asp:View>
        </asp:MultiView>
    </ContentTemplate>
</asp:UpdatePanel>
</div>
