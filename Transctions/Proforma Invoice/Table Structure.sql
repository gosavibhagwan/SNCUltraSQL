if not exists(select * from SNC.TblSNCTableStructure where QueryName ='TblProformaInvoiceDetails_<PCODE>')
begin
insert into snc.TblSNCTableStructure (QueryName,QueryString,QueryType)values('TblProformaInvoiceDetails_<PCODE>','
CREATE TABLE [SNC].[TblProformaInvoiceDetails_<PCODE>](
	[Code] [int] IDENTITY(1,1) NOT NULL,
	[ProformaInvoiceId] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<PCODE>_ProformaInvoiceId] DEFAULT ((0)),
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<PCODE>_ReservationId]  DEFAULT (space(1)),
	[DayId] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<PCODE>_DayId]  DEFAULT (space(1)),
	[FPNumber] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<PCODE>_FPNumber]  DEFAULT (space(1)),
	[Diplomat] [varchar](5) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<PCODE>_Diplomat]  DEFAULT (space(1)),
	[OverCounter] [varchar](5) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<PCODE>_OverCounter]  DEFAULT (space(1)),
	[PayMode] [varchar](5) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<PCODE>_PayMode]  DEFAULT (space(1)),
	[AdvancePay] [money] NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<PCODE>_AdvancePay]  DEFAULT ((0)),
	[GrantTotal] [money] NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<PCODE>_GrantTotal]  DEFAULT ((0)),
	[Amount] [money] NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<PCODE>_Amount]  DEFAULT ((0)),
	[Pax] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<PCODE>_Pax]  DEFAULT (space(1)),
	[Discount] [money] NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<PCODE>_Discount]  DEFAULT ((0)),
	[TotalTax] [money] NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<PCODE>_TotalTax]  DEFAULT ((0)),
	[TaxType] [varchar](5) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<PCODE>_TaxType]  DEFAULT (space(1)),
	[Done] [varchar](5) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<PCODE>_Done]  DEFAULT (space(1)),	
	[TempId] [varchar](50) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<PCODE>_TempId]  DEFAULT (space(1)),
	[HallHire] [money] NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<PCODE>_HallHire]  DEFAULT ((0)),
	[VenueRental] [money] NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<PCODE>_VenueRental]  DEFAULT ((0)),
	[LiquorLicense] [money] NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<PCODE>_LiquorLicense]  DEFAULT ((0)),
	[AdvanceRecpNo] [varchar](2000) NOT NULL CONSTRAINT [Df_TblProformaInvoiceDetails_<PCODE>_AdvanceRecpNo]  DEFAULT (space((0))),
	[AmdCode] [int] NOT NULL CONSTRAINT [Df_TblProformaInvoiceDetails_<PCODE>_AmdCode]  DEFAULT ((0)),
	[BillNo] [varchar](20) NOT NULL CONSTRAINT [Df_TblProformaInvoiceDetails_<PCODE>_BillNo] DEFAULT (space((1))),
	[AreaCode] [varchar](20) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<PCODE>_AreaCode]  DEFAULT (space((0))),
	[MainPINo] [int] NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<PCODE>_MainPINo] DEFAULT ((0)),
	[IsSplitPI] [char](1) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<PCODE>_IsSplitPI] DEFAULT (''N''),
	[PIToParty] [varchar](50) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<PCODE>_PIToParty]  DEFAULT (space((0))),
	[PIToContact] [varchar](50) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<PCODE>_PIToContact] DEFAULT (space((0))),
	[AccountGSTRegNo] [varchar](20) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<PCODE>_AccountGSTRegNo]  DEFAULT (space(1)),
	[AccountGSTStateCode] [varchar](20) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<PCODE>_AccountGSTStateCode]  DEFAULT (space(1)),
	[AccountGSTStateValue] [varchar](20) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<PCODE>_AccountGSTStateValue]  DEFAULT (space(1)),
	[SEZ] [char](1) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<PCODE>_SEZ]  DEFAULT (''N''),
	[CreatedBy] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<PCODE>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<PCODE>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<PCODE>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<PCODE>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<PCODE>_GroupID]  DEFAULT (space(1)),
	[ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<PCODE>_ClientID]  DEFAULT (space(1))
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
IF NOT EXISTS (SELECT * FROM Sysobjects WHERE xtype=''U'' AND [name]=N''TblProformaInvoiceDetails_<POSCode>'')
BEGIN
  CREATE TABLE [SNC].[TblProformaInvoiceDetails_<POSCode>](
	[Code] [int] IDENTITY(1,1) NOT NULL,
	[ProformaInvoiceId] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<POSCode>_ProformaInvoiceId] DEFAULT ((0)),
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<POSCode>_ReservationId]  DEFAULT (space(1)),
	[DayId] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<POSCode>_DayId]  DEFAULT (space(1)),
	[FPNumber] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<POSCode>_FPNumber]  DEFAULT (space(1)),
	[Diplomat] [varchar](5) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<POSCode>_Diplomat]  DEFAULT (space(1)),
	[OverCounter] [varchar](5) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<POSCode>_OverCounter]  DEFAULT (space(1)),
	[PayMode] [varchar](5) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<POSCode>_PayMode]  DEFAULT (space(1)),
	[AdvancePay] [money] NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<POSCode>_AdvancePay]  DEFAULT ((0)),
	[GrantTotal] [money] NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<POSCode>_GrantTotal]  DEFAULT ((0)),
	[Amount] [money] NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<POSCode>_Amount]  DEFAULT ((0)),
	[Pax] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<POSCode>_Pax]  DEFAULT (space(1)),
	[Discount] [money] NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<POSCode>_Discount]  DEFAULT ((0)),
	[TotalTax] [money] NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<POSCode>_TotalTax]  DEFAULT ((0)),
	[TaxType] [varchar](5) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<POSCode>_TaxType]  DEFAULT (space(1)),
	[Done] [varchar](5) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<POSCode>_Done]  DEFAULT (space(1)),	
	[TempId] [varchar](50) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<POSCode>_TempId]  DEFAULT (space(1)),
	[HallHire] [money] NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<POSCode>_HallHire]  DEFAULT ((0)),
	[VenueRental] [money] NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<POSCode>_VenueRental]  DEFAULT ((0)),
	[LiquorLicense] [money] NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<POSCode>_LiquorLicense]  DEFAULT ((0)),
	[AdvanceRecpNo] [varchar](2000) NOT NULL CONSTRAINT [Df_TblProformaInvoiceDetails_<POSCode>_AdvanceRecpNo]  DEFAULT (space((0))),
	[AmdCode] [int] NOT NULL CONSTRAINT [Df_TblProformaInvoiceDetails_<POSCode>_AmdCode]  DEFAULT ((0)),
	[BillNo] [varchar](20) NOT NULL CONSTRAINT [Df_TblProformaInvoiceDetails_<POSCode>_BillNo] DEFAULT (space((1))),
	[AreaCode] [varchar](20) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<POSCode>_AreaCode]  DEFAULT (space((0))),
	[MainPINo] [int] NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<POSCode>_MainPINo] DEFAULT ((0)),
	[IsSplitPI] [char](1) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<POSCode>_IsSplitPI] DEFAULT (''N''),
	[PIToParty] [varchar](50) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<POSCode>_PIToParty]  DEFAULT (space((0))),
	[PIToContact] [varchar](50) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<POSCode>_PIToContact] DEFAULT (space((0))),
	[AccountGSTRegNo] [varchar](20) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<POSCode>_AccountGSTRegNo]  DEFAULT (space(1)),
	[AccountGSTStateCode] [varchar](20) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<POSCode>_AccountGSTStateCode]  DEFAULT (space(1)),
	[AccountGSTStateValue] [varchar](20) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<POSCode>_AccountGSTStateValue]  DEFAULT (space(1)),
	[SEZ] [char](1) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<POSCode>_SEZ]  DEFAULT (''N''),
	[CreatedBy] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<POSCode>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<POSCode>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<POSCode>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<POSCode>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<POSCode>_GroupID]  DEFAULT (space(1)),
	[ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblProformaInvoiceDetails_<POSCode>_ClientID]  DEFAULT (space(1))
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

