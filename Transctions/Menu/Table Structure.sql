if not exists(select * from SNC.TblSNCTableStructure where QueryName ='TblMenuBanquetItem_<PCODE>')
begin
insert into snc.TblSNCTableStructure (QueryName,QueryString,QueryType)values('TblMenuBanquetItem_<PCODE>','
CREATE TABLE [SNC].[TblMenuBanquetItem_<PCODE>](
	[ReservationId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<PCODE>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<PCODE>_DayId]  DEFAULT (space((1))),	
	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<PCODE>_BanquetItemId]  DEFAULT (space((1))),
	[GuarantedPax] [int] NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<PCODE>_GuaranteedPax]  DEFAULT ((0)),
	[ActualPax] [int] NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<PCODE>_ActualPax]  DEFAULT ((0)),
	[PercentPremiumCharge] [int] NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<PCODE>_PercentPremiumCharge]  DEFAULT ((0)),
	[AmountPremiumCharge] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<PCODE>_AmountPremiumCharge]  DEFAULT ((0)),
	[PerPaxRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<PCODE>_PerPaxRate]  DEFAULT ((0)),
	[CalculatedPaxRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<PCODE>_CalculatedPaxRate]  DEFAULT ((0)),
	[PremiumRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<PCODE>_PremiumRate]  DEFAULT ((0)),
	[CalculatedRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<PCODE>_CalculatedRate]  DEFAULT ((0)),
	[BanquetItemPriceId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<PCODE>_BanquetItemPriceId]  DEFAULT (space((1))),
	[KitchenTime] [varchar](30) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<PCODE>_KitchenTime]  DEFAULT (space((1))),
	[ServeTime] [varchar](30) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<PCODE>_ServeTime]  DEFAULT (space((1))),	
	[CostPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<PCODE>_CostPrice]  DEFAULT ((0)),
	[CalculatedPremium] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<PCODE>_CalculatedPremium]  DEFAULT ((0)),
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<PCODE>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<PCODE>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<PCODE>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<PCODE>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<PCODE>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<PCODE>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<PCODE>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<PCODE>_ClientID]  DEFAULT (space(1))	
) ON [PRIMARY]', 1)
end
GO

if not exists(select * from SNC.TblSNCTableStructure where QueryName ='TblChallanMenuBanquetItem_<PCODE>')
begin
insert into snc.TblSNCTableStructure (QueryName,QueryString,QueryType)values('TblChallanMenuBanquetItem_<PCODE>','
CREATE TABLE [SNC].[TblChallanMenuBanquetItem_<PCODE>](
	[ReservationId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<PCODE>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<PCODE>_DayId]  DEFAULT (space((1))),
	
	[ProformaInvoiceId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<PCODE>_ProformaInvoiceId]  DEFAULT (space((1))),
	
	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<PCODE>_BanquetItemId]  DEFAULT (space((1))),
	[GuarantedPax] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<PCODE>_GuaranteedPax]  DEFAULT ((0)),
	[ActualPax] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<PCODE>_ActualPax]  DEFAULT ((0)),
	[PercentPremiumCharge] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<PCODE>_PercentPremiumCharge]  DEFAULT ((0)),
	[AmountPremiumCharge] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<PCODE>_AmountPremiumCharge]  DEFAULT ((0)),
	[PerPaxRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<PCODE>_PerPaxRate]  DEFAULT ((0)),
	[CalculatedPaxRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<PCODE>_CalculatedPaxRate]  DEFAULT ((0)),
	[PremiumRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<PCODE>_PremiumRate]  DEFAULT ((0)),
	[CalculatedRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<PCODE>_CalculatedRate]  DEFAULT ((0)),
	[BanquetItemPriceId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<PCODE>_BanquetItemPriceId]  DEFAULT (space((1))),
	[KitchenTime] [varchar](30) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<PCODE>_KitchenTime]  DEFAULT (space((1))),
	[ServeTime] [varchar](30) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<PCODE>_ServeTime]  DEFAULT (space((1))),
	
	[Status] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<PCODE>_Status]  DEFAULT (space(1)),
	[TaxAmt] [money] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<PCODE>_TaxAmt]  DEFAULT ((0)),
	[TaxStr] [varchar](5000) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<PCODE>_TaXStr]  DEFAULT (space(1)),
	[Rate] [decimal](38,2) NOT NULL  CONSTRAINT [DF_TblChallanMenuBanquetItem_<PCODE>_Rate]  DEFAULT ((0)),
	[Discount] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<PCODE>_Discount]  DEFAULT ((0)),
	[Qty] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<PCODE>_Quantity]  DEFAULT ((0)),
	
	[CostPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<PCODE>_CostPrice]  DEFAULT ((0)),
	[CalculatedPremium] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<PCODE>_CalculatedPremium]  DEFAULT ((0)),
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<PCODE>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<PCODE>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<PCODE>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<PCODE>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<PCODE>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<PCODE>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<PCODE>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<PCODE>_ClientID]  DEFAULT (space(1))	
) ON [PRIMARY]', 1)
end
GO

if not exists(select * from SNC.TblSNCTableStructure where QueryName ='TblChallanMenuBanquetItemTemp_<PCODE>')
begin
insert into snc.TblSNCTableStructure (QueryName,QueryString,QueryType)values('TblChallanMenuBanquetItemTemp_<PCODE>','
CREATE TABLE [SNC].[TblChallanMenuBanquetItemTemp_<PCODE>](
	[ReservationId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<PCODE>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<PCODE>_DayId]  DEFAULT (space((1))),
	[ProformaInvoiceId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<PCODE>_ProformaInvoiceId]  DEFAULT (space((1))),
	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<PCODE>_BanquetItemId]  DEFAULT (space((1))),
	[GuarantedPax] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<PCODE>_GuaranteedPax]  DEFAULT ((0)),
	[ActualPax] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<PCODE>_ActualPax]  DEFAULT ((0)),
	[PercentPremiumCharge] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<PCODE>_PercentPremiumCharge]  DEFAULT ((0)),
	[AmountPremiumCharge] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<PCODE>_AmountPremiumCharge]  DEFAULT ((0)),
	[PerPaxRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<PCODE>_PerPaxRate]  DEFAULT ((0)),
	[CalculatedPaxRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<PCODE>_CalculatedPaxRate]  DEFAULT ((0)),
	[PremiumRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<PCODE>_PremiumRate]  DEFAULT ((0)),
	[CalculatedRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<PCODE>_CalculatedRate]  DEFAULT ((0)),
	[BanquetItemPriceId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<PCODE>_BanquetItemPriceId]  DEFAULT (space((1))),
	[KitchenTime] [varchar](30) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<PCODE>_KitchenTime]  DEFAULT (space((1))),
	[ServeTime] [varchar](30) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<PCODE>_ServeTime]  DEFAULT (space((1))),
	[Status] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<PCODE>_Status]  DEFAULT (space(1)),
	[TaxAmt] [money] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<PCODE>_TaxAmt]  DEFAULT ((0)),
	[TaxStr] [varchar](5000) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<PCODE>_TaXStr]  DEFAULT (space(1)),
	[Rate] [decimal](38,2) NOT NULL  CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<PCODE>_Rate]  DEFAULT ((0)),
	[Discount] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<PCODE>_Discount]  DEFAULT ((0)),
	[Qty] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<PCODE>_Quantity]  DEFAULT ((0)),
	[CostPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<PCODE>_CostPrice]  DEFAULT ((0)),
	[CalculatedPremium] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<PCODE>_CalculatedPremium]  DEFAULT ((0)),
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<PCODE>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<PCODE>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<PCODE>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<PCODE>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<PCODE>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<PCODE>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<PCODE>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<PCODE>_ClientID]  DEFAULT (space(1)),	
	[Guid] [nvarchar] (max) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<PCODE>_Guid] DEFAULT (space(1))
) ON [PRIMARY]', 1)
end
GO


if not exists(select * from SNC.TblSNCTableStructure where QueryName ='TblMenuBanquetItemAmd_<PCODE>')
begin
insert into snc.TblSNCTableStructure (QueryName,QueryString,QueryType)values('TblMenuBanquetItemAmd_<PCODE>','
CREATE TABLE [SNC].[TblMenuBanquetItemAmd_<PCODE>](
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<PCODE>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](3) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<PCODE>_DayId]  DEFAULT (space((1))),	
	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<PCODE>_BanquetItemId]  DEFAULT (space((1))),
	[GuarantedPax] [int] NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<PCODE>_GuaranteedPax]  DEFAULT ((0)),
	[ActualPax] [int] NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<PCODE>_ActualPax]  DEFAULT ((0)),
	[PercentPremiumCharge] [int] NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<PCODE>_PercentPremiumCharge]  DEFAULT ((0)),
	[AmountPremiumCharge] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<PCODE>_AmountPremiumCharge]  DEFAULT ((0)),
	[PerPaxRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<PCODE>_PerPaxRate]  DEFAULT ((0)),
	[CalculatedPaxRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<PCODE>_CalculatedPaxRate]  DEFAULT ((0)),
	[PremiumRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<PCODE>_PremiumRate]  DEFAULT ((0)),
	[CalculatedRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<PCODE>_CalculatedRate]  DEFAULT ((0)),
	[BanquetItemPriceId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<PCODE>_BanquetItemPriceId]  DEFAULT (space((1))),
	[KitchenTime] [varchar](30) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<PCODE>_KitchenTime]  DEFAULT (space((1))),
	[ServeTime] [varchar](30) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<PCODE>_ServeTime]  DEFAULT (space((1))),
	[CostPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<PCODE>_CostPrice]  DEFAULT ((0)),
	[CalculatedPremium] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<PCODE>_CalculatedPremium]  DEFAULT ((0)),
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<PCODE>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<PCODE>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<PCODE>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<PCODE>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<PCODE>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<PCODE>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<PCODE>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<PCODE>_ClientID]  DEFAULT (space(1))	
) ON [PRIMARY]', 1)
end
GO

if not exists(select * from SNC.TblSNCTableStructure where QueryName ='TblChallanMenuBanquetItemAmd_<PCODE>')
begin
insert into snc.TblSNCTableStructure (QueryName,QueryString,QueryType)values('TblChallanMenuBanquetItemAmd_<PCODE>','
CREATE TABLE [SNC].[TblChallanMenuBanquetItemAmd_<PCODE>](
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<PCODE>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](3) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<PCODE>_DayId]  DEFAULT (space((1))),
	[ProformaInvoiceId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<PCODE>_ProformaInvoiceId]  DEFAULT (space((1))),
	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<PCODE>_BanquetItemId]  DEFAULT (space((1))),
	[GuarantedPax] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<PCODE>_GuaranteedPax]  DEFAULT ((0)),
	[ActualPax] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<PCODE>_ActualPax]  DEFAULT ((0)),
	[PercentPremiumCharge] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<PCODE>_PercentPremiumCharge]  DEFAULT ((0)),
	[AmountPremiumCharge] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<PCODE>_AmountPremiumCharge]  DEFAULT ((0)),
	[PerPaxRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<PCODE>_PerPaxRate]  DEFAULT ((0)),
	[CalculatedPaxRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<PCODE>_CalculatedPaxRate]  DEFAULT ((0)),
	[PremiumRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<PCODE>_PremiumRate]  DEFAULT ((0)),
	[CalculatedRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<PCODE>_CalculatedRate]  DEFAULT ((0)),
	[BanquetItemPriceId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<PCODE>_BanquetItemPriceId]  DEFAULT (space((1))),
	[KitchenTime] [varchar](30) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<PCODE>_KitchenTime]  DEFAULT (space((1))),
	[ServeTime] [varchar](30) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<PCODE>_ServeTime]  DEFAULT (space((1))),
	[Status] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<PCODE>_Status]  DEFAULT (space(1)),
	[TaxAmt] [money] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<PCODE>_TaxAmt]  DEFAULT ((0)),
	[TaxStr] [varchar](5000) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<PCODE>_TaXStr]  DEFAULT (space(1)),
	[Rate] [decimal](38,2) NOT NULL  CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<PCODE>_Rate]  DEFAULT ((0)),
	[Discount] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<PCODE>_Discount]  DEFAULT ((0)),
	[Qty] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<PCODE>_Quantity]  DEFAULT ((0)),
	[CostPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<PCODE>_CostPrice]  DEFAULT ((0)),
	[CalculatedPremium] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<PCODE>_CalculatedPremium]  DEFAULT ((0)),
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<PCODE>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<PCODE>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<PCODE>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<PCODE>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<PCODE>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<PCODE>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<PCODE>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<PCODE>_ClientID]  DEFAULT (space(1))	
) ON [PRIMARY]', 1)
end
GO



