if not exists(select * from SNC.TblSNCTableStructure where QueryName ='TblServices_<PCODE>')
begin
insert into snc.TblSNCTableStructure (QueryName,QueryString,QueryType)values('TblServices_<PCODE>','
CREATE TABLE [SNC].[TblServices_<PCODE>](
	[SrNo] [int] IDENTITY(1,1) NOT NULL,	
	[ReservationId] [int] NOT NULL CONSTRAINT [DF_TblServices_<PCODE>_ReservationId] DEFAULT (0) , --Foreign key references [SNC].[TblReservationHead_<PCODE>](ReservationId)
	[DayId] [int] NOT NULL CONSTRAINT [DF_TblServices_<PCODE>_DayId] DEFAULT (0),	
	[ServiceID] [varchar](24) NOT NULL CONSTRAINT [DF_TblServices_<PCODE>_ServiceID] DEFAULT (space(1)),	
	[Quantity] [int] NOT NULL CONSTRAINT [DF_TblServices_<PCODE>_Quantity] DEFAULT (0),
	[IsChargable] [bit] NOT NULL CONSTRAINT [DF_TblServices_<PCODE>_IsChargable] DEFAULT (0),
	[PerUnitRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblServices_<PCODE>_PerUnitRate] DEFAULT (0),
	[PerUnitChargableType1] [int] NOT NULL CONSTRAINT [DF_TblServices_<PCODE>_PerUnitChargableType1] DEFAULT (0),	
	[PerUnitChargableType2] [int] NOT NULL CONSTRAINT [DF_TblServices_<PCODE>_PerUnitChargableType2] DEFAULT (0),
	[CalcualtedRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblServices_<PCODE>_CalcualtedRate] DEFAULT (0),
	[CalcualtedCost] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblServices_<PCODE>_CalcualtedCost] DEFAULT (0),
	[ServiceRateId] [varchar](24) NOT NULL CONSTRAINT [DF_TblServices_<PCODE>_ServiceRateId] DEFAULT (space(1)),	
	[SupplierRateCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblServices_<PCODE>_SupplierRateCode] DEFAULT (space(1)),	
	[PerUnitCost] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblServices_<PCODE>_PerUnitCost] DEFAULT (0),	
	[IsDisplay] [int] NOT NULL CONSTRAINT [DF_TblServices_<PCODE>_IsDisplay] DEFAULT (0),	
	[CostType] [varchar](5) NOT NULL CONSTRAINT [DF_TblServices_<PCODE>_CostType] DEFAULT (space(1)),	
	[CostPer]  [decimal](38,2) NOT NULL CONSTRAINT [DF_TblServices_<PCODE>_CostPer]	DEFAULT (0),	
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblServices_<PCODE>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblServices_<PCODE>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblServices_<PCODE>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblServices_<PCODE>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblServices_<PCODE>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblServices_<PCODE>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblServices_<PCODE>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblServices_<PCODE>_ClientID]  DEFAULT (space(1))
) ON [PRIMARY]', 1)
end
GO

if not exists(select * from SNC.TblSNCTableStructure where QueryName ='TblChallanServices_<PCODE>')
begin
insert into snc.TblSNCTableStructure (QueryName,QueryString,QueryType)values('TblChallanServices_<PCODE>','
CREATE TABLE [SNC].[TblChallanServices_<PCODE>](
	[SrNo] [int] IDENTITY(1,1) NOT NULL,	
	[ReservationId] [int] NOT NULL CONSTRAINT [DF_TblChallanServices_<PCODE>_ReservationId] DEFAULT (0) , --Foreign key references [SNC].[TblReservationHead_<PCODE>](ReservationId)
	[DayId] [int] NOT NULL CONSTRAINT [DF_TblChallanServices_<PCODE>_DayId] DEFAULT (0),		
	[ProformaInvoiceId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanServices_<PCODE>_ProformaInvoiceId]  DEFAULT (space((1))),
	[ServiceID] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanServices_<PCODE>_ServiceID] DEFAULT (space(1)),	
	[Quantity] [int] NOT NULL CONSTRAINT [DF_TblChallanServices_<PCODE>_Quantity] DEFAULT (0),
	[IsChargable] [bit] NOT NULL CONSTRAINT [DF_TblChallanServices_<PCODE>_IsChargable] DEFAULT (0),
	[PerUnitRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServices_<PCODE>_PerUnitRate] DEFAULT (0),
	[PerUnitChargableType1] [int] NOT NULL CONSTRAINT [DF_TblChallanServices_<PCODE>_PerUnitChargableType1] DEFAULT (0),	
	[PerUnitChargableType2] [int] NOT NULL CONSTRAINT [DF_TblChallanServices_<PCODE>_PerUnitChargableType2] DEFAULT (0),
	[CalcualtedRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServices_<PCODE>_CalcualtedRate] DEFAULT (0),
	[CalcualtedCost] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServices_<PCODE>_CalcualtedCost] DEFAULT (0),
	[ServiceRateId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanServices_<PCODE>_ServiceRateId] DEFAULT (space(1)),	
	[SupplierRateCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanServices_<PCODE>_SupplierRateCode] DEFAULT (space(1)),	
	[PerUnitCost] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServices_<PCODE>_PerUnitCost] DEFAULT (0),	
	[IsDisplay] [int] NOT NULL CONSTRAINT [DF_TblChallanServices_<PCODE>_IsDisplay] DEFAULT (0),	
	[CostType] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanServices_<PCODE>_CostType] DEFAULT (space(1)),	
	[CostPer]  [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServices_<PCODE>_CostPer]	DEFAULT (0),		
	[Status] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanServices_<PCODE>_Status]  DEFAULT (space(1)),
	[TaxAmt] [money] NOT NULL CONSTRAINT [DF_TblChallanServices_<PCODE>_TaxAmt]  DEFAULT ((0)),
	[TaxStr] [varchar](5000) NOT NULL CONSTRAINT [DF_TblChallanServices_<PCODE>_TaXStr]  DEFAULT (space(1)),
	[Rate] [decimal](38,2) NOT NULL  CONSTRAINT [DF_TblChallanServices_<PCODE>_Rate]  DEFAULT ((0)),
	[Discount] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServices_<PCODE>_Discount]  DEFAULT ((0)),
	[Qty] [int] NOT NULL CONSTRAINT [DF_TblChallanServices_<PCODE>_Qty]  DEFAULT ((0)),
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblChallanServices_<PCODE>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanServices_<PCODE>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanServices_<PCODE>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanServices_<PCODE>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanServices_<PCODE>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanServices_<PCODE>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanServices_<PCODE>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanServices_<PCODE>_ClientID]  DEFAULT (space(1))
) ON [PRIMARY]', 1)
end
GO