if not exists(select * from SNC.TblSNCTableStructure where QueryName ='TblProformaInvoiceTax_<PCODE>')
begin
insert into snc.TblSNCTableStructure (QueryName,QueryString,QueryType)values('TblProformaInvoiceTax_<PCODE>','
CREATE TABLE [SNC].[TblProformaInvoiceTax_<PCODE>](
	[ProformaInvoiceNo] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTax_<PCODE>_ProformaInvoiceNo]  DEFAULT (''),
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTax_<PCODE>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTax_<PCODE>_DayId]  DEFAULT (space((1))),
	[TaxCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTax_<PCODE>_TaxCode]  DEFAULT (''),
	[TaxDesc] [varchar](50) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTax_<PCODE>_TaxDesc]  DEFAULT (''),
	[TaxAmt] [money] NOT NULL CONSTRAINT [DF_TblProformaInvoiceTax_<PCODE>_TaxAmt]  DEFAULT ((0)),
	[OnAmt] [money] NOT NULL CONSTRAINT [DF_TblProformaInvoiceTax_<PCODE>_OnAmt]  DEFAULT ((0)),
	[TotalTaxAmount] [money] NOT NULL CONSTRAINT [DF_TblProformaInvoiceTax_<PCODE>_TotalTaxAmount]  DEFAULT ((0)),
	[Status] [varchar](5)  NOT NULL CONSTRAINT [DF_TblProformaInvoiceTax_<PCODE>_Status]  DEFAULT (''),
	[CreatedBy] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTax_<PCODE>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblProformaInvoiceTax_<PCODE>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTax_<PCODE>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblProformaInvoiceTax_<PCODE>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTax_<PCODE>_GroupID]  DEFAULT (space(1)),
	[ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTax_<PCODE>_ClientID]  DEFAULT (space(1))
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
  IF NOT EXISTS (SELECT * FROM Sysobjects WHERE xtype=''U'' AND [name]=N''TblProformaInvoiceTax_<POSCode>'')