if not exists(select * from SNC.TblSNCTableStructure where QueryName ='TblMenuItem_<PCODE>')
begin
insert into snc.TblSNCTableStructure (QueryName,QueryString,QueryType)values('TblMenuItem_<PCODE>','
CREATE TABLE [SNC].[TblMenuItem_<PCODE>](
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItem_<PCODE>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](3) NOT NULL CONSTRAINT [DF_TblMenuItem_<PCODE>_DayId]  DEFAULT (space((1))),
	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItem_<PCODE>_BanquetItemId]  DEFAULT (space((1))),
	[MenuHeadCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItem_<PCODE>_MenuHeadCode]  DEFAULT (space((1))),
	[MenuItemCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItem_<PCODE>_MenuItemCode]  DEFAULT (space((1))),
	[IsTDHCost] [bit] NOT NULL CONSTRAINT [DF_TblMenuItem_<PCODE>_IsTDHCost]  DEFAULT ((0)),
	[Quantity] [decimal](38, 3) NOT NULL CONSTRAINT [DF_TblMenuItem_<PCODE>_Quantity]  DEFAULT ((0)),
	[CostPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuItem_<PCODE>_CostPrice]  DEFAULT ((0)),
	[PerSalesPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuItem_<PCODE>_PerSalesPrice]  DEFAULT ((0)),
	[CalculatedPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuItem_<PCODE>_CalculatedPrice]  DEFAULT ((0)),
	[IsModifier] [bit] NOT NULL CONSTRAINT [DF_TblMenuItem_<PCODE>_IsModifier]  DEFAULT ((0)),
	[MenuItemRateCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItem_<PCODE>_MenuItemRateCode]  DEFAULT (space((1))),	
	[IsFreeFlow] [bit] NOT NULL CONSTRAINT [DF_TblMenuItem_<PCODE>_IsFreeFlow]  DEFAULT ((0)),
	[MenuHeadType] [varchar](10) NOT NULL CONSTRAINT [DF_TblMenuItem_<PCODE>_MenuHeadType]  DEFAULT (space((1))),
	[Chargeble] [varchar](5) NOT NULL CONSTRAINT [DF_TblMenuItem_<PCODE>_Chargeble]  DEFAULT (space(1)),
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblMenuItem_<PCODE>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblMenuItem_<PCODE>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuItem_<PCODE>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuItem_<PCODE>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuItem_<PCODE>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuItem_<PCODE>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuItem_<PCODE>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuItem_<PCODE>_ClientID]  DEFAULT (space(1))	
) ON [PRIMARY]', 1)
end
GO


if not exists(select * from SNC.TblSNCTableStructure where QueryName ='TblChallanMenuItem_<PCODE>')
begin
insert into snc.TblSNCTableStructure (QueryName,QueryString,QueryType)values('TblChallanMenuItem_<PCODE>','
CREATE TABLE [SNC].[TblChallanMenuItem_<PCODE>](
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<PCODE>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](3) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<PCODE>_DayId]  DEFAULT (space((1))),
	
	[ProformaInvoiceId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<PCODE>_ProformaInvoiceId]  DEFAULT (space((1))),

	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<PCODE>_BanquetItemId]  DEFAULT (space((1))),
	[MenuHeadCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<PCODE>_MenuHeadCode]  DEFAULT (space((1))),
	[MenuItemCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<PCODE>_MenuItemCode]  DEFAULT (space((1))),
	[IsTDHCost] [bit] NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<PCODE>_IsTDHCost]  DEFAULT ((0)),
	[Quantity] [decimal](38, 3) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<PCODE>_Quantity]  DEFAULT ((0)),
	[CostPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<PCODE>_CostPrice]  DEFAULT ((0)),
	[PerSalesPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<PCODE>_PerSalesPrice]  DEFAULT ((0)),
	[CalculatedPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<PCODE>_CalculatedPrice]  DEFAULT ((0)),
	[IsModifier] [bit] NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<PCODE>_IsModifier]  DEFAULT ((0)),
	[MenuItemRateCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<PCODE>_MenuItemRateCode]  DEFAULT (space((1))),	
	[IsFreeFlow] [bit] NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<PCODE>_IsFreeFlow]  DEFAULT ((0)),
	[MenuHeadType] [varchar](10) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<PCODE>_MenuHeadType]  DEFAULT (space((1))),
	[Chargeble] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<PCODE>_Chargeble]  DEFAULT (space(1)),
	
	[Status] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<PCODE>_Status]  DEFAULT (space(1)),
	[TaxAmt] [money] NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<PCODE>_TaxAmt]  DEFAULT ((0)),
	[TaxStr] [varchar](5000) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<PCODE>_TaXStr]  DEFAULT (space(1)),
	[Rate] [decimal](38,2) NOT NULL  CONSTRAINT [DF_TblChallanMenuItem_<PCODE>_Rate]  DEFAULT ((0)),
	[Discount] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<PCODE>_Discount]  DEFAULT ((0)),
	[Qty] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<PCODE>_Qty]  DEFAULT ((0)),

	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<PCODE>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<PCODE>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<PCODE>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<PCODE>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<PCODE>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<PCODE>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<PCODE>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<PCODE>_ClientID]  DEFAULT (space(1))	
) ON [PRIMARY]', 1)
end
GO

if not exists(select * from SNC.TblSNCTableStructure where QueryName ='TblChallanMenuItemTemp_<PCODE>')
begin
insert into snc.TblSNCTableStructure (QueryName,QueryString,QueryType)values('TblChallanMenuItemTemp_<PCODE>','
CREATE TABLE [SNC].[TblChallanMenuItemTemp_<PCODE>](
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<PCODE>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](3) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<PCODE>_DayId]  DEFAULT (space((1))),
	
	[ProformaInvoiceId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<PCODE>_ProformaInvoiceId]  DEFAULT (space((1))),

	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<PCODE>_BanquetItemId]  DEFAULT (space((1))),
	[MenuHeadCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<PCODE>_MenuHeadCode]  DEFAULT (space((1))),
	[MenuItemCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<PCODE>_MenuItemCode]  DEFAULT (space((1))),
	[IsTDHCost] [bit] NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<PCODE>_IsTDHCost]  DEFAULT ((0)),
	[Quantity] [decimal](38, 3) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<PCODE>_Quantity]  DEFAULT ((0)),
	[CostPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<PCODE>_CostPrice]  DEFAULT ((0)),
	[PerSalesPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<PCODE>_PerSalesPrice]  DEFAULT ((0)),
	[CalculatedPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<PCODE>_CalculatedPrice]  DEFAULT ((0)),
	[IsModifier] [bit] NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<PCODE>_IsModifier]  DEFAULT ((0)),
	[MenuItemRateCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<PCODE>_MenuItemRateCode]  DEFAULT (space((1))),	
	[IsFreeFlow] [bit] NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<PCODE>_IsFreeFlow]  DEFAULT ((0)),
	[MenuHeadType] [varchar](10) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<PCODE>_MenuHeadType]  DEFAULT (space((1))),
	[Chargeble] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<PCODE>_Chargeble]  DEFAULT (space(1)),
	
	[Status] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<PCODE>_Status]  DEFAULT (space(1)),
	[TaxAmt] [money] NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<PCODE>_TaxAmt]  DEFAULT ((0)),
	[TaxStr] [varchar](5000) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<PCODE>_TaXStr]  DEFAULT (space(1)),
	[Rate] [decimal](38,2) NOT NULL  CONSTRAINT [DF_TblChallanMenuItemTemp_<PCODE>_Rate]  DEFAULT ((0)),
	[Discount] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<PCODE>_Discount]  DEFAULT ((0)),
	[Qty] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<PCODE>_Qty]  DEFAULT ((0)),

	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<PCODE>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<PCODE>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<PCODE>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<PCODE>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<PCODE>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<PCODE>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<PCODE>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<PCODE>_ClientID]  DEFAULT (space(1)),
	[Guid] [nvarchar] (max) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<PCODE>_Guid] DEFAULT (space(1))	
) ON [PRIMARY]', 1)
end
GO


if not exists(select * from SNC.TblSNCTableStructure where QueryName ='TblMenuItemAmd_<PCODE>')
begin
insert into snc.TblSNCTableStructure (QueryName,QueryString,QueryType)values('TblMenuItemAmd_<PCODE>','
CREATE TABLE [SNC].[TblMenuItemAmd_<PCODE>](
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<PCODE>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](3) NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<PCODE>_DayId]  DEFAULT (space((1))),
	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<PCODE>_BanquetItemId]  DEFAULT (space((1))),
	[MenuHeadCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<PCODE>_MenuHeadCode]  DEFAULT (space((1))),
	[MenuItemCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<PCODE>_MenuItemCode]  DEFAULT (space((1))),
	[IsTDHCost] [bit] NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<PCODE>_IsTDHCost]  DEFAULT ((0)),
	[Quantity] [decimal](38, 3) NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<PCODE>_Quantity]  DEFAULT ((0)),
	[CostPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<PCODE>_CostPrice]  DEFAULT ((0)),
	[PerSalesPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<PCODE>_PerSalesPrice]  DEFAULT ((0)),
	[CalculatedPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<PCODE>_CalculatedPrice]  DEFAULT ((0)),
	[IsModifier] [bit] NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<PCODE>_IsModifier]  DEFAULT ((0)),
	[MenuItemRateCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<PCODE>_MenuItemRateCode]  DEFAULT (space((1))),	
	[IsFreeFlow] [bit] NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<PCODE>_IsFreeFlow]  DEFAULT ((0)),
	[MenuHeadType] [varchar](10) NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<PCODE>_MenuHeadType]  DEFAULT (space((1))),
	[Chargeble] [varchar](5) NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<PCODE>_Chargeble]  DEFAULT (space(1)),
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<PCODE>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<PCODE>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<PCODE>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<PCODE>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<PCODE>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<PCODE>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<PCODE>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<PCODE>_ClientID]  DEFAULT (space(1))	
) ON [PRIMARY]', 1)
end
GO

