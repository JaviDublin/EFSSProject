<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FileFrance.ascx.cs" Inherits="APP.App_UserControls.Reports.OutputFileFrance.FileFrance" %>

<asp:UpdatePanel runat="server" ID="UpdatePanelTextFrance" UpdateMode="Conditional"
    ChildrenAsTriggers="false">
    <ContentTemplate>
        <table width="100%">
            <tr>
                <td align="left">
                    <asp:Label runat="server" ID="LabelFrenchLTSCTitle" Text="French LTSC File" CssClass="LabelForm"
                        Font-Underline="true"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" class="tableFilterHeader">
                    <table>
                        <tr>
                            <td>
                                <uc:UCButtonCommand runat="server" ID="ButtonCommandExport" CausesValidation="true"
                                    ButtonCommandName="Export" ButtonImageUrl="~/App_Images/page_go.png" OnCommand="OnCommand"
                                    ButtonText="Export Text File" />
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
                            <td align="left">
                                Company
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="DropDownListCompanies" CssClass="dropdownForm"
                                    AppendDataBoundItems="True" DataSourceID="sdsCompanies" DataTextField="CompanyName"
                                    DataValueField="CompanyId">
                                    <asp:ListItem Text="ALL" Value="-1"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource runat="server" ID="sdsCompanies" ConnectionString="<%$ ConnectionStrings:RAD.Properties.Settings.ApplicationDataBase %>"
                                    SelectCommand="select CompanyId , CompanyName from [Dimension.Companies] where GroupName = 'FRANCE'">
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                Document type
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="DropDownListDocumentType" CssClass="dropdownForm"
                                    AppendDataBoundItems="True" DataSourceID="sdsDocumentType" DataTextField="DocType"
                                    DataValueField="DocType">
                                    <asp:ListItem Text="ALL" Value="-1"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource runat="server" ID="sdsDocumentType" ConnectionString="<%$ ConnectionStrings:RAD.Properties.Settings.ApplicationDataBase %>"
                                    SelectCommand="select DocType from [Dimension.DocumentTypes] where DocumentTypeId in
(select documentTypeId 
from [Archive.Sales] 
group by documentTypeId)
group by DocType"></asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                Sale Type
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="DropDownListSaleType" CssClass="dropdownForm"
                                    AppendDataBoundItems="True" DataSourceID="sdsSaleType" DataTextField="DocSubType"
                                    DataValueField="DocSubType" Width="100px">
                                    <asp:ListItem Text="ALL" Value="-1"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource runat="server" ID="sdsSaleType" ConnectionString="<%$ ConnectionStrings:RAD.Properties.Settings.ApplicationDataBase %>"
                                    SelectCommand="select DocSubType from [Dimension.DocumentTypes] where DocumentTypeId in
(select documentTypeId 
from [Archive.Sales] 
group by documentTypeId)
group by DocSubType"></asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                File Date
                            </td>
                            <td align="left">
                                <cc:DateTextBox runat="server" ID="TextBoxFileDate" Width="100px" CssClass="TextBoxForm"></cc:DateTextBox>
                                <asp:ImageButton runat="server" ID="imgcalendarFileDate" ImageUrl="~/App_Images/calendar.png" ImageAlign="AbsBottom" />
                                <asp:CalendarExtender runat="server" ID="CalendarExtenderFileDate" TargetControlID="TextBoxFileDate"
                                    Format="dd/MM/yyyy" PopupButtonID="imgcalendarFileDate"
                                    Enabled="true" CssClass="calendarClass">
                                </asp:CalendarExtender>
                            </td>
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
                <td align="left" class="contentboxForm">
                    <table>
                        <tr>
                            <td align="left">
                                Invoice Date From
                            </td>
                            <td align="left">
                                <cc:DateTextBox runat="server" ID="TextBoxInvoiceDateFrom" Width="100px" CssClass="TextBoxForm"></cc:DateTextBox>
                                <asp:ImageButton runat="server" ID="ImageButtonInvoiceDateFrom"  ImageUrl="~/App_Images/calendar.png" ImageAlign="AbsBottom" />
                                <asp:CalendarExtender runat="server" ID="CalendarExtenderDateFrom" TargetControlID="TextBoxInvoiceDateFrom"
                                    Format="dd/MM/yyyy" PopupButtonID="ImageButtonInvoiceDateFrom" Enabled="true" CssClass="calendarClass">
                                </asp:CalendarExtender>
                            </td>
                            <td align="left">
                                To
                            </td>
                            <td align="left">
                                <cc:DateTextBox runat="server" ID="TextBoxInvoiceDateTo" Width="100px" CssClass="TextBoxForm"></cc:DateTextBox>
                                <asp:ImageButton runat="server" ID="ImageButtonInvoiceDateTo" ImageUrl="~/App_Images/calendar.png" ImageAlign="AbsBottom" />
                                <asp:CalendarExtender runat="server" ID="CalendarExtenderDateTo" TargetControlID="TextBoxInvoiceDateTo"
                                    Format="dd/MM/yyyy" PopupButtonID="ImageButtonInvoiceDateTo"
                                    Enabled="true" CssClass="calendarClass">
                                </asp:CalendarExtender>
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