if not exists(select * from SNC.TblSNCTableStructure where QueryName ='TblChallanServicesTemp_<PCODE>')
begin
insert into snc.TblSNCTableStructure (QueryName,QueryString,QueryType)values('TblChallanServicesTemp_<PCODE>','
CREATE TABLE [SNC].[TblChallanServicesTemp_<PCODE>](
	[SrNo] [int] IDENTITY(1,1) NOT NULL,	
	[ReservationId] [int] NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<PCODE>_ReservationId] DEFAULT (0) , --Foreign key references [SNC].[TblReservationHead_<PCODE>](ReservationId)
	[DayId] [int] NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<PCODE>_DayId] DEFAULT (0),		
	[ProformaInvoiceId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<PCODE>_ProformaInvoiceId]  DEFAULT (space((1))),
	[ServiceID] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<PCODE>_ServiceID] DEFAULT (space(1)),	
	[Quantity] [int] NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<PCODE>_Quantity] DEFAULT (0),
	[IsChargable] [bit] NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<PCODE>_IsChargable] DEFAULT (0),
	[PerUnitRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<PCODE>_PerUnitRate] DEFAULT (0),
	[PerUnitChargableType1] [int] NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<PCODE>_PerUnitChargableType1] DEFAULT (0),	
	[PerUnitChargableType2] [int] NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<PCODE>_PerUnitChargableType2] DEFAULT (0),
	[CalcualtedRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<PCODE>_CalcualtedRate] DEFAULT (0),
	[CalcualtedCost] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<PCODE>_CalcualtedCost] DEFAULT (0),
	[ServiceRateId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<PCODE>_ServiceRateId] DEFAULT (space(1)),	
	[SupplierRateCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<PCODE>_SupplierRateCode] DEFAULT (space(1)),	
	[PerUnitCost] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<PCODE>_PerUnitCost] DEFAULT (0),	
	[IsDisplay] [int] NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<PCODE>_IsDisplay] DEFAULT (0),	
	[CostType] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<PCODE>_CostType] DEFAULT (space(1)),	
	[CostPer]  [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<PCODE>_CostPer]	DEFAULT (0),		
	[Status] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<PCODE>_Status]  DEFAULT (space(1)),
	[TaxAmt] [money] NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<PCODE>_TaxAmt]  DEFAULT ((0)),
	[TaxStr] [varchar](5000) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<PCODE>_TaXStr]  DEFAULT (space(1)),
	[Rate] [decimal](38,2) NOT NULL  CONSTRAINT [DF_TblChallanServicesTemp_<PCODE>_Rate]  DEFAULT ((0)),
	[Discount] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<PCODE>_Discount]  DEFAULT ((0)),
	[Qty] [int] NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<PCODE>_Qty]  DEFAULT ((0)),
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<PCODE>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<PCODE>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<PCODE>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<PCODE>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<PCODE>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<PCODE>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<PCODE>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<PCODE>_ClientID]  DEFAULT (space(1)),	
	[Guid] [nvarchar] (max) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<PCODE>_Guid] DEFAULT (space(1))
) ON [PRIMARY]', 1)
end
GO