if not exists(select * from SNC.TblSNCTableStructure where QueryName ='TblChallanMenuItemAmd_<PCODE>')
begin
insert into snc.TblSNCTableStructure (QueryName,QueryString,QueryType)values('TblChallanMenuItemAmd_<PCODE>','
CREATE TABLE [SNC].[TblChallanMenuItemAmd_<PCODE>](
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<PCODE>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](3) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<PCODE>_DayId]  DEFAULT (space((1))),
	
	[ProformaInvoiceId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<PCODE>_ProformaInvoiceId]  DEFAULT (space((1))),

	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<PCODE>_BanquetItemId]  DEFAULT (space((1))),
	[MenuHeadCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<PCODE>_MenuHeadCode]  DEFAULT (space((1))),
	[MenuItemCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<PCODE>_MenuItemCode]  DEFAULT (space((1))),
	[IsTDHCost] [bit] NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<PCODE>_IsTDHCost]  DEFAULT ((0)),
	[Quantity] [decimal](38, 3) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<PCODE>_Quantity]  DEFAULT ((0)),
	[CostPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<PCODE>_CostPrice]  DEFAULT ((0)),
	[PerSalesPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<PCODE>_PerSalesPrice]  DEFAULT ((0)),
	[CalculatedPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<PCODE>_CalculatedPrice]  DEFAULT ((0)),
	[IsModifier] [bit] NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<PCODE>_IsModifier]  DEFAULT ((0)),
	[MenuItemRateCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<PCODE>_MenuItemRateCode]  DEFAULT (space((1))),	
	[IsFreeFlow] [bit] NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<PCODE>_IsFreeFlow]  DEFAULT ((0)),
	[MenuHeadType] [varchar](10) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<PCODE>_MenuHeadType]  DEFAULT (space((1))),
	[Chargeble] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<PCODE>_Chargeble]  DEFAULT (space(1)),
	
	[Status] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<PCODE>_Status]  DEFAULT (space(1)),
	[TaxAmt] [money] NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<PCODE>_TaxAmt]  DEFAULT ((0)),
	[TaxStr] [varchar](5000) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<PCODE>_TaXStr]  DEFAULT (space(1)),
	[Rate] [decimal](38,2) NOT NULL  CONSTRAINT [DF_TblChallanMenuItemAmd_<PCODE>_Rate]  DEFAULT ((0)),
	[Discount] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<PCODE>_Discount]  DEFAULT ((0)),
	[Qty] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<PCODE>_Qty]  DEFAULT ((0)),

	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<PCODE>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<PCODE>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<PCODE>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<PCODE>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<PCODE>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<PCODE>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<PCODE>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<PCODE>_ClientID]  DEFAULT (space(1))	
) ON [PRIMARY]', 1)
end
GO



if not exists(select * from SNC.TblSNCTableStructure where QueryName ='TblMenuModifier_<PCODE>')
begin
insert into snc.TblSNCTableStructure (QueryName,QueryString,QueryType)values('TblMenuModifier_<PCODE>','
CREATE TABLE [SNC].[TblMenuModifier_<PCODE>](
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuModifier_<PCODE>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](3) NOT NULL CONSTRAINT [DF_TblMenuModifier_<PCODE>_DayId]  DEFAULT (space((1))),
	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuModifier_<PCODE>_BanquetItemId]  DEFAULT (space((1))),
	[MenuHeadCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuModifier_<PCODE>_MenuHeadCode]  DEFAULT (space((1))),
	[MenuItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuModifier_<PCODE>_MenuItemId]  DEFAULT (space((1))),
	[ModifierId] [int] IDENTITY(1,1) NOT NULL,
	[ModifierDescription] [varchar](500) NULL CONSTRAINT [DF_TblMenuModifier_<PCODE>_ModifierDescription]  DEFAULT (space((1))),
	[ModifierRate] [decimal] (38,2) NOT NULL CONSTRAINT [DF_TblMenuModifier_<PCODE>_ModifierRate]  DEFAULT ((0)),	
	[IsFreeFlow] [bit] NOT NULL CONSTRAINT [DF_TblMenuModifier_<PCODE>_IsFreeFlow]  DEFAULT ((0)),
	[MenuHeadType] [varchar](10) NOT NULL CONSTRAINT [DF_TblMenuModifier_<PCODE>_MenuHeadType]  DEFAULT (space((1))),	
	[ModifierCost] [decimal] (38,2) NOT NULL CONSTRAINT [DF_TblMenuModifier_<PCODE>_ModifierCost] DEFAULT ((0)),
	[Quantity] [nvarchar](50) NOT NULL CONSTRAINT [DF_TblMenuModifier_<PCODE>_Quantity] DEFAULT ((0)),
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblMenuModifier_<PCODE>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblMenuModifier_<PCODE>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuModifier_<PCODE>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuModifier_<PCODE>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuModifier_<PCODE>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuModifier_<PCODE>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuModifier_<PCODE>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuModifier_<PCODE>_ClientID]  DEFAULT (space(1))	
 CONSTRAINT [PK_TblMenuModifier_<PCODE>] PRIMARY KEY CLUSTERED 
(
	[ModifierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]', 1)
end
GO


if not exists(select * from SNC.TblSNCTableStructure where QueryName ='TblChallanMenuModifier_<PCODE>')
begin
insert into snc.TblSNCTableStructure (QueryName,QueryString,QueryType)values('TblChallanMenuModifier_<PCODE>','
CREATE TABLE [SNC].[TblChallanMenuModifier_<PCODE>](
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<PCODE>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](3) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<PCODE>_DayId]  DEFAULT (space((1))),
	
	[ProformaInvoiceId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<PCODE>_ProformaInvoiceId]  DEFAULT (space((1))),
	
	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<PCODE>_BanquetItemId]  DEFAULT (space((1))),
	[MenuHeadCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<PCODE>_MenuHeadCode]  DEFAULT (space((1))),
	[MenuItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<PCODE>_MenuItemId]  DEFAULT (space((1))),
	[ModifierId] [int] IDENTITY(1,1) NOT NULL,
	[ModifierDescription] [varchar](500) NULL CONSTRAINT [DF_TblChallanMenuModifier_<PCODE>_ModifierDescription]  DEFAULT (space((1))),
	[ModifierRate] [decimal] (38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<PCODE>_ModifierRate]  DEFAULT ((0)),	
	[IsFreeFlow] [bit] NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<PCODE>_IsFreeFlow]  DEFAULT ((0)),
	[MenuHeadType] [varchar](10) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<PCODE>_MenuHeadType]  DEFAULT (space((1))),	
	[ModifierCost] [decimal] (38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<PCODE>_ModifierCost] DEFAULT ((0)),
	[Quantity] [nvarchar](50) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<PCODE>_Quantity] DEFAULT ((0)),

	[Status] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<PCODE>_Status]  DEFAULT (space(1)),
	[TaxAmt] [money] NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<PCODE>_TaxAmt]  DEFAULT ((0)),
	[TaxStr] [varchar](5000) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<PCODE>_TaXStr]  DEFAULT (space(1)),
	[Rate] [decimal](38,2) NOT NULL  CONSTRAINT [DF_TblChallanMenuModifier_<PCODE>_Rate]  DEFAULT ((0)),
	[Discount] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<PCODE>_Discount]  DEFAULT ((0)),
	[Qty] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<PCODE>_Qty]  DEFAULT ((0)),

	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<PCODE>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<PCODE>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<PCODE>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<PCODE>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<PCODE>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<PCODE>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<PCODE>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<PCODE>_ClientID]  DEFAULT (space(1))	
 CONSTRAINT [PK_TblChallanMenuModifier_<PCODE>] PRIMARY KEY CLUSTERED 
(
	[ModifierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]', 1)
end
GO


if not exists(select * from SNC.TblSNCTableStructure where QueryName ='TblChallanMenuModifierTemp_<PCODE>')
begin
insert into snc.TblSNCTableStructure (QueryName,QueryString,QueryType)values('TblChallanMenuModifierTemp_<PCODE>','
CREATE TABLE [SNC].[TblChallanMenuModifierTemp_<PCODE>](
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<PCODE>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](3) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<PCODE>_DayId]  DEFAULT (space((1))),
	
	[ProformaInvoiceId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<PCODE>_ProformaInvoiceId]  DEFAULT (space((1))),
	
	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<PCODE>_BanquetItemId]  DEFAULT (space((1))),
	[MenuHeadCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<PCODE>_MenuHeadCode]  DEFAULT (space((1))),
	[MenuItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<PCODE>_MenuItemId]  DEFAULT (space((1))),
	[ModifierId] [int] IDENTITY(1,1) NOT NULL,
	[ModifierDescription] [varchar](500) NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<PCODE>_ModifierDescription]  DEFAULT (space((1))),
	[ModifierRate] [decimal] (38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<PCODE>_ModifierRate]  DEFAULT ((0)),	
	[IsFreeFlow] [bit] NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<PCODE>_IsFreeFlow]  DEFAULT ((0)),
	[MenuHeadType] [varchar](10) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<PCODE>_MenuHeadType]  DEFAULT (space((1))),	
	[ModifierCost] [decimal] (38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<PCODE>_ModifierCost] DEFAULT ((0)),
	[Quantity] [nvarchar](50) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<PCODE>_Quantity] DEFAULT ((0)),
	
	[Status] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<PCODE>_Status]  DEFAULT (space(1)),
	[TaxAmt] [money] NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<PCODE>_TaxAmt]  DEFAULT ((0)),
	[TaxStr] [varchar](5000) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<PCODE>_TaXStr]  DEFAULT (space(1)),
	[Rate] [decimal](38,2) NOT NULL  CONSTRAINT [DF_TblChallanMenuModifierTemp_<PCODE>_Rate]  DEFAULT ((0)),
	[Discount] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<PCODE>_Discount]  DEFAULT ((0)),
	[Qty] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<PCODE>_Qty]  DEFAULT ((0)),

	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<PCODE>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<PCODE>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<PCODE>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<PCODE>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<PCODE>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<PCODE>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<PCODE>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<PCODE>_ClientID]  DEFAULT (space(1)),
	[Guid] [nvarchar] (max) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<PCODE>_Guid] DEFAULT (space(1))		
 CONSTRAINT [PK_TblChallanMenuModifierTemp_<PCODE>] PRIMARY KEY CLUSTERED 
(
	[ModifierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]', 1)
end
GO


if not exists(select * from SNC.TblSNCTableStructure where QueryName ='TblMenuModifierAmd_<PCODE>')
begin
insert into snc.TblSNCTableStructure (QueryName,QueryString,QueryType)values('TblMenuModifierAmd_<PCODE>','
CREATE TABLE [SNC].[TblMenuModifierAmd_<PCODE>](
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<PCODE>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](3) NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<PCODE>_DayId]  DEFAULT (space((1))),
	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<PCODE>_BanquetItemId]  DEFAULT (space((1))),
	[MenuHeadCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<PCODE>_MenuHeadCode]  DEFAULT (space((1))),
	[MenuItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<PCODE>_MenuItemId]  DEFAULT (space((1))),
	[ModifierId] [int] NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<PCODE>_ModifierId] DEFAULT ((0)),
	[ModifierDescription] [varchar](500) NULL CONSTRAINT [DF_TblMenuModifierAmd_<PCODE>_ModifierDescription]  DEFAULT (space((1))),
	[ModifierRate] [decimal] (38,2) NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<PCODE>_ModifierRate]  DEFAULT ((0)),	
	[IsFreeFlow] [bit] NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<PCODE>_IsFreeFlow]  DEFAULT ((0)),
	[MenuHeadType] [varchar](10) NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<PCODE>_MenuHeadType]  DEFAULT (space((1))),	
	[ModifierCost] [decimal] (38,2) NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<PCODE>_ModifierCost] DEFAULT ((0)),
	[Quantity] [nvarchar](50) NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<PCODE>_Quantity] DEFAULT ((0)),
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<PCODE>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<PCODE>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<PCODE>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<PCODE>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<PCODE>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<PCODE>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<PCODE>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<PCODE>_ClientID]  DEFAULT (space(1))	
)', 1)
end
GO