BEGIN
CREATE TABLE [SNC].[TblProformaInvoiceTax_<POSCode>](
	[ProformaInvoiceNo] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTax_<POSCode>_ProformaInvoiceNo]  DEFAULT (''),
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTax_<POSCode>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTax_<POSCode>_DayId]  DEFAULT (space((1))),
	[TaxCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTax_<POSCode>_TaxCode]  DEFAULT (''),
	[TaxDesc] [varchar](50) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTax_<POSCode>_TaxDesc]  DEFAULT (''),
	[TaxAmt] [money] NOT NULL CONSTRAINT [DF_TblProformaInvoiceTax_<POSCode>_TaxAmt]  DEFAULT ((0)),
	[OnAmt] [money] NOT NULL CONSTRAINT [DF_TblProformaInvoiceTax_<POSCode>_OnAmt]  DEFAULT ((0)),
	[TotalTaxAmount] [money] NOT NULL CONSTRAINT [DF_TblProformaInvoiceTax_<POSCode>_TotalTaxAmount]  DEFAULT ((0)),
	[Status] [varchar](5)  NOT NULL CONSTRAINT [DF_TblProformaInvoiceTax_<POSCode>_Status]  DEFAULT (''),
	[CreatedBy] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTax_<POSCode>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblProformaInvoiceTax_<POSCode>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTax_<POSCode>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblProformaInvoiceTax_<POSCode>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTax_<POSCode>_GroupID]  DEFAULT (space(1)),
	[ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTax_<POSCode>_ClientID]  DEFAULT (space(1))
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

