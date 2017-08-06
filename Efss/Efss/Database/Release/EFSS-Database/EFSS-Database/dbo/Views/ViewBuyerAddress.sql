CREATE VIEW dbo.ViewBuyerAddress
AS
SELECT     dbo.[Dimension.Countries].CountryId, dbo.[Dimension.Countries].CountryName, dbo.[Dimension.Buyers].BuyerId, dbo.[Dimension.Buyers].BuyerCode, 
                      dbo.[Dimension.Buyers].BuyerName, dbo.[Dimension.Buyers].BuyerTaxCode, dbo.[Dimension.Buyers].BuyerFiscalCode, 
                      dbo.[Fact.BuyersAddress].BuyerAddressId, dbo.[Fact.BuyersAddress].ContactTypeId, dbo.[Fact.BuyersAddress].BuyerAddress1, 
                      dbo.[Fact.BuyersAddress].BuyerAddress2, dbo.[Fact.BuyersAddress].BuyerAddress3, dbo.[Fact.BuyersAddress].BuyerAddress4, 
                      dbo.[Fact.BuyersAddress].BuyerAddress5, dbo.[Fact.BuyersAddress].BuyerAddress6, dbo.[Fact.BuyersAddress].IsDeleted, 
                      dbo.[Fact.BuyersAddress].Position
FROM         dbo.[Dimension.Buyers] INNER JOIN
                      dbo.[Dimension.Countries] ON dbo.[Dimension.Buyers].CountryId = dbo.[Dimension.Countries].CountryId INNER JOIN
                      dbo.[Fact.BuyersAddress] ON dbo.[Dimension.Buyers].BuyerId = dbo.[Fact.BuyersAddress].BuyerId
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'ViewBuyerAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Dimension.Buyers"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 197
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Dimension.Countries"
            Begin Extent = 
               Top = 6
               Left = 235
               Bottom = 114
               Right = 386
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Fact.BuyersAddress"
            Begin Extent = 
               Top = 6
               Left = 424
               Bottom = 114
               Right = 581
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'ViewBuyerAddress';