if not exists(select * from SNC.TblSNCTableStructure where QueryName ='TblChallanMenuModifierAmd_<PCODE>')
begin
insert into snc.TblSNCTableStructure (QueryName,QueryString,QueryType)values('TblChallanMenuModifierAmd_<PCODE>','
CREATE TABLE [SNC].[TblChallanMenuModifierAmd_<PCODE>](
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<PCODE>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](3) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<PCODE>_DayId]  DEFAULT (space((1))),
	
	[ProformaInvoiceId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<PCODE>_ProformaInvoiceId]  DEFAULT (space((1))),
	
	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<PCODE>_BanquetItemId]  DEFAULT (space((1))),
	[MenuHeadCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<PCODE>_MenuHeadCode]  DEFAULT (space((1))),
	[MenuItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<PCODE>_MenuItemId]  DEFAULT (space((1))),
	[ModifierId] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<PCODE>_ModifierId] DEFAULT ((0)),
	[ModifierDescription] [varchar](500) NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<PCODE>_ModifierDescription]  DEFAULT (space((1))),
	[ModifierRate] [decimal] (38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<PCODE>_ModifierRate]  DEFAULT ((0)),	
	[IsFreeFlow] [bit] NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<PCODE>_IsFreeFlow]  DEFAULT ((0)),
	[MenuHeadType] [varchar](10) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<PCODE>_MenuHeadType]  DEFAULT (space((1))),	
	[ModifierCost] [decimal] (38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<PCODE>_ModifierCost] DEFAULT ((0)),
	[Quantity] [nvarchar](50) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<PCODE>_Quantity] DEFAULT ((0)),
	
	[Status] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<PCODE>_Status]  DEFAULT (space(1)),
	[TaxAmt] [money] NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<PCODE>_TaxAmt]  DEFAULT ((0)),
	[TaxStr] [varchar](5000) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<PCODE>_TaXStr]  DEFAULT (space(1)),
	[Rate] [decimal](38,2) NOT NULL  CONSTRAINT [DF_TblChallanMenuModifierAmd_<PCODE>_Rate]  DEFAULT ((0)),
	[Discount] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<PCODE>_Discount]  DEFAULT ((0)),
	[Qty] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<PCODE>_Qty]  DEFAULT ((0)),
	
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<PCODE>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<PCODE>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<PCODE>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<PCODE>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<PCODE>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<PCODE>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<PCODE>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<PCODE>_ClientID]  DEFAULT (space(1))	
)', 1)
end
GO
 
if not exists(select * from SNC.TblSNCTableStructure where QueryName ='TblMenuItemCostCenter_<PCODE>')
begin
insert into snc.TblSNCTableStructure (QueryName,QueryString,QueryType)values('TblMenuItemCostCenter_<PCODE>','
CREATE TABLE [SNC].[TblMenuItemCostCenter_<PCODE>](
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenter_<PCODE>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](3) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenter_<PCODE>_DayId]  DEFAULT (space((1))),
	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenter_<PCODE>_BanquetItemId]  DEFAULT (space((1))),
	[MenuHeadId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenter_<PCODE>_MenuHeadId]  DEFAULT (space((1))),
	[MenuItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenter_<PCODE>_MenuItemId]  DEFAULT (space((1))),
	[CostCenter] [varchar](10) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenter_<PCODE>_CostCenter]  DEFAULT (space((1))),	
	[MenuHeadType] [varchar](10) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenter_<PCODE>_MenuHeadType]  DEFAULT (space((1))),	
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblMenuItemCostCenter_<PCODE>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenter_<PCODE>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenter_<PCODE>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuItemCostCenter_<PCODE>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenter_<PCODE>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuItemCostCenter_<PCODE>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenter_<PCODE>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenter_<PCODE>_ClientID]  DEFAULT (space(1))
) ON [PRIMARY]', 1)
end
GO

if not exists(select * from SNC.TblSNCTableStructure where QueryName ='TblChallanMenuItemCostCenter_<PCODE>')
begin
insert into snc.TblSNCTableStructure (QueryName,QueryString,QueryType)values('TblChallanMenuItemCostCenter_<PCODE>','
CREATE TABLE [SNC].[TblChallanMenuItemCostCenter_<PCODE>](
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenter_<PCODE>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](3) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenter_<PCODE>_DayId]  DEFAULT (space((1))),
	
	[ProformaInvoiceId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenter_<PCODE>_ProformaInvoiceId]  DEFAULT (space((1))),
	
	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenter_<PCODE>_BanquetItemId]  DEFAULT (space((1))),
	[MenuHeadId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenter_<PCODE>_MenuHeadId]  DEFAULT (space((1))),
	[MenuItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenter_<PCODE>_MenuItemId]  DEFAULT (space((1))),
	[CostCenter] [varchar](10) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenter_<PCODE>_CostCenter]  DEFAULT (space((1))),	
	[MenuHeadType] [varchar](10) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenter_<PCODE>_MenuHeadType]  DEFAULT (space((1))),	
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenter_<PCODE>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenter_<PCODE>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenter_<PCODE>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenter_<PCODE>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenter_<PCODE>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenter_<PCODE>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenter_<PCODE>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenter_<PCODE>_ClientID]  DEFAULT (space(1))
) ON [PRIMARY]', 1)
end
GO


if not exists(select * from SNC.TblSNCTableStructure where QueryName ='TblChallanMenuItemCostCenterTemp_<PCODE>')
begin
insert into snc.TblSNCTableStructure (QueryName,QueryString,QueryType)values('TblChallanMenuItemCostCenterTemp_<PCODE>','
CREATE TABLE [SNC].[TblChallanMenuItemCostCenterTemp_<PCODE>](
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterTemp_<PCODE>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](3) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterTemp_<PCODE>_DayId]  DEFAULT (space((1))),
	
	[ProformaInvoiceId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterTemp_<PCODE>_ProformaInvoiceId]  DEFAULT (space((1))),
	
	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterTemp_<PCODE>_BanquetItemId]  DEFAULT (space((1))),
	[MenuHeadId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterTemp_<PCODE>_MenuHeadId]  DEFAULT (space((1))),
	[MenuItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterTemp_<PCODE>_MenuItemId]  DEFAULT (space((1))),
	[CostCenter] [varchar](10) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterTemp_<PCODE>_CostCenter]  DEFAULT (space((1))),	
	[MenuHeadType] [varchar](10) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterTemp_<PCODE>_MenuHeadType]  DEFAULT (space((1))),	
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterTemp_<PCODE>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterTemp_<PCODE>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterTemp_<PCODE>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterTemp_<PCODE>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterTemp_<PCODE>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterTemp_<PCODE>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterTemp_<PCODE>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterTemp_<PCODE>_ClientID]  DEFAULT (space(1)),
	[Guid] [nvarchar] (max) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterTemp_<PCODE>_Guid] DEFAULT (space(1))	
) ON [PRIMARY]', 1)
end
GO


if not exists(select * from SNC.TblSNCTableStructure where QueryName ='TblMenuItemCostCenterAmd_<PCODE>')
begin
insert into snc.TblSNCTableStructure (QueryName,QueryString,QueryType)values('TblMenuItemCostCenterAmd_<PCODE>','
CREATE TABLE [SNC].[TblMenuItemCostCenterAmd_<PCODE>](
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenterAmd_<PCODE>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](3) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenterAmd_<PCODE>_DayId]  DEFAULT (space((1))),
	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenterAmd_<PCODE>_BanquetItemId]  DEFAULT (space((1))),
	[MenuHeadId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenterAmd_<PCODE>_MenuHeadId]  DEFAULT (space((1))),
	[MenuItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenterAmd_<PCODE>_MenuItemId]  DEFAULT (space((1))),
	[CostCenter] [varchar](10) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenterAmd_<PCODE>_CostCenter]  DEFAULT (space((1))),	
	[MenuHeadType] [varchar](10) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenterAmd_<PCODE>_MenuHeadType]  DEFAULT (space((1))),	
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblMenuItemCostCenterAmd_<PCODE>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenterAmd_<PCODE>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenterAmd_<PCODE>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuItemCostCenterAmd_<PCODE>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenterAmd_<PCODE>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuItemCostCenterAmd_<PCODE>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenterAmd_<PCODE>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenterAmd_<PCODE>_ClientID]  DEFAULT (space(1))
) ON [PRIMARY]', 1)
end
GO

if not exists(select * from SNC.TblSNCTableStructure where QueryName ='TblChallanMenuItemCostCenterAmd_<PCODE>')
begin
insert into snc.TblSNCTableStructure (QueryName,QueryString,QueryType)values('TblChallanMenuItemCostCenterAmd_<PCODE>','
CREATE TABLE [SNC].[TblChallanMenuItemCostCenterAmd_<PCODE>](
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterAmd_<PCODE>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](3) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterAmd_<PCODE>_DayId]  DEFAULT (space((1))),
	
	[ProformaInvoiceId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterAmd_<PCODE>_ProformaInvoiceId]  DEFAULT (space((1))),
	
	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterAmd_<PCODE>_BanquetItemId]  DEFAULT (space((1))),
	[MenuHeadId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterAmd_<PCODE>_MenuHeadId]  DEFAULT (space((1))),
	[MenuItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterAmd_<PCODE>_MenuItemId]  DEFAULT (space((1))),
	[CostCenter] [varchar](10) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterAmd_<PCODE>_CostCenter]  DEFAULT (space((1))),	
	[MenuHeadType] [varchar](10) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterAmd_<PCODE>_MenuHeadType]  DEFAULT (space((1))),	
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterAmd_<PCODE>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterAmd_<PCODE>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterAmd_<PCODE>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterAmd_<PCODE>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterAmd_<PCODE>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterAmd_<PCODE>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterAmd_<PCODE>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterAmd_<PCODE>_ClientID]  DEFAULT (space(1))
) ON [PRIMARY]', 1)
end
GO



--===============================================

DECLARE @propertycode varchar(5),
        @str varchar(500),
        @QueryString VARCHAR(MAX),
        @QueryString1 VARCHAR(MAX),
        @QueryString2 VARCHAR(MAX),
		@ExcQuery VARCHAR(MAX)=''
  
SET @QueryString ='
IF NOT EXISTS (SELECT * FROM Sysobjects WHERE xtype=''U'' AND [name]=N''TblMenuBanquetItem_<POSCode>'')
BEGIN
  CREATE TABLE [SNC].[TblMenuBanquetItem_<POSCode>](
	[ReservationId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<POSCode>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<POSCode>_DayId]  DEFAULT (space((1))),	
	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<POSCode>_BanquetItemId]  DEFAULT (space((1))),
	[GuarantedPax] [int] NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<POSCode>_GuaranteedPax]  DEFAULT ((0)),
	[ActualPax] [int] NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<POSCode>_ActualPax]  DEFAULT ((0)),
	[PercentPremiumCharge] [int] NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<POSCode>_PercentPremiumCharge]  DEFAULT ((0)),
	[AmountPremiumCharge] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<POSCode>_AmountPremiumCharge]  DEFAULT ((0)),
	[PerPaxRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<POSCode>_PerPaxRate]  DEFAULT ((0)),
	[CalculatedPaxRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<POSCode>_CalculatedPaxRate]  DEFAULT ((0)),
	[PremiumRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<POSCode>_PremiumRate]  DEFAULT ((0)),
	[CalculatedRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<POSCode>_CalculatedRate]  DEFAULT ((0)),
	[BanquetItemPriceId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<POSCode>_BanquetItemPriceId]  DEFAULT (space((1))),
	[KitchenTime] [varchar](30) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<POSCode>_KitchenTime]  DEFAULT (space((1))),
	[ServeTime] [varchar](30) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<POSCode>_ServeTime]  DEFAULT (space((1))),	
	[CostPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<POSCode>_CostPrice]  DEFAULT ((0)),
	[CalculatedPremium] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<POSCode>_CalculatedPremium]  DEFAULT ((0)),
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<POSCode>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<POSCode>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<POSCode>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<POSCode>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<POSCode>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<POSCode>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<POSCode>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuBanquetItem_<POSCode>_ClientID]  DEFAULT (space(1))	
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

