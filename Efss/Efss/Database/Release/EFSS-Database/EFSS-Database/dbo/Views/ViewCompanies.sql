CREATE VIEW dbo.ViewCompanies
AS
SELECT     dbo.[Dimension.Countries].CountryName, dbo.[Dimension.Regions].RegionName, dbo.[Dimension.Companies].CompanyName, 
                      dbo.[Dimension.Companies].CompanyId, dbo.[Dimension.Countries].CountryCode, dbo.[Dimension.Companies].CompanyCode, 
                      dbo.[Dimension.CompanyTypes].CompanyType, dbo.[Dimension.Currencies].CurrencyName, dbo.[Dimension.Currencies].CurrencyCode, 
                      dbo.[Dimension.Currencies].Rate, dbo.[Dimension.Countries].CountryVat, dbo.[Dimension.Companies].CompanyFiscalCode, 
                      dbo.[Dimension.CompanyAddress].Address1, dbo.[Dimension.CompanyAddress].Address2, dbo.[Dimension.CompanyAddress].Address3, 
                      dbo.[Dimension.CompanyAddress].Address4, dbo.[Dimension.CompanyAddress].Address5, dbo.[Dimension.CompanyAddress].Address6, 
                      dbo.[Dimension.CompanyAddress].Address7, dbo.[Dimension.CompanyAddress].Address8, dbo.[Dimension.CompanyAddress].Address9, 
                      dbo.[Dimension.CompanyAddress].Address10, dbo.[Dimension.CompanyAddress].Address11, dbo.[Dimension.CompanyAddress].Address12, 
                      dbo.[Dimension.Companies].OracleCode, dbo.[Dimension.Companies].GroupName, dbo.[Dimension.Companies].EmailDublin
FROM         dbo.[Dimension.Companies] INNER JOIN
                      dbo.[Dimension.Countries] ON dbo.[Dimension.Companies].CountryId = dbo.[Dimension.Countries].CountryId INNER JOIN
                      dbo.[Dimension.Regions] ON dbo.[Dimension.Countries].RegionId = dbo.[Dimension.Regions].RegionId INNER JOIN
                      dbo.[Dimension.Currencies] ON dbo.[Dimension.Countries].CurrencyId = dbo.[Dimension.Currencies].CurrencyId INNER JOIN
                      dbo.[Dimension.CompanyTypes] ON dbo.[Dimension.Companies].CompanyTypeId = dbo.[Dimension.CompanyTypes].CompanyTypeId INNER JOIN
                      dbo.[Dimension.CompanyAddress] ON dbo.[Dimension.Companies].CompanyId = dbo.[Dimension.CompanyAddress].CompanyId
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'ViewCompanies';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'= 9
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'ViewCompanies';


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
         Begin Table = "Dimension.Companies"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 214
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "Dimension.Countries"
            Begin Extent = 
               Top = 6
               Left = 252
               Bottom = 114
               Right = 403
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Dimension.Regions"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 192
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Dimension.Currencies"
            Begin Extent = 
               Top = 114
               Left = 227
               Bottom = 222
               Right = 378
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Dimension.CompanyTypes"
            Begin Extent = 
               Top = 192
               Left = 38
               Bottom = 270
               Right = 197
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Dimension.CompanyAddress"
            Begin Extent = 
               Top = 222
               Left = 235
               Bottom = 330
               Right = 409
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
      Begin ColumnWidths ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'ViewCompanies';