if not exists(select * from SNC.TblSNCTableStructure where QueryName ='TblServicesAmd_<PCODE>')
begin
insert into snc.TblSNCTableStructure (QueryName,QueryString,QueryType)values('TblServicesAmd_<PCODE>','
CREATE TABLE [SNC].[TblServicesAmd_<PCODE>](	
	[SrNo] [int] NOT NULL CONSTRAINT [DF_TblServicesAmd_<PCODE>_SrNo] DEFAULT (0),
	[ReservationId] [int] NOT NULL CONSTRAINT [DF_TblServicesAmd_<PCODE>_ReservationId] DEFAULT (0) , --Foreign key references [SNC].[TblReservationHead_<PCODE>](ReservationId)
	[DayId] [int] NOT NULL CONSTRAINT [DF_TblServicesAmd_<PCODE>_DayId] DEFAULT (0),	
	[ServiceID] [varchar](24) NOT NULL CONSTRAINT [DF_TblServicesAmd_<PCODE>_ServiceID] DEFAULT (space(1)),	
	[Quantity] [int] NOT NULL CONSTRAINT [DF_TblServicesAmd_<PCODE>_Quantity] DEFAULT (0),
	[IsChargable] [bit] NOT NULL CONSTRAINT [DF_TblServicesAmd_<PCODE>_IsChargable] DEFAULT (0),
	[PerUnitRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblServicesAmd_<PCODE>_PerUnitRate] DEFAULT (0),
	[PerUnitChargableType1] [int] NOT NULL CONSTRAINT [DF_TblServicesAmd_<PCODE>_PerUnitChargableType1] DEFAULT (0),	
	[PerUnitChargableType2] [int] NOT NULL CONSTRAINT [DF_TblServicesAmd_<PCODE>_PerUnitChargableType2] DEFAULT (0),
	[CalcualtedRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblServicesAmd_<PCODE>_CalcualtedRate] DEFAULT (0),
	[CalcualtedCost] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblServicesAmd_<PCODE>_CalcualtedCost] DEFAULT (0),
	[ServiceRateId] [varchar](24) NOT NULL CONSTRAINT [DF_TblServicesAmd_<PCODE>_ServiceRateId] DEFAULT (space(1)),	
	[SupplierRateCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblServicesAmd_<PCODE>_SupplierRateCode] DEFAULT (space(1)),	
	[PerUnitCost] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblServicesAmd_<PCODE>_PerUnitCost] DEFAULT (0),	
	[IsDisplay] [int] NOT NULL CONSTRAINT [DF_TblServicesAmd_<PCODE>_IsDisplay] DEFAULT (0),	
	[CostType] [varchar](5) NOT NULL CONSTRAINT [DF_TblServicesAmd_<PCODE>_CostType] DEFAULT (space(1)),	
	[CostPer]  [decimal](38,2) NOT NULL CONSTRAINT [DF_TblServicesAmd_<PCODE>_CostPer]	DEFAULT (0),	
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblServicesAmd_<PCODE>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblServicesAmd_<PCODE>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblServicesAmd_<PCODE>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblServicesAmd_<PCODE>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblServicesAmd_<PCODE>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblServicesAmd_<PCODE>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblServicesAmd_<PCODE>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblServicesAmd_<PCODE>_ClientID]  DEFAULT (space(1))
) ON [PRIMARY]', 1)
end
GO

if not exists(select * from SNC.TblSNCTableStructure where QueryName ='TblChallanServicesAmd_<PCODE>')
begin
insert into snc.TblSNCTableStructure (QueryName,QueryString,QueryType)values('TblChallanServicesAmd_<PCODE>','
CREATE TABLE [SNC].[TblChallanServicesAmd_<PCODE>](	
	[SrNo] [int] NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<PCODE>_SrNo] DEFAULT (0),
	[ReservationId] [int] NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<PCODE>_ReservationId] DEFAULT (0) , --Foreign key references [SNC].[TblReservationHead_<PCODE>](ReservationId)
	[DayId] [int] NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<PCODE>_DayId] DEFAULT (0),		
	[ProformaInvoiceId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<PCODE>_ProformaInvoiceId]  DEFAULT (space((1))),
	[ServiceID] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<PCODE>_ServiceID] DEFAULT (space(1)),	
	[Quantity] [int] NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<PCODE>_Quantity] DEFAULT (0),
	[IsChargable] [bit] NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<PCODE>_IsChargable] DEFAULT (0),
	[PerUnitRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<PCODE>_PerUnitRate] DEFAULT (0),
	[PerUnitChargableType1] [int] NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<PCODE>_PerUnitChargableType1] DEFAULT (0),	
	[PerUnitChargableType2] [int] NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<PCODE>_PerUnitChargableType2] DEFAULT (0),
	[CalcualtedRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<PCODE>_CalcualtedRate] DEFAULT (0),
	[CalcualtedCost] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<PCODE>_CalcualtedCost] DEFAULT (0),
	[ServiceRateId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<PCODE>_ServiceRateId] DEFAULT (space(1)),	
	[SupplierRateCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<PCODE>_SupplierRateCode] DEFAULT (space(1)),	
	[PerUnitCost] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<PCODE>_PerUnitCost] DEFAULT (0),	
	[IsDisplay] [int] NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<PCODE>_IsDisplay] DEFAULT (0),	
	[CostType] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<PCODE>_CostType] DEFAULT (space(1)),	
	[CostPer]  [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<PCODE>_CostPer]	DEFAULT (0),		
	[Status] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<PCODE>_Status]  DEFAULT (space(1)),
	[TaxAmt] [money] NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<PCODE>_TaxAmt]  DEFAULT ((0)),
	[TaxStr] [varchar](5000) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<PCODE>_TaXStr]  DEFAULT (space(1)),
	[Rate] [decimal](38,2) NOT NULL  CONSTRAINT [DF_TblChallanServicesAmd_<PCODE>_Rate]  DEFAULT ((0)),
	[Discount] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<PCODE>_Discount]  DEFAULT ((0)),
	[Qty] [int] NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<PCODE>_Qty]  DEFAULT ((0)),
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<PCODE>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<PCODE>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<PCODE>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<PCODE>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<PCODE>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<PCODE>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<PCODE>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<PCODE>_ClientID]  DEFAULT (space(1))
) ON [PRIMARY]', 1)
end
GO

