<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SearchEngine.ascx.cs" Inherits="APP.App_UserControls.Invoices.Search.SearchEngine" %>
<%-- Control Wrapper --%>
<div class="div-Application-Content">
<asp:UpdatePanel ID="UpdatePanelForm" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false">
    <ContentTemplate>

<table width="100%">
<tr>
    <td align="left">
        <asp:Label runat="server" ID="LabelInvoiceSearchEngineTitle" Text="Invoice Search Engine" CssClass="LabelForm" Font-Underline="true"></asp:Label>
    </td>
</tr>
<tr>
    <td align="left" class="tableFilterHeader">
        <table>
            <tr>
                <td>
                    <uc:UCButtonCommand runat="server" ID="UCButtonCommandExcel" CausesValidation="false"
                        ButtonToolTip="Export To Excel" ButtonCommandName="ExportExcel" ButtonImageUrl="~/App_Images/page_excel.png"
                        OnCommand="OnCommand" ButtonText="Export To Excel" />
                </td>
                <td>
                    <uc:UCButtonCommand runat="server" ID="UCButtonCommandPDF" CausesValidation="false"
                        ButtonToolTip="Export To PDF" ButtonCommandName="ExportPDF" ButtonImageUrl="~/App_Images/page_white_acrobat.png"
                        OnCommand="OnCommand" ButtonText="Export To PDF" />
                </td>
                <td>
                    <uc:UCButtonCommand runat="server" ID="UCButtonCommandEmail" CausesValidation="false"
                        ButtonToolTip="Send Email" ButtonCommandName="SendEmail" ButtonImageUrl="~/App_Images/email.png"
                        OnCommand="OnCommand" ButtonText="Send Email" />
                </td>
                <td>
                     <uc:UCButtonCommand runat="server" ID="UCButtonCommandTransport" CausesValidation="false"
                        ButtonToolTip="Netherlands Transport Invoice" ButtonCommandName="Transport" ButtonImageUrl="~/App_Images/car.png"
                        OnCommand="OnCommand" ButtonText="Netherlands Transport" />
                </td>
                <td align="right" style="width:120px;">
                    <asp:DropDownList runat="server" ID="DropDownInvoiceMode" CssClass="dropdownForm" Font-Bold="True" Font-Size="11px" Width="90px">
                        <asp:ListItem Value="1" Text="Original"></asp:ListItem>
                        <asp:ListItem Value="2" Text="Copy"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </td>
</tr>
<tr>
    <td align="left" class="contentboxheader">
        <asp:Label runat="server" ID="LabelHeaderFilters" Text="Filters" CssClass="LabelForm2"></asp:Label>
    </td>
</tr>
<tr>
    <td align="left"  class="contentboxForm">
        <table>
            <tr>
                <td align="left" style="width:120px;">Country</td>
                <td align="left"><asp:DropDownList runat="server" ID="DropDownListCountries" OnSelectedIndexChanged="DropDownListCountries_SelectedIndexChanged"
                        AutoPostBack="True" CssClass="dropdownForm" Width="250px">
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td align="left" style="width:120px;">Company</td>
                <td align="left"> <asp:DropDownList runat="server" ID="DropDownListCompanies" AppendDataBoundItems="true" Width="250px" AutoPostBack="True" OnSelectedIndexChanged="DropDownListCompanies_SelectedIndexChanged"
                        CssClass="dropdownForm">
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td align="left" style="width:120px;">Serial</td>
                <td align="left"><asp:TextBox runat="server" ID="TextBoxSerial" CssClass="TextBoxForm" Width="200px"></asp:TextBox></td>
            </tr>
            <tr>
                <td align="left" style="width:120px;">Plate</td>
                <td align="left"><asp:TextBox runat="server" ID="TextBoxPlate" Width="200px" CssClass="TextBoxForm"></asp:TextBox></td>
            </tr>
            <tr>
                <td align="left" style="width:120px;">Unit</td>
                <td align="left"><asp:TextBox runat="server" ID="TextBoxUnit" Width="200px" CssClass="TextBoxForm"></asp:TextBox></td>
            </tr>
            <tr>
                <td align="left" style="width:120px;">Vendor Code</td>
                <td align="left"><asp:TextBox runat="server" ID="TextBoxBuyerCode" Width="150px" CssClass="TextBoxForm"></asp:TextBox></td>
            </tr>
            <tr>
                <td align="left" style="width:120px;">Vendor Name</td>
                <td align="left"><asp:TextBox runat="server" ID="TextBoxBuyerName" Width="300px" CssClass="TextBoxForm"></asp:TextBox></td>
            </tr>
        </table>
    </td>
