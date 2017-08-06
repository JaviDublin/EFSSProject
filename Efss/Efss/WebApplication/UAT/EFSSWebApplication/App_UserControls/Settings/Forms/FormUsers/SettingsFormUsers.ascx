<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SettingsFormUsers.ascx.cs" Inherits="APP.App_UserControls.Settings.Forms.FormUsers.SettingsFormUsers" %>
<asp:UpdatePanel ID="UpdatePanelFormusers" runat="server" ChildrenAsTriggers="false"
    UpdateMode="Conditional">
    <ContentTemplate>
        <table width="100%">
            <tr>
                <td align="left">
                    <asp:Label runat="server" ID="LabelUsersTitle" Text="Users Details" CssClass="LabelForm"
                        Font-Underline="true"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" class="tableFilterHeader">
                    <table>
                        <tr>
                            <td>
                                <uc:UCButtonCommand runat="server" ID="ButtonCommandInsert" CausesValidation="false"
                                    ButtonCommandName="Insert" ButtonImageUrl="~/App_Images/Command-Insert.png"
                                    OnCommand="OnCommand" ButtonText="Add New User" />

                            </td>
                            <td>
                                <uc:UCButtonCommand runat="server" ID="ButtonCommandSave" CausesValidation="true"
                                    ValidationGroup="UsersRacfId" ButtonCommandName="Save" ButtonImageUrl="~/App_Images/SaveHS.png"
                                    OnCommand="OnCommand" ButtonText="Save" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="left" class="contentboxheader">
                    <asp:Label runat="server" ID="LabelHeaderDetails" Text="User Details" CssClass="LabelForm2"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" class="contentboxForm">
                    <table>
                        <tr>
                            <td align="left" style="width: 120px;">
                                Name
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxUserName" CssClass="TextBoxForm"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 120px;">
                                Surame
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxSurname" CssClass="TextBoxForm"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 120px;">
                                Racf Id
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxRacfId" CssClass="TextBoxForm"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorRacfId" runat="server" ControlToValidate="TextBoxRacfId"
                                    ValidationGroup="UsersRacfId" EnableViewState="false" ErrorMessage="*" Font-Bold="True"
                                    ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 120px;">
                                Email
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxEmail" CssClass="TextBoxForm"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 120px;">
                                Phone
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="TextBoxPhone" CssClass="TextBoxForm"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 120px;">
                                Role
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="DropDownListRoles" DataSourceID="sdsRoles" DataTextField="RoleName"
                                    CssClass="dropdownForm" DataValueField="RoleId">
                                </asp:DropDownList>
                                <asp:SqlDataSource runat="server" ID="sdsRoles" ConnectionString="<%$ ConnectionStrings:RAD.Properties.Settings.ApplicationDataBase %>"
                                    SelectCommand="SELECT [RoleId], [RoleName] FROM [Application.Roles]"></asp:SqlDataSource>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </ContentTemplate>
</asp:UpdatePanel>