--====

DECLARE @propertycode varchar(5),
        @str varchar(500),
        @QueryString VARCHAR(MAX),
        @QueryString1 VARCHAR(MAX),
        @QueryString2 VARCHAR(MAX),
		@ExcQuery VARCHAR(MAX)=''
  
SET @QueryString ='
IF NOT EXISTS (SELECT * FROM Sysobjects WHERE xtype=''U'' AND [name]=N''TblChallanMenuBanquetItem_<POSCode>'')
BEGIN
   CREATE TABLE [SNC].[TblChallanMenuBanquetItem_<POSCode>](
	[ReservationId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<POSCode>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<POSCode>_DayId]  DEFAULT (space((1))),
	
	[ProformaInvoiceId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<POSCode>_ProformaInvoiceId]  DEFAULT (space((1))),
	
	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<POSCode>_BanquetItemId]  DEFAULT (space((1))),
	[GuarantedPax] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<POSCode>_GuaranteedPax]  DEFAULT ((0)),
	[ActualPax] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<POSCode>_ActualPax]  DEFAULT ((0)),
	[PercentPremiumCharge] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<POSCode>_PercentPremiumCharge]  DEFAULT ((0)),
	[AmountPremiumCharge] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<POSCode>_AmountPremiumCharge]  DEFAULT ((0)),
	[PerPaxRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<POSCode>_PerPaxRate]  DEFAULT ((0)),
	[CalculatedPaxRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<POSCode>_CalculatedPaxRate]  DEFAULT ((0)),
	[PremiumRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<POSCode>_PremiumRate]  DEFAULT ((0)),
	[CalculatedRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<POSCode>_CalculatedRate]  DEFAULT ((0)),
	[BanquetItemPriceId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<POSCode>_BanquetItemPriceId]  DEFAULT (space((1))),
	[KitchenTime] [varchar](30) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<POSCode>_KitchenTime]  DEFAULT (space((1))),
	[ServeTime] [varchar](30) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<POSCode>_ServeTime]  DEFAULT (space((1))),
	
	[Status] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<POSCode>_Status]  DEFAULT (space(1)),
	[TaxAmt] [money] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<POSCode>_TaxAmt]  DEFAULT ((0)),
	[TaxStr] [varchar](5000) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<POSCode>_TaXStr]  DEFAULT (space(1)),
	[Rate] [decimal](38,2) NOT NULL  CONSTRAINT [DF_TblChallanMenuBanquetItem_<POSCode>_Rate]  DEFAULT ((0)),
	[Discount] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<POSCode>_Discount]  DEFAULT ((0)),
	[Qty] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<POSCode>_Quantity]  DEFAULT ((0)),
	
	[CostPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<POSCode>_CostPrice]  DEFAULT ((0)),
	[CalculatedPremium] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<POSCode>_CalculatedPremium]  DEFAULT ((0)),
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<POSCode>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<POSCode>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<POSCode>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<POSCode>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<POSCode>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<POSCode>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<POSCode>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItem_<POSCode>_ClientID]  DEFAULT (space(1))	
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

--====

DECLARE @propertycode varchar(5),
        @str varchar(500),
        @QueryString VARCHAR(MAX),
        @QueryString1 VARCHAR(MAX),
        @QueryString2 VARCHAR(MAX),
		@ExcQuery VARCHAR(MAX)=''
  
SET @QueryString ='
IF NOT EXISTS (SELECT * FROM Sysobjects WHERE xtype=''U'' AND [name]=N''TblChallanMenuBanquetItemTemp_<POSCode>'')
BEGIN
CREATE TABLE [SNC].[TblChallanMenuBanquetItemTemp_<POSCode>](
	[ReservationId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<POSCode>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<POSCode>_DayId]  DEFAULT (space((1))),
	[ProformaInvoiceId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<POSCode>_ProformaInvoiceId]  DEFAULT (space((1))),
	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<POSCode>_BanquetItemId]  DEFAULT (space((1))),
	[GuarantedPax] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<POSCode>_GuaranteedPax]  DEFAULT ((0)),
	[ActualPax] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<POSCode>_ActualPax]  DEFAULT ((0)),
	[PercentPremiumCharge] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<POSCode>_PercentPremiumCharge]  DEFAULT ((0)),
	[AmountPremiumCharge] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<POSCode>_AmountPremiumCharge]  DEFAULT ((0)),
	[PerPaxRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<POSCode>_PerPaxRate]  DEFAULT ((0)),
	[CalculatedPaxRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<POSCode>_CalculatedPaxRate]  DEFAULT ((0)),
	[PremiumRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<POSCode>_PremiumRate]  DEFAULT ((0)),
	[CalculatedRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<POSCode>_CalculatedRate]  DEFAULT ((0)),
	[BanquetItemPriceId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<POSCode>_BanquetItemPriceId]  DEFAULT (space((1))),
	[KitchenTime] [varchar](30) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<POSCode>_KitchenTime]  DEFAULT (space((1))),
	[ServeTime] [varchar](30) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<POSCode>_ServeTime]  DEFAULT (space((1))),
	[Status] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<POSCode>_Status]  DEFAULT (space(1)),
	[TaxAmt] [money] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<POSCode>_TaxAmt]  DEFAULT ((0)),
	[TaxStr] [varchar](5000) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<POSCode>_TaXStr]  DEFAULT (space(1)),
	[Rate] [decimal](38,2) NOT NULL  CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<POSCode>_Rate]  DEFAULT ((0)),
	[Discount] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<POSCode>_Discount]  DEFAULT ((0)),
	[Qty] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<POSCode>_Quantity]  DEFAULT ((0)),
	[CostPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<POSCode>_CostPrice]  DEFAULT ((0)),
	[CalculatedPremium] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<POSCode>_CalculatedPremium]  DEFAULT ((0)),
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<POSCode>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<POSCode>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<POSCode>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<POSCode>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<POSCode>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<POSCode>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<POSCode>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<POSCode>_ClientID]  DEFAULT (space(1)),	
	[Guid] [nvarchar] (max) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemTemp_<POSCode>_Guid] DEFAULT (space(1))
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

--====

DECLARE @propertycode varchar(5),
        @str varchar(500),
        @QueryString VARCHAR(MAX),
        @QueryString1 VARCHAR(MAX),
        @QueryString2 VARCHAR(MAX),
		@ExcQuery VARCHAR(MAX)=''
  
SET @QueryString ='
IF NOT EXISTS (SELECT * FROM Sysobjects WHERE xtype=''U'' AND [name]=N''TblMenuBanquetItemAmd_<POSCode>'')
BEGIN
CREATE TABLE [SNC].[TblMenuBanquetItemAmd_<POSCode>](
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<POSCode>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](3) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<POSCode>_DayId]  DEFAULT (space((1))),	
	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<POSCode>_BanquetItemId]  DEFAULT (space((1))),
	[GuarantedPax] [int] NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<POSCode>_GuaranteedPax]  DEFAULT ((0)),
	[ActualPax] [int] NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<POSCode>_ActualPax]  DEFAULT ((0)),
	[PercentPremiumCharge] [int] NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<POSCode>_PercentPremiumCharge]  DEFAULT ((0)),
	[AmountPremiumCharge] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<POSCode>_AmountPremiumCharge]  DEFAULT ((0)),
	[PerPaxRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<POSCode>_PerPaxRate]  DEFAULT ((0)),
	[CalculatedPaxRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<POSCode>_CalculatedPaxRate]  DEFAULT ((0)),
	[PremiumRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<POSCode>_PremiumRate]  DEFAULT ((0)),
	[CalculatedRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<POSCode>_CalculatedRate]  DEFAULT ((0)),
	[BanquetItemPriceId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<POSCode>_BanquetItemPriceId]  DEFAULT (space((1))),
	[KitchenTime] [varchar](30) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<POSCode>_KitchenTime]  DEFAULT (space((1))),
	[ServeTime] [varchar](30) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<POSCode>_ServeTime]  DEFAULT (space((1))),
	[CostPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<POSCode>_CostPrice]  DEFAULT ((0)),
	[CalculatedPremium] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<POSCode>_CalculatedPremium]  DEFAULT ((0)),
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<POSCode>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<POSCode>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<POSCode>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<POSCode>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<POSCode>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<POSCode>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<POSCode>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuBanquetItemAmd_<POSCode>_ClientID]  DEFAULT (space(1))	
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

--====

DECLARE @propertycode varchar(5),
        @str varchar(500),
        @QueryString VARCHAR(MAX),
        @QueryString1 VARCHAR(MAX),
        @QueryString2 VARCHAR(MAX),
		@ExcQuery VARCHAR(MAX)=''
  
SET @QueryString ='
IF NOT EXISTS (SELECT * FROM Sysobjects WHERE xtype=''U'' AND [name]=N''TblChallanMenuBanquetItemAmd_<POSCode>'')
BEGIN
CREATE TABLE [SNC].[TblChallanMenuBanquetItemAmd_<POSCode>](
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<POSCode>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](3) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<POSCode>_DayId]  DEFAULT (space((1))),
	[ProformaInvoiceId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<POSCode>_ProformaInvoiceId]  DEFAULT (space((1))),
	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<POSCode>_BanquetItemId]  DEFAULT (space((1))),
	[GuarantedPax] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<POSCode>_GuaranteedPax]  DEFAULT ((0)),
	[ActualPax] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<POSCode>_ActualPax]  DEFAULT ((0)),
	[PercentPremiumCharge] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<POSCode>_PercentPremiumCharge]  DEFAULT ((0)),
	[AmountPremiumCharge] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<POSCode>_AmountPremiumCharge]  DEFAULT ((0)),
	[PerPaxRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<POSCode>_PerPaxRate]  DEFAULT ((0)),
	[CalculatedPaxRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<POSCode>_CalculatedPaxRate]  DEFAULT ((0)),
	[PremiumRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<POSCode>_PremiumRate]  DEFAULT ((0)),
	[CalculatedRate] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<POSCode>_CalculatedRate]  DEFAULT ((0)),
	[BanquetItemPriceId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<POSCode>_BanquetItemPriceId]  DEFAULT (space((1))),
	[KitchenTime] [varchar](30) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<POSCode>_KitchenTime]  DEFAULT (space((1))),
	[ServeTime] [varchar](30) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<POSCode>_ServeTime]  DEFAULT (space((1))),
	[Status] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<POSCode>_Status]  DEFAULT (space(1)),
	[TaxAmt] [money] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<POSCode>_TaxAmt]  DEFAULT ((0)),
	[TaxStr] [varchar](5000) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<POSCode>_TaXStr]  DEFAULT (space(1)),
	[Rate] [decimal](38,2) NOT NULL  CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<POSCode>_Rate]  DEFAULT ((0)),
	[Discount] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<POSCode>_Discount]  DEFAULT ((0)),
	[Qty] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<POSCode>_Quantity]  DEFAULT ((0)),
	[CostPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<POSCode>_CostPrice]  DEFAULT ((0)),
	[CalculatedPremium] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<POSCode>_CalculatedPremium]  DEFAULT ((0)),
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<POSCode>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<POSCode>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<POSCode>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<POSCode>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<POSCode>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<POSCode>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<POSCode>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuBanquetItemAmd_<POSCode>_ClientID]  DEFAULT (space(1))	
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

--====

DECLARE @propertycode varchar(5),
        @str varchar(500),
        @QueryString VARCHAR(MAX),
        @QueryString1 VARCHAR(MAX),
        @QueryString2 VARCHAR(MAX),
		@ExcQuery VARCHAR(MAX)=''
  