if not exists(select * from SNC.TblSNCTableStructure where QueryName ='TblMenuServiceOrder_<PCODE>')
begin
insert into snc.TblSNCTableStructure (QueryName,QueryString,QueryType)values('TblMenuServiceOrder_<PCODE>','
CREATE TABLE [SNC].[TblMenuServiceOrder_<PCODE>](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuServiceOrder_<PCODE>_ReservationId]  DEFAULT (space(1)),
	[DayId] [varchar](3) NOT NULL  CONSTRAINT [DF_TblMenuServiceOrder_<PCODE>_DayId]  DEFAULT (space(1)),
	[BanquetItemId] [varchar](24) NULL CONSTRAINT [DF_TblMenuServiceOrder_<PCODE>_BanquetItemId]  DEFAULT (space(1)),
	[ServiceID] [varchar](100) NULL  CONSTRAINT [DF_TblMenuServiceOrder_<PCODE>_ServiceID]  DEFAULT (space(1)),
	[ALACARTE] [varchar](100) NULL  CONSTRAINT [DF_TblMenuServiceOrder_<PCODE>_ALACARTE]  DEFAULT (space(1)),
	[MenuServiceOrder] [int] NOT NULL CONSTRAINT [DF_TblMenuServiceOrder_<PCODE>_MenuServiceOrder]  DEFAULT ((0)),
	[MenuHeadId] [varchar](100) NULL CONSTRAINT [DF_TblMenuServiceOrder_<PCODE>_MenuHeadId]  DEFAULT (space(1)),
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblMenuServiceOrder_<PCODE>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuServiceOrder_<PCODE>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuServiceOrder_<PCODE>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuServiceOrder_<PCODE>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuServiceOrder_<PCODE>_ModifiedDate]  DEFAULT (getdate()),
	[POSCode] [varchar](5) NOT NULL CONSTRAINT [DF_TblMenuServiceOrder_<PCODE>_POSCode] DEFAULT (space(1)),	
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuServiceOrder_<PCODE>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuServiceOrder_<PCODE>_ClientID]  DEFAULT (space(1))
) ON [PRIMARY]', 1)
end
GO


DECLARE @propertycode varchar(5),
        @str varchar(500),
        @QueryString VARCHAR(MAX),
        @QueryString1 VARCHAR(MAX),
        @QueryString2 VARCHAR(MAX),
		@ExcQuery VARCHAR(MAX)=''
  
