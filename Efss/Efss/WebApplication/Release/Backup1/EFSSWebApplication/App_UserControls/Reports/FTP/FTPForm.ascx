<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FTPForm.ascx.cs" Inherits="APP.App_UserControls.Reports.FTP.FTPForm" %>
<%-- Control Wrapper --%>
<div class="div-Application-Content">
    <asp:UpdatePanel runat="server" ID="UpdatePanelFTP" UpdateMode="Conditional" ChildrenAsTriggers="false">
        <ContentTemplate>
            <table width="100%">
                <tr>
                    <td align="left">
                        <asp:Label runat="server" ID="LabelFTPReports" Text="FTP Reports" CssClass="LabelForm"
                            Font-Underline="true"></asp:Label>
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
                                <td align="left" style="width: 180px;">
                                    Please, select the Report:
                                </td>
                                <td align="left">
                                    <asp:DropDownList runat="server" ID="DropDownListFileTye" CssClass="dropdownForm"
                                        Width="250px"  DataSourceID="sdsFiles" DataTextField="Notes" DataValueField="FileId">
                                    </asp:DropDownList>
                                    <asp:SqlDataSource runat="server" ID="sdsFiles" ConnectionString="<%$ ConnectionStrings:RAD.Properties.Settings.ApplicationDataBase %>"
                                        SelectCommand="select FileId , UPPER(Notes) as &quot;Notes&quot; 
                                            from [Application.Files]
                                            where IsImported = 1
                                            order by FileId"></asp:SqlDataSource>

                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="width: 180px;">
                                    Browse the file to upload:
                                </td>
                                <td align="left">

                                    <rad:AsyncFileUpload ID="AsyncFileUploadReport" runat="server" AllowedFileTypes="txt"
                                        MaxFileSize="MB100" MaxFileSizeInformation="Maximum file size allowed 100 MB."
                                        AllowedFileTypesInformation="Allowed file types: TXT" OnUploadedFileError="OnFileUploadError"
                                        ClientIDMode="Static" Dynamic="true" OnUploadedFileComplete="OnFileUploadComplete"
                                        CssClass="TextBoxFormUpload" Height="60px" UploaderStyle="Traditional" />

                                </td>
                            </tr>
                        </table>
                    
                    </td>
                </tr>
                </table>
        </ContentTemplate>
        
    </asp:UpdatePanel>
</div>
