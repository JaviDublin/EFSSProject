<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FleetPanelColumns.ascx.cs" Inherits="APP.App_UserControls.Fleet.PanelColumns.FleetPanelColumns" %>
<%-- Control Wrapper --%>
<div class="div-Application-Content">
    <asp:UpdatePanel runat="server" ID="UpdatePanelFleetExcel" UpdateMode="Conditional"
        ChildrenAsTriggers="false">
        <ContentTemplate>
            <table width="100%">
                <tr>
                    <td align="left">
                        <asp:Label runat="server" ID="LabelDashboardReportTitle" Text="Fleet Search Engine"
                            CssClass="LabelForm" Font-Underline="true"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="left" class="tableFilterHeader">
                        <table>
                            <tr>
                                <td>
                                    <uc:UCButtonCommand runat="server" ID="ButtonCommandExport" CausesValidation="false"
                                        ButtonCommandName="Export" ButtonImageUrl="~/App_Images/page_excel.png" OnCommand="OnCommand"
                                        ButtonText="Export To Excel" />
                                </td>
                                <td>
                                    <asp:Image runat="server" ID="ImageSeparator" ImageUrl="~/App_Styles/Images/menu-bg.jpg" />
                                </td>
                                <td>
                                    <uc:UCButtonCommand runat="server" ID="UCButtonCommandSelectAll" CausesValidation="false"
                                        ButtonCommandName="Select" ButtonImageUrl="~/App_Images/checkbox-checked.png"
                                        OnCommand="OnCommand" ButtonText="Select All" />
                                </td>
                                <td>
                                    <uc:UCButtonCommand runat="server" ID="UCButtonCommandDeselectAll" CausesValidation="false"
                                        ButtonCommandName="Deselect" ButtonImageUrl="~/App_Images/checkbox-unchecked.png"
                                        OnCommand="OnCommand" ButtonText="De-Select All" />
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
                    <td align="left" class="contentboxForm">
                        <table>
                            <tr>
                                <td align="left" style="width: 120px;">
                                    File
                                </td>
                                <td align="left">
                                    <asp:DropDownList runat="server" ID="DropDownListFiles" CssClass="dropdownForm" Width="250px"
                                        DataSourceID="sdsFiles" DataTextField="Notes" DataValueField="FileId">
                                    </asp:DropDownList>
                                    <asp:SqlDataSource runat="server" ID="sdsFiles" ConnectionString="<%$ ConnectionStrings:RAD.Properties.Settings.ApplicationDataBase %>"
                                        SelectCommand="select FileId , UPPER(Notes) as &quot;Notes&quot; 
                                            from [Application.Files]
                                            where FileGroupType = 'FLEET'
                                            order by FileId"></asp:SqlDataSource>
                                </td>
                                <td align="left">
                                </td>
                                <td align="left">
                                </td>
                                <td align="left">
                                </td>
                                <td align="left">
                                </td>
                                <td align="left">
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="width: 120px;">
                                    Country
                                </td>
                                <td align="left">
                                    <asp:DropDownList runat="server" ID="DropDownListCountries" OnSelectedIndexChanged="DropDownListCountries_SelectedIndexChanged"
                                        AutoPostBack="True" CssClass="dropdownForm" AppendDataBoundItems="true" Width="250px">
                                    </asp:DropDownList>
                                </td>
                                <td align="left">
                                </td>
                                <td align="left">
                                   
                                </td>
                                <td align="left">
                               
                                </td>
                                <td align="left">
                                </td>
                                <td align="left">
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="width: 120px;">
                                    Company
                                </td>
                                <td align="left">
                                    <asp:DropDownList runat="server" ID="DropDownListCompanies" Width="250px" AutoPostBack="True" AppendDataBoundItems="true"
                                        OnSelectedIndexChanged="DropDownListCompanies_SelectedIndexChanged" CssClass="dropdownForm">
                                    </asp:DropDownList>
                                </td>
                                <td align="left">
                                </td>
                                <td align="left">
                                </td>
                                <td align="left">
                                </td>
                                <td align="left">
                                </td>
                                <td align="left">
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="width: 120px;">
                                    Area
                                </td>
                                <td align="left">
                                    <asp:TextBox runat="server" ID="txtAreaCode" CssClass="TextBoxForm"></asp:TextBox>
                                </td>
                                <td align="left">
                                </td>
                                <td align="left">
                                    In Service Date
                                </td>
                                <td align="left">
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:DropDownList runat="server" ID="DropDownListInServiceDate" Width="35px" CssClass="dropdownForm">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <cc:DateTextBox runat="server" ID="txtInServiceDate" CssClass="TextBoxForm" Width="100px"></cc:DateTextBox>
                                                <asp:ImageButton runat="server" ID="imgcalendarisd" ImageUrl="~/App_Images/calendar.png"
                                                    ImageAlign="AbsBottom" />
                                                <asp:CalendarExtender runat="server" ID="dtISD" TargetControlID="txtInServiceDate"
                                                    Format="dd/MM/yyyy" PopupButtonID="imgcalendarisd" Enabled="true" CssClass="calendarClass">
                                                </asp:CalendarExtender>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td align="left">
                                </td>
                                <td align="left">
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:DropDownList runat="server" ID="DropDownListInServiceDate2" Width="35px" CssClass="dropdownForm">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <cc:DateTextBox runat="server" ID="txtInServiceDate2" CssClass="TextBoxForm" Width="100px"></cc:DateTextBox>
                                                <asp:ImageButton runat="server" ID="imgcalendarisd2" ImageUrl="~/App_Images/calendar.png"
                                                    ImageAlign="AbsBottom" />
                                                <asp:CalendarExtender runat="server" ID="dtISD2" TargetControlID="txtInServiceDate2"
                                                    Format="dd/MM/yyyy" PopupButtonID="imgcalendarisd2" Enabled="true" CssClass="calendarClass">
                                                </asp:CalendarExtender>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="width: 120px;">
                                    Model Code
                                </td>
                                <td align="left">
                                    <asp:TextBox runat="server" ID="txtModelCode" CssClass="TextBoxForm"></asp:TextBox>
                                </td>
                                <td align="left">
                                </td>
                                <td align="left">
                                    MSO Date
                                </td>
                                <td align="left">
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:DropDownList runat="server" ID="DropDownListMSODate" Width="35px" CssClass="dropdownForm">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <cc:DateTextBox runat="server" ID="txtMsoDate" CssClass="TextBoxForm" Width="100px"></cc:DateTextBox>
                                                <asp:ImageButton runat="server" ID="imgcalendarmsod" ImageUrl="~/App_Images/calendar.png"
                                                    ImageAlign="AbsBottom" />
                                                <asp:CalendarExtender runat="server" ID="dtMSOD" TargetControlID="txtMsoDate" Format="dd/MM/yyyy"
                                                    PopupButtonID="imgcalendarmsod" Enabled="true" CssClass="calendarClass">
                                                </asp:CalendarExtender>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td align="left">
                                </td>
                                <td align="left">
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:DropDownList runat="server" ID="DropDownListMSODate2" Width="35px" CssClass="dropdownForm">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <cc:DateTextBox runat="server" ID="txtMsoDate2" CssClass="TextBoxForm" Width="100px"></cc:DateTextBox>
                                                <asp:ImageButton runat="server" ID="imgcalendarmsod2" ImageUrl="~/App_Images/calendar.png"
                                                    ImageAlign="AbsBottom" />
                                                <asp:CalendarExtender runat="server" ID="dtMSOD2" TargetControlID="txtMsoDate2" Format="dd/MM/yyyy"
                                                    PopupButtonID="imgcalendarmsod2" Enabled="true" CssClass="calendarClass">
                                                </asp:CalendarExtender>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="width: 120px;">
                                    Manufacturer
                                </td>
                                <td align="left">
                                    <asp:DropDownList runat="server" ID="DropDownListManufacturer" CssClass="dropdownForm"
                                        Width="150px" AppendDataBoundItems="true">
                                    </asp:DropDownList>
                                </td>
                                <td align="left">
                                </td>
                                <td align="left">
                                    Delivery Date
                                </td>
                                <td align="left">
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:DropDownList runat="server" ID="DropDownListDeliveryDate" Width="35px" CssClass="dropdownForm">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <cc:DateTextBox runat="server" ID="txtDeliveryDate" CssClass="TextBoxForm" Width="100px"></cc:DateTextBox>
                                                <asp:ImageButton runat="server" ID="imgcalendardd" ImageUrl="~/App_Images/calendar.png"
                                                    ImageAlign="AbsBottom" />
                                                <asp:CalendarExtender runat="server" ID="dtDD" TargetControlID="txtDeliveryDate"
                                                    Format="dd/MM/yyyy" PopupButtonID="imgcalendardd" Enabled="true" CssClass="calendarClass">
                                                </asp:CalendarExtender>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td align="left">
                                </td>
                                <td align="left">
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:DropDownList runat="server" ID="DropDownListDeliveryDate2" Width="35px" CssClass="dropdownForm">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <cc:DateTextBox runat="server" ID="txtDeliveryDate2" CssClass="TextBoxForm" Width="100px"></cc:DateTextBox>
                                                <asp:ImageButton runat="server" ID="imgcalendardd2" ImageUrl="~/App_Images/calendar.png"
                                                    ImageAlign="AbsBottom" />
                                                <asp:CalendarExtender runat="server" ID="dtDD2" TargetControlID="txtDeliveryDate2"
                                                    Format="dd/MM/yyyy" PopupButtonID="imgcalendardd2" Enabled="true" CssClass="calendarClass">
                                                </asp:CalendarExtender>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="width: 120px;">
                                    Vendor Code
                                </td>
                                <td align="left">
                                    <asp:TextBox runat="server" ID="TextBoxBuyerCode" Width="150px" CssClass="TextBoxForm"></asp:TextBox>
                                </td>
                                <td align="left">
                                </td>
                                <td align="left">
                                    Sale Type
                                </td>
                                <td align="left">
                                    <asp:DropDownList runat="server" ID="DropDownListSaleType" CssClass="dropdownForm"
                                        Width="80px" AppendDataBoundItems="True" DataSourceID="sdsSaleType" DataTextField="SaleType"
                                        DataValueField="SaleType">
                                        <asp:ListItem Text="ALL" Value="-1"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource runat="server" ID="sdsSaleType" ConnectionString="<%$ ConnectionStrings:RAD.Properties.Settings.ApplicationDataBase %>"
                                        SelectCommand="SELECT [SaleType] FROM [Dimension.SaleType] WHERE ([DocSubType] IS NOT NULL) ORDER BY [SaleType]">
                                    </asp:SqlDataSource>
                                </td>
                                <td align="left">
                                </td>
                                <td align="left">
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="width: 120px;">
                                    Mileage
                                </td>
                                <td align="left">
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:DropDownList runat="server" ID="DropDownListOperatorMileage" Width="35px" CssClass="dropdownForm">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <cc:NumericTextBox runat="server" ID="txtMileage" CssClass="TextBoxForm" Width="100px"></cc:NumericTextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td align="left">
                                </td>
                                <td align="left">
                                    Vehicle Status
                                </td>
                                <td align="left">
                                    <asp:DropDownList runat="server" ID="DropDownListVehicleStatus" CssClass="dropdownForm"
                                        Width="80px" AppendDataBoundItems="True" DataSourceID="sdsVehicleStatus" DataTextField="VehicleStatus"
                                        DataValueField="VehicleStatus">
                                        <asp:ListItem Text="ALL" Value="-1"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource runat="server" ID="sdsVehicleStatus" ConnectionString="<%$ ConnectionStrings:RAD.Properties.Settings.ApplicationDataBase %>"
                                        SelectCommand="SELECT [VehicleStatus] FROM [Dimension.VehicleStatus] ORDER BY [VehicleStatus]">
                                    </asp:SqlDataSource>
                                </td>
                                <td align="left">
                                </td>
                                <td align="left">
                                </td>
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
                    <td align="left" class="contentboxForm">
                        <table>
                            <tr>
                                <td>
                                    <asp:CheckBox ID="CheckBoxCompanyCode" runat="server" />
                                </td>
                                <td>
                                    Company Code
                                </td>
                                <td>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBoxMileage" runat="server" />
                                </td>
                                <td>
                                    Mileage
                                </td>
                                <td>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBoxCapitalCost" runat="server" />
                                </td>
                                <td>
                                    Capital Cost
                                </td>
                                <td>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBoxBuyerCode" runat="server" />
                                </td>
                                <td>
                                    Buyer Code
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:CheckBox ID="CheckBoxAreaCode" runat="server" />
                                </td>
                                <td>
                                    Area Code
                                </td>
                                <td>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBoxInServiceDate" runat="server" />
                                </td>
                                <td>
                                    In Service Date
                                </td>
                                <td>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBoxDepreciation" runat="server" />
                                </td>
                                <td>
                                    Depreciation
                                </td>
                                <td>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBoxBuyerName" runat="server" />
                                </td>
                                <td>
                                    Buyer Name
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:CheckBox ID="CheckBoxSerial" runat="server" />
                                </td>
                                <td>
                                    Serial
                                </td>
                                <td>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBoxOutServiceDate" runat="server" />
                                </td>
                                <td>
                                    Out Service Date
                                </td>
                                <td>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBoxDepreciationRate" runat="server" />
                                </td>
                                <td>
                                    Depreciation Rate
                                </td>
                                <td>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBoxsaleDocumentNumber" runat="server" />
                                </td>
                                <td>
                                    Sale Document Number
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:CheckBox ID="CheckBoxPlate" runat="server" />
                                </td>
                                <td>
                                    Plate
                                </td>
                                <td>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBoxMSOServiceDate" runat="server" />
                                </td>
                                <td>
                                    MSO Date
                                </td>
                                <td>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBoxDepreciationPCT" runat="server" />
                                </td>
                                <td>
                                    Depreciation %
                                </td>
                                <td>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBoxInvoiceNumber" runat="server" />
                                </td>
                                <td>
                                    Invoice Number
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:CheckBox ID="CheckBoxUnit" runat="server" />
                                </td>
                                <td>
                                    Unit
                                </td>
                                <td>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBoxDeliveryDate" runat="server" />
                                </td>
                                <td>
                                    Delivery Date
                                </td>
                                <td>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBoxBookValue" runat="server" />
                                </td>
                                <td>
                                    BookValue
                                </td>
                                <td>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBoxInvoiceStatus" runat="server" />
                                </td>
                                <td>
                                    Invoice Status
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:CheckBox ID="CheckBoxModelCode" runat="server" />
                                </td>
                                <td>
                                    Model Code
                                </td>
                                <td>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBoxDaysInService" runat="server" />
                                </td>
                                <td>
                                    Days In Service
                                </td>
                                <td>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBoxBuyBackCap" runat="server" />
                                </td>
                                <td>
                                    BuyBack Cap.
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:CheckBox ID="CheckBoxManufacturer" runat="server" />
                                </td>
                                <td>
                                    Manufacturer Code
                                </td>
                                <td>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBoxVehicleType" runat="server" />
                                </td>
                                <td>
                                    Vehicle Type
                                </td>
                                <td>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBoxsalesPrice" runat="server" />
                                </td>
                                <td>
                                    Sale Price
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:CheckBox ID="CheckBoxModelDesc" runat="server" />
                                </td>
                                <td>
                                    Model Description
                                </td>
                                <td>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBoxVehicleClass" runat="server" />
                                </td>
                                <td>
                                    Vehicle Class
                                </td>
                                <td>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBoxSaleType" runat="server" />
                                </td>
                                <td>
                                    Sale Type
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:CheckBox ID="CheckBoxModelYear" runat="server" />
                                </td>
                                <td>
                                    Model Year
                                </td>
                                <td>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBoxVehicleStatus" runat="server" />
                                </td>
                                <td>
                                    Vehicle Status
                                </td>
                                <td>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBoxRateClass" runat="server" />
                                </td>
                                <td>
                                    Rate Class
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="ButtonCommandExport" />
        </Triggers>
    </asp:UpdatePanel>
</div>