SET @QueryString ='
IF NOT EXISTS (SELECT * FROM Sysobjects WHERE xtype=''U'' AND [name]=N''TblServices_<POSCode>'')
BEGIN
CREATE TABLE [SNC].[TblServices_<POSCode>](
	[SrNo] [int] IDENTITY(1,1) NOT NULL,	
	[ReservationId] [int] NOT NULL CONSTRAINT [DF_TblServices_<POSCode>_ReservationId] DEFAULT (0) , --Foreign key references [SNC].[TblReservationHead_<POSCode>](ReservationId)
	[DayId] [int] NOT NULL CONSTRAINT [DF_TblServices_<POSCode>_DayId] DEFAULT (0),	
	[ServiceID] [varchar](24) NOT NULL CONSTRAINT [DF_TblServices_<POSCode>_ServiceID] DEFAULT (space(1)),	
	[Quantity] [int] NOT NULL CONSTRAINT [DF_TblServices_<POSCode>_Quantity] DEFAULT (0),
	[IsChargable] [bit] NOT NULL CONSTRAINT [DF_TblServices_<POSCode>_IsChargable] DEFAULT (0),
	[PerUnitRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblServices_<POSCode>_PerUnitRate] DEFAULT (0),
	[PerUnitChargableType1] [int] NOT NULL CONSTRAINT [DF_TblServices_<POSCode>_PerUnitChargableType1] DEFAULT (0),	
	[PerUnitChargableType2] [int] NOT NULL CONSTRAINT [DF_TblServices_<POSCode>_PerUnitChargableType2] DEFAULT (0),
	[CalcualtedRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblServices_<POSCode>_CalcualtedRate] DEFAULT (0),
	[CalcualtedCost] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblServices_<POSCode>_CalcualtedCost] DEFAULT (0),
	[ServiceRateId] [varchar](24) NOT NULL CONSTRAINT [DF_TblServices_<POSCode>_ServiceRateId] DEFAULT (space(1)),	
	[SupplierRateCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblServices_<POSCode>_SupplierRateCode] DEFAULT (space(1)),	
	[PerUnitCost] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblServices_<POSCode>_PerUnitCost] DEFAULT (0),	
	[IsDisplay] [int] NOT NULL CONSTRAINT [DF_TblServices_<POSCode>_IsDisplay] DEFAULT (0),	
	[CostType] [varchar](5) NOT NULL CONSTRAINT [DF_TblServices_<POSCode>_CostType] DEFAULT (space(1)),	
	[CostPer]  [decimal](38,2) NOT NULL CONSTRAINT [DF_TblServices_<POSCode>_CostPer]	DEFAULT (0),	
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblServices_<POSCode>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblServices_<POSCode>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblServices_<POSCode>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblServices_<POSCode>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblServices_<POSCode>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblServices_<POSCode>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblServices_<POSCode>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblServices_<POSCode>_ClientID]  DEFAULT (space(1))
) ON [PRIMARY]
End'  
DECLARE d_cursor CURSOR FOR select Trim(POSCode) from Tblposmst where PosStyle='7' order by POSCODE 
                OPEN d_cursor  
                FETCH NEXT FROM d_cursor INTO @propertycode
                WHILE @@FETCH_STATUS = 0  
                BEGIN          
                        SET @QueryString1 = replace(@QueryString,'<POSCode>',@propertycode)                                        
                        SET @QueryString2 = replace(@QueryString1,'{','''')                                
                        SET quoted_identifier off
                        print(@QueryString2)
                        EXEC(@QueryString2)
                        FETCH NEXT FROM d_cursor INTO @propertycode
                END
                CLOSE d_cursor  
                DEALLOCATE d_cursor
GO


DECLARE @propertycode varchar(5),
        @str varchar(500),
        @QueryString VARCHAR(MAX),
        @QueryString1 VARCHAR(MAX),
        @QueryString2 VARCHAR(MAX),
		@ExcQuery VARCHAR(MAX)=''
  
SET @QueryString ='
IF NOT EXISTS (SELECT * FROM Sysobjects WHERE xtype=''U'' AND [name]=N''TblChallanServices_<POSCode>'')
BEGIN
CREATE TABLE [SNC].[TblChallanServices_<POSCode>](
	[SrNo] [int] IDENTITY(1,1) NOT NULL,	
	[ReservationId] [int] NOT NULL CONSTRAINT [DF_TblChallanServices_<POSCode>_ReservationId] DEFAULT (0) , --Foreign key references [SNC].[TblReservationHead_<POSCode>](ReservationId)
	[DayId] [int] NOT NULL CONSTRAINT [DF_TblChallanServices_<POSCode>_DayId] DEFAULT (0),		
	[ProformaInvoiceId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanServices_<POSCode>_ProformaInvoiceId]  DEFAULT (space((1))),
	[ServiceID] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanServices_<POSCode>_ServiceID] DEFAULT (space(1)),	
	[Quantity] [int] NOT NULL CONSTRAINT [DF_TblChallanServices_<POSCode>_Quantity] DEFAULT (0),
	[IsChargable] [bit] NOT NULL CONSTRAINT [DF_TblChallanServices_<POSCode>_IsChargable] DEFAULT (0),
	[PerUnitRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServices_<POSCode>_PerUnitRate] DEFAULT (0),
	[PerUnitChargableType1] [int] NOT NULL CONSTRAINT [DF_TblChallanServices_<POSCode>_PerUnitChargableType1] DEFAULT (0),	
	[PerUnitChargableType2] [int] NOT NULL CONSTRAINT [DF_TblChallanServices_<POSCode>_PerUnitChargableType2] DEFAULT (0),
	[CalcualtedRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServices_<POSCode>_CalcualtedRate] DEFAULT (0),
	[CalcualtedCost] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServices_<POSCode>_CalcualtedCost] DEFAULT (0),
	[ServiceRateId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanServices_<POSCode>_ServiceRateId] DEFAULT (space(1)),	
	[SupplierRateCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanServices_<POSCode>_SupplierRateCode] DEFAULT (space(1)),	
	[PerUnitCost] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServices_<POSCode>_PerUnitCost] DEFAULT (0),	
	[IsDisplay] [int] NOT NULL CONSTRAINT [DF_TblChallanServices_<POSCode>_IsDisplay] DEFAULT (0),	
	[CostType] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanServices_<POSCode>_CostType] DEFAULT (space(1)),	
	[CostPer]  [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServices_<POSCode>_CostPer]	DEFAULT (0),		
	[Status] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanServices_<POSCode>_Status]  DEFAULT (space(1)),
	[TaxAmt] [money] NOT NULL CONSTRAINT [DF_TblChallanServices_<POSCode>_TaxAmt]  DEFAULT ((0)),
	[TaxStr] [varchar](5000) NOT NULL CONSTRAINT [DF_TblChallanServices_<POSCode>_TaXStr]  DEFAULT (space(1)),
	[Rate] [decimal](38,2) NOT NULL  CONSTRAINT [DF_TblChallanServices_<POSCode>_Rate]  DEFAULT ((0)),
	[Discount] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServices_<POSCode>_Discount]  DEFAULT ((0)),
	[Qty] [int] NOT NULL CONSTRAINT [DF_TblChallanServices_<POSCode>_Qty]  DEFAULT ((0)),
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblChallanServices_<POSCode>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanServices_<POSCode>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanServices_<POSCode>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanServices_<POSCode>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanServices_<POSCode>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanServices_<POSCode>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanServices_<POSCode>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanServices_<POSCode>_ClientID]  DEFAULT (space(1))
) ON [PRIMARY]
End'  
DECLARE d_cursor CURSOR FOR select Trim(POSCode) from Tblposmst where PosStyle='7' order by POSCODE 
                OPEN d_cursor  
                FETCH NEXT FROM d_cursor INTO @propertycode
                WHILE @@FETCH_STATUS = 0  
                BEGIN          
                        SET @QueryString1 = replace(@QueryString,'<POSCode>',@propertycode)                                        
                        SET @QueryString2 = replace(@QueryString1,'{','''')                                
                        SET quoted_identifier off
                        print(@QueryString2)
                        EXEC(@QueryString2)
                        FETCH NEXT FROM d_cursor INTO @propertycode
                END
                CLOSE d_cursor  
                DEALLOCATE d_cursor
GO


DECLARE @propertycode varchar(5),
        @str varchar(500),
        @QueryString VARCHAR(MAX),
        @QueryString1 VARCHAR(MAX),
        @QueryString2 VARCHAR(MAX),
		@ExcQuery VARCHAR(MAX)=''
  
SET @QueryString ='
IF NOT EXISTS (SELECT * FROM Sysobjects WHERE xtype=''U'' AND [name]=N''TblChallanServicesTemp_<POSCode>'')
BEGIN
CREATE TABLE [SNC].[TblChallanServicesTemp_<POSCode>](
	[SrNo] [int] IDENTITY(1,1) NOT NULL,	
	[ReservationId] [int] NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<POSCode>_ReservationId] DEFAULT (0) , --Foreign key references [SNC].[TblReservationHead_<POSCode>](ReservationId)
	[DayId] [int] NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<POSCode>_DayId] DEFAULT (0),		
	[ProformaInvoiceId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<POSCode>_ProformaInvoiceId]  DEFAULT (space((1))),
	[ServiceID] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<POSCode>_ServiceID] DEFAULT (space(1)),	
	[Quantity] [int] NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<POSCode>_Quantity] DEFAULT (0),
	[IsChargable] [bit] NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<POSCode>_IsChargable] DEFAULT (0),
	[PerUnitRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<POSCode>_PerUnitRate] DEFAULT (0),
	[PerUnitChargableType1] [int] NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<POSCode>_PerUnitChargableType1] DEFAULT (0),	
	[PerUnitChargableType2] [int] NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<POSCode>_PerUnitChargableType2] DEFAULT (0),
	[CalcualtedRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<POSCode>_CalcualtedRate] DEFAULT (0),
	[CalcualtedCost] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<POSCode>_CalcualtedCost] DEFAULT (0),
	[ServiceRateId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<POSCode>_ServiceRateId] DEFAULT (space(1)),	
	[SupplierRateCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<POSCode>_SupplierRateCode] DEFAULT (space(1)),	
	[PerUnitCost] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<POSCode>_PerUnitCost] DEFAULT (0),	
	[IsDisplay] [int] NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<POSCode>_IsDisplay] DEFAULT (0),	
	[CostType] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<POSCode>_CostType] DEFAULT (space(1)),	
	[CostPer]  [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<POSCode>_CostPer]	DEFAULT (0),		
	[Status] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<POSCode>_Status]  DEFAULT (space(1)),
	[TaxAmt] [money] NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<POSCode>_TaxAmt]  DEFAULT ((0)),
	[TaxStr] [varchar](5000) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<POSCode>_TaXStr]  DEFAULT (space(1)),
	[Rate] [decimal](38,2) NOT NULL  CONSTRAINT [DF_TblChallanServicesTemp_<POSCode>_Rate]  DEFAULT ((0)),
	[Discount] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<POSCode>_Discount]  DEFAULT ((0)),
	[Qty] [int] NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<POSCode>_Qty]  DEFAULT ((0)),
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<POSCode>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<POSCode>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<POSCode>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<POSCode>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<POSCode>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<POSCode>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<POSCode>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<POSCode>_ClientID]  DEFAULT (space(1)),	
	[Guid] [nvarchar] (max) NOT NULL CONSTRAINT [DF_TblChallanServicesTemp_<POSCode>_Guid] DEFAULT (space(1))
) ON [PRIMARY]
End'  
DECLARE d_cursor CURSOR FOR select Trim(POSCode) from Tblposmst where PosStyle='7' order by POSCODE 
                OPEN d_cursor  
                FETCH NEXT FROM d_cursor INTO @propertycode
                WHILE @@FETCH_STATUS = 0  
                BEGIN          
                        SET @QueryString1 = replace(@QueryString,'<POSCode>',@propertycode)                                        
                        SET @QueryString2 = replace(@QueryString1,'{','''')                                
                        SET quoted_identifier off
                        print(@QueryString2)
                        EXEC(@QueryString2)
                        FETCH NEXT FROM d_cursor INTO @propertycode
                END
                CLOSE d_cursor  
                DEALLOCATE d_cursor
GO


DECLARE @propertycode varchar(5),
        @str varchar(500),
        @QueryString VARCHAR(MAX),
        @QueryString1 VARCHAR(MAX),
        @QueryString2 VARCHAR(MAX),
		@ExcQuery VARCHAR(MAX)=''
  
SET @QueryString ='
IF NOT EXISTS (SELECT * FROM Sysobjects WHERE xtype=''U'' AND [name]=N''TblServicesAmd_<POSCode>'')
BEGIN
CREATE TABLE [SNC].[TblServicesAmd_<POSCode>](	
	[SrNo] [int] NOT NULL CONSTRAINT [DF_TblServicesAmd_<POSCode>_SrNo] DEFAULT (0),
	[ReservationId] [int] NOT NULL CONSTRAINT [DF_TblServicesAmd_<POSCode>_ReservationId] DEFAULT (0) , --Foreign key references [SNC].[TblReservationHead_<POSCode>](ReservationId)
	[DayId] [int] NOT NULL CONSTRAINT [DF_TblServicesAmd_<POSCode>_DayId] DEFAULT (0),	
	[ServiceID] [varchar](24) NOT NULL CONSTRAINT [DF_TblServicesAmd_<POSCode>_ServiceID] DEFAULT (space(1)),	
	[Quantity] [int] NOT NULL CONSTRAINT [DF_TblServicesAmd_<POSCode>_Quantity] DEFAULT (0),
	[IsChargable] [bit] NOT NULL CONSTRAINT [DF_TblServicesAmd_<POSCode>_IsChargable] DEFAULT (0),
	[PerUnitRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblServicesAmd_<POSCode>_PerUnitRate] DEFAULT (0),
	[PerUnitChargableType1] [int] NOT NULL CONSTRAINT [DF_TblServicesAmd_<POSCode>_PerUnitChargableType1] DEFAULT (0),	
	[PerUnitChargableType2] [int] NOT NULL CONSTRAINT [DF_TblServicesAmd_<POSCode>_PerUnitChargableType2] DEFAULT (0),
	[CalcualtedRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblServicesAmd_<POSCode>_CalcualtedRate] DEFAULT (0),
	[CalcualtedCost] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblServicesAmd_<POSCode>_CalcualtedCost] DEFAULT (0),
	[ServiceRateId] [varchar](24) NOT NULL CONSTRAINT [DF_TblServicesAmd_<POSCode>_ServiceRateId] DEFAULT (space(1)),	
	[SupplierRateCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblServicesAmd_<POSCode>_SupplierRateCode] DEFAULT (space(1)),	
	[PerUnitCost] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblServicesAmd_<POSCode>_PerUnitCost] DEFAULT (0),	
	[IsDisplay] [int] NOT NULL CONSTRAINT [DF_TblServicesAmd_<POSCode>_IsDisplay] DEFAULT (0),	
	[CostType] [varchar](5) NOT NULL CONSTRAINT [DF_TblServicesAmd_<POSCode>_CostType] DEFAULT (space(1)),	
	[CostPer]  [decimal](38,2) NOT NULL CONSTRAINT [DF_TblServicesAmd_<POSCode>_CostPer]	DEFAULT (0),	
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblServicesAmd_<POSCode>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblServicesAmd_<POSCode>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblServicesAmd_<POSCode>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblServicesAmd_<POSCode>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblServicesAmd_<POSCode>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblServicesAmd_<POSCode>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblServicesAmd_<POSCode>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblServicesAmd_<POSCode>_ClientID]  DEFAULT (space(1))
) ON [PRIMARY]
End'  
DECLARE d_cursor CURSOR FOR select Trim(POSCode) from Tblposmst where PosStyle='7' order by POSCODE 
                OPEN d_cursor  
                FETCH NEXT FROM d_cursor INTO @propertycode
                WHILE @@FETCH_STATUS = 0  
                BEGIN          
                        SET @QueryString1 = replace(@QueryString,'<POSCode>',@propertycode)                                        
                        SET @QueryString2 = replace(@QueryString1,'{','''')                                
                        SET quoted_identifier off
                        print(@QueryString2)
                        EXEC(@QueryString2)
                        FETCH NEXT FROM d_cursor INTO @propertycode
                END
                CLOSE d_cursor  
                DEALLOCATE d_cursor
GO


DECLARE @propertycode varchar(5),
        @str varchar(500),
        @QueryString VARCHAR(MAX),
        @QueryString1 VARCHAR(MAX),
        @QueryString2 VARCHAR(MAX),
		@ExcQuery VARCHAR(MAX)=''
  
SET @QueryString ='
IF NOT EXISTS (SELECT * FROM Sysobjects WHERE xtype=''U'' AND [name]=N''TblChallanServicesAmd_<POSCode>'')
BEGIN
CREATE TABLE [SNC].[TblChallanServicesAmd_<POSCode>](	
	[SrNo] [int] NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<POSCode>_SrNo] DEFAULT (0),
	[ReservationId] [int] NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<POSCode>_ReservationId] DEFAULT (0) , --Foreign key references [SNC].[TblReservationHead_<POSCode>](ReservationId)
	[DayId] [int] NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<POSCode>_DayId] DEFAULT (0),		
	[ProformaInvoiceId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<POSCode>_ProformaInvoiceId]  DEFAULT (space((1))),
	[ServiceID] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<POSCode>_ServiceID] DEFAULT (space(1)),	
	[Quantity] [int] NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<POSCode>_Quantity] DEFAULT (0),
	[IsChargable] [bit] NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<POSCode>_IsChargable] DEFAULT (0),
	[PerUnitRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<POSCode>_PerUnitRate] DEFAULT (0),
	[PerUnitChargableType1] [int] NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<POSCode>_PerUnitChargableType1] DEFAULT (0),	
	[PerUnitChargableType2] [int] NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<POSCode>_PerUnitChargableType2] DEFAULT (0),
	[CalcualtedRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<POSCode>_CalcualtedRate] DEFAULT (0),
	[CalcualtedCost] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<POSCode>_CalcualtedCost] DEFAULT (0),
	[ServiceRateId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<POSCode>_ServiceRateId] DEFAULT (space(1)),	
	[SupplierRateCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<POSCode>_SupplierRateCode] DEFAULT (space(1)),	
	[PerUnitCost] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<POSCode>_PerUnitCost] DEFAULT (0),	
	[IsDisplay] [int] NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<POSCode>_IsDisplay] DEFAULT (0),	
	[CostType] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<POSCode>_CostType] DEFAULT (space(1)),	
	[CostPer]  [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<POSCode>_CostPer]	DEFAULT (0),		
	[Status] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<POSCode>_Status]  DEFAULT (space(1)),
	[TaxAmt] [money] NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<POSCode>_TaxAmt]  DEFAULT ((0)),
	[TaxStr] [varchar](5000) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<POSCode>_TaXStr]  DEFAULT (space(1)),
	[Rate] [decimal](38,2) NOT NULL  CONSTRAINT [DF_TblChallanServicesAmd_<POSCode>_Rate]  DEFAULT ((0)),
	[Discount] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<POSCode>_Discount]  DEFAULT ((0)),
	[Qty] [int] NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<POSCode>_Qty]  DEFAULT ((0)),
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<POSCode>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<POSCode>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<POSCode>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<POSCode>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<POSCode>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<POSCode>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<POSCode>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanServicesAmd_<POSCode>_ClientID]  DEFAULT (space(1))
) ON [PRIMARY]
End'  
DECLARE d_cursor CURSOR FOR select Trim(POSCode) from Tblposmst where PosStyle='7' order by POSCODE 
                OPEN d_cursor  
                FETCH NEXT FROM d_cursor INTO @propertycode
                WHILE @@FETCH_STATUS = 0  
                BEGIN          
                        SET @QueryString1 = replace(@QueryString,'<POSCode>',@propertycode)                                        
                        SET @QueryString2 = replace(@QueryString1,'{','''')                                
                        SET quoted_identifier off
                        print(@QueryString2)
                        EXEC(@QueryString2)
                        FETCH NEXT FROM d_cursor INTO @propertycode
                END
                CLOSE d_cursor  
                DEALLOCATE d_cursor
GO


DECLARE @propertycode varchar(5),
        @str varchar(500),
        @QueryString VARCHAR(MAX),
        @QueryString1 VARCHAR(MAX),
        @QueryString2 VARCHAR(MAX),
		@ExcQuery VARCHAR(MAX)=''
  
SET @QueryString ='
IF NOT EXISTS (SELECT * FROM Sysobjects WHERE xtype=''U'' AND [name]=N''TblMenuServiceOrder_<POSCode>'')
BEGIN
CREATE TABLE [SNC].[TblMenuServiceOrder_<POSCode>](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuServiceOrder_<POSCode>_ReservationId]  DEFAULT (space(1)),
	[DayId] [varchar](3) NOT NULL  CONSTRAINT [DF_TblMenuServiceOrder_<POSCode>_DayId]  DEFAULT (space(1)),
	[BanquetItemId] [varchar](24) NULL CONSTRAINT [DF_TblMenuServiceOrder_<POSCode>_BanquetItemId]  DEFAULT (space(1)),
	[ServiceID] [varchar](100) NULL  CONSTRAINT [DF_TblMenuServiceOrder_<POSCode>_ServiceID]  DEFAULT (space(1)),
	[ALACARTE] [varchar](100) NULL  CONSTRAINT [DF_TblMenuServiceOrder_<POSCode>_ALACARTE]  DEFAULT (space(1)),
	[MenuServiceOrder] [int] NOT NULL CONSTRAINT [DF_TblMenuServiceOrder_<POSCode>_MenuServiceOrder]  DEFAULT ((0)),
	[MenuHeadId] [varchar](100) NULL CONSTRAINT [DF_TblMenuServiceOrder_<POSCode>_MenuHeadId]  DEFAULT (space(1)),
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblMenuServiceOrder_<POSCode>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuServiceOrder_<POSCode>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuServiceOrder_<POSCode>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuServiceOrder_<POSCode>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuServiceOrder_<POSCode>_ModifiedDate]  DEFAULT (getdate()),
	[POSCode] [varchar](5) NOT NULL CONSTRAINT [DF_TblMenuServiceOrder_<POSCode>_POSCode] DEFAULT (space(1)),	
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuServiceOrder_<POSCode>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuServiceOrder_<POSCode>_ClientID]  DEFAULT (space(1))
) ON [PRIMARY]
End'  
DECLARE d_cursor CURSOR FOR select Trim(POSCode) from Tblposmst where PosStyle='7' order by POSCODE 
                OPEN d_cursor  
                FETCH NEXT FROM d_cursor INTO @propertycode
                WHILE @@FETCH_STATUS = 0  
                BEGIN          
                        SET @QueryString1 = replace(@QueryString,'<POSCode>',@propertycode)                                        
                        SET @QueryString2 = replace(@QueryString1,'{','''')                                
                        SET quoted_identifier off
                        print(@QueryString2)
                        EXEC(@QueryString2)
                        FETCH NEXT FROM d_cursor INTO @propertycode
                END
                CLOSE d_cursor  
                DEALLOCATE d_cursor
GO