SET @QueryString ='
IF NOT EXISTS (SELECT * FROM Sysobjects WHERE xtype=''U'' AND [name]=N''TblMenuItem_<POSCode>'')
BEGIN
CREATE TABLE [SNC].[TblMenuItem_<POSCode>](
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItem_<POSCode>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](3) NOT NULL CONSTRAINT [DF_TblMenuItem_<POSCode>_DayId]  DEFAULT (space((1))),
	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItem_<POSCode>_BanquetItemId]  DEFAULT (space((1))),
	[MenuHeadCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItem_<POSCode>_MenuHeadCode]  DEFAULT (space((1))),
	[MenuItemCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItem_<POSCode>_MenuItemCode]  DEFAULT (space((1))),
	[IsTDHCost] [bit] NOT NULL CONSTRAINT [DF_TblMenuItem_<POSCode>_IsTDHCost]  DEFAULT ((0)),
	[Quantity] [decimal](38, 3) NOT NULL CONSTRAINT [DF_TblMenuItem_<POSCode>_Quantity]  DEFAULT ((0)),
	[CostPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuItem_<POSCode>_CostPrice]  DEFAULT ((0)),
	[PerSalesPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuItem_<POSCode>_PerSalesPrice]  DEFAULT ((0)),
	[CalculatedPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuItem_<POSCode>_CalculatedPrice]  DEFAULT ((0)),
	[IsModifier] [bit] NOT NULL CONSTRAINT [DF_TblMenuItem_<POSCode>_IsModifier]  DEFAULT ((0)),
	[MenuItemRateCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItem_<POSCode>_MenuItemRateCode]  DEFAULT (space((1))),	
	[IsFreeFlow] [bit] NOT NULL CONSTRAINT [DF_TblMenuItem_<POSCode>_IsFreeFlow]  DEFAULT ((0)),
	[MenuHeadType] [varchar](10) NOT NULL CONSTRAINT [DF_TblMenuItem_<POSCode>_MenuHeadType]  DEFAULT (space((1))),
	[Chargeble] [varchar](5) NOT NULL CONSTRAINT [DF_TblMenuItem_<POSCode>_Chargeble]  DEFAULT (space(1)),
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblMenuItem_<POSCode>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblMenuItem_<POSCode>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuItem_<POSCode>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuItem_<POSCode>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuItem_<POSCode>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuItem_<POSCode>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuItem_<POSCode>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuItem_<POSCode>_ClientID]  DEFAULT (space(1))	
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

--====

DECLARE @propertycode varchar(5),
        @str varchar(500),
        @QueryString VARCHAR(MAX),
        @QueryString1 VARCHAR(MAX),
        @QueryString2 VARCHAR(MAX),
		@ExcQuery VARCHAR(MAX)=''
  
SET @QueryString ='
IF NOT EXISTS (SELECT * FROM Sysobjects WHERE xtype=''U'' AND [name]=N''TblChallanMenuItem_<POSCode>'')
BEGIN
CREATE TABLE [SNC].[TblChallanMenuItem_<POSCode>](
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<POSCode>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](3) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<POSCode>_DayId]  DEFAULT (space((1))),
	
	[ProformaInvoiceId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<POSCode>_ProformaInvoiceId]  DEFAULT (space((1))),

	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<POSCode>_BanquetItemId]  DEFAULT (space((1))),
	[MenuHeadCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<POSCode>_MenuHeadCode]  DEFAULT (space((1))),
	[MenuItemCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<POSCode>_MenuItemCode]  DEFAULT (space((1))),
	[IsTDHCost] [bit] NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<POSCode>_IsTDHCost]  DEFAULT ((0)),
	[Quantity] [decimal](38, 3) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<POSCode>_Quantity]  DEFAULT ((0)),
	[CostPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<POSCode>_CostPrice]  DEFAULT ((0)),
	[PerSalesPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<POSCode>_PerSalesPrice]  DEFAULT ((0)),
	[CalculatedPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<POSCode>_CalculatedPrice]  DEFAULT ((0)),
	[IsModifier] [bit] NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<POSCode>_IsModifier]  DEFAULT ((0)),
	[MenuItemRateCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<POSCode>_MenuItemRateCode]  DEFAULT (space((1))),	
	[IsFreeFlow] [bit] NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<POSCode>_IsFreeFlow]  DEFAULT ((0)),
	[MenuHeadType] [varchar](10) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<POSCode>_MenuHeadType]  DEFAULT (space((1))),
	[Chargeble] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<POSCode>_Chargeble]  DEFAULT (space(1)),
	
	[Status] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<POSCode>_Status]  DEFAULT (space(1)),
	[TaxAmt] [money] NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<POSCode>_TaxAmt]  DEFAULT ((0)),
	[TaxStr] [varchar](5000) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<POSCode>_TaXStr]  DEFAULT (space(1)),
	[Rate] [decimal](38,2) NOT NULL  CONSTRAINT [DF_TblChallanMenuItem_<POSCode>_Rate]  DEFAULT ((0)),
	[Discount] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<POSCode>_Discount]  DEFAULT ((0)),
	[Qty] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<POSCode>_Qty]  DEFAULT ((0)),

	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<POSCode>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<POSCode>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<POSCode>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<POSCode>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<POSCode>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<POSCode>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<POSCode>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuItem_<POSCode>_ClientID]  DEFAULT (space(1))	
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

--====

DECLARE @propertycode varchar(5),
        @str varchar(500),
        @QueryString VARCHAR(MAX),
        @QueryString1 VARCHAR(MAX),
        @QueryString2 VARCHAR(MAX),
		@ExcQuery VARCHAR(MAX)=''
  
SET @QueryString ='
IF NOT EXISTS (SELECT * FROM Sysobjects WHERE xtype=''U'' AND [name]=N''TblChallanMenuItemTemp_<POSCode>'')
BEGIN
CREATE TABLE [SNC].[TblChallanMenuItemTemp_<POSCode>](
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<POSCode>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](3) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<POSCode>_DayId]  DEFAULT (space((1))),
	
	[ProformaInvoiceId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<POSCode>_ProformaInvoiceId]  DEFAULT (space((1))),

	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<POSCode>_BanquetItemId]  DEFAULT (space((1))),
	[MenuHeadCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<POSCode>_MenuHeadCode]  DEFAULT (space((1))),
	[MenuItemCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<POSCode>_MenuItemCode]  DEFAULT (space((1))),
	[IsTDHCost] [bit] NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<POSCode>_IsTDHCost]  DEFAULT ((0)),
	[Quantity] [decimal](38, 3) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<POSCode>_Quantity]  DEFAULT ((0)),
	[CostPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<POSCode>_CostPrice]  DEFAULT ((0)),
	[PerSalesPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<POSCode>_PerSalesPrice]  DEFAULT ((0)),
	[CalculatedPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<POSCode>_CalculatedPrice]  DEFAULT ((0)),
	[IsModifier] [bit] NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<POSCode>_IsModifier]  DEFAULT ((0)),
	[MenuItemRateCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<POSCode>_MenuItemRateCode]  DEFAULT (space((1))),	
	[IsFreeFlow] [bit] NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<POSCode>_IsFreeFlow]  DEFAULT ((0)),
	[MenuHeadType] [varchar](10) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<POSCode>_MenuHeadType]  DEFAULT (space((1))),
	[Chargeble] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<POSCode>_Chargeble]  DEFAULT (space(1)),
	
	[Status] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<POSCode>_Status]  DEFAULT (space(1)),
	[TaxAmt] [money] NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<POSCode>_TaxAmt]  DEFAULT ((0)),
	[TaxStr] [varchar](5000) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<POSCode>_TaXStr]  DEFAULT (space(1)),
	[Rate] [decimal](38,2) NOT NULL  CONSTRAINT [DF_TblChallanMenuItemTemp_<POSCode>_Rate]  DEFAULT ((0)),
	[Discount] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<POSCode>_Discount]  DEFAULT ((0)),
	[Qty] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<POSCode>_Qty]  DEFAULT ((0)),

	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<POSCode>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<POSCode>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<POSCode>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<POSCode>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<POSCode>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<POSCode>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<POSCode>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<POSCode>_ClientID]  DEFAULT (space(1)),
	[Guid] [nvarchar] (max) NOT NULL CONSTRAINT [DF_TblChallanMenuItemTemp_<POSCode>_Guid] DEFAULT (space(1))	
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

--====

DECLARE @propertycode varchar(5),
        @str varchar(500),
        @QueryString VARCHAR(MAX),
        @QueryString1 VARCHAR(MAX),
        @QueryString2 VARCHAR(MAX),
		@ExcQuery VARCHAR(MAX)=''
  
SET @QueryString ='
IF NOT EXISTS (SELECT * FROM Sysobjects WHERE xtype=''U'' AND [name]=N''TblMenuItemAmd_<POSCode>'')
BEGIN
CREATE TABLE [SNC].[TblMenuItemAmd_<POSCode>](
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<POSCode>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](3) NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<POSCode>_DayId]  DEFAULT (space((1))),
	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<POSCode>_BanquetItemId]  DEFAULT (space((1))),
	[MenuHeadCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<POSCode>_MenuHeadCode]  DEFAULT (space((1))),
	[MenuItemCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<POSCode>_MenuItemCode]  DEFAULT (space((1))),
	[IsTDHCost] [bit] NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<POSCode>_IsTDHCost]  DEFAULT ((0)),
	[Quantity] [decimal](38, 3) NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<POSCode>_Quantity]  DEFAULT ((0)),
	[CostPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<POSCode>_CostPrice]  DEFAULT ((0)),
	[PerSalesPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<POSCode>_PerSalesPrice]  DEFAULT ((0)),
	[CalculatedPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<POSCode>_CalculatedPrice]  DEFAULT ((0)),
	[IsModifier] [bit] NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<POSCode>_IsModifier]  DEFAULT ((0)),
	[MenuItemRateCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<POSCode>_MenuItemRateCode]  DEFAULT (space((1))),	
	[IsFreeFlow] [bit] NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<POSCode>_IsFreeFlow]  DEFAULT ((0)),
	[MenuHeadType] [varchar](10) NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<POSCode>_MenuHeadType]  DEFAULT (space((1))),
	[Chargeble] [varchar](5) NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<POSCode>_Chargeble]  DEFAULT (space(1)),
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<POSCode>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<POSCode>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<POSCode>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<POSCode>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<POSCode>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<POSCode>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<POSCode>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuItemAmd_<POSCode>_ClientID]  DEFAULT (space(1))	
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

--====

DECLARE @propertycode varchar(5),
        @str varchar(500),
        @QueryString VARCHAR(MAX),
        @QueryString1 VARCHAR(MAX),
        @QueryString2 VARCHAR(MAX),
		@ExcQuery VARCHAR(MAX)=''
  
