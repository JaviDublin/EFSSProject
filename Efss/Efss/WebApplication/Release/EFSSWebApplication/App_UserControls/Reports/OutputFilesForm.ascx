<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="OutputFilesForm.ascx.cs"
    Inherits="APP.App_UserControls.Reports.OutputFilesForm" %>
<%-- Control Wrapper --%>
<div class="div-Application-Content">
    <table width="100%">
        <tr>
            <td align="left">
                <asp:Label runat="server" ID="LabelStatsTitle" Text="Stats" CssClass="LabelForm"
                    Font-Underline="true"></asp:Label>
            </td>
        </tr>
    </table>
    <asp:UpdatePanel runat="server" ID="UpdatePanelCharts" UpdateMode="Conditional" ChildrenAsTriggers="false">
        <ContentTemplate>
            <uc:UCNavigationPanel runat="server" ID="NavigationPanelCharts" OnNavigationMenuClick="NavigationMenuClick" />
            <asp:MultiView runat="server" ID="MultiViewCharts" ActiveViewIndex="0">
                <asp:View runat="server" ID="SalesByCountry">
                    <asp:Chart runat="server" ID="ChartSales" BackSecondaryColor="White" BorderlineColor="Gray"
                        BorderlineDashStyle="Solid" BorderlineWidth="2" DataSourceID="sdsSales" Height="400px"
                        Palette="Pastel" Width="700px" BackColor="211, 223, 240" BackGradientStyle="TopBottom">
                        <Series>
                            <asp:Series Name="Series2" XValueMember="CountryCode" YValueMembers="Total" ChartArea="ChartArea2"
                                CustomProperties="DrawingStyle=Cylinder" Legend="Legend1" Font="Microsoft Sans Serif, 8pt, style=Bold"
                                IsValueShownAsLabel="True" LabelBackColor="White" LabelBorderColor="Black">
                                <SmartLabelStyle AllowOutsidePlotArea="No" CalloutLineAnchorCapStyle="Square" CalloutStyle="Box" />
                            </asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea2" BackColor="64, 165, 191, 228" BackGradientStyle="TopBottom">
                            </asp:ChartArea>
                        </ChartAreas>
                        <Titles>
                            <asp:Title Alignment="TopLeft" Font="Trebuchet MS, 14.25pt, style=Bold" ForeColor="26, 59, 105"
                                Name="Title1" ShadowOffset="2" Text="Sales By Country %">
                            </asp:Title>
                        </Titles>
                        <BorderSkin SkinStyle="Emboss" />
                    </asp:Chart>
                    <asp:SqlDataSource runat="server" ID="sdsSales" ConnectionString="<%$ ConnectionStrings:RAD.Properties.Settings.ApplicationDataBase %>"
                        SelectCommand="spSalesOverviewChart" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                </asp:View>
                <asp:View runat="server" ID="SalesByRegion">
                    <asp:Chart ID="ChartSalesRegion" runat="server" BorderlineColor="Gray" BorderlineDashStyle="Solid"
                        BorderlineWidth="2" DataSourceID="sdsSalesRegion" Palette="Pastel" Width="700px"
                        BackColor="211, 223, 240" BackGradientStyle="TopBottom" Height="400px">
                        <Series>
                            <asp:Series Name="Series4" XValueMember="RegionName" YValueMembers="Total" CustomProperties="DrawingStyle=Cylinder"
                                Legend="Legend1" Font="Microsoft Sans Serif, 8pt, style=Bold" IsValueShownAsLabel="True"
                                LabelBackColor="White" LabelBorderColor="Black">
                                <SmartLabelStyle AllowOutsidePlotArea="No" />
                            </asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea4" BackColor="64, 165, 191, 228" BackGradientStyle="TopBottom">
                            </asp:ChartArea>
                        </ChartAreas>
                        <Titles>
                            <asp:Title Alignment="TopLeft" Font="Trebuchet MS, 14.25pt, style=Bold" ForeColor="26, 59, 105"
                                Name="Title1" ShadowOffset="2" Text="Sales By Region %">
                            </asp:Title>
                        </Titles>
                        <BorderSkin SkinStyle="Emboss" />
                    </asp:Chart>
                    <asp:SqlDataSource ID="sdsSalesRegion" runat="server" ConnectionString="<%$ ConnectionStrings:RAD.Properties.Settings.ApplicationDataBase %>"
                        SelectCommand="spSalesOverviewChartRegion" SelectCommandType="StoredProcedure">
                    </asp:SqlDataSource>
                </asp:View>
                <asp:View runat="server" ID="FleetByCountry">
                    <asp:Chart ID="ChartFleet" runat="server" BackColor="211, 223, 240" BackGradientStyle="TopBottom"
                        BorderlineDashStyle="Solid" DataSourceID="sdsFleet" Palette="Pastel" Width="700px"
                        BorderlineWidth="2" Height="400px">
                        <Series>
                            <asp:Series CustomProperties="DrawingStyle=Cylinder" Name="Series1" XValueMember="CountryCode"
                                YValueMembers="Total" Legend="Legend1" Font="Microsoft Sans Serif, 8pt, style=Bold"
                                IsValueShownAsLabel="True" LabelBackColor="White" LabelBorderColor="Black">
                                <SmartLabelStyle AllowOutsidePlotArea="No" CalloutLineAnchorCapStyle="None" IsMarkerOverlappingAllowed="True"
                                    MovingDirection="Top, Center" />
                            </asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea BackColor="64, 165, 191, 228" BackGradientStyle="TopBottom" Name="ChartArea1"
                                ShadowColor="Transparent">
                            </asp:ChartArea>
                        </ChartAreas>
                        <Titles>
                            <asp:Title Alignment="TopLeft" Font="Trebuchet MS, 14.25pt, style=Bold" ForeColor="26, 59, 105"
                                Name="Title1" ShadowOffset="2" Text="Fleet By Country %">
                            </asp:Title>
                        </Titles>
                        <BorderSkin SkinStyle="Emboss" />
                    </asp:Chart>
                    <asp:SqlDataSource ID="sdsFleet" runat="server" ConnectionString="<%$ ConnectionStrings:RAD.Properties.Settings.ApplicationDataBase %>"
                        SelectCommand="spFleetImportFileActiveFleetReportDayChart" SelectCommandType="StoredProcedure">
                    </asp:SqlDataSource>
                </asp:View>
                <asp:View runat="server" ID="FleetByRegion">
                    <asp:Chart ID="ChartFleetRegion" runat="server" BorderlineColor="Gray" BorderlineDashStyle="Solid"
                        BorderlineWidth="2" DataSourceID="sdsFleetRegion" Palette="Pastel" Width="700px"
                        BackColor="211, 223, 240" BackGradientStyle="TopBottom" Height="400px">
                        <Series>
                            <asp:Series Name="Series3" XValueMember="RegionName" YValueMembers="Total" Legend="Legend1"
                                CustomProperties="DrawingStyle=Cylinder" Font="Microsoft Sans Serif, 8pt, style=Bold"
                                IsValueShownAsLabel="True" LabelBackColor="White" LabelBorderColor="Black">
                                <SmartLabelStyle AllowOutsidePlotArea="No" />
                            </asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea3" BackColor="64, 165, 191, 228" BackGradientStyle="TopBottom">
                                <Area3DStyle Inclination="20" />
                            </asp:ChartArea>
                        </ChartAreas>
                        <Titles>
                            <asp:Title Alignment="TopLeft" Font="Trebuchet MS, 14.25pt, style=Bold" ForeColor="26, 59, 105"
                                Name="Title1" ShadowOffset="2" Text="Fleet By Region %">
                            </asp:Title>
                        </Titles>
                        <BorderSkin SkinStyle="Emboss" />
                    </asp:Chart>
                    <asp:SqlDataSource ID="sdsFleetRegion" runat="server" ConnectionString="<%$ ConnectionStrings:RAD.Properties.Settings.ApplicationDataBase %>"
                        SelectCommand="spFleetImportFileActiveFleetReportDayChartRegion" SelectCommandType="StoredProcedure">
                    </asp:SqlDataSource>
                </asp:View>
                <asp:View runat="server" ID="MonthAdds">
                    <asp:Chart ID="ChartMonth" runat="server" BackColor="211, 223, 240" BackGradientStyle="TopBottom"
                        BorderlineColor="Gray" BorderlineDashStyle="Solid" DataSourceID="sdsFleetMonthAD"
                        Palette="Pastel" Width="900px" Height="400px">
                        <Series>
                            <asp:Series CustomProperties="DrawingStyle=Cylinder" Legend="Legend1" Name="Adds"
                                XValueMember="CompanyCode" YValueMembers="MonthAdds" IsValueShownAsLabel="True"
                                Font="Microsoft Sans Serif, 8pt, style=Bold" LabelBackColor="White" LabelBorderColor="Black">
                                <SmartLabelStyle AllowOutsidePlotArea="No" />
                            </asp:Series>
                            <asp:Series ChartArea="ChartArea1" CustomProperties="DrawingStyle=Cylinder" Legend="Legend1"
                                Name="Deletes" XValueMember="CompanyCode" YValueMembers="MonthDels" IsValueShownAsLabel="True"
                                Font="Microsoft Sans Serif, 8pt, style=Bold" LabelBackColor="White" LabelBorderColor="Black">
                                <SmartLabelStyle AllowOutsidePlotArea="No" />
                            </asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea BackColor="64, 165, 191, 228" BackGradientStyle="TopBottom" Name="ChartArea1">
                                <Area3DStyle Inclination="10" />
                            </asp:ChartArea>
                        </ChartAreas>
                        <Legends>
                            <asp:Legend Docking="Bottom" Name="Legend1" BackColor="Transparent" Font="Trebuchet MS, 8.25pt, style=Bold">
                            </asp:Legend>
                        </Legends>
                        <Titles>
                            <asp:Title Alignment="TopLeft" Font="Microsoft Sans Serif, 14.25pt, style=Bold" ForeColor="26, 59, 105"
                                Name="Title1" ShadowOffset="2" Text="Fleet Month Add / Dels.">
                            </asp:Title>
                        </Titles>
                        <BorderSkin SkinStyle="Emboss" />
                    </asp:Chart>
                    <asp:SqlDataSource ID="sdsFleetMonthAD" runat="server" ConnectionString="<%$ ConnectionStrings:RAD.Properties.Settings.ApplicationDataBase %>"
                        SelectCommand="spFleetImportFileActiveFleetMonthADChart" SelectCommandType="StoredProcedure">
                    </asp:SqlDataSource>
                </asp:View>
                <asp:View runat="server" ID="YearAdds">
                    <asp:Chart ID="ChartYear" runat="server" BackColor="211, 223, 240" BackGradientStyle="TopBottom"
                        BorderlineColor="Gray" BorderlineDashStyle="Solid" DataSourceID="sdsFleetYearAD"
                        Palette="Pastel" Width="900px" Height="400px">
                        <Series>
                            <asp:Series CustomProperties="DrawingStyle=Cylinder" Name="Adds" XValueMember="CompanyCode"
                                YValueMembers="YearAdds" IsValueShownAsLabel="True" Font="Microsoft Sans Serif, 8pt, style=Bold"
                                Legend="Legend1" LabelBackColor="White" LabelBorderColor="Black">
                                <SmartLabelStyle AllowOutsidePlotArea="No" />
                            </asp:Series>
                            <asp:Series ChartArea="ChartArea1" CustomProperties="DrawingStyle=Cylinder" Name="Deletes"
                                XValueMember="CompanyCode" YValueMembers="YearDels" IsValueShownAsLabel="True"
                                Font="Microsoft Sans Serif, 8pt, style=Bold" Legend="Legend1" LabelBackColor="White"
                                LabelBorderColor="Black">
                                <SmartLabelStyle AllowOutsidePlotArea="No" />
                            </asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea BackColor="64, 165, 191, 228" BackGradientStyle="TopBottom" Name="ChartArea1">
                            </asp:ChartArea>
                        </ChartAreas>
                        <Legends>
                            <asp:Legend Docking="Bottom" Name="Legend1">
                            </asp:Legend>
                        </Legends>
                        <Titles>
                            <asp:Title Alignment="TopLeft" Font="Microsoft Sans Serif, 14.25pt, style=Bold" ForeColor="26, 59, 105"
                                Name="Title1" ShadowOffset="2" Text="Fleet Year Add / Dels.">
                            </asp:Title>
                        </Titles>
                        <BorderSkin SkinStyle="Emboss" />
                    </asp:Chart>
                    <asp:SqlDataSource ID="sdsFleetYearAD" runat="server" ConnectionString="<%$ ConnectionStrings:RAD.Properties.Settings.ApplicationDataBase %>"
                        SelectCommand="spFleetImportFileActiveFleetYearADChart" SelectCommandType="StoredProcedure">
                    </asp:SqlDataSource>
                </asp:View>
            </asp:MultiView>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