if not exists(select * from SNC.TblSNCTableStructure where QueryName ='TblProformaInvoiceTaxDetail_<PCODE>')
begin
insert into snc.TblSNCTableStructure (QueryName,QueryString,QueryType)values('TblProformaInvoiceTaxDetail_<PCODE>','
CREATE TABLE [SNC].[TblProformaInvoiceTaxDetail_<PCODE>](
	[ProformaInvoiceNo] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTaxDetail_<PCODE>_ProformaInvoiceNo]  DEFAULT (space((1))),
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTaxDetail_<PCODE>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTaxDetail_<PCODE>_DayId]  DEFAULT (space((1))),
	[ItemType] [varchar](3) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTaxDetail_<PCODE>_ItemType]  DEFAULT (space((1))),
	[ItemCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTaxDetail_<PCODE>_ItemCode]  DEFAULT (space((1))),
	[TaxCode] [varchar](24) NOT NULL  CONSTRAINT [DF_TblProformaInvoiceTaxDetail_<PCODE>_TaxCode]  DEFAULT (space((1))),
	[TaxDesc] [varchar](50) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTaxDetail_<PCODE>_TaxDesc]  DEFAULT (space((1))),
	[TaxAmt] [money] NOT NULL CONSTRAINT [DF_TblProformaInvoiceTaxDetail_<PCODE>_TaxAmt]  DEFAULT ((0)),
	[OnAmt] [money] NOT NULL CONSTRAINT [DF_TblProformaInvoiceTaxDetail_<PCODE>_OnAmt]  DEFAULT ((0)),	
	[AreaCode] [varchar](20) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTaxDetail_<PCODE>_AreaCode]  DEFAULT (space((0))),
	[CreatedBy] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTaxDetail_<PCODE>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblProformaInvoiceTaxDetail_<PCODE>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTaxDetail_<PCODE>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblProformaInvoiceTaxDetail_<PCODE>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTaxDetail_<PCODE>_GroupID]  DEFAULT (space(1)),
	[ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTaxDetail_<PCODE>_ClientID]  DEFAULT (space(1))
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
IF NOT EXISTS (SELECT * FROM Sysobjects WHERE xtype=''U'' AND [name]=N''TblProformaInvoiceTaxDetail_<POSCode>'')
BEGIN
CREATE TABLE [SNC].[TblProformaInvoiceTaxDetail_<POSCode>](
	[ProformaInvoiceNo] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTaxDetail_<POSCode>_ProformaInvoiceNo]  DEFAULT (space((1))),
	[ReservationId] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTaxDetail_<POSCode>_ReservationId]  DEFAULT (space((1))),
	[DayId] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTaxDetail_<POSCode>_DayId]  DEFAULT (space((1))),
	[ItemType] [varchar](3) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTaxDetail_<POSCode>_ItemType]  DEFAULT (space((1))),
	[ItemCode] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTaxDetail_<POSCode>_ItemCode]  DEFAULT (space((1))),
	[TaxCode] [varchar](24) NOT NULL  CONSTRAINT [DF_TblProformaInvoiceTaxDetail_<POSCode>_TaxCode]  DEFAULT (space((1))),
	[TaxDesc] [varchar](50) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTaxDetail_<POSCode>_TaxDesc]  DEFAULT (space((1))),
	[TaxAmt] [money] NOT NULL CONSTRAINT [DF_TblProformaInvoiceTaxDetail_<POSCode>_TaxAmt]  DEFAULT ((0)),
	[OnAmt] [money] NOT NULL CONSTRAINT [DF_TblProformaInvoiceTaxDetail_<POSCode>_OnAmt]  DEFAULT ((0)),	
	[AreaCode] [varchar](20) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTaxDetail_<POSCode>_AreaCode]  DEFAULT (space((0))),
	[CreatedBy] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTaxDetail_<POSCode>_CreatedBy]  DEFAULT (space(1)),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_TblProformaInvoiceTaxDetail_<POSCode>_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [varchar](24) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTaxDetail_<POSCode>_ModifiedBy]  DEFAULT (space(1)),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TblProformaInvoiceTaxDetail_<POSCode>_ModifiedDate]  DEFAULT (getdate()),
	[GroupID] [varchar](4) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTaxDetail_<POSCode>_GroupID]  DEFAULT (space(1)),
	[ClientID] [varchar](4) NOT NULL CONSTRAINT [DF_TblProformaInvoiceTaxDetail_<POSCode>_ClientID]  DEFAULT (space(1))
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
