CREATE VIEW dbo.ViewBuyers
AS
SELECT     dbo.[Dimension.CompanyTypes].CompanyType, dbo.[Dimension.Buyers].BuyerId, dbo.[Dimension.Buyers].BuyerName, 
                      dbo.[Dimension.Buyers].CountryId, dbo.[Dimension.Countries].CountryName, dbo.[Dimension.Buyers].BuyerCode, 
                      dbo.[Dimension.Buyers].BuyerName AS Expr1, dbo.[Dimension.Buyers].BuyerTaxCode, dbo.[Dimension.Buyers].BuyerFiscalCode, 
                      dbo.[Dimension.Buyers].CompanyId, dbo.[Fact.BuyersAddress].BuyerAddress1, dbo.[Fact.BuyersAddress].BuyerAddress2, 
                      dbo.[Fact.BuyersAddress].BuyerAddress3, dbo.[Fact.BuyersAddress].BuyerAddress4, dbo.[Fact.BuyersAddress].BuyerAddress5, 
                      dbo.[Fact.BuyersAddress].BuyerAddress6, dbo.[Fact.BuyersContact].ContactId, dbo.[Fact.BuyersContact].ContactTypeId, 
                      dbo.[Fact.BuyersContact].ContactName, dbo.[Fact.BuyersContact].ContactPhone, dbo.[Fact.BuyersContact].ContactEmail, 
                      dbo.[Fact.BuyersContact].ContactFax, dbo.[Fact.BuyersManufacturer].ManufacturerId, dbo.[Dimension.Manufacturer].ManufacturerName
FROM         dbo.[Dimension.Buyers] INNER JOIN
                      dbo.[Dimension.Countries] ON dbo.[Dimension.Buyers].CountryId = dbo.[Dimension.Countries].CountryId INNER JOIN
                      dbo.[Dimension.Companies] ON dbo.[Dimension.Buyers].CompanyId = dbo.[Dimension.Companies].CompanyId INNER JOIN
                      dbo.[Dimension.CompanyTypes] ON dbo.[Dimension.Companies].CompanyTypeId = dbo.[Dimension.CompanyTypes].CompanyTypeId INNER JOIN
                      dbo.[Fact.BuyersAddress] ON dbo.[Dimension.Buyers].BuyerId = dbo.[Fact.BuyersAddress].BuyerId INNER JOIN
                      dbo.[Fact.BuyersContact] ON dbo.[Dimension.Buyers].BuyerId = dbo.[Fact.BuyersContact].BuyerId LEFT OUTER JOIN
                      dbo.[Fact.BuyersManufacturer] ON dbo.[Dimension.Buyers].BuyerId = dbo.[Fact.BuyersManufacturer].BuyerId LEFT OUTER JOIN
                      dbo.[Dimension.Manufacturer] ON dbo.[Fact.BuyersManufacturer].ManufacturerId = dbo.[Dimension.Manufacturer].ManufacturerId
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'ViewBuyers';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'  Bottom = 489
               Right = 411
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Dimension.Manufacturer"
            Begin Extent = 
               Top = 426
               Left = 38
               Bottom = 534
               Right = 213
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
      Begin ColumnWidths = 24
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'ViewBuyers';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[29] 3) )"
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
         Top = -96
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Dimension.Buyers"
            Begin Extent = 
               Top = 102
               Left = 38
               Bottom = 210
               Right = 197
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Dimension.Countries"
            Begin Extent = 
               Top = 102
               Left = 235
               Bottom = 210
               Right = 386
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Dimension.Companies"
            Begin Extent = 
               Top = 210
               Left = 38
               Bottom = 318
               Right = 214
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Dimension.CompanyTypes"
            Begin Extent = 
               Top = 210
               Left = 252
               Bottom = 288
               Right = 411
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Fact.BuyersAddress"
            Begin Extent = 
               Top = 288
               Left = 252
               Bottom = 396
               Right = 409
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Fact.BuyersContact"
            Begin Extent = 
               Top = 318
               Left = 38
               Bottom = 426
               Right = 190
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Fact.BuyersManufacturer"
            Begin Extent = 
               Top = 396
               Left = 228
             ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'ViewBuyers';

