<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FileUploadTax.ascx.cs" Inherits="APP.App_UserControls.Reports.FormTaxUpload.FileUploadTax" %>
<table width="100%">
    <tr>
        <td align="left">
            <asp:Label runat="server" ID="LabelImportFilesTitle" Text="Import Spanish Files"
                CssClass="LabelForm" Font-Underline="true"></asp:Label>
        </td>
    </tr>
    <tr>
        <td align="left" class="contentboxheader">
            <asp:Label runat="server" ID="LabelHeaderUpload" Text="Upload" CssClass="LabelForm2"></asp:Label>
        </td>
    </tr>
    <tr>
        <td align="left" class="contentboxForm">
            <table>
                <tr>
                    <td align="left">
                        Please, select a file:
                    </td>
                    <td align="left">
                        <asp:DropDownList runat="server" ID="DropDownListFileTye" CssClass="dropdownForm"
                            Width="200px">
                            <asp:ListItem Value="1" Text="BANK FILE"></asp:ListItem>
                            <asp:ListItem Value="2" Text="SPANISH FLEET"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td align="left">
                        <rad:AsyncFileUpload ID="AsyncFileUploadFileBank" runat="server" AllowedFileTypes="txt|dev|xlsx|xls"
                            MaxFileSize="MB100" MaxFileSizeInformation="Maximum file size allowed 100 MB."
                            AllowedFileTypesInformation="Allowed file types DEV , TXT, XLX" OnUploadedFileError="OnFileUploadError"
                            ClientIDMode="Static" Dynamic="true" OnUploadedFileComplete="OnFileUploadComplete"
                            CssClass="TextBoxFormUpload" Height="40px" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>


