﻿CREATE TABLE [dbo].[FLOTA] (
    [unidad]              NVARCHAR (11)  NULL,
    [modelo]              NVARCHAR (15)  NULL,
    [descripcion]         NVARCHAR (100) NULL,
    [color]               NVARCHAR (5)   NULL,
    [matricula]           NVARCHAR (10)  NULL,
    [chasis]              NVARCHAR (25)  NULL,
    [tipo_vehiculo]       NVARCHAR (1)   NULL,
    [kilometros]          INT            NULL,
    [peri_desc]           NVARCHAR (255) NULL,
    [peri_coste]          INT            NULL,
    [precio_venta]        FLOAT (53)     NULL,
    [base_impo]           FLOAT (53)     NULL,
    [capital_cost]        FLOAT (53)     NULL,
    [book_value]          FLOAT (53)     NULL,
    [bonus]               FLOAT (53)     NULL,
    [profit]              FLOAT (53)     NULL,
    [situacion]           NVARCHAR (1)   NULL,
    [dealer]              NVARCHAR (9)   NULL,
    [tipo_venta]          NVARCHAR (1)   NULL,
    [n_factura]           VARCHAR (15)   NULL,
    [n_proforma]          VARCHAR (15)   NULL,
    [origen]              NVARCHAR (100) NULL,
    [num_carga]           INT            NULL,
    [destino]             NVARCHAR (100) NULL,
    [vendedor]            NVARCHAR (100) NULL,
    [vendedor2]           NVARCHAR (100) NULL,
    [fecha_pago]          SMALLDATETIME  NULL,
    [pagado]              NVARCHAR (1)   NULL,
    [fecha_compra]        SMALLDATETIME  NULL,
    [fecha_campa]         SMALLDATETIME  NULL,
    [paralizacion]        INT            NULL,
    [depreciacion]        FLOAT (53)     NULL,
    [cod_radio]           INT            NULL,
    [c_arranque]          INT            NULL,
    [fecha_cobro]         SMALLDATETIME  NULL,
    [fecha_factura]       SMALLDATETIME  NULL,
    [modelo2]             NVARCHAR (100) NULL,
    [fecha_matriculacion] SMALLDATETIME  NULL,
    [grupo]               NVARCHAR (1)   NULL,
    [grupo_vehiculo]      NVARCHAR (2)   NULL,
    [AUTORIZA]            NVARCHAR (1)   NULL,
    [MES]                 SMALLINT       NULL,
    [PREVISION]           NVARCHAR (20)  NULL,
    [fecha_comi]          SMALLDATETIME  NULL,
    [fecha_delivery]      SMALLDATETIME  NULL,
    [fecha_swit]          SMALLDATETIME  NULL
);