</tr>
<tr>
    <td align="left" class="contentboxheader">
        <asp:Label runat="server" ID="LabelHeaderOptions" Text="Options" CssClass="LabelForm2"></asp:Label>
    </td>
</tr>
<tr>
    <td align="left"  class="contentboxForm">
            <table>
                <tr>
                    <td align="left" style="width:120px;">Document Type</td>
                    <td align="left"><asp:DropDownList runat="server" ID="DropDownListDocumentType" AppendDataBoundItems="True"
                        CssClass="dropdownForm">
                        <asp:ListItem></asp:ListItem>
                    </asp:DropDownList></td>
                </tr>
                <tr>
                    <td align="left" style="width:120px;">Invoice Type</td>
                    <td align="left"><asp:DropDownList runat="server" ID="DropDownListInvoiceType" AppendDataBoundItems="True"
                        CssClass="dropdownForm">
                        <asp:ListItem></asp:ListItem>
                    </asp:DropDownList></td>
                </tr>
                <tr>
                    <td align="left" style="width:120px;">Manufacturer</td>
                    <td align="left"><asp:DropDownList runat="server" ID="DropDownListManufacturer" CssClass="dropdownForm" AppendDataBoundItems="true"></asp:DropDownList></td>
                </tr>
                <tr>
                    <td align="left" style="width:120px;">Vehicle Type</td>
                    <td align="left"><asp:DropDownList runat="server" ID="dropDownListVehicleType" CssClass="dropdownForm"
                        Width="80px" AppendDataBoundItems="True" DataSourceID="sdsVehicleTypes" DataTextField="VehicleType"
                        DataValueField="VehicleType">
                        <asp:ListItem Text="" Value="-1"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource runat="server" ID="sdsVehicleTypes" ConnectionString="<%$ ConnectionStrings:RAD.Properties.Settings.ApplicationDataBase %>"
                        SelectCommand="SELECT [VehicleType] FROM [Dimension.VehicleType] WHERE [VehicleType] IN (SELECT [VehicleType] FROM [Archive.Sales])"></asp:SqlDataSource></td>
                </tr>
                <tr>
                    <td align="left" style="width:120px;">Sale Type</td>
                    <td align="left"><asp:DropDownList runat="server" ID="dropDownListSaleType" CssClass="dropdownForm"
                        Width="80px" AppendDataBoundItems="True" DataSourceID="sdsSaleType" DataTextField="SaleType"
                        DataValueField="SaleType">
                        <asp:ListItem Text="" Value="-1"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource runat="server" ID="sdsSaleType" ConnectionString="<%$ ConnectionStrings:RAD.Properties.Settings.ApplicationDataBase %>"
                        SelectCommand="SELECT [SaleType] FROM [Dimension.SaleType] WHERE [SaleType] IN (SELECT [SaleType] FROM [Archive.Sales])"></asp:SqlDataSource></td>
                </tr>
            </table>
    </td>
</tr>
<tr>
    <td align="left" class="contentboxheader">
        <asp:Label runat="server" ID="LabelHeaderCustom" Text="Custom" CssClass="LabelForm2"></asp:Label>
    </td>