SET @QueryString ='
IF NOT EXISTS (SELECT * FROM Sysobjects WHERE xtype=''U'' AND [name]=N''TblChallanMenuItemAmd_<POSCode>'')
BEGIN
CREATE TABLE [SNC].[TblChallanMenuItemAmd_<POSCode>](
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<POSCode>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](3) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<POSCode>_DayId]  DEFAULT (space((1))),
	
	[ProformaInvoiceId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<POSCode>_ProformaInvoiceId]  DEFAULT (space((1))),

	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<POSCode>_BanquetItemId]  DEFAULT (space((1))),
	[MenuHeadCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<POSCode>_MenuHeadCode]  DEFAULT (space((1))),
	[MenuItemCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<POSCode>_MenuItemCode]  DEFAULT (space((1))),
	[IsTDHCost] [bit] NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<POSCode>_IsTDHCost]  DEFAULT ((0)),
	[Quantity] [decimal](38, 3) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<POSCode>_Quantity]  DEFAULT ((0)),
	[CostPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<POSCode>_CostPrice]  DEFAULT ((0)),
	[PerSalesPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<POSCode>_PerSalesPrice]  DEFAULT ((0)),
	[CalculatedPrice] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<POSCode>_CalculatedPrice]  DEFAULT ((0)),
	[IsModifier] [bit] NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<POSCode>_IsModifier]  DEFAULT ((0)),
	[MenuItemRateCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<POSCode>_MenuItemRateCode]  DEFAULT (space((1))),	
	[IsFreeFlow] [bit] NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<POSCode>_IsFreeFlow]  DEFAULT ((0)),
	[MenuHeadType] [varchar](10) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<POSCode>_MenuHeadType]  DEFAULT (space((1))),
	[Chargeble] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<POSCode>_Chargeble]  DEFAULT (space(1)),
	
	[Status] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<POSCode>_Status]  DEFAULT (space(1)),
	[TaxAmt] [money] NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<POSCode>_TaxAmt]  DEFAULT ((0)),
	[TaxStr] [varchar](5000) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<POSCode>_TaXStr]  DEFAULT (space(1)),
	[Rate] [decimal](38,2) NOT NULL  CONSTRAINT [DF_TblChallanMenuItemAmd_<POSCode>_Rate]  DEFAULT ((0)),
	[Discount] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<POSCode>_Discount]  DEFAULT ((0)),
	[Qty] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<POSCode>_Qty]  DEFAULT ((0)),

	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<POSCode>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<POSCode>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<POSCode>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<POSCode>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<POSCode>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<POSCode>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<POSCode>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemAmd_<POSCode>_ClientID]  DEFAULT (space(1))	
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

--====

DECLARE @propertycode varchar(5),
        @str varchar(500),
        @QueryString VARCHAR(MAX),
        @QueryString1 VARCHAR(MAX),
        @QueryString2 VARCHAR(MAX),
		@ExcQuery VARCHAR(MAX)=''
  
SET @QueryString ='
IF NOT EXISTS (SELECT * FROM Sysobjects WHERE xtype=''U'' AND [name]=N''TblMenuModifier_<POSCode>'')
BEGIN
CREATE TABLE [SNC].[TblMenuModifier_<POSCode>](
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuModifier_<POSCode>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](3) NOT NULL CONSTRAINT [DF_TblMenuModifier_<POSCode>_DayId]  DEFAULT (space((1))),
	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuModifier_<POSCode>_BanquetItemId]  DEFAULT (space((1))),
	[MenuHeadCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuModifier_<POSCode>_MenuHeadCode]  DEFAULT (space((1))),
	[MenuItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuModifier_<POSCode>_MenuItemId]  DEFAULT (space((1))),
	[ModifierId] [int] IDENTITY(1,1) NOT NULL,
	[ModifierDescription] [varchar](500) NULL CONSTRAINT [DF_TblMenuModifier_<POSCode>_ModifierDescription]  DEFAULT (space((1))),
	[ModifierRate] [decimal] (38,2) NOT NULL CONSTRAINT [DF_TblMenuModifier_<POSCode>_ModifierRate]  DEFAULT ((0)),	
	[IsFreeFlow] [bit] NOT NULL CONSTRAINT [DF_TblMenuModifier_<POSCode>_IsFreeFlow]  DEFAULT ((0)),
	[MenuHeadType] [varchar](10) NOT NULL CONSTRAINT [DF_TblMenuModifier_<POSCode>_MenuHeadType]  DEFAULT (space((1))),	
	[ModifierCost] [decimal] (38,2) NOT NULL CONSTRAINT [DF_TblMenuModifier_<POSCode>_ModifierCost] DEFAULT ((0)),
	[Quantity] [nvarchar](50) NOT NULL CONSTRAINT [DF_TblMenuModifier_<POSCode>_Quantity] DEFAULT ((0)),
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblMenuModifier_<POSCode>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblMenuModifier_<POSCode>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuModifier_<POSCode>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuModifier_<POSCode>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuModifier_<POSCode>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuModifier_<POSCode>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuModifier_<POSCode>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuModifier_<POSCode>_ClientID]  DEFAULT (space(1))	
 CONSTRAINT [PK_TblMenuModifier_<POSCode>] PRIMARY KEY CLUSTERED 
(
	[ModifierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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

--====

DECLARE @propertycode varchar(5),
        @str varchar(500),
        @QueryString VARCHAR(MAX),
        @QueryString1 VARCHAR(MAX),
        @QueryString2 VARCHAR(MAX),
		@ExcQuery VARCHAR(MAX)=''
  
SET @QueryString ='
IF NOT EXISTS (SELECT * FROM Sysobjects WHERE xtype=''U'' AND [name]=N''TblChallanMenuModifier_<POSCode>'')
BEGIN
CREATE TABLE [SNC].[TblChallanMenuModifier_<POSCode>](
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<POSCode>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](3) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<POSCode>_DayId]  DEFAULT (space((1))),
	
	[ProformaInvoiceId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<POSCode>_ProformaInvoiceId]  DEFAULT (space((1))),
	
	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<POSCode>_BanquetItemId]  DEFAULT (space((1))),
	[MenuHeadCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<POSCode>_MenuHeadCode]  DEFAULT (space((1))),
	[MenuItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<POSCode>_MenuItemId]  DEFAULT (space((1))),
	[ModifierId] [int] IDENTITY(1,1) NOT NULL,
	[ModifierDescription] [varchar](500) NULL CONSTRAINT [DF_TblChallanMenuModifier_<POSCode>_ModifierDescription]  DEFAULT (space((1))),
	[ModifierRate] [decimal] (38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<POSCode>_ModifierRate]  DEFAULT ((0)),	
	[IsFreeFlow] [bit] NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<POSCode>_IsFreeFlow]  DEFAULT ((0)),
	[MenuHeadType] [varchar](10) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<POSCode>_MenuHeadType]  DEFAULT (space((1))),	
	[ModifierCost] [decimal] (38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<POSCode>_ModifierCost] DEFAULT ((0)),
	[Quantity] [nvarchar](50) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<POSCode>_Quantity] DEFAULT ((0)),

	[Status] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<POSCode>_Status]  DEFAULT (space(1)),
	[TaxAmt] [money] NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<POSCode>_TaxAmt]  DEFAULT ((0)),
	[TaxStr] [varchar](5000) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<POSCode>_TaXStr]  DEFAULT (space(1)),
	[Rate] [decimal](38,2) NOT NULL  CONSTRAINT [DF_TblChallanMenuModifier_<POSCode>_Rate]  DEFAULT ((0)),
	[Discount] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<POSCode>_Discount]  DEFAULT ((0)),
	[Qty] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<POSCode>_Qty]  DEFAULT ((0)),

	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<POSCode>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<POSCode>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<POSCode>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<POSCode>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<POSCode>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<POSCode>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<POSCode>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuModifier_<POSCode>_ClientID]  DEFAULT (space(1))	
 CONSTRAINT [PK_TblChallanMenuModifier_<POSCode>] PRIMARY KEY CLUSTERED 
(
	[ModifierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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

--====

DECLARE @propertycode varchar(5),
        @str varchar(500),
        @QueryString VARCHAR(MAX),
        @QueryString1 VARCHAR(MAX),
        @QueryString2 VARCHAR(MAX),
		@ExcQuery VARCHAR(MAX)=''
  
SET @QueryString ='
IF NOT EXISTS (SELECT * FROM Sysobjects WHERE xtype=''U'' AND [name]=N''TblChallanMenuModifierTemp_<POSCode>'')
BEGIN
CREATE TABLE [SNC].[TblChallanMenuModifierTemp_<POSCode>](
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<POSCode>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](3) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<POSCode>_DayId]  DEFAULT (space((1))),
	
	[ProformaInvoiceId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<POSCode>_ProformaInvoiceId]  DEFAULT (space((1))),
	
	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<POSCode>_BanquetItemId]  DEFAULT (space((1))),
	[MenuHeadCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<POSCode>_MenuHeadCode]  DEFAULT (space((1))),
	[MenuItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<POSCode>_MenuItemId]  DEFAULT (space((1))),
	[ModifierId] [int] IDENTITY(1,1) NOT NULL,
	[ModifierDescription] [varchar](500) NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<POSCode>_ModifierDescription]  DEFAULT (space((1))),
	[ModifierRate] [decimal] (38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<POSCode>_ModifierRate]  DEFAULT ((0)),	
	[IsFreeFlow] [bit] NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<POSCode>_IsFreeFlow]  DEFAULT ((0)),
	[MenuHeadType] [varchar](10) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<POSCode>_MenuHeadType]  DEFAULT (space((1))),	
	[ModifierCost] [decimal] (38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<POSCode>_ModifierCost] DEFAULT ((0)),
	[Quantity] [nvarchar](50) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<POSCode>_Quantity] DEFAULT ((0)),
	
	[Status] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<POSCode>_Status]  DEFAULT (space(1)),
	[TaxAmt] [money] NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<POSCode>_TaxAmt]  DEFAULT ((0)),
	[TaxStr] [varchar](5000) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<POSCode>_TaXStr]  DEFAULT (space(1)),
	[Rate] [decimal](38,2) NOT NULL  CONSTRAINT [DF_TblChallanMenuModifierTemp_<POSCode>_Rate]  DEFAULT ((0)),
	[Discount] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<POSCode>_Discount]  DEFAULT ((0)),
	[Qty] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<POSCode>_Qty]  DEFAULT ((0)),

	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<POSCode>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<POSCode>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<POSCode>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<POSCode>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<POSCode>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<POSCode>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<POSCode>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<POSCode>_ClientID]  DEFAULT (space(1)),
	[Guid] [nvarchar] (max) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierTemp_<POSCode>_Guid] DEFAULT (space(1))		
 CONSTRAINT [PK_TblChallanMenuModifierTemp_<POSCode>] PRIMARY KEY CLUSTERED 
(
	[ModifierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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

--====

DECLARE @propertycode varchar(5),
        @str varchar(500),
        @QueryString VARCHAR(MAX),
        @QueryString1 VARCHAR(MAX),
        @QueryString2 VARCHAR(MAX),
		@ExcQuery VARCHAR(MAX)=''
  
SET @QueryString ='
IF NOT EXISTS (SELECT * FROM Sysobjects WHERE xtype=''U'' AND [name]=N''TblMenuModifierAmd_<POSCode>'')
BEGIN
CREATE TABLE [SNC].[TblMenuModifierAmd_<POSCode>](
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<POSCode>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](3) NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<POSCode>_DayId]  DEFAULT (space((1))),
	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<POSCode>_BanquetItemId]  DEFAULT (space((1))),
	[MenuHeadCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<POSCode>_MenuHeadCode]  DEFAULT (space((1))),
	[MenuItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<POSCode>_MenuItemId]  DEFAULT (space((1))),
	[ModifierId] [int] NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<POSCode>_ModifierId] DEFAULT ((0)),
	[ModifierDescription] [varchar](500) NULL CONSTRAINT [DF_TblMenuModifierAmd_<POSCode>_ModifierDescription]  DEFAULT (space((1))),
	[ModifierRate] [decimal] (38,2) NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<POSCode>_ModifierRate]  DEFAULT ((0)),	
	[IsFreeFlow] [bit] NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<POSCode>_IsFreeFlow]  DEFAULT ((0)),
	[MenuHeadType] [varchar](10) NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<POSCode>_MenuHeadType]  DEFAULT (space((1))),	
	[ModifierCost] [decimal] (38,2) NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<POSCode>_ModifierCost] DEFAULT ((0)),
	[Quantity] [nvarchar](50) NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<POSCode>_Quantity] DEFAULT ((0)),
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<POSCode>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<POSCode>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<POSCode>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<POSCode>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<POSCode>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<POSCode>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<POSCode>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuModifierAmd_<POSCode>_ClientID]  DEFAULT (space(1))	
)
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

