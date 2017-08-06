<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FleetCashForm.ascx.cs" Inherits="APP.App_UserControls.Reports.FleetCashForm" %>
<asp:UpdatePanel runat="server" ID="UpdatePanelFleetCash" UpdateMode="Conditional"
    ChildrenAsTriggers="false">
    <ContentTemplate>
        <table width="100%">
            <tr>
                <td align="left">
                    <asp:Label runat="server" ID="LabelFleetCashTitle" Text="Fleet Cash Targets" CssClass="LabelForm"
                        Font-Underline="true"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" class="tableFilterHeader">
                    <table>
                        <tr>
                            <td>
                                <uc:UCButtonCommand runat="server" ID="ButtonCommandExport" CausesValidation="false"
                                    ButtonCommandName="Export" ButtonImageUrl="~/App_Images/page_excel.png" OnCommand="OnCommand"
                                    ButtonText="Export To excel" />
                            </td>
                            <td>
                                <uc:UCButtonCommand runat="server" ID="ButtonCommandSave" CausesValidation="true"
                                    ButtonCommandName="Save" ButtonImageUrl="~/App_Images/SaveHS.png" OnCommand="OnCommand"
                                    ButtonText="Save" />
                            </td>
                            <td>
                                <asp:Image runat="server" ID="ImageSeparator" ImageUrl="~/App_Styles/Images/menu-bg.jpg" />
                            </td>
                             <td align="left">
                                    Day
                                </td>
                                <td align="left">
                                    <cc:DateTextBox runat="server" ID="txtReportDayDate" CssClass="TextBoxFormDate" 
                                        Width="100px" AutoPostBack="True" ontextchanged="txtReportDayDate_TextChanged"></cc:DateTextBox>
                                    <asp:ImageButton runat="server" ID="imgreportdaydate" ImageUrl="~/App_Images/calendar.png"
                                        ImageAlign="AbsBottom" />
                                    <asp:CalendarExtender runat="server" ID="dtRDD" TargetControlID="txtReportDayDate"
                                        Format="dd/MM/yyyy" PopupButtonID="imgreportdaydate" Enabled="true" CssClass="calendarClass">
                                    </asp:CalendarExtender>
                                </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="left" class="contentboxheader">
                    <asp:Label runat="server" ID="LabelHeaderReceivables" Text="Receivables" CssClass="LabelForm2"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" class="contentboxForm">
                    <table class="tableFleetCash">
                        <tr class="rowFleetCashHeader">
                            <td align="left" style="width: 120px;border-width: 0px;">
                            </td>
                            <td align="center" style="border-width: 0px;">
                                <b>Beg -
                                <br />
                                Balance</b>
                            </td>
                            <td align="center" style="border-width: 0px;">
                                <b>BB Dels
                                <br />
                                (+VAT)</b>
                            </td>
                            <td align="center" style="border-width: 0px;">
                                <b>End
                                <br />
                                Balance</b>
                            </td>
                            <td align="center" style="border-width: 0px;">
                               <b> CE
                                <br />
                                Target</b>
                            </td>
                            <td align="center" style="border-width: 0px;">
                                <b>Collection
                                <br />
                                Target</b>
                            </td>
                            <td align="center" style="border-width: 0px;">
                                <b>Collection
                                <br />
                                MTD</b>
                            </td>
                            <td align="center" style="border-width: 0px;">
                               <b> Expected
                                <br />
                                Collection</b>
                            </td>
                            <td align="center" style="border-width: 0px;">
                                <b>Variance
                                <br />
                                (Fav)/Adv</b>
                            </td>
                            <td align="center" style="border-width: 0px;">
                                <b>Comments</b>
                            </td>
                        </tr>
                        <tr class="rowFleetCash">
                            <td class="cellcountry">
                                Belux
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtBLXRecBalanceInit" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtBLXRecBalanceVat" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtBLXRecBalanceEnd" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtBLXRecTargetCE" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtBLXRecCollection" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtBLXRecMtd" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <table>
                                    <tr>
                                        <td>
                                            <cc:NumericLargeTextBox ID="txtBLXRecExpected" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                                        </td>
                                        <td>
                                            <asp:Image ID="ImageHoverBLXRecExpected" runat="server" ImageUrl="~/App_Images/listview-hover.gif" />
                                            <%--onMouseOver="$find('pceBLXRecExpected').showPopup();"--%>
                                            <asp:PopupControlExtender ID="PopupControlBLXRecExpected" runat="server" TargetControlID="ImageHoverBLXRecExpected"
                                                PopupControlID="PanelHoverBLXRecExpected" Position="Top" OffsetX="-250" OffsetY="0"
                                                BehaviorID="pceBLXRecExpected">
                                            </asp:PopupControlExtender>
                                            <asp:Panel ID="PanelHoverBLXRecExpected" runat="server" CssClass="panel-DynamicHover-AccountsDashboard">
                                                <div class="div-ModalCloseDashboard">
                                                    <asp:Image ID="ImageCloseBLXRecExpected" runat="server" ImageUrl="~/App_Images/modal-close.gif"
                                                        onclick="$find('pceBLXRecExpected').hidePopup();" />
                                                </div>
                                                <asp:Panel ID="PanelDynamicContentBLXRecExpected" runat="server" CssClass="panel-HoverAccountsDashboard">
                                                    <asp:TextBox ID="TextBoxNotesBLXRecExpected" runat="server" Wrap="true" TextMode="MultiLine"
                                                        Width="400px" Height="130px" CssClass="TextBoxFormDashBoard" />
                                                </asp:Panel>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtBLXRecRemain" runat="server" CssClass="TextBoxFormDashBoard" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <asp:Image ID="ImageHoverBLXRecNotes" runat="server" ImageUrl="~/App_Images/listview-hover.gif" />
                                <%--onMouseOver="$find('pceBLXRecNotes').showPopup();"--%>
                                <asp:PopupControlExtender ID="PopupControlBLXRecNotes" runat="server" TargetControlID="ImageHoverBLXRecNotes"
                                    PopupControlID="PanelHoverBLXRecNotes" Position="Top" OffsetX="-250" OffsetY="0"
                                    BehaviorID="pceBLXRecNotes">
                                </asp:PopupControlExtender>
                                <asp:Panel ID="PanelHoverBLXRecNotes" runat="server" CssClass="panel-DynamicHover-AccountsDashboard">
                                    <div class="div-ModalCloseDashboard">
                                        <asp:Image ID="ImageCloseBLXRecNotes" runat="server" ImageUrl="~/App_Images/modal-close.gif"
                                            onclick="$find('pceBLXRecNotes').hidePopup();" />
                                    </div>
                                    <asp:Panel ID="PanelDynamicContentBLXRecNotes" runat="server" CssClass="panel-HoverAccountsDashboard">
                                        <asp:TextBox ID="txtBLXRecNotes" runat="server" Wrap="true" TextMode="MultiLine"
                                            CssClass="TextBoxFormDashBoard" Width="400px" Height="130px" />
                                    </asp:Panel>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr class="rowFleetCash">
                            <td class="cellcountry">
                                Germany
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtGERecBalanceInit" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtGERecBalanceVat" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtGERecBalanceEnd" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtGERecTargetCE" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtGERecCollection" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtGERecMtd" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <table>
                                    <tr>
                                        <td>
                                            <cc:NumericLargeTextBox ID="txtGERecExpected" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                                        </td>
                                        <td>
                                            <asp:Image ID="ImageHoverGERecExpected" runat="server" ImageUrl="~/App_Images/listview-hover.gif" />
                                            <%--  onMouseOver="$find('pceGERecExpected').showPopup();"--%>
                                            <asp:PopupControlExtender ID="PopupControlGERecExpected" runat="server" TargetControlID="ImageHoverGERecExpected"
                                                PopupControlID="PanelHoverGERecExpected" Position="Top" OffsetX="-250" OffsetY="0"
                                                BehaviorID="pceGERecExpected">
                                            </asp:PopupControlExtender>
                                            <asp:Panel ID="PanelHoverGERecExpected" runat="server" CssClass="panel-DynamicHover-AccountsDashboard">
                                                <div class="div-ModalCloseDashboard">
                                                    <asp:Image ID="ImageCloseGERecExpected" runat="server" ImageUrl="~/App_Images/modal-close.gif"
                                                        onclick="$find('pceGERecExpected').hidePopup();" />
                                                </div>
                                                <asp:Panel ID="PanelDynamicContentGERecExpected" runat="server" CssClass="panel-HoverAccountsDashboard">
                                                    <asp:TextBox ID="TextBoxNotesGERecExpected" runat="server" Wrap="true" TextMode="MultiLine"
                                                        Width="400px" Height="130" CssClass="TextBoxFormDashBoard" />
                                                </asp:Panel>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtGERecRemain" runat="server" CssClass="TextBoxFormDashBoard" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <asp:Image ID="ImageHoverGERecNotes" runat="server" ImageUrl="~/App_Images/listview-hover.gif" />
                                <%--onMouseOver="$find('pceGERecNotes').showPopup();"--%>
                                <asp:PopupControlExtender ID="PopupControlGERecNotes" runat="server" TargetControlID="ImageHoverGERecNotes"
                                    PopupControlID="PanelHoverGERecNotes" Position="Top" OffsetX="-250" OffsetY="0"
                                    BehaviorID="pceGERecNotes">
                                </asp:PopupControlExtender>
                                <asp:Panel ID="PanelHoverGERecNotes" runat="server" CssClass="panel-DynamicHover-AccountsDashboard">
                                    <div class="div-ModalCloseDashboard">
                                        <asp:Image ID="ImageCloseGERecNotes" runat="server" ImageUrl="~/App_Images/modal-close.gif"
                                            onclick="$find('pceGERecNotes').hidePopup();" />
                                    </div>
                                    <asp:Panel ID="PanelDynamicContentGERecNotes" runat="server" CssClass="panel-HoverAccountsDashboard">
                                        <asp:TextBox ID="txtGERecNotes" runat="server" Wrap="true" TextMode="MultiLine" Width="400px"
                                            Height="130px" CssClass="TextBoxFormDashBoard" />
                                    </asp:Panel>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr class="rowFleetCash">
                            <td class="cellcountry">
                                Netherlands
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtNERecBalanceInit" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtNERecBalanceVat" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtNERecBalanceEnd" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtNERecTargetCE" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtNERecCollection" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtNERecMtd" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <table>
                                    <tr>
                                        <td>
                                            <cc:NumericLargeTextBox ID="txtNERecExpected" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                                        </td>
                                        <td>
                                            <asp:Image ID="ImageHoverNERecExpected" runat="server" ImageUrl="~/App_Images/listview-hover.gif" />
                                            <%--onMouseOver="$find('pceNERecExpected').showPopup();"--%>
                                            <asp:PopupControlExtender ID="PopupControlNERecExpected" runat="server" TargetControlID="ImageHoverNERecExpected"
                                                PopupControlID="PanelHoverNERecExpected" Position="Top" OffsetX="-250" OffsetY="0"
                                                BehaviorID="pceNERecExpected">
                                            </asp:PopupControlExtender>
                                            <asp:Panel ID="PanelHoverNERecExpected" runat="server" CssClass="panel-DynamicHover-AccountsDashboard">
                                                <div class="div-ModalCloseDashboard">
                                                    <asp:Image ID="ImageCloseNERecExpected" runat="server" ImageUrl="~/App_Images/modal-close.gif"
                                                        onclick="$find('pceNERecExpected').hidePopup();" />
                                                </div>
                                                <asp:Panel ID="PanelDynamicContentNERecExpected" runat="server" CssClass="panel-HoverAccountsDashboard">
                                                    <asp:TextBox ID="TextBoxNotesNERecExpected" runat="server" Wrap="true" TextMode="MultiLine"
                                                        Width="400px" Height="130px" CssClass="TextBoxFormDashBoardNotes" />
                                                </asp:Panel>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtNERecRemain" runat="server" CssClass="TextBoxFormDashBoard" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <asp:Image ID="ImageHoverNERecNotes" runat="server" ImageUrl="~/App_Images/listview-hover.gif" />
                                <%--onMouseOver="$find('pceNERecNotes').showPopup();"--%>
                                <asp:PopupControlExtender ID="PopupControlNERecNotes" runat="server" TargetControlID="ImageHoverNERecNotes"
                                    PopupControlID="PanelHoverNERecNotes" Position="Top" OffsetX="-250" OffsetY="0"
                                    BehaviorID="pceNERecNotes">
                                </asp:PopupControlExtender>
                                <asp:Panel ID="PanelHoverNERecNotes" runat="server" CssClass="panel-DynamicHover-AccountsDashboard">
                                    <div class="div-ModalCloseDashboard">
                                        <asp:Image ID="ImageCloseNERecNotes" runat="server" ImageUrl="~/App_Images/modal-close.gif"
                                            onclick="$find('pceNERecNotes').hidePopup();" />
                                    </div>
                                    <asp:Panel ID="PanelDynamicContentNERecNotes" runat="server" CssClass="panel-HoverAccountsDashboard">
                                        <asp:TextBox ID="txtNERecNotes" runat="server" Wrap="true" TextMode="MultiLine" Width="400px"
                                            Height="130px" CssClass="TextBoxFormDashBoardNotes" />
                                    </asp:Panel>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr class="rowFleetCash">
                            <td class="cellcountry">
                                Switzerland
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtSZRecBalanceInit" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtSZRecBalanceVat" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtSZRecBalanceEnd" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtSZRecTargetCE" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtSZRecCollection" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtSZRecMtd" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <table>
                                    <tr>
                                        <td>
                                            <cc:NumericLargeTextBox ID="txtSZRecExpected" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                                        </td>
                                        <td>
                                            <asp:Image ID="ImageHoverSZRecExpected" runat="server" ImageUrl="~/App_Images/listview-hover.gif" />
                                            <%--onMouseOver="$find('pceSZRecExpected').showPopup();"--%>
                                            <asp:PopupControlExtender ID="PopupcontrolsFleetCashZRecExpected" runat="server"
                                                TargetControlID="ImageHoverSZRecExpected" PopupControlID="PanelHoverSZRecExpected"
                                                Position="Top" OffsetX="-250" OffsetY="0" BehaviorID="pceSZRecExpected">
                                            </asp:PopupControlExtender>
                                            <asp:Panel ID="PanelHoverSZRecExpected" runat="server" CssClass="panel-DynamicHover-AccountsDashboard">
                                                <div class="div-ModalCloseDashboard">
                                                    <asp:Image ID="ImageCloseSZRecExpected" runat="server" ImageUrl="~/App_Images/modal-close.gif"
                                                        onclick="$find('pceSZRecExpected').hidePopup();" />
                                                </div>
                                                <asp:Panel ID="PanelDynamicContentSZRecExpected" runat="server" CssClass="panel-HoverAccountsDashboard">
                                                    <asp:TextBox ID="TextBoxNotesSZRecExpected" runat="server" Wrap="true" TextMode="MultiLine"
                                                        Width="400px" Height="130px" CssClass="TextBoxFormDashBoardNotes" />
                                                </asp:Panel>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtSZRecRemain" runat="server" CssClass="TextBoxFormDashBoard" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <asp:Image ID="ImageHoverSZRecNotes" runat="server" ImageUrl="~/App_Images/listview-hover.gif" />
                                <%--onMouseOver="$find('pceSZRecNotes').showPopup();"--%>
                                <asp:PopupControlExtender ID="PopupcontrolsFleetCashZRecNotes" runat="server" TargetControlID="ImageHoverSZRecNotes"
                                    PopupControlID="PanelHoverSZRecNotes" Position="Top" OffsetX="-250" OffsetY="0"
                                    BehaviorID="pceSZRecNotes">
                                </asp:PopupControlExtender>
                                <asp:Panel ID="PanelHoverSZRecNotes" runat="server" CssClass="panel-DynamicHover-AccountsDashboard">
                                    <div class="div-ModalCloseDashboard">
                                        <asp:Image ID="ImageCloseSZRecNotes" runat="server" ImageUrl="~/App_Images/modal-close.gif"
                                            onclick="$find('pceSZRecNotes').hidePopup();" />
                                    </div>
                                    <asp:Panel ID="PanelDynamicContentSZRecNotes" runat="server" CssClass="panel-HoverAccountsDashboard">
                                        <asp:TextBox ID="txtSZRecNotes" runat="server" Wrap="true" TextMode="MultiLine" Width="400px"
                                            Height="130px" CssClass="TextBoxFormDashBoardNotes" />
                                    </asp:Panel>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr class="rowFleetCash">
                            <td class="cellcountry">
                                UK RAC
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtUKRecBalanceInit" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtUKRecBalanceVat" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtUKRecBalanceEnd" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtUKRecTargetCE" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtUKRecCollection" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtUKRecMtd" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <table>
                                    <tr>
                                        <td>
                                            <cc:NumericLargeTextBox ID="txtUKRecExpected" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                                        </td>
                                        <td>
                                            <asp:Image ID="ImageHoverUKRecExpected" runat="server" ImageUrl="~/App_Images/listview-hover.gif" />
                                            <%--onMouseOver="$find('pceUKRecExpected').showPopup();"--%>
                                            <asp:PopupControlExtender ID="PopupControlUKRecExpected" runat="server" TargetControlID="ImageHoverUKRecExpected"
                                                PopupControlID="PanelHoverUKRecExpected" Position="Top" OffsetX="-250" OffsetY="0"
                                                BehaviorID="pceUKRecExpected">
                                            </asp:PopupControlExtender>
                                            <asp:Panel ID="PanelHoverUKRecExpected" runat="server" CssClass="panel-DynamicHover-AccountsDashboard">
                                                <div class="div-ModalCloseDashboard">
                                                    <asp:Image ID="ImageCloseUKRecExpected" runat="server" ImageUrl="~/App_Images/modal-close.gif"
                                                        onclick="$find('pceUKRecExpected').hidePopup();" />
                                                </div>
                                                <asp:Panel ID="PanelDynamicContentUKRecExpected" runat="server" CssClass="panel-HoverAccountsDashboard">
                                                    <asp:TextBox ID="TextBoxNotesUKRecExpected" runat="server" Wrap="true" TextMode="MultiLine"
                                                        Width="400px" Height="130px" CssClass="TextBoxFormDashBoardNotes" />
                                                </asp:Panel>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtUKRecRemain" runat="server" CssClass="TextBoxFormDashBoard" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <asp:Image ID="ImageHoverUKRecNotes" runat="server" ImageUrl="~/App_Images/listview-hover.gif" />
                                <%--onMouseOver="$find('pceUKRecNotes').showPopup();"--%>
                                <asp:PopupControlExtender ID="PopupControlUKRecNotes" runat="server" TargetControlID="ImageHoverUKRecNotes"
                                    PopupControlID="PanelHoverUKRecNotes" Position="Top" OffsetX="-250" OffsetY="0"
                                    BehaviorID="pceUKRecNotes">
                                </asp:PopupControlExtender>
                                <asp:Panel ID="PanelHoverUKRecNotes" runat="server" CssClass="panel-DynamicHover-AccountsDashboard">
                                    <div class="div-ModalCloseDashboard">
                                        <asp:Image ID="ImageCloseUKRecNotes" runat="server" ImageUrl="~/App_Images/modal-close.gif"
                                            onclick="$find('pceUKRecNotes').hidePopup();" />
                                    </div>
                                    <asp:Panel ID="PanelDynamicContentUKRecNotes" runat="server" CssClass="panel-HoverAccountsDashboard">
                                        <asp:TextBox ID="txtUKRecNotes" runat="server" Wrap="true" TextMode="MultiLine" Width="400px"
                                            Height="130px" CssClass="TextBoxFormDashBoardNotes" />
                                    </asp:Panel>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr class="rowTotal">
                            <td class="cellcountry">
                                <b>Region North</b>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtRNRecBalanceInit" ReadOnly="true" runat="server" CssClass="TextBoxFormDashBoardTotal" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtRNRecBalanceVat" ReadOnly="true" runat="server" CssClass="TextBoxFormDashBoardTotal" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtRNRecBalanceEnd" ReadOnly="true" runat="server" CssClass="TextBoxFormDashBoardTotal" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtRNRecTargetCE" ReadOnly="true" runat="server" CssClass="TextBoxFormDashBoardTotal" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtRNRecCollection" ReadOnly="true" runat="server" CssClass="TextBoxFormDashBoardTotal" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtRNRecMtd" ReadOnly="true" runat="server" CssClass="TextBoxFormDashBoardTotal" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputleft">
                                <cc:NumericLargeTextBox ID="txtRNRecExpected" ReadOnly="true" runat="server" CssClass="TextBoxFormDashBoardTotal" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtRNRecRemain" ReadOnly="true" runat="server" CssClass="TextBoxFormDashBoardTotal" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                            </td>
                        </tr>
                        <tr class="rowFleetCash">
                            <td class="cellcountry">
                                France
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtFRRecBalanceInit" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtFRRecBalanceVat" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtFRRecBalanceEnd" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtFRRecTargetCE" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtFRRecCollection" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtFRRecMtd" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <table>
                                    <tr>
                                        <td>
                                            <cc:NumericLargeTextBox ID="txtFRRecExpected" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                                        </td>
                                        <td>
                                            <asp:Image ID="ImageHoverFRRecExpected" runat="server" ImageUrl="~/App_Images/listview-hover.gif" />
                                            <%--onMouseOver="$find('pceFRRecExpected').showPopup();"--%>
                                            <asp:PopupControlExtender ID="PopupControlFRRecExpected" runat="server" TargetControlID="ImageHoverFRRecExpected"
                                                PopupControlID="PanelHoverFRRecExpected" Position="Top" OffsetX="-250" OffsetY="0"
                                                BehaviorID="pceFRRecExpected">
                                            </asp:PopupControlExtender>
                                            <asp:Panel ID="PanelHoverFRRecExpected" runat="server" CssClass="panel-DynamicHover-AccountsDashboard">
                                                <div class="div-ModalCloseDashboard">
                                                    <asp:Image ID="ImageCloseFRRecExpected" runat="server" ImageUrl="~/App_Images/modal-close.gif"
                                                        onclick="$find('pceFRRecExpected').hidePopup();" />
                                                </div>
                                                <asp:Panel ID="PanelDynamicContentFRRecExpected" runat="server" CssClass="panel-HoverAccountsDashboard">
                                                    <asp:TextBox ID="TextBoxNotesFRRecExpected" runat="server" Wrap="true" TextMode="MultiLine"
                                                        Width="400px" Height="130px" CssClass="TextBoxFormDashBoardNotes" />
                                                </asp:Panel>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtFRRecRemain" runat="server" CssClass="TextBoxFormDashBoard" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <asp:Image ID="ImageHoverFRRecNotes" runat="server" ImageUrl="~/App_Images/listview-hover.gif" />
                                <%--onMouseOver="$find('pceFRRecNotes').showPopup();"--%>
                                <asp:PopupControlExtender ID="PopupControlFRRecNotes" runat="server" TargetControlID="ImageHoverFRRecNotes"
                                    PopupControlID="PanelHoverFRRecNotes" Position="Top" OffsetX="-250" OffsetY="0"
                                    BehaviorID="pceFRRecNotes">
                                </asp:PopupControlExtender>
                                <asp:Panel ID="PanelHoverFRRecNotes" runat="server" CssClass="panel-DynamicHover-AccountsDashboard">
                                    <div class="div-ModalCloseDashboard">
                                        <asp:Image ID="ImageCloseFRRecNotes" runat="server" ImageUrl="~/App_Images/modal-close.gif"
                                            onclick="$find('pceFRRecNotes').hidePopup();" />
                                    </div>
                                    <asp:Panel ID="PanelDynamicContentFRRecNotes" runat="server" CssClass="panel-HoverAccountsDashboard">
                                        <asp:TextBox ID="txtFRRecNotes" runat="server" Wrap="true" TextMode="MultiLine" Width="400px"
                                            Height="130px" CssClass="TextBoxFormDashBoardNotes" />
                                    </asp:Panel>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr class="rowFleetCash">
                            <td class="cellcountry">
                                Italy
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtITRecBalanceInit" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtITRecBalanceVat" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtITRecBalanceEnd" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtITRecTargetCE" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtITRecCollection" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtITRecMtd" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <table>
                                    <tr>
                                        <td>
                                            <cc:NumericLargeTextBox ID="txtITRecExpected" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                                        </td>
                                        <td>
                                            <asp:Image ID="ImageHoverITRecExpected" runat="server" ImageUrl="~/App_Images/listview-hover.gif" />
                                            <%--onMouseOver="$find('pceITRecExpected').showPopup();"--%>
                                            <asp:PopupControlExtender ID="PopupControlITRecExpected" runat="server" TargetControlID="ImageHoverITRecExpected"
                                                PopupControlID="PanelHoverITRecExpected" Position="Top" OffsetX="-250" OffsetY="0"
                                                BehaviorID="pceITRecExpected">
                                            </asp:PopupControlExtender>
                                            <asp:Panel ID="PanelHoverITRecExpected" runat="server" CssClass="panel-DynamicHover-AccountsDashboard">
                                                <div class="div-ModalCloseDashboard">
                                                    <asp:Image ID="ImageCloseITRecExpected" runat="server" ImageUrl="~/App_Images/modal-close.gif"
                                                        onclick="$find('pceITRecExpected').hidePopup();" />
                                                </div>
                                                <asp:Panel ID="PanelDynamicContentITRecExpected" runat="server" CssClass="panel-HoverAccountsDashboard">
                                                    <asp:TextBox ID="TextBoxNotesITRecExpected" runat="server" Wrap="true" TextMode="MultiLine"
                                                        Width="400px" Height="130px" CssClass="TextBoxFormDashBoardNotes" />
                                                </asp:Panel>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtITRecRemain" runat="server" CssClass="TextBoxFormDashBoard" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <asp:Image ID="ImageHoverITRecNotes" runat="server" ImageUrl="~/App_Images/listview-hover.gif" />
                                <%--onMouseOver="$find('pceITRecNotes').showPopup();"--%>
                                <asp:PopupControlExtender ID="PopupControlITRecNotes" runat="server" TargetControlID="ImageHoverITRecNotes"
                                    PopupControlID="PanelHoverITRecNotes" Position="Top" OffsetX="-250" OffsetY="0"
                                    BehaviorID="pceITRecNotes">
                                </asp:PopupControlExtender>
                                <asp:Panel ID="PanelHoverITRecNotes" runat="server" CssClass="panel-DynamicHover-AccountsDashboard">
                                    <div class="div-ModalCloseDashboard">
                                        <asp:Image ID="ImageCloseITRecNotes" runat="server" ImageUrl="~/App_Images/modal-close.gif"
                                            onclick="$find('pceITRecNotes').hidePopup();" />
                                    </div>
                                    <asp:Panel ID="PanelDynamicContentITRecNotes" runat="server" CssClass="panel-HoverAccountsDashboard">
                                        <asp:TextBox ID="txtITRecNotes" runat="server" Wrap="true" TextMode="MultiLine" Width="400px"
                                            Height="130px" CssClass="TextBoxFormDashBoardNotes" />
                                    </asp:Panel>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr class="rowFleetCash">
                            <td class="cellcountry">
                                Spain
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtSPRecBalanceInit" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtSPRecBalanceVat" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtSPRecBalanceEnd" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtSPRecTargetCE" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtSPRecCollection" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtSPRecMtd" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <table>
                                    <tr>
                                        <td>
                                            <cc:NumericLargeTextBox ID="txtSPRecExpected" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                                        </td>
                                        <td>
                                            <asp:Image ID="ImageHoverSPRecExpected" runat="server" ImageUrl="~/App_Images/listview-hover.gif" />
                                            <%--onMouseOver="$find('pceSPRecExpected').showPopup();"--%>
                                            <asp:PopupControlExtender ID="PopupcontrolsFleetCashPRecExpected" runat="server"
                                                TargetControlID="ImageHoverSPRecExpected" PopupControlID="PanelHoverSPRecExpected"
                                                Position="Top" OffsetX="-250" OffsetY="0" BehaviorID="pceSPRecExpected">
                                            </asp:PopupControlExtender>
                                            <asp:Panel ID="PanelHoverSPRecExpected" runat="server" CssClass="panel-DynamicHover-AccountsDashboard">
                                                <div class="div-ModalCloseDashboard">
                                                    <asp:Image ID="ImageCloseSPRecExpected" runat="server" ImageUrl="~/App_Images/modal-close.gif"
                                                        onclick="$find('pceSPRecExpected').hidePopup();" />
                                                </div>
                                                <asp:Panel ID="PanelDynamicContentSPRecExpected" runat="server" CssClass="panel-HoverAccountsDashboard">
                                                    <asp:TextBox ID="TextBoxNotesSPRecExpected" runat="server" Wrap="true" TextMode="MultiLine"
                                                        Width="400px" Height="130px" CssClass="TextBoxFormDashBoardNotes" />
                                                </asp:Panel>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtSPRecRemain" runat="server" CssClass="TextBoxFormDashBoard" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <asp:Image ID="ImageHoverSPRecNotes" runat="server" ImageUrl="~/App_Images/listview-hover.gif" />
                                <%--onMouseOver="$find('pceSPRecNotes').showPopup();"--%>
                                <asp:PopupControlExtender ID="PopupcontrolsFleetCashPRecNotes" runat="server" TargetControlID="ImageHoverSPRecNotes"
                                    PopupControlID="PanelHoverSPRecNotes" Position="Top" OffsetX="-250" OffsetY="0"
                                    BehaviorID="pceSPRecNotes">
                                </asp:PopupControlExtender>
                                <asp:Panel ID="PanelHoverSPRecNotes" runat="server" CssClass="panel-DynamicHover-AccountsDashboard">
                                    <div class="div-ModalCloseDashboard">
                                        <asp:Image ID="ImageCloseSPRecNotes" runat="server" ImageUrl="~/App_Images/modal-close.gif"
                                            onclick="$find('pceSPRecNotes').hidePopup();" />
                                    </div>
                                    <asp:Panel ID="PanelDynamicContentSPRecNotes" runat="server" CssClass="panel-HoverAccountsDashboard">
                                        <asp:TextBox ID="txtSPRecNotes" runat="server" Wrap="true" TextMode="MultiLine" Width="400px"
                                            Height="130px" CssClass="TextBoxFormDashBoardNotes" />
                                    </asp:Panel>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr class="rowTotal">
                            <td class="cellcountry">
                                <b>Region South</b>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtRSRecBalanceInit" runat="server" CssClass="TextBoxFormDashBoardTotal"
                                    ReadOnly="True" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtRSRecBalanceVat" runat="server" CssClass="TextBoxFormDashBoardTotal"
                                    ReadOnly="True" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtRSRecBalanceEnd" runat="server" CssClass="TextBoxFormDashBoardTotal"
                                    ReadOnly="True" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtRSRecTargetCE" runat="server" CssClass="TextBoxFormDashBoardTotal"
                                    ReadOnly="True" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtRSRecCollection" runat="server" CssClass="TextBoxFormDashBoardTotal"
                                    ReadOnly="True" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtRSRecMtd" runat="server" CssClass="TextBoxFormDashBoardTotal"
                                    ReadOnly="True" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputleft">
                                <cc:NumericLargeTextBox ID="txtRSRecExpected" runat="server" CssClass="TextBoxFormDashBoardTotal"
                                    ReadOnly="True" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtRSRecRemain" runat="server" CssClass="TextBoxFormDashBoardTotal"
                                    ReadOnly="True" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                            </td>
                        </tr>
                        <tr class="rowTotal">
                            <td class="cellcountry">
                                <b>Total</b>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtTTRecBalanceInit" runat="server" CssClass="TextBoxFormDashBoardTotal"
                                    ReadOnly="True" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtTTRecBalanceVat" runat="server" CssClass="TextBoxFormDashBoardTotal"
                                    ReadOnly="True" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtTTRecBalanceEnd" runat="server" CssClass="TextBoxFormDashBoardTotal"
                                    ReadOnly="True" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtTTRecTargetCE" runat="server" CssClass="TextBoxFormDashBoardTotal"
                                    ReadOnly="True" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtTTRecCollection" runat="server" CssClass="TextBoxFormDashBoardTotal"
                                    ReadOnly="True" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtTTRecMtd" runat="server" CssClass="TextBoxFormDashBoardTotal"
                                    ReadOnly="True" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputleft">
                                <cc:NumericLargeTextBox ID="txtTTRecExpected" runat="server" CssClass="TextBoxFormDashBoardTotal"
                                    ReadOnly="True" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtTTRecRemain" runat="server" CssClass="TextBoxFormDashBoardTotal"
                                    ReadOnly="True" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="left" class="contentboxheader">
                    <asp:Label runat="server" ID="LabelHeaderPayables" Text="Payables" CssClass="LabelForm2"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" class="contentboxForm">
                    <table class="tableFleetCash">
                        <tr class="rowFleetCashHeader">
                            <td align="left" style="width: 120px;">
                            </td>
                            <td align="center">
                                <b>Beg -
                                <br />
                                Balance</b>
                            </td>
                            <td align="center">
                                <b>ADDs
                                <br />
                                (+VAT)</b>
                            </td>
                            <td align="center">
                                <b>End
                                <br />
                                Balance</b>
                            </td>
                            <td align="center">
                                <b>CE
                                <br />
                                Target</b>
                            </td>
                            <td align="center">
                                <b>Payment
                                <br />
                                Target</b>
                            </td>
                            <td align="center">
                                <b>Paid
                                <br />
                                MTD</b>
                            </td>
                            <td align="center">
                                <b>Schedule
                                <br />
                                To Pay</b>
                            </td>
                            <td align="center">
                                <b>Variance
                                <br />
                                (Fav)/Adv</b>
                            </td>
                            <td align="center">
                                <b>Comments</b>
                            </td>
                        </tr>
                        <tr>
                            <td class="cellcountry">
                                Belux
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtBLXPayBalanceInit" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtBLXPayBalanceVat" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtBLXPayBalanceEnd" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtBLXPayTargetCE" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtBLXPayCollection" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtBLXPayMtd" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <table>
                                    <tr>
                                        <td>
                                            <cc:NumericLargeTextBox ID="txtBLXPayExpected" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                                        </td>
                                        <td>
                                            <asp:Image ID="ImageHoverBLXPayExpected" runat="server" ImageUrl="~/App_Images/listview-hover.gif" />
                                            <%--onMouseOver="$find('pceBLXPayExpected').showPopup();" --%>
                                            <asp:PopupControlExtender ID="PopupControlBLXPayExpected" runat="server" TargetControlID="ImageHoverBLXPayExpected"
                                                PopupControlID="PanelHoverBLXPayExpected" Position="Top" OffsetX="-250" OffsetY="0"
                                                BehaviorID="pceBLXPayExpected">
                                            </asp:PopupControlExtender>
                                            <asp:Panel ID="PanelHoverBLXPayExpected" runat="server" CssClass="panel-DynamicHover-AccountsDashboard">
                                                <div class="div-ModalCloseDashboard">
                                                    <asp:Image ID="ImageCloseBLXPayExpected" runat="server" ImageUrl="~/App_Images/modal-close.gif"
                                                        onclick="$find('pceBLXPayExpected').hidePopup();" />
                                                </div>
                                                <asp:Panel ID="PanelDynamicContentBLXPayExpected" runat="server" CssClass="panel-HoverAccountsDashboard">
                                                    <asp:TextBox ID="TextBoxNotesBLXPayExpected" runat="server" Wrap="true" TextMode="MultiLine"
                                                        Width="400px" Height="130px" CssClass="TextBoxFormDashBoard" />
                                                </asp:Panel>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtBLXPayRemain" runat="server" CssClass="TextBoxFormDashBoard" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <asp:Image ID="ImageHoverBLXPayNotes" runat="server" ImageUrl="~/App_Images/listview-hover.gif" />
                                <%--onMouseOver="$find('pceBLXPayNotes').showPopup();"--%>
                                <asp:PopupControlExtender ID="PopupControlBLXPayNotes" runat="server" TargetControlID="ImageHoverBLXPayNotes"
                                    PopupControlID="PanelHoverBLXPayNotes" Position="Top" OffsetX="-250" OffsetY="0"
                                    BehaviorID="pceBLXPayNotes">
                                </asp:PopupControlExtender>
                                <asp:Panel ID="PanelHoverBLXPayNotes" runat="server" CssClass="panel-DynamicHover-AccountsDashboard">
                                    <div class="div-ModalCloseDashboard">
                                        <asp:Image ID="ImageCloseBLXPayNotes" runat="server" ImageUrl="~/App_Images/modal-close.gif"
                                            onclick="$find('pceBLXPayNotes').hidePopup();" />
                                    </div>
                                    <asp:Panel ID="PanelDynamicContentBLXPayNotes" runat="server" CssClass="panel-HoverAccountsDashboard">
                                        <asp:TextBox ID="txtBLXPayNotes" runat="server" Wrap="true" TextMode="MultiLine"
                                            Width="400px" Height="130px" CssClass="TextBoxFormDashBoard" />
                                    </asp:Panel>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td class="cellcountry">
                                Germany
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtGEPayBalanceInit" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtGEPayBalanceVat" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtGEPayBalanceEnd" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtGEPayTargetCE" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtGEPayCollection" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtGEPayMtd" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <table>
                                    <tr>
                                        <td>
                                            <cc:NumericLargeTextBox ID="txtGEPayExpected" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                                        </td>
                                        <td>
                                            <asp:Image ID="ImageHoverGEPayExpected" runat="server" ImageUrl="~/App_Images/listview-hover.gif" />
                                            <%--onMouseOver="$find('pceGEPayExpected').showPopup();"--%>
                                            <asp:PopupControlExtender ID="PopupControlGEPayExpected" runat="server" TargetControlID="ImageHoverGEPayExpected"
                                                PopupControlID="PanelHoverGEPayExpected" Position="Top" OffsetX="-250" OffsetY="0"
                                                BehaviorID="pceGEPayExpected">
                                            </asp:PopupControlExtender>
                                            <asp:Panel ID="PanelHoverGEPayExpected" runat="server" CssClass="panel-DynamicHover-AccountsDashboard">
                                                <div class="div-ModalCloseDashboard">
                                                    <asp:Image ID="ImageCloseGEPayExpected" runat="server" ImageUrl="~/App_Images/modal-close.gif"
                                                        onclick="$find('pceGEPayExpected').hidePopup();" />
                                                </div>
                                                <asp:Panel ID="PanelDynamicContentGEPayExpected" runat="server" CssClass="panel-HoverAccountsDashboard">
                                                    <asp:TextBox ID="TextBoxNotesGEPayExpected" runat="server" Wrap="true" TextMode="MultiLine"
                                                        Width="400px" Height="130px" CssClass="TextBoxFormDashBoard" />
                                                </asp:Panel>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtGEPayRemain" runat="server" CssClass="TextBoxFormDashBoard" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <asp:Image ID="ImageHoverGEPayNotes" runat="server" ImageUrl="~/App_Images/listview-hover.gif" />
                                <%--onMouseOver="$find('pceGEPayNotes').showPopup();"--%>
                                <asp:PopupControlExtender ID="PopupControlGEPayNotes" runat="server" TargetControlID="ImageHoverGEPayNotes"
                                    PopupControlID="PanelHoverGEPayNotes" Position="Top" OffsetX="-250" OffsetY="0"
                                    BehaviorID="pceGEPayNotes">
                                </asp:PopupControlExtender>
                                <asp:Panel ID="PanelHoverGEPayNotes" runat="server" CssClass="panel-DynamicHover-AccountsDashboard">
                                    <div class="div-ModalCloseDashboard">
                                        <asp:Image ID="ImageCloseGEPayNotes" runat="server" ImageUrl="~/App_Images/modal-close.gif"
                                            onclick="$find('pceGEPayNotes').hidePopup();" />
                                    </div>
                                    <asp:Panel ID="PanelDynamicContentGEPayNotes" runat="server" CssClass="panel-HoverAccountsDashboard">
                                        <asp:TextBox ID="txtGEPayNotes" runat="server" Wrap="true" TextMode="MultiLine" Width="400px"
                                            Height="130px" CssClass="TextBoxFormDashBoard" />
                                    </asp:Panel>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td class="cellcountry">
                                Netherlands
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtNEPayBalanceInit" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtNEPayBalanceVat" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtNEPayBalanceEnd" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtNEPayTargetCE" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtNEPayCollection" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtNEPayMtd" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <table>
                                    <tr>
                                        <td>
                                            <cc:NumericLargeTextBox ID="txtNEPayExpected" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                                        </td>
                                        <td>
                                            <asp:Image ID="ImageHoverNEPayExpected" runat="server" ImageUrl="~/App_Images/listview-hover.gif" />
                                            <%--onMouseOver="$find('pceNEPayExpected').showPopup();"--%>
                                            <asp:PopupControlExtender ID="PopupControlNEPayExpected" runat="server" TargetControlID="ImageHoverNEPayExpected"
                                                PopupControlID="PanelHoverNEPayExpected" Position="Top" OffsetX="-250" OffsetY="0"
                                                BehaviorID="pceNEPayExpected">
                                            </asp:PopupControlExtender>
                                            <asp:Panel ID="PanelHoverNEPayExpected" runat="server" CssClass="panel-DynamicHover-AccountsDashboard">
                                                <div class="div-ModalCloseDashboard">
                                                    <asp:Image ID="ImageCloseNEPayExpected" runat="server" ImageUrl="~/App_Images/modal-close.gif"
                                                        onclick="$find('pceNEPayExpected').hidePopup();" />
                                                </div>
                                                <asp:Panel ID="PanelDynamicContentNEPayExpected" runat="server" CssClass="panel-HoverAccountsDashboard">
                                                    <asp:TextBox ID="TextBoxNotesNEPayExpected" runat="server" Wrap="true" TextMode="MultiLine"
                                                        Width="400px" Height="130px" CssClass="TextBoxFormDashBoard" />
                                                </asp:Panel>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtNEPayRemain" runat="server" CssClass="TextBoxFormDashBoard" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <asp:Image ID="ImageHoverNEPayNotes" runat="server" ImageUrl="~/App_Images/listview-hover.gif" />
                                <%--onMouseOver="$find('pceNEPayNotes').showPopup();"--%>
                                <asp:PopupControlExtender ID="PopupControlNEPayNotes" runat="server" TargetControlID="ImageHoverNEPayNotes"
                                    PopupControlID="PanelHoverNEPayNotes" Position="Top" OffsetX="-250" OffsetY="0"
                                    BehaviorID="pceNEPayNotes">
                                </asp:PopupControlExtender>
                                <asp:Panel ID="PanelHoverNEPayNotes" runat="server" CssClass="panel-DynamicHover-AccountsDashboard">
                                    <div class="div-ModalCloseDashboard">
                                        <asp:Image ID="ImageCloseNEPayNotes" runat="server" ImageUrl="~/App_Images/modal-close.gif"
                                            onclick="$find('pceNEPayNotes').hidePopup();" />
                                    </div>
                                    <asp:Panel ID="PanelDynamicContentNEPayNotes" runat="server" CssClass="panel-HoverAccountsDashboard">
                                        <asp:TextBox ID="txtNEPayNotes" runat="server" Wrap="true" TextMode="MultiLine" Width="400px"
                                            Height="130px" CssClass="TextBoxFormDashBoard" />
                                    </asp:Panel>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td class="cellcountry">
                                Switzerland
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtSZPayBalanceInit" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtSZPayBalanceVat" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtSZPayBalanceEnd" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtSZPayTargetCE" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtSZPayCollection" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtSZPayMtd" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <table>
                                    <tr>
                                        <td>
                                            <cc:NumericLargeTextBox ID="txtSZPayExpected" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                                        </td>
                                        <td>
                                            <asp:Image ID="ImageHoverSZPayExpected" runat="server" ImageUrl="~/App_Images/listview-hover.gif" />
                                            <%--onMouseOver="$find('pceSZPayExpected').showPopup();"--%>
                                            <asp:PopupControlExtender ID="PopupcontrolsFleetCashZPayExpected" runat="server"
                                                TargetControlID="ImageHoverSZPayExpected" PopupControlID="PanelHoverSZPayExpected"
                                                Position="Top" OffsetX="-250" OffsetY="0" BehaviorID="pceSZPayExpected">
                                            </asp:PopupControlExtender>
                                            <asp:Panel ID="PanelHoverSZPayExpected" runat="server" CssClass="panel-DynamicHover-AccountsDashboard">
                                                <div class="div-ModalCloseDashboard">
                                                    <asp:Image ID="ImageCloseSZPayExpected" runat="server" ImageUrl="~/App_Images/modal-close.gif"
                                                        onclick="$find('pceSZPayExpected').hidePopup();" />
                                                </div>
                                                <asp:Panel ID="PanelDynamicContentSZPayExpected" runat="server" CssClass="panel-HoverAccountsDashboard">
                                                    <asp:TextBox ID="TextBoxNotesSZPayExpected" runat="server" Wrap="true" TextMode="MultiLine"
                                                        Width="400px" Height="130px" CssClass="TextBoxFormDashBoard" />
                                                </asp:Panel>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtSZPayRemain" runat="server" CssClass="TextBoxFormDashBoard" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <asp:Image ID="ImageHoverSZPayNotes" runat="server" ImageUrl="~/App_Images/listview-hover.gif" />
                                <%--onMouseOver="$find('pceSZPayNotes').showPopup();"--%>
                                <asp:PopupControlExtender ID="PopupcontrolsFleetCashZPayNotes" runat="server" TargetControlID="ImageHoverSZPayNotes"
                                    PopupControlID="PanelHoverSZPayNotes" Position="Top" OffsetX="-250" OffsetY="0"
                                    BehaviorID="pceSZPayNotes">
                                </asp:PopupControlExtender>
                                <asp:Panel ID="PanelHoverSZPayNotes" runat="server" CssClass="panel-DynamicHover-AccountsDashboard">
                                    <div class="div-ModalCloseDashboard">
                                        <asp:Image ID="ImageCloseSZPayNotes" runat="server" ImageUrl="~/App_Images/modal-close.gif"
                                            onclick="$find('pceSZPayNotes').hidePopup();" />
                                    </div>
                                    <asp:Panel ID="PanelDynamicContentSZPayNotes" runat="server" CssClass="panel-HoverAccountsDashboard">
                                        <asp:TextBox ID="txtSZPayNotes" runat="server" Wrap="true" TextMode="MultiLine" Width="400px"
                                            Height="130px" CssClass="TextBoxFormDashBoard" />
                                    </asp:Panel>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td class="cellcountry">
                                UK RAC
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtUKPayBalanceInit" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtUKPayBalanceVat" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtUKPayBalanceEnd" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtUKPayTargetCE" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtUKPayCollection" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtUKPayMtd" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <table>
                                    <tr>
                                        <td>
                                            <cc:NumericLargeTextBox ID="txtUKPayExpected" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                                        </td>
                                        <td>
                                            <asp:Image ID="ImageHoverUKPayExpected" runat="server" ImageUrl="~/App_Images/listview-hover.gif" />
                                            <%--onMouseOver="$find('pceUKPayExpected').showPopup();"--%>
                                            <asp:PopupControlExtender ID="PopupControlUKPayExpected" runat="server" TargetControlID="ImageHoverUKPayExpected"
                                                PopupControlID="PanelHoverUKPayExpected" Position="Top" OffsetX="-250" OffsetY="0"
                                                BehaviorID="pceUKPayExpected">
                                            </asp:PopupControlExtender>
                                            <asp:Panel ID="PanelHoverUKPayExpected" runat="server" CssClass="panel-DynamicHover-AccountsDashboard">
                                                <div class="div-ModalCloseDashboard">
                                                    <asp:Image ID="ImageCloseUKPayExpected" runat="server" ImageUrl="~/App_Images/modal-close.gif"
                                                        onclick="$find('pceUKPayExpected').hidePopup();" />
                                                </div>
                                                <asp:Panel ID="PanelDynamicContentUKPayExpected" runat="server" CssClass="panel-HoverAccountsDashboard">
                                                    <asp:TextBox ID="TextBoxNotesUKPayExpected" runat="server" Wrap="true" TextMode="MultiLine"
                                                        Width="400px" Height="130px" CssClass="TextBoxFormDashBoard" />
                                                </asp:Panel>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtUKPayRemain" runat="server" CssClass="TextBoxFormDashBoard" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <asp:Image ID="ImageHoverUKPayNotes" runat="server" ImageUrl="~/App_Images/listview-hover.gif" />
                                <%--onMouseOver="$find('pceUKPayNotes').showPopup();"--%>
                                <asp:PopupControlExtender ID="PopupControlUKPayNotes" runat="server" TargetControlID="ImageHoverUKPayNotes"
                                    PopupControlID="PanelHoverUKPayNotes" Position="Top" OffsetX="-250" OffsetY="0"
                                    BehaviorID="pceUKPayNotes">
                                </asp:PopupControlExtender>
                                <asp:Panel ID="PanelHoverUKPayNotes" runat="server" CssClass="panel-DynamicHover-AccountsDashboard">
                                    <div class="div-ModalCloseDashboard">
                                        <asp:Image ID="ImageCloseUKPayNotes" runat="server" ImageUrl="~/App_Images/modal-close.gif"
                                            onclick="$find('pceUKPayNotes').hidePopup();" />
                                    </div>
                                    <asp:Panel ID="PanelDynamicContentUKPayNotes" runat="server" CssClass="panel-HoverAccountsDashboard">
                                        <asp:TextBox ID="txtUKPayNotes" runat="server" Wrap="true" TextMode="MultiLine" Width="400px"
                                            Height="130px" CssClass="TextBoxFormDashBoard" />
                                    </asp:Panel>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr class="rowTotal">
                            <td class="cellcountry">
                                <b>Region North</b>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtRNPayBalanceInit" ReadOnly="true" runat="server" CssClass="TextBoxFormDashBoardTotal" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtRNPayBalanceVat" ReadOnly="true" runat="server" CssClass="TextBoxFormDashBoardTotal" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtRNPayBalanceEnd" ReadOnly="true" runat="server" CssClass="TextBoxFormDashBoardTotal" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtRNPayTargetCE" ReadOnly="true" runat="server" CssClass="TextBoxFormDashBoardTotal" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtRNPayCollection" ReadOnly="true" runat="server" CssClass="TextBoxFormDashBoardTotal" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtRNPayMtd" ReadOnly="true" runat="server" CssClass="TextBoxFormDashBoardTotal" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtRNPayExpected" ReadOnly="true" runat="server" CssClass="TextBoxFormDashBoardTotal" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtRNPayRemain" ReadOnly="true" runat="server" CssClass="TextBoxFormDashBoardTotal" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                        </tr>
                        <tr>
                            <td class="cellcountry">
                                France
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtFRPayBalanceInit" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtFRPayBalanceVat" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtFRPayBalanceEnd" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtFRPayTargetCE" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtFRPayCollection" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtFRPayMtd" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <table>
                                    <tr>
                                        <td>
                                            <cc:NumericLargeTextBox ID="txtFRPayExpected" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                                        </td>
                                        <td>
                                            <asp:Image ID="ImageHoverFRPayExpected" runat="server" ImageUrl="~/App_Images/listview-hover.gif" />
                                            <%--onMouseOver="$find('pceFRPayExpected').showPopup();"--%>
                                            <asp:PopupControlExtender ID="PopupControlFRPayExpected" runat="server" TargetControlID="ImageHoverFRPayExpected"
                                                PopupControlID="PanelHoverFRPayExpected" Position="Top" OffsetX="-250" OffsetY="0"
                                                BehaviorID="pceFRPayExpected">
                                            </asp:PopupControlExtender>
                                            <asp:Panel ID="PanelHoverFRPayExpected" runat="server" CssClass="panel-DynamicHover-AccountsDashboard">
                                                <div class="div-ModalCloseDashboard">
                                                    <asp:Image ID="ImageCloseFRPayExpected" runat="server" ImageUrl="~/App_Images/modal-close.gif"
                                                        onclick="$find('pceFRPayExpected').hidePopup();" />
                                                </div>
                                                <asp:Panel ID="PanelDynamicContentFRPayExpected" runat="server" CssClass="panel-HoverAccountsDashboard">
                                                    <asp:TextBox ID="TextBoxNotesFRPayExpected" runat="server" Wrap="true" TextMode="MultiLine"
                                                        Width="400px" Height="130px" CssClass="TextBoxFormDashBoard" />
                                                </asp:Panel>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtFRPayRemain" runat="server" CssClass="TextBoxFormDashBoard" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <asp:Image ID="ImageHoverFRPayNotes" runat="server" ImageUrl="~/App_Images/listview-hover.gif" />
                                <%--onMouseOver="$find('pceFRPayNotes').showPopup();"--%>
                                <asp:PopupControlExtender ID="PopupControlFRPayNotes" runat="server" TargetControlID="ImageHoverFRPayNotes"
                                    PopupControlID="PanelHoverFRPayNotes" Position="Top" OffsetX="-250" OffsetY="0"
                                    BehaviorID="pceFRPayNotes">
                                </asp:PopupControlExtender>
                                <asp:Panel ID="PanelHoverFRPayNotes" runat="server" CssClass="panel-DynamicHover-AccountsDashboard">
                                    <div class="div-ModalCloseDashboard">
                                        <asp:Image ID="ImageCloseFRPayNotes" runat="server" ImageUrl="~/App_Images/modal-close.gif"
                                            onclick="$find('pceFRPayNotes').hidePopup();" />
                                    </div>
                                    <asp:Panel ID="PanelDynamicContentFRPayNotes" runat="server" CssClass="panel-HoverAccountsDashboard">
                                        <asp:TextBox ID="txtFRPayNotes" runat="server" Wrap="true" TextMode="MultiLine" Width="400px"
                                            Height="130px" CssClass="TextBoxFormDashBoard" />
                                    </asp:Panel>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td class="cellcountry">
                                Italy
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtITPayBalanceInit" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtITPayBalanceVat" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtITPayBalanceEnd" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtITPayTargetCE" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtITPayCollection" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtITPayMtd" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <table>
                                    <tr>
                                        <td>
                                            <cc:NumericLargeTextBox ID="txtITPayExpected" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                                        </td>
                                        <td>
                                            <asp:Image ID="ImageHoverITPayExpected" runat="server" ImageUrl="~/App_Images/listview-hover.gif" />
                                            <%--onMouseOver="$find('pceITPayExpected').showPopup();"--%>
                                            <asp:PopupControlExtender ID="PopupControlITPayExpected" runat="server" TargetControlID="ImageHoverITPayExpected"
                                                PopupControlID="PanelHoverITPayExpected" Position="Top" OffsetX="-250" OffsetY="0"
                                                BehaviorID="pceITPayExpected">
                                            </asp:PopupControlExtender>
                                            <asp:Panel ID="PanelHoverITPayExpected" runat="server" CssClass="panel-DynamicHover-AccountsDashboard">
                                                <div class="div-ModalCloseDashboard">
                                                    <asp:Image ID="ImageCloseITPayExpected" runat="server" ImageUrl="~/App_Images/modal-close.gif"
                                                        onclick="$find('pceITPayExpected').hidePopup();" />
                                                </div>
                                                <asp:Panel ID="PanelDynamicContentITPayExpected" runat="server" CssClass="panel-HoverAccountsDashboard">
                                                    <asp:TextBox ID="TextBoxNotesITPayExpected" runat="server" Wrap="true" TextMode="MultiLine"
                                                        Width="400px" Height="130px" CssClass="TextBoxFormDashBoard" />
                                                </asp:Panel>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtITPayRemain" runat="server" CssClass="TextBoxFormDashBoard" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <asp:Image ID="ImageHoverITPayNotes" runat="server" ImageUrl="~/App_Images/listview-hover.gif" />
                                <%--onMouseOver="$find('pceITPayNotes').showPopup();"--%>
                                <asp:PopupControlExtender ID="PopupControlITPayNotes" runat="server" TargetControlID="ImageHoverITPayNotes"
                                    PopupControlID="PanelHoverITPayNotes" Position="Top" OffsetX="-250" OffsetY="0"
                                    BehaviorID="pceITPayNotes">
                                </asp:PopupControlExtender>
                                <asp:Panel ID="PanelHoverITPayNotes" runat="server" CssClass="panel-DynamicHover-AccountsDashboard">
                                    <div class="div-ModalCloseDashboard">
                                        <asp:Image ID="ImageCloseITPayNotes" runat="server" ImageUrl="~/App_Images/modal-close.gif"
                                            onclick="$find('pceITPayNotes').hidePopup();" />
                                    </div>
                                    <asp:Panel ID="PanelDynamicContentITPayNotes" runat="server" CssClass="panel-HoverAccountsDashboard">
                                        <asp:TextBox ID="txtITPayNotes" runat="server" Wrap="true" TextMode="MultiLine" Width="400px"
                                            Height="130px" CssClass="TextBoxFormDashBoard" />
                                    </asp:Panel>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td class="cellcountry">
                                Spain
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtSPPayBalanceInit" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtSPPayBalanceVat" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtSPPayBalanceEnd" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtSPPayTargetCE" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtSPPayCollection" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtSPPayMtd" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <table>
                                    <tr>
                                        <td>
                                            <cc:NumericLargeTextBox ID="txtSPPayExpected" runat="server" CssClass="TextBoxFormDashBoard"></cc:NumericLargeTextBox>
                                        </td>
                                        <td>
                                            <asp:Image ID="ImageHoverSPPayExpected" runat="server" ImageUrl="~/App_Images/listview-hover.gif" />
                                            <%--onMouseOver="$find('pceSPPayExpected').showPopup();"--%>
                                            <asp:PopupControlExtender ID="PopupcontrolsFleetCashPPayExpected" runat="server"
                                                TargetControlID="ImageHoverSPPayExpected" PopupControlID="PanelHoverSPPayExpected"
                                                Position="Top" OffsetX="-250" OffsetY="0" BehaviorID="pceSPPayExpected">
                                            </asp:PopupControlExtender>
                                            <asp:Panel ID="PanelHoverSPPayExpected" runat="server" CssClass="panel-DynamicHover-AccountsDashboard">
                                                <div class="div-ModalCloseDashboard">
                                                    <asp:Image ID="ImageCloseSPPayExpected" runat="server" ImageUrl="~/App_Images/modal-close.gif"
                                                        onclick="$find('pceSPPayExpected').hidePopup();" />
                                                </div>
                                                <asp:Panel ID="PanelDynamicContentSPPayExpected" runat="server" CssClass="panel-HoverAccountsDashboard">
                                                    <asp:TextBox ID="TextBoxNotesSPPayExpected" runat="server" Wrap="true" TextMode="MultiLine"
                                                        Width="400px" Height="130px" CssClass="TextBoxFormDashBoard" />
                                                </asp:Panel>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td class="cellinputbox">
                                <cc:NumericLargeTextBox ID="txtSPPayRemain" runat="server" CssClass="TextBoxFormDashBoard" Enabled="false"></cc:NumericLargeTextBox>
                            </td>
                            <td class="cellinputbox">
                                <asp:Image ID="ImageHoverSPPayNotes" runat="server" ImageUrl="~/App_Images/listview-hover.gif" />
                                <%--onMouseOver="$find('pceSPPayNotes').showPopup();"--%>
                                <asp:PopupControlExtender ID="PopupcontrolsFleetCashPPayNotes" runat="server" TargetControlID="ImageHoverSPPayNotes"
                                    PopupControlID="PanelHoverSPPayNotes" Position="Top" OffsetX="-250" OffsetY="0"
                                    BehaviorID="pceSPPayNotes">
                                </asp:PopupControlExtender>
                                <asp:Panel ID="PanelHoverSPPayNotes" runat="server" CssClass="panel-DynamicHover-AccountsDashboard">
                                    <div class="div-ModalCloseDashboard">
                                        <asp:Image ID="ImageCloseSPPayNotes" runat="server" ImageUrl="~/App_Images/modal-close.gif"
                                            onclick="$find('pceSPPayNotes').hidePopup();" />
                                    </div>
                                    <asp:Panel ID="PanelDynamicContentSPPayNotes" runat="server" CssClass="panel-HoverAccountsDashboard">
                                        <asp:TextBox ID="txtSPPayNotes" runat="server" Wrap="true" TextMode="MultiLine" Width="400px"
                                            Height="130px" CssClass="TextBoxFormDashBoard" />
                                    </asp:Panel>
                                </asp:Panel>
                            </td>

                           </tr>
                        <tr class="rowTotal">
                                <td class="cellcountry">
                                    <b>Region South</b>
                                </td>
                                <td class="cellinputbox">
                                    <cc:NumericLargeTextBox ID="txtRSPayBalanceInit" runat="server" CssClass="TextBoxFormDashBoardTotal"
                                        ReadOnly="True" Enabled="false"></cc:NumericLargeTextBox>
                                </td>
                                <td class="cellinputbox">
                                    <cc:NumericLargeTextBox ID="txtRSPayBalanceVat" runat="server" CssClass="TextBoxFormDashBoardTotal"
                                        ReadOnly="True" Enabled="false"></cc:NumericLargeTextBox>
                                </td>
                                <td class="cellinputbox">
                                    <cc:NumericLargeTextBox ID="txtRSPayBalanceEnd" runat="server" CssClass="TextBoxFormDashBoardTotal"
                                        ReadOnly="True" Enabled="false"></cc:NumericLargeTextBox>
                                </td>
                                <td class="cellinputbox">
                                    <cc:NumericLargeTextBox ID="txtRSPayTargetCE" runat="server" CssClass="TextBoxFormDashBoardTotal"
                                        ReadOnly="True" Enabled="false"></cc:NumericLargeTextBox>
                                </td>
                                <td class="cellinputbox">
                                    <cc:NumericLargeTextBox ID="txtRSPayCollection" runat="server" CssClass="TextBoxFormDashBoardTotal"
                                        ReadOnly="True" Enabled="false"></cc:NumericLargeTextBox>
                                </td>
                                <td class="cellinputbox">
                                    <cc:NumericLargeTextBox ID="txtRSPayMtd" runat="server" CssClass="TextBoxFormDashBoardTotal"
                                        ReadOnly="True" Enabled="false"></cc:NumericLargeTextBox>
                                </td>
                                <td class="cellinputbox">
                                    <cc:NumericLargeTextBox ID="txtRSPayExpected" runat="server" CssClass="TextBoxFormDashBoardTotal"
                                        ReadOnly="True" Enabled="false"></cc:NumericLargeTextBox>
                                </td>
                                <td class="cellinputbox">
                                    <cc:NumericLargeTextBox ID="txtRSPayRemain" runat="server" CssClass="TextBoxFormDashBoardTotal"
                                        ReadOnly="True" Enabled="false">
                                    </cc:NumericLargeTextBox>
                                </td>
                                <td class="cellinputbox">
                                </td>
                            </tr>
                        <tr class="rowTotal">
                                <td class="cellcountry">
                                    <b>Total</b>
                                </td>
                                <td class="cellinputbox">
                                    <cc:NumericLargeTextBox ID="txtTTPayBalanceInit" runat="server" CssClass="TextBoxFormDashBoardTotal"
                                        ReadOnly="True" Enabled="false"></cc:NumericLargeTextBox>
                                </td>
                                <td class="cellinputbox">
                                    <cc:NumericLargeTextBox ID="txtTTPayBalanceVat" runat="server" CssClass="TextBoxFormDashBoardTotal"
                                        ReadOnly="True" Enabled="false"></cc:NumericLargeTextBox>
                                </td>
                                <td class="cellinputbox">
                                    <cc:NumericLargeTextBox ID="txtTTPayBalanceEnd" runat="server" CssClass="TextBoxFormDashBoardTotal"
                                        ReadOnly="True" Enabled="false"></cc:NumericLargeTextBox>
                                </td>
                                <td class="cellinputbox">
                                    <cc:NumericLargeTextBox ID="txtTTPayTargetCE" runat="server" CssClass="TextBoxFormDashBoardTotal"
                                        ReadOnly="True" Enabled="false"></cc:NumericLargeTextBox>
                                </td>
                                <td class="cellinputbox">
                                    <cc:NumericLargeTextBox ID="txtTTPayCollection" runat="server" CssClass="TextBoxFormDashBoardTotal"
                                        ReadOnly="True" Enabled="false"></cc:NumericLargeTextBox>
                                </td>
                                <td class="cellinputbox">
                                    <cc:NumericLargeTextBox ID="txtTTPayMtd" runat="server" CssClass="TextBoxFormDashBoardTotal"
                                        ReadOnly="True" Enabled="false"></cc:NumericLargeTextBox>
                                </td>
                                <td class="cellinputbox">
                                    <cc:NumericLargeTextBox ID="txtTTPayExpected" runat="server" CssClass="TextBoxFormDashBoardTotal"
                                        ReadOnly="True" Enabled="false"></cc:NumericLargeTextBox>
                                </td>
                                <td class="cellinputbox">
                                    <cc:NumericLargeTextBox ID="txtTTPayRemain" runat="server" CssClass="TextBoxFormDashBoardTotal"
                                        ReadOnly="True" Enabled="false"></cc:NumericLargeTextBox>
                                </td>
                                <td class="cellinputbox">
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
