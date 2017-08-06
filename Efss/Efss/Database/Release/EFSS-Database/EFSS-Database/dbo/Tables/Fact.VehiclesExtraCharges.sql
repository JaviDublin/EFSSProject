CREATE TABLE [dbo].[Fact.VehiclesExtraCharges] (
    [ExtrasId]     INT        IDENTITY (1, 1) NOT NULL,
    [MileCharge]   FLOAT (53) NULL,
    [PlusKM]       FLOAT (53) NULL,
    [FuelCharge]   FLOAT (53) NULL,
    [Damage]       FLOAT (53) NULL,
    [SuperCharge]  FLOAT (53) NULL,
    [HandleFee]    FLOAT (53) NULL,
    [AddOn]        FLOAT (53) NULL,
    [Other1]       FLOAT (53) NULL,
    [Other2]       FLOAT (53) NULL,
    [Amount5]      FLOAT (53) NULL,
    [Amount6]      FLOAT (53) NULL,
    [RegTaxAmount] FLOAT (53) NULL,
    PRIMARY KEY CLUSTERED ([ExtrasId] ASC)
);