--====

DECLARE @propertycode varchar(5),
        @str varchar(500),
        @QueryString VARCHAR(MAX),
        @QueryString1 VARCHAR(MAX),
        @QueryString2 VARCHAR(MAX),
		@ExcQuery VARCHAR(MAX)=''
  
SET @QueryString ='
IF NOT EXISTS (SELECT * FROM Sysobjects WHERE xtype=''U'' AND [name]=N''TblChallanMenuModifierAmd_<POSCode>'')
BEGIN
CREATE TABLE [SNC].[TblChallanMenuModifierAmd_<POSCode>](
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<POSCode>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](3) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<POSCode>_DayId]  DEFAULT (space((1))),
	
	[ProformaInvoiceId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<POSCode>_ProformaInvoiceId]  DEFAULT (space((1))),
	
	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<POSCode>_BanquetItemId]  DEFAULT (space((1))),
	[MenuHeadCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<POSCode>_MenuHeadCode]  DEFAULT (space((1))),
	[MenuItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<POSCode>_MenuItemId]  DEFAULT (space((1))),
	[ModifierId] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<POSCode>_ModifierId] DEFAULT ((0)),
	[ModifierDescription] [varchar](500) NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<POSCode>_ModifierDescription]  DEFAULT (space((1))),
	[ModifierRate] [decimal] (38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<POSCode>_ModifierRate]  DEFAULT ((0)),	
	[IsFreeFlow] [bit] NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<POSCode>_IsFreeFlow]  DEFAULT ((0)),
	[MenuHeadType] [varchar](10) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<POSCode>_MenuHeadType]  DEFAULT (space((1))),	
	[ModifierCost] [decimal] (38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<POSCode>_ModifierCost] DEFAULT ((0)),
	[Quantity] [nvarchar](50) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<POSCode>_Quantity] DEFAULT ((0)),
	
	[Status] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<POSCode>_Status]  DEFAULT (space(1)),
	[TaxAmt] [money] NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<POSCode>_TaxAmt]  DEFAULT ((0)),
	[TaxStr] [varchar](5000) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<POSCode>_TaXStr]  DEFAULT (space(1)),
	[Rate] [decimal](38,2) NOT NULL  CONSTRAINT [DF_TblChallanMenuModifierAmd_<POSCode>_Rate]  DEFAULT ((0)),
	[Discount] [decimal](38,2) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<POSCode>_Discount]  DEFAULT ((0)),
	[Qty] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<POSCode>_Qty]  DEFAULT ((0)),
	
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<POSCode>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<POSCode>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<POSCode>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<POSCode>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<POSCode>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<POSCode>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<POSCode>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuModifierAmd_<POSCode>_ClientID]  DEFAULT (space(1))	
)
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
 
 --====

DECLARE @propertycode varchar(5),
        @str varchar(500),
        @QueryString VARCHAR(MAX),
        @QueryString1 VARCHAR(MAX),
        @QueryString2 VARCHAR(MAX),
		@ExcQuery VARCHAR(MAX)=''
  
SET @QueryString ='
IF NOT EXISTS (SELECT * FROM Sysobjects WHERE xtype=''U'' AND [name]=N''TblMenuItemCostCenter_<POSCode>'')
BEGIN
CREATE TABLE [SNC].[TblMenuItemCostCenter_<POSCode>](
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenter_<POSCode>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](3) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenter_<POSCode>_DayId]  DEFAULT (space((1))),
	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenter_<POSCode>_BanquetItemId]  DEFAULT (space((1))),
	[MenuHeadId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenter_<POSCode>_MenuHeadId]  DEFAULT (space((1))),
	[MenuItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenter_<POSCode>_MenuItemId]  DEFAULT (space((1))),
	[CostCenter] [varchar](10) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenter_<POSCode>_CostCenter]  DEFAULT (space((1))),	
	[MenuHeadType] [varchar](10) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenter_<POSCode>_MenuHeadType]  DEFAULT (space((1))),	
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblMenuItemCostCenter_<POSCode>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenter_<POSCode>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenter_<POSCode>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuItemCostCenter_<POSCode>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenter_<POSCode>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuItemCostCenter_<POSCode>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenter_<POSCode>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenter_<POSCode>_ClientID]  DEFAULT (space(1))
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

--====

DECLARE @propertycode varchar(5),
        @str varchar(500),
        @QueryString VARCHAR(MAX),
        @QueryString1 VARCHAR(MAX),
        @QueryString2 VARCHAR(MAX),
		@ExcQuery VARCHAR(MAX)=''
  
SET @QueryString ='
IF NOT EXISTS (SELECT * FROM Sysobjects WHERE xtype=''U'' AND [name]=N''TblChallanMenuItemCostCenter_<POSCode>'')
BEGIN
CREATE TABLE [SNC].[TblChallanMenuItemCostCenter_<POSCode>](
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenter_<POSCode>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](3) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenter_<POSCode>_DayId]  DEFAULT (space((1))),
	
	[ProformaInvoiceId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenter_<POSCode>_ProformaInvoiceId]  DEFAULT (space((1))),
	
	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenter_<POSCode>_BanquetItemId]  DEFAULT (space((1))),
	[MenuHeadId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenter_<POSCode>_MenuHeadId]  DEFAULT (space((1))),
	[MenuItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenter_<POSCode>_MenuItemId]  DEFAULT (space((1))),
	[CostCenter] [varchar](10) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenter_<POSCode>_CostCenter]  DEFAULT (space((1))),	
	[MenuHeadType] [varchar](10) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenter_<POSCode>_MenuHeadType]  DEFAULT (space((1))),	
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenter_<POSCode>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenter_<POSCode>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenter_<POSCode>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenter_<POSCode>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenter_<POSCode>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenter_<POSCode>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenter_<POSCode>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenter_<POSCode>_ClientID]  DEFAULT (space(1))
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

--====

DECLARE @propertycode varchar(5),
        @str varchar(500),
        @QueryString VARCHAR(MAX),
        @QueryString1 VARCHAR(MAX),
        @QueryString2 VARCHAR(MAX),
		@ExcQuery VARCHAR(MAX)=''
  
SET @QueryString ='
IF NOT EXISTS (SELECT * FROM Sysobjects WHERE xtype=''U'' AND [name]=N''TblChallanMenuItemCostCenterTemp_<POSCode>'')
BEGIN
CREATE TABLE [SNC].[TblChallanMenuItemCostCenterTemp_<POSCode>](
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterTemp_<POSCode>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](3) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterTemp_<POSCode>_DayId]  DEFAULT (space((1))),
	
	[ProformaInvoiceId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterTemp_<POSCode>_ProformaInvoiceId]  DEFAULT (space((1))),
	
	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterTemp_<POSCode>_BanquetItemId]  DEFAULT (space((1))),
	[MenuHeadId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterTemp_<POSCode>_MenuHeadId]  DEFAULT (space((1))),
	[MenuItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterTemp_<POSCode>_MenuItemId]  DEFAULT (space((1))),
	[CostCenter] [varchar](10) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterTemp_<POSCode>_CostCenter]  DEFAULT (space((1))),	
	[MenuHeadType] [varchar](10) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterTemp_<POSCode>_MenuHeadType]  DEFAULT (space((1))),	
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterTemp_<POSCode>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterTemp_<POSCode>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterTemp_<POSCode>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterTemp_<POSCode>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterTemp_<POSCode>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterTemp_<POSCode>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterTemp_<POSCode>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterTemp_<POSCode>_ClientID]  DEFAULT (space(1)),
	[Guid] [nvarchar] (max) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterTemp_<POSCode>_Guid] DEFAULT (space(1))	
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

--====

DECLARE @propertycode varchar(5),
        @str varchar(500),
        @QueryString VARCHAR(MAX),
        @QueryString1 VARCHAR(MAX),
        @QueryString2 VARCHAR(MAX),
		@ExcQuery VARCHAR(MAX)=''
  
SET @QueryString ='
IF NOT EXISTS (SELECT * FROM Sysobjects WHERE xtype=''U'' AND [name]=N''TblMenuItemCostCenterAmd_<POSCode>'')
BEGIN
CREATE TABLE [SNC].[TblMenuItemCostCenterAmd_<POSCode>](
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenterAmd_<POSCode>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](3) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenterAmd_<POSCode>_DayId]  DEFAULT (space((1))),
	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenterAmd_<POSCode>_BanquetItemId]  DEFAULT (space((1))),
	[MenuHeadId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenterAmd_<POSCode>_MenuHeadId]  DEFAULT (space((1))),
	[MenuItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenterAmd_<POSCode>_MenuItemId]  DEFAULT (space((1))),
	[CostCenter] [varchar](10) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenterAmd_<POSCode>_CostCenter]  DEFAULT (space((1))),	
	[MenuHeadType] [varchar](10) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenterAmd_<POSCode>_MenuHeadType]  DEFAULT (space((1))),	
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblMenuItemCostCenterAmd_<POSCode>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenterAmd_<POSCode>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenterAmd_<POSCode>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuItemCostCenterAmd_<POSCode>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenterAmd_<POSCode>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblMenuItemCostCenterAmd_<POSCode>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenterAmd_<POSCode>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblMenuItemCostCenterAmd_<POSCode>_ClientID]  DEFAULT (space(1))
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

--====

DECLARE @propertycode varchar(5),
        @str varchar(500),
        @QueryString VARCHAR(MAX),
        @QueryString1 VARCHAR(MAX),
        @QueryString2 VARCHAR(MAX),
		@ExcQuery VARCHAR(MAX)=''
  
SET @QueryString ='
IF NOT EXISTS (SELECT * FROM Sysobjects WHERE xtype=''U'' AND [name]=N''TblChallanMenuItemCostCenterAmd_<POSCode>'')
BEGIN
CREATE TABLE [SNC].[TblChallanMenuItemCostCenterAmd_<POSCode>](
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterAmd_<POSCode>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](3) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterAmd_<POSCode>_DayId]  DEFAULT (space((1))),
	
	[ProformaInvoiceId] [varchar] (20) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterAmd_<POSCode>_ProformaInvoiceId]  DEFAULT (space((1))),
	
	[BanquetItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterAmd_<POSCode>_BanquetItemId]  DEFAULT (space((1))),
	[MenuHeadId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterAmd_<POSCode>_MenuHeadId]  DEFAULT (space((1))),
	[MenuItemId] [varchar](24) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterAmd_<POSCode>_MenuItemId]  DEFAULT (space((1))),
	[CostCenter] [varchar](10) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterAmd_<POSCode>_CostCenter]  DEFAULT (space((1))),	
	[MenuHeadType] [varchar](10) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterAmd_<POSCode>_MenuHeadType]  DEFAULT (space((1))),	
	[AmdCode] [int] NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterAmd_<POSCode>_AmdCode] DEFAULT (0),	
	[UpdatedFrom] [varchar](5) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterAmd_<POSCode>_UpdatedFrom]  DEFAULT (space(1)),
	[CreatedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterAmd_<POSCode>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterAmd_<POSCode>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar] (4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterAmd_<POSCode>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterAmd_<POSCode>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterAmd_<POSCode>_GroupID]  DEFAULT (space(1)),
    [ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblChallanMenuItemCostCenterAmd_<POSCode>_ClientID]  DEFAULT (space(1))
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

--====