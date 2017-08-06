<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Loading.ascx.cs" Inherits="APP.App_UserControls.Controls.Dialogs.Loading" %>
<script type="text/javascript" language="javascript">
    var prm = Sys.WebForms.PageRequestManager.getInstance(); prm.add_initializeRequest(InitializeRequest); prm.add_endRequest(EndRequest); function InitializeRequest(sender, e) { var postBackElement = e.get_postBackElement(); if (postBackElement != null) { if (!CheckNoProgressArray(postBackElement.id)) { var modalPopupBehavior = $find('ModalPopupBehaviorLoading'); modalPopupBehavior.show(); } } } function EndRequest(sender, e) { var modalPopupBehavior = $find('ModalPopupBehaviorLoading'); modalPopupBehavior.hide(); };    
</script>
<%-- Loading Modal PopUp --%>
<asp:Panel runat="server" CssClass="panel-ModalPopup" ID="PanelPopupLoading" Style="display: none;">
    <div id="divAjaxLoadingImage" class ="div-AjaxLoadingImage">
        <asp:Image ID="ImageLoading" runat="server" AlternateText="Loading selected request." ImageUrl="~/App_Images/loading.gif" />
    </div>
    <div id="divAjaxLoadingText" class ="div-AjaxLoadingText">
        <strong>
            <asp:Label ID="LabelLoading" runat="server" Text="Please Wait. Loading...." EnableViewState ="false" ></asp:Label>
        </strong>
    </div>
</asp:Panel>
<asp:Button runat="server" ID="ButtonModalPopupLoading" Style="display: none;" />
<asp:ModalPopupExtender ID="ModalPopupExtenderLoading" runat="server" BehaviorID="ModalPopupBehaviorLoading" TargetControlID="ButtonModalPopupLoading" PopupControlID="PanelPopupLoading" BackgroundCssClass="extender-ModalBackground">
</asp:ModalPopupExtender>