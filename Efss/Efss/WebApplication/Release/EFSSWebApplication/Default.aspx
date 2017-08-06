<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/Application.Master"
    AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="APP.Default"    %>

<%@ MasterType VirtualPath="~/App_MasterPages/Application.Master" %>
<asp:Content ID="ContentHead" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">


</asp:Content>
<asp:Content ID="ContentMainContent" ContentPlaceHolderID="ContentPlaceHolderMainContent"
    runat="server">
    <asp:UpdatePanel ID="UpdatePanelContent" runat="server" ChildrenAsTriggers="false"
        UpdateMode="Conditional">
        <ContentTemplate>
           
            <%-- <asp:Literal ID="LiteralResult" runat="server"></asp:Literal>--%>

            <%-- Access Denied--%>
           <uc:UCAccessDenied runat="server" ID="AccessDenied" Visible="false" />

            <%-- Invoices--%>
            <uc:UCInvoicesForm runat="server" ID="Invoices" Visible="false" />
            <uc:UCSalesReport runat="server" ID="SalesReport" Visible="false" />
            <uc:UCSearchEngine runat="server" ID="SearchEngine" Visible="false" />
            <%-- Fleet--%>
            <%-- Export To Excel--%>
           <uc:UCFleetPanelColumns runat="server" ID="ExportExcel" Visible="false" />
            <%-- Fleet Files Day - Month--%>

             <uc:UCFleetDayReport runat="server" ID="ControlUCFleetDayReport" Visible="false" /> 
             <uc:UCFleetMonthReport runat="server" ID="ControlUCFleetMonthReport" Visible="false" />   

            <%-- Fleet Current Day Adds - Deletes--%>
            <uc:TransactionsDay runat="server" ID="TransactionsDay" Visible="false" />
           
            
            <%-- Fleet Year Adds - Deletes--%>
            <uc:TransactionsYear runat="server" ID="TransactionsYear" Visible="false" />
            <%-- Fleet Test--%>
            

            <%-- Settings--%>
            <%-- Settings : Buyers--%>
            <uc:UCVendorsForm runat="server" ID="Vendors" Visible="false" />
            <%-- Settings : Models--%>
            <uc:UCManufacturersForm runat="server" ID="Manufacturers" Visible="false" />
            <%-- Settings : Companies--%>
            <uc:UCCompaniesForm runat="server" ID="Companies" Visible="false" />
            <%-- Settings : Users--%>
            <uc:UCUsersForm runat="server" ID="Users" Visible="false" />
           


            <%--<uc:UCAreasForm runat="server" ID="" Visible="false" />--%>
             <%-- Settings : Settings--%>
            <uc:UCSettingsForm runat="server" ID="Settings" Visible="false" />
             <%-- Settings : Email--%>
            <uc:UCSettingsEmail runat="server" ID="Email" Visible="false" />
            <%-- Reports--%>
            
            <uc:UCFleetCashForm runat="server" ID="FleetCash" Visible="false" />
            <uc:UCFleetDashboardForm runat="server" ID="Dashboard" Visible="false" />

             <uc:TextFileFrance runat="server" ID="FrenchFile" Visible="false" />

             <uc:TaxSpain runat="server" ID="TaxSpain" Visible="false" />
                   
            <uc:UCListViewReports runat="server" ID="ListViewReports" Visible="false" />

            <uc:UCOutputFilesForm runat="server" ID="chart" Visible="true" />

            <uc:FTPForm runat="server" ID="FTPForm" Visible="false" />

            <div style="display: none;">
                 <rad:AsyncFileUpload ID="AsyncFileUploadReport" runat="server" />
            </div>
	

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="ContentFooter" ContentPlaceHolderID="ContentPlaceHolderFooter" runat="server">
</asp:Content>