</tr>
<tr>
    <td align="left"  class="contentboxForm">
        <table>
            <tr>
                <td align="left" style="width:120px;">Invoice Number From</td>
                <td align="left"><cc:NumericTextBox runat="server" ID="TextBoxInvoiceNumberFrom" Width="100px" CssClass="TextBoxForm"></cc:NumericTextBox></td>
                <td align="left">To</td>
                <td align="left"><cc:NumericTextBox runat="server" ID="TextBoxInvoiceNumberTo" Width="100px" CssClass="TextBoxForm"></cc:NumericTextBox></td>
            </tr>
            <tr>
                <td align="left" style="width:120px;">Invoice Date From</td>
                <td align="left">
                    <cc:DateTextBox runat="server" ID="TextBoxInvoiceDateForm" Width="100px" CssClass="TextBoxForm"></cc:DateTextBox>
                    <asp:ImageButton runat="server" ID="imgcalendarFrom" ImageUrl="~/App_Images/calendar.png" ImageAlign="AbsBottom" />
                    <asp:CalendarExtender runat="server" ID="dtPickerFrom" TargetControlID="TextBoxInvoiceDateForm"
                        Format="dd/MM/yyyy" PopupButtonID="imgcalendarFrom" Enabled="true" CssClass="calendarClass">
                    </asp:CalendarExtender>
                    <asp:CustomValidator ID="ValidateDateFrom" runat="server" ControlToValidate="TextBoxInvoiceDateForm"
                        ValidateEmptyText="true" Display="Dynamic" ToolTip="<%$Resources:ToolTips, DateSelect %>"></asp:CustomValidator>
                </td>
                <td align="left">To</td>
                <td align="left">
                    <cc:DateTextBox runat="server" ID="TextBoxInvoiceDateTo" Width="100px" CssClass="TextBoxForm"></cc:DateTextBox>
                    <asp:ImageButton runat="server" ID="imgcalendarTo" ImageUrl="~/App_Images/calendar.png" ImageAlign="AbsBottom" />
                    <asp:CalendarExtender runat="server" ID="dtPickerTo" TargetControlID="TextBoxInvoiceDateTo"
                        Format="dd/MM/yyyy" PopupButtonID="imgcalendarTo" Enabled="true" CssClass="calendarClass">
                    </asp:CalendarExtender>
                    <asp:CustomValidator ID="ValidateDateTo" runat="server" ControlToValidate="TextBoxInvoiceDateTo"
                        ValidateEmptyText="true" Display="Dynamic" ToolTip="<%$Resources:ToolTips, DateSelect %>"></asp:CustomValidator>
                </td>
            </tr>
            <tr>
                <td align="left" style="width:120px;">File Date</td>
                <td align="left">
                    <cc:DateTextBox runat="server" ID="TextBoxFileDate" Width="100px" CssClass="TextBoxForm"></cc:DateTextBox>
                    <asp:ImageButton runat="server" ID="ImageButtonFileDate" ImageUrl="~/App_Images/calendar.png" ImageAlign="AbsBottom" />
                    <asp:CalendarExtender runat="server" ID="CalendarExtenderFileDate" TargetControlID="TextBoxFileDate"
                        Format="dd/MM/yyyy" PopupButtonID="ImageButtonFileDate" Enabled="true" CssClass="calendarClass">
                    </asp:CalendarExtender>
                
                </td>
                <td align="left"></td>
                <td align="left"></td>
            </tr>
        </table>
    </td>
</tr>
<tr>
    <td align="left" class="contentboxheader">
        <asp:Label runat="server" ID="LabelFreeFormat" Text="Free Format Text" CssClass="LabelForm2"></asp:Label>
    </td>
</tr>
<tr>
    <td align="left" class="contentboxForm">
        <table>
            <tr>
                <td align="left" valign="top" style="width:120px;">Free Format Text</td>
                <td align="left">
                    <asp:TextBox runat="server" ID="TextBoxFreeFormat" TextMode="MultiLine" CssClass="TextBoxForm" Width="300px" Height="120px"></asp:TextBox>
                </td>
            </tr>
        </table>
    </td>
</tr>
</table>
    </ContentTemplate>
    <Triggers>
        <asp:PostBackTrigger ControlID="UCButtonCommandExcel" />
        <asp:PostBackTrigger ControlID="UCButtonCommandPDF" />
        <asp:PostBackTrigger ControlID="UCButtonCommandEmail" />
        <asp:PostBackTrigger ControlID="UCButtonCommandTransport" />
    </Triggers>
</asp:UpdatePanel>
</div>