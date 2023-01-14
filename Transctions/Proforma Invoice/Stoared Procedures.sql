IF EXISTS(SELECT * FROM sysobjects WHERE type='P' AND name='SprSNCGetProformaInvoicePreReq')        
BEGIN
        DROP PROCEDURE SprSNCGetProformaInvoicePreReq
END
Go
Create Procedure SprSNCGetProformaInvoicePreReq
(
	@POSCode Nvarchar(20),
	@GroupId Nvarchar(20),
	@ClientId Nvarchar(20)
)
AS
BEGIN
	select Ltrim(Rtrim(OverCounterSalesCode)) as OverCounterSalesCode,Ltrim(Rtrim(OverCounterSalesDesc)) as OverCounterSalesDesc From TblOverCounterSales where IsActive=1
	select Ltrim(Rtrim(LocalCode)) as DiplomatCode , Ltrim(Rtrim([Description])) As DiplomatDesc from TblUIGlobalDictionary Where GlobalCode='DPMT'
	select Ltrim(Rtrim(isnull(GSTStatecode,0))) as GSTStatecode ,Ltrim(Rtrim(StateDescription)) as StateDescription  From TblStateMst
	select Ltrim(Rtrim(LocalCode)) as PayMode ,Ltrim(Rtrim([Description])) as PayModeDesc From TblUIGlobalDictionary where GlobalCode='PM'
	Exec('select TaxCode,Description from TblTaxMst where POSCode='''+@POSCode+''' ')
END
Go

IF EXISTS(SELECT * FROM sysobjects WHERE type='P' AND name='SprSNCInitiateAddModifyMenuServicePI')        
BEGIN
        DROP PROCEDURE SprSNCInitiateAddModifyMenuServicePI
END
Go
Create Procedure SprSNCInitiateAddModifyMenuServicePI
(
	@ReservationId varchar(20),
	@DayId varchar(20),
	@Type  Nchar(4),
	@Guid Nvarchar(MAX),
	@POSCode Nvarchar(20),	
	@User varchar(4),
	@GroupId char(3),
	@ClientId char(3)
)
AS
BEGIN
	Declare @StrLocInsertToChallanMenuBanquetItemTemp nvarchar(max)
	Declare @StrLocInsertToChallanMenuItemTemp nvarchar(max)
	Declare @StrLocInsertToChallanMenuModifierTemp nvarchar(max)
	Declare @StrLocInsertToChallanMenuItemCostCenterTemp nvarchar(max)
	Declare @StrLocInsertToTblChallanServicesTemp nvarchar(max)
	
	

	SET @StrLocInsertToChallanMenuBanquetItemTemp=''
	SET @StrLocInsertToChallanMenuItemTemp=''
	SET @StrLocInsertToChallanMenuModifierTemp=''
	SET @StrLocInsertToChallanMenuItemCostCenterTemp =''
	SET @StrLocInsertToTblChallanServicesTemp =''
	

	IF(@Type='M')
	BEGIN
		SET @StrLocInsertToChallanMenuBanquetItemTemp='
		insert into SNC.TblChallanMenuBanquetItemTemp_'+ltrim(rtrim(@POSCode))+' 
		select 
			ReservationId,DayId,'''',BanquetItemId,GuarantedPax,ActualPax,PercentPremiumCharge,AmountPremiumCharge,PerPaxRate
			,CalculatedPaxRate,PremiumRate,CalculatedRate,BanquetItemPriceId,KitchenTime,ServeTime,'''',0,'''',0,0,0
			,CostPrice,CalculatedPremium,AmdCode,UpdatedFrom,CreatedBy,CreatedDate,ModifiedBy,ModifiedDate,GroupID,ClientID,'''+@Guid+'''
		from SNC.TblMenuBanquetItem_'+ltrim(rtrim(@POSCode))+' 
		where  [ReservationId]='+ convert(varchar(20),@ReservationId) +'  and [DayId]='+ Convert(varchar(20),@DayId) +'	
		union all
		select 
			ReservationId,DayId,ProformaInvoiceId,BanquetItemId,GuarantedPax,ActualPax,PercentPremiumCharge,AmountPremiumCharge,PerPaxRate
			,CalculatedPaxRate,PremiumRate,CalculatedRate,BanquetItemPriceId,KitchenTime,ServeTime,[Status],TaxAmt,TaxStr,Rate,Discount,Qty
			,CostPrice,CalculatedPremium,AmdCode,UpdatedFrom,CreatedBy,CreatedDate,ModifiedBy,ModifiedDate,GroupID,ClientID,'''+@Guid+'''
		from SNC.TblChallanMenuBanquetItem_'+ltrim(rtrim(@POSCode))+' 
		where  [ReservationId]='+ convert(varchar(20),@ReservationId) +'  and [DayId]='+ Convert(varchar(20),@DayId) +'	
		'
		SET @StrLocInsertToChallanMenuItemTemp='
		insert into SNC.TblChallanMenuItemTemp_'+ltrim(rtrim(@POSCode))+' 
		select 
			ReservationId,DayId,ProformaInvoiceId,BanquetItemId,MenuHeadCode,MenuItemCode,IsTDHCost,Quantity,CostPrice
			,PerSalesPrice,CalculatedPrice,IsModifier,MenuItemRateCode,IsFreeFlow,MenuHeadType,Chargeble,Status,TaxAmt,TaxStr,Rate,Discount,Qty
			,AmdCode,UpdatedFrom,CreatedBy,CreatedDate,ModifiedBy,ModifiedDate,GroupID,ClientID,'''+@Guid+'''
		from SNC.TblChallanMenuItem_'+ltrim(rtrim(@POSCode))+' 	
		where  [ReservationId]='+ convert(varchar(20),@ReservationId) +'  and [DayId]='+ Convert(varchar(20),@DayId) +'	
		union all
		select 
			ReservationId,DayId,'''',BanquetItemId,MenuHeadCode,MenuItemCode,IsTDHCost,Quantity,CostPrice
			,PerSalesPrice,CalculatedPrice,IsModifier,MenuItemRateCode,IsFreeFlow,MenuHeadType,Chargeble,'''',0,'''',0,0,0
			,AmdCode,UpdatedFrom,CreatedBy,CreatedDate,ModifiedBy,ModifiedDate,GroupID,ClientID,'''+@Guid+'''
		from SNC.TblMenuItem_'+ltrim(rtrim(@POSCode))+'
		where  [ReservationId]='+ convert(varchar(20),@ReservationId) +'  and [DayId]='+ Convert(varchar(20),@DayId) +'	 
		'
		SET @StrLocInsertToChallanMenuModifierTemp='
		insert into SNC.TblChallanMenuModifierTemp_'+ltrim(rtrim(@POSCode))+' 
		select 
			ReservationId,DayId,ProformaInvoiceId,BanquetItemId,MenuHeadCode,MenuItemId,ModifierDescription,ModifierRate,IsFreeFlow
			,MenuHeadType,ModifierCost,Quantity,[Status],TaxAmt,TaxStr,Rate,Discount,Qty,AmdCode,UpdatedFrom,CreatedBy,CreatedDate
			,ModifiedBy,ModifiedDate,GroupID,ClientID,'''+@Guid+'''
		from SNC.TblChallanMenuModifier_'+ltrim(rtrim(@POSCode))+' 
		where  [ReservationId]='+ convert(varchar(20),@ReservationId) +'  and [DayId]='+ Convert(varchar(20),@DayId) +'		
		union all
		select 
			ReservationId,DayId,'''',BanquetItemId,MenuHeadCode,MenuItemId,ModifierDescription,ModifierRate,IsFreeFlow
			,MenuHeadType,ModifierCost,Quantity,'''',0,'''',0,0,0,AmdCode,UpdatedFrom,CreatedBy,CreatedDate
			,ModifiedBy,ModifiedDate,GroupID,ClientID,'''+@Guid+'''
		from SNC.TblMenuModifier_'+ltrim(rtrim(@POSCode))+' 
		where  [ReservationId]='+ convert(varchar(20),@ReservationId) +'  and [DayId]='+ Convert(varchar(20),@DayId) +'	
		'
		SET @StrLocInsertToChallanMenuItemCostCenterTemp ='
		insert into SNC.TblChallanMenuItemCostCenterTemp_'+ltrim(rtrim(@POSCode))+' 
		select 
			ReservationId,DayId,ProformaInvoiceId,BanquetItemId,MenuHeadId,MenuItemId,CostCenter,MenuHeadType,AmdCode
			,UpdatedFrom,CreatedBy,CreatedDate,ModifiedBy,ModifiedDate,GroupID,ClientID,'''+@Guid+'''
		from SNC.TblChallanMenuItemCostCenter_'+ltrim(rtrim(@POSCode))+' 
		where  [ReservationId]='+ convert(varchar(20),@ReservationId) +'  and [DayId]='+ Convert(varchar(20),@DayId) +'		
		union all
		select 
			ReservationId,DayId,'''',BanquetItemId,MenuHeadId,MenuItemId,CostCenter,MenuHeadType,AmdCode
			,UpdatedFrom,CreatedBy,CreatedDate,ModifiedBy,ModifiedDate,GroupID,ClientID,'''+@Guid+'''
		from SNC.TblMenuItemCostCenter_'+ltrim(rtrim(@POSCode))+' 
		where  [ReservationId]='+ convert(varchar(20),@ReservationId) +'  and [DayId]='+ Convert(varchar(20),@DayId) +'	
		'
		
		EXECUTE sp_executesql  @StrLocInsertToChallanMenuBanquetItemTemp
		EXECUTE sp_executesql  @StrLocInsertToChallanMenuItemTemp
		EXECUTE sp_executesql  @StrLocInsertToChallanMenuModifierTemp
		EXECUTE sp_executesql  @StrLocInsertToChallanMenuItemCostCenterTemp
		
	END
	ELSE IF(@Type='S')
	BEGIN
		SET @StrLocInsertToTblChallanServicesTemp ='
		insert into SNC.TblChallanServicesTemp_'+ltrim(rtrim(@POSCode))+' 
		select 
			ReservationId,DayId,ProformaInvoiceId,ServiceID,Quantity,IsChargable,PerUnitRate,PerUnitChargableType1
			,PerUnitChargableType2,CalcualtedRate,CalcualtedCost,ServiceRateId,SupplierRateCode,PerUnitCost,IsDisplay
			,CostType,CostPer,[Status],TaxAmt,TaxStr,Rate,Discount,Qty,AmdCode,UpdatedFrom,CreatedBy,CreatedDate,ModifiedBy
			,ModifiedDate,GroupID,ClientID,'''+@Guid+'''
		from SNC.TblChallanServices_'+ltrim(rtrim(@POSCode))+' 
		where  [ReservationId]='+ convert(varchar(20),@ReservationId) +'  and [DayId]='+ Convert(varchar(20),@DayId) +'		
		union all
		select 
			ReservationId,DayId,'''',ServiceID,Quantity,IsChargable,PerUnitRate,PerUnitChargableType1
			,PerUnitChargableType2,CalcualtedRate,CalcualtedCost,ServiceRateId,SupplierRateCode,PerUnitCost,IsDisplay
			,CostType,CostPer,'''',0,'''',0,0,0,AmdCode,UpdatedFrom,CreatedBy,CreatedDate,ModifiedBy
			,ModifiedDate,GroupID,ClientID,'''+@Guid+'''
		from SNC.TblServices_'+ltrim(rtrim(@POSCode))+' 
		where  [ReservationId]='+ convert(varchar(20),@ReservationId) +'  and [DayId]='+ Convert(varchar(20),@DayId) +'	
		'

		EXECUTE sp_executesql  @StrLocInsertToTblChallanServicesTemp	

	END
		

END
Go

IF EXISTS(SELECT * FROM sysobjects WHERE type='P' AND name='SprSNCSaveProformaInvoice')        
BEGIN
        DROP PROCEDURE SprSNCSaveProformaInvoice
END
Go
Create  Procedure SprSNCSaveProformaInvoice
(  
 @xmlReservationDetails varchar(MAX),  
 @xmlMenuBanquetItemDetails varchar(MAX),  
 @xmlMenuItemDetails varchar(MAX),  
 @xmlMenuModifierDetails varchar(MAX),  
 @xmlMenuItemCostCenterDetails varchar(MAX),  
 @xmlServicesDetails varchar(MAX),   
 @XmlProformaInvoiceDetails  varchar(MAX),  
 @XmlProformaInvoiceTax  varchar(MAX),   
 @XmlProformaInvoiceTaxDetail  varchar(MAX),   
 @IsPI int,  
 @Guid nvarchar(Max),  
 @POSCode Nvarchar(20),   
 @User varchar(4),  
 @GroupId char(3),  
 @ClientId char(3)  
)  
AS  
BEGIN   
 DECLARE @xmlHandle INT  
   
 DECLARE @StrLocQueryGetPIAmdCode Nvarchar(MAX)  
 DECLARE @StrLocQueryInsertUpdatePI Nvarchar(MAX)  
 DECLARE @StrLocQueryInsertTaxDetail nvarchar(MAX)  
 DECLARE @StrLocQueryInsertTax nvarchar(MAX)  
  
 DECLARE @StrLocProformaInvNo nvarchar(MAX)  
 DECLARE @ReservationId nvarchar(MAX)  
 DECLARE @DayId nvarchar(MAX)  
 DECLARE @PIAmdCode nvarchar(10)
 
  DECLARE @UserCode int   ---added for MyAcitvity           
 select @UserCode=UserCode From TblUser where UserShortName=@User; --- added for MyAcitvity    
    
  CREATE TABLE #TblProformaInvoiceDetails   
  (  
   [ProformaInvoiceId] [varchar](24),  
   [ReservationId] [varchar](24),  
   [DayId] [varchar](24) ,  
   [FPNumber] [varchar](24),  
   [Diplomat] [varchar](5) ,  
   [OverCounter] [varchar](5),  
   [PayMode] [varchar](5) ,  
   [AdvancePay] [money] ,  
   [GrantTotal] [money] ,  
   [Amount] [money] ,  
   [Pax] [varchar](24) ,  
   [Discount] [money] ,  
   [TotalTax] [money] ,  
   [TaxType] [varchar](5),  
   [Done] [varchar](5) ,  
   [TempId] [varchar](50),  
   [HallHire] [money] ,  
   [VenueRental] [money],  
   [LiquorLicense] [money] ,  
   [AdvanceRecpNo] [varchar](2000),  
   [AmdCode] [int],  
   [BillNo] [varchar](20),  
   [AreaCode] [varchar](20),  
   [MainPINo] [int],  
   [IsSplitPI] [char](1),  
   [PIToParty] [varchar](50),  
   [PIToContact] [varchar](50),  
   [AccountGSTRegNo] [varchar](20),  
   [AccountGSTStateCode] [varchar](20),  
   [AccountGSTStateValue] [varchar](20),  
   [SEZ] [char](1)  
  )  
  
  CREATE TABLE #TblProformaInvoiceTaxDetail  
  (  
   [ProformaInvoiceNo] [varchar](24),  
   [ReservationId] [varchar](24),  
   [DayId] [varchar](24),  
   [ItemType] [varchar](3),  
   [ItemCode] [varchar](24),  
   [TaxCode] [varchar](24) ,  
   [TaxDesc] [varchar](50),  
   [TaxAmt] [money] ,  
   [OnAmt] [money],  
   [AreaCode] [varchar](20)  
  )   
  
  
  CREATE TABLE #TblProformaInvoiceTax  
  (  
   [ProformaInvoiceNo] [varchar](24) ,  
   [ReservationId] [varchar](24) ,  
   [DayId] [varchar](24) ,  
   [TaxCode] [varchar](24) ,  
   [TaxDesc] [varchar](50) ,  
   [TaxAmt] [money] ,  
   [OnAmt] [money] ,  
   [TotalTaxAmount] [money],  
   [Status] [varchar](5)     
  )   
  
  EXEC sp_xml_preparedocument @xmlHandle output, @XmlProformaInvoiceDetails    
  INSERT INTO #TblProformaInvoiceDetails  
  SELECT   ProformaInvoiceId,ReservationId,DayId,FPNumber,Diplomat,OverCounter,PayMode,AdvancePay,GrantTotal,Amount,Pax,Discount,TotalTax,TaxType  
    ,Done,TempId,HallHire,VenueRental,LiquorLicense,AdvanceRecpNo,AmdCode,BillNo,AreaCode,MainPINo,IsSplitPI,PIToParty,PIToContact  
    ,AccountGSTRegNo,AccountGSTStateCode,AccountGSTStateValue,SEZ  
  FROM  OPENXML (@xmlHandle, 'NewDataSet/DataTable',1)  
      WITH (   
        [ProformaInvoiceId] [varchar](24) '@StrPubProformaInvoiceId' ,  
        [ReservationId] [varchar](24)'@StrPubReservationId' ,  
        [DayId] [varchar](24) '@StrPubDayId' ,  
        [FPNumber] [varchar](24)'@StrPubFPNumber' ,  
        [Diplomat] [varchar](5) '@StrPubDiplomat' ,  
        [OverCounter] [varchar](5)'@StrPubOverCounter' ,  
        [PayMode] [varchar](5) '@StrPubPayMode' ,  
        [AdvancePay] [money] '@StrPubAdvancePay' ,  
        [GrantTotal] [money] '@StrPubGrantTotal' ,  
        [Amount] [money] '@StrPubAmount' ,  
        [Pax] [varchar](24) '@StrPubPax' ,  
        [Discount] [money] '@StrPubDiscount' ,  
        [TotalTax] [money] '@StrPubTotalTax' ,  
        [TaxType] [varchar](5)'@StrPubTaxType' ,  
        [Done] [varchar](5) '@StrPubDone' ,  
        [TempId] [varchar](50)'@StrPubTempId' ,  
        [HallHire] [money] '@StrPubHallHire' ,  
        [VenueRental] [money]'@StrPubVenueRental' ,  
        [LiquorLicense] [money] '@StrPubLiquorLicense' ,  
        [AdvanceRecpNo] [varchar](2000)'@StrPubAdvanceRecpNo' ,  
        [AmdCode] [int]'@StrPubAmdCode' ,  
        [BillNo] [varchar](20)'@StrPubBillNo' ,  
        [AreaCode] [varchar](20)'@StrPubAreaCode' ,  
        [MainPINo] [int]'@StrPubMainPINo' ,  
        [IsSplitPI] [char](1)'@StrPubIsSplitPI' ,  
        [PIToParty] [varchar](50)'@StrPubPIToParty' ,  
        [PIToContact] [varchar](50)'@StrPubPIToContact' ,  
        [AccountGSTRegNo] [varchar](20)'@StrPubAccountGSTRegNo' ,  
        [AccountGSTStateCode] [varchar](20)'@StrPubAccountGSTStateCode' ,  
        [AccountGSTStateValue] [varchar](20)'@StrPubAccountGSTStateValue' ,  
        [SEZ] [char](1) '@StrPubSEZ'          
        )  
 EXEC sp_xml_removedocument @xmlHandle  
  
  Select top 1   
   @StrLocProformaInvNo=isnull(ProformaInvoiceId ,'0'),  
   @ReservationId=isnull(ReservationId ,'0'),  
   @DayId=isnull(DayId ,'0')  
  From #TblProformaInvoiceDetails  
  
    
  
 EXEC sp_xml_preparedocument @xmlHandle output, @XmlProformaInvoiceTaxDetail    
  INSERT INTO #TblProformaInvoiceTaxDetail  
  SELECT   @StrLocProformaInvNo as [ProformaInvoiceNo],@ReservationId as [ReservationId], @DayId as [DayId],[ItemType],[ItemCode],[TaxCode],'' as [TaxDesc],[TaxAmt],[OnAmt],[AreaCode]  
  FROM  OPENXML (@xmlHandle, 'NewDataSet/DataTable',1)  
      WITH (           
        [ItemType] [varchar](3) '@ItemType',  
        [ItemCode] [varchar](24) '@MenuItemCode',  
        [TaxCode] [varchar](24)'@TaxCode',          
        [TaxAmt] [money] '@TaxAmount',  
        [OnAmt] [money] '@TaxableAmount',  
        [AreaCode] [varchar](20) '@AreaCode'        
        )  
 EXEC sp_xml_removedocument @xmlHandle  
  
 EXEC sp_xml_preparedocument @xmlHandle output, @XmlProformaInvoiceTax    
  INSERT INTO #TblProformaInvoiceTax  
  SELECT   @StrLocProformaInvNo as [ProformaInvoiceNo],@ReservationId as [ReservationId], @DayId as [DayId],[TaxCode],'' as [TaxDesc],[TaxAmt],[OnAmt],0 as [TotalTaxAmount],'' as [Status]  
  FROM  OPENXML (@xmlHandle, 'NewDataSet/DataTable',1)  
      WITH (   
        [TaxCode] [varchar](24) '@TaxCode',          
        [TaxAmt] [money] '@TaxAmount',  
        [OnAmt] [money] '@TaxableAmount'         
              
        )  
 EXEC sp_xml_removedocument @xmlHandle  
   
    
    
    
  
  SET @StrLocQueryGetPIAmdCode=''  
  SET @StrLocQueryGetPIAmdCode='SELECT @PIAmdCode=ISNULL(max(amdcode),0)+1 FROM SNC.TblProformaInvoiceDetails_'+@POSCode+' WHERE ProformaInvoiceId=''' + @StrLocProformaInvNo + ''' '  
    
  DECLARE @ParmDefinition nvarchar(500);  
  SET @ParmDefinition = ' @PIAmdCode nvarchar(10) OUTPUT';  
  EXECUTE sp_executesql  @StrLocQueryGetPIAmdCode,@ParmDefinition,@PIAmdCode=@PIAmdCode OUTPUT  
    
  
  SET @StrLocQueryInsertUpdatePI=''  
  SET @StrLocQueryInsertUpdatePI='    
  MERGE [SNC].[TblProformaInvoiceDetails_'+@POSCode+'] AS TARGET    
  USING #TblProformaInvoiceDetails AS SOURCE     
  ON (TARGET.ProformaInvoiceId=SOURCE.ProformaInvoiceId AND TARGET.ReservationId=SOURCE.ReservationId AND TARGET.DayId=SOURCE.DayId)    
  WHEN MATCHED  THEN          
   UPDATE SET    
    TARGET.[Diplomat] = SOURCE.[Diplomat],    
    TARGET.[OverCounter]=SOURCE.[OverCounter],    
    TARGET.[PayMode]=SOURCE.[PayMode],    
    TARGET.[AdvancePay]=SOURCE.[AdvancePay],    
    TARGET.[AdvanceRecpNo]=SOURCE.[AdvanceRecpNo],  
    TARGET.[amdcode]=@PIAmdCode,    
    TARGET.[ModifiedBy] = '''+@User+''',    
    TARGET.[ModifiedDate] = [dbo].GetLocalDate(),    
    TARGET.GroupID='''+@GroupId+''',    
    TARGET.ClientID='''+@ClientId+'''       
  WHEN NOT MATCHED BY TARGET THEN     
   insert (ProformaInvoiceId,ReservationId,DayId,FPNumber,Diplomat,OverCounter,PayMode,AdvancePay,  
     GrantTotal,Amount,Pax,Discount,TotalTax,TaxType,Done,TempId,HallHire,VenueRental,  
     LiquorLicense,AdvanceRecpNo,AmdCode,BillNo,AreaCode,MainPINo,IsSplitPI,PIToParty,PIToContact  
     ,AccountGSTRegNo,AccountGSTStateCode,AccountGSTStateValue,SEZ  
     ,CreatedBy,CreatedDate,ModifiedBy,ModifiedDate,GroupID,ClientID  
       )  
   VALUES (  
     @StrLocProformaInvNo,SOURCE.ReservationId,SOURCE.DayId,SOURCE.FPNumber,SOURCE.Diplomat,SOURCE.OverCounter,SOURCE.PayMode,SOURCE.AdvancePay,  
     SOURCE.GrantTotal,SOURCE.Amount,SOURCE.Pax,SOURCE.Discount,SOURCE.TotalTax,SOURCE.TaxType,SOURCE.Done,SOURCE.TempId,SOURCE.HallHire,SOURCE.VenueRental,  
     SOURCE.LiquorLicense,SOURCE.AdvanceRecpNo,@PIAmdCode,SOURCE.BillNo,SOURCE.AreaCode,SOURCE.MainPINo,SOURCE.IsSplitPI,SOURCE.PIToParty,SOURCE.PIToContact,  
     SOURCE.AccountGSTRegNo,SOURCE.AccountGSTStateCode,SOURCE.AccountGSTStateValue,SOURCE.SEZ,  
     '''+@User+''',[dbo].GetLocalDate(),'''+@User+''',[dbo].GetLocalDate(),'''+@GroupId+''', '''+@ClientId+'''   
       );    
         
    
  '  
    
    
  
  SET @StrLocQueryInsertTaxDetail=''  
  SET @StrLocQueryInsertTaxDetail='    
  MERGE [SNC].[TblProformaInvoiceTaxDetail_'+@POSCode+'] AS TARGET    
  USING #TblProformaInvoiceTaxDetail AS SOURCE     
  ON (TARGET.ProformaInvoiceNo=SOURCE.ProformaInvoiceNo AND TARGET.ReservationId=SOURCE.ReservationId   
   AND TARGET.DayId=SOURCE.DayId AND TARGET.[ItemType] = SOURCE.[ItemType] AND TARGET.[ItemCode]=SOURCE.[ItemCode]   
   AND TARGET.[TaxCode]=SOURCE.[TaxCode])    
  WHEN MATCHED  THEN          
   UPDATE SET    
    TARGET.[ItemType] = SOURCE.[ItemType],    
    TARGET.[ItemCode]=SOURCE.[ItemCode],    
    TARGET.[TaxCode]=SOURCE.[TaxCode],    
    TARGET.[TaxDesc]=SOURCE.[TaxDesc],  
    TARGET.[TaxAmt]=SOURCE.[TaxAmt],    
    TARGET.[OnAmt]=SOURCE.[OnAmt],  
    TARGET.[AreaCode]=SOURCE.[AreaCode],    
    TARGET.[ModifiedBy] = '''+@User+''',    
    TARGET.[ModifiedDate] = [dbo].GetLocalDate(),    
    TARGET.GroupID='''+@GroupId+''',    
    TARGET.ClientID='''+@ClientId+'''       
  WHEN NOT MATCHED BY TARGET THEN     
   insert ([ProformaInvoiceNo],[ReservationId], [DayId],[ItemType],[ItemCode],[TaxCode],[TaxDesc],[TaxAmt],  
     [OnAmt],[AreaCode],[CreatedBy],[CreatedDate],[ModifiedBy],[ModifiedDate],[GroupID],[ClientID]  
       )  
   VALUES (  
     SOURCE.ProformaInvoiceNo,SOURCE.ReservationId,SOURCE.DayId,SOURCE.[ItemType],SOURCE.[ItemCode],SOURCE.[TaxCode],SOURCE.[TaxDesc],SOURCE.[TaxAmt],  
     SOURCE.[OnAmt],SOURCE.[AreaCode],'''+@User+''',[dbo].GetLocalDate(),'''+@User+''',[dbo].GetLocalDate(),'''+@GroupId+''', '''+@ClientId+'''   
       );    
    
  '  
  
  SET @StrLocQueryInsertTax=''  
  SET @StrLocQueryInsertTax='    
  MERGE [SNC].[TblProformaInvoiceTax_'+@POSCode+'] AS TARGET    
  USING #TblProformaInvoiceTax AS SOURCE     
  ON (TARGET.ProformaInvoiceNo=SOURCE.ProformaInvoiceNo AND TARGET.ReservationId=SOURCE.ReservationId AND TARGET.DayId=SOURCE.DayId AND TARGET.[TaxCode]=SOURCE.[TaxCode])    
  WHEN MATCHED  THEN          
   UPDATE SET        
    TARGET.[TaxCode]=SOURCE.[TaxCode],    
    TARGET.[TaxDesc]=SOURCE.[TaxDesc],  
    TARGET.[TaxAmt]=SOURCE.[TaxAmt],    
    TARGET.[OnAmt]=SOURCE.[OnAmt],  
    TARGET.[TotalTaxAmount]=SOURCE.[TotalTaxAmount],   
    TARGET.[Status]=SOURCE.[Status],   
    TARGET.[ModifiedBy] = '''+@User+''',    
    TARGET.[ModifiedDate] = [dbo].GetLocalDate(),    
    TARGET.GroupID='''+@GroupId+''',    
    TARGET.ClientID='''+@ClientId+'''       
  WHEN NOT MATCHED BY TARGET THEN     
   insert ([ProformaInvoiceNo],[ReservationId], [DayId],[TaxCode],[TaxDesc],[TaxAmt],  
     [OnAmt],[TotalTaxAmount],[Status],[CreatedBy],[CreatedDate],[ModifiedBy],[ModifiedDate],[GroupID],[ClientID]  
       )  
   VALUES (  
     SOURCE.ProformaInvoiceNo,SOURCE.ReservationId,SOURCE.DayId,SOURCE.[TaxCode],SOURCE.[TaxDesc],SOURCE.[TaxAmt],  
     SOURCE.[OnAmt],SOURCE.[TotalTaxAmount],SOURCE.[Status],'''+@User+''',[dbo].GetLocalDate(),'''+@User+''',[dbo].GetLocalDate(),'''+@GroupId+''', '''+@ClientId+'''   
       );    
    
  '  
  
  
    
  DECLARE @ParmDefinitionInsert nvarchar(500);      
  SET @ParmDefinitionInsert = ' @PIAmdCode nvarchar(10),@StrLocProformaInvNo nvarchar(20)';  
  EXECUTE sp_executesql  @StrLocQueryInsertUpdatePI,@ParmDefinitionInsert,@PIAmdCode=@PIAmdCode,@StrLocProformaInvNo=@StrLocProformaInvNo  
  EXECUTE sp_executesql  @StrLocQueryInsertTaxDetail  
  EXECUTE sp_executesql  @StrLocQueryInsertTax    
  Exec SprSNCSaveMenuForReservation @xmlReservationDetails,@xmlMenuBanquetItemDetails,@xmlMenuItemDetails,@xmlMenuModifierDetails,@xmlMenuItemCostCenterDetails,@IsPI,@StrLocProformaInvNo,@Guid,@POSCode,@User,@GroupId,@ClientId   
  Exec SprSNCSaveServicesForReservation @xmlReservationDetails,@xmlServicesDetails,@IsPI,@StrLocProformaInvNo,@Guid   
  
---------------changesInsertTaskForMyActivity---------------------        
      
 exec SprSNCInsertTaskForMyActivity @ReservationId,@UserCode,'12',@POSCode,@GroupId,@ClientId        
        
---------------changesInsertTaskForMyActivity---------------------   
     
    
END  
GO

IF EXISTS(SELECT * FROM sysobjects WHERE type='P' AND name='SprSNCInitiatePIGeneration')        
BEGIN
        DROP PROCEDURE SprSNCInitiatePIGeneration
END
Go
Create Procedure SprSNCInitiatePIGeneration
(
	@ReservationId varchar(20),
	@DayId varchar(20),
	@IsPI int,
	@Guid Nvarchar(MAX),
	@POSCode Nvarchar(20),	
	@User varchar(4),
	@GroupId char(3),
	@ClientId char(3)
)
AS
BEGIN
	Declare @StrLocInsertToChallanMenuBanquetItemTemp nvarchar(max)
	Declare @StrLocInsertToChallanMenuItemTemp nvarchar(max)
	Declare @StrLocInsertToChallanMenuModifierTemp nvarchar(max)
	Declare @StrLocInsertToChallanMenuItemCostCenterTemp nvarchar(max)
	Declare @StrLocInsertToTblChallanServicesTemp nvarchar(max)
	
	

	SET @StrLocInsertToChallanMenuBanquetItemTemp=''
	SET @StrLocInsertToChallanMenuItemTemp=''
	SET @StrLocInsertToChallanMenuModifierTemp=''
	SET @StrLocInsertToChallanMenuItemCostCenterTemp =''
	SET @StrLocInsertToTblChallanServicesTemp =''
	

	IF(@IsPI=0)	
	BEGIN
		SET @StrLocInsertToChallanMenuBanquetItemTemp='
		insert into SNC.TblChallanMenuBanquetItemTemp_'+ltrim(rtrim(@POSCode))+' 
		select 
			ReservationId,DayId,''0'',BanquetItemId,GuarantedPax,ActualPax,PercentPremiumCharge,AmountPremiumCharge,PerPaxRate
			,CalculatedPaxRate,PremiumRate,CalculatedRate,BanquetItemPriceId,KitchenTime,ServeTime,'''',0,'''',0,0,0
			,CostPrice,CalculatedPremium,AmdCode,UpdatedFrom,CreatedBy,CreatedDate,ModifiedBy,ModifiedDate,GroupID,ClientID,'''+@Guid+'''
		from SNC.TblMenuBanquetItem_'+ltrim(rtrim(@POSCode))+' 
		where  [ReservationId]='+ convert(varchar(20),@ReservationId) +'  and [DayId]='+ Convert(varchar(20),@DayId) +'			
		'
		SET @StrLocInsertToChallanMenuItemTemp='
		insert into SNC.TblChallanMenuItemTemp_'+ltrim(rtrim(@POSCode))+' 
		select 
			ReservationId,DayId,''0'',BanquetItemId,MenuHeadCode,MenuItemCode,IsTDHCost,Quantity,CostPrice
			,PerSalesPrice,CalculatedPrice,IsModifier,MenuItemRateCode,IsFreeFlow,MenuHeadType,Chargeble,'''',0,'''',0,0,0
			,AmdCode,UpdatedFrom,CreatedBy,CreatedDate,ModifiedBy,ModifiedDate,GroupID,ClientID,'''+@Guid+'''
		from SNC.TblMenuItem_'+ltrim(rtrim(@POSCode))+'
		where  [ReservationId]='+ convert(varchar(20),@ReservationId) +'  and [DayId]='+ Convert(varchar(20),@DayId) +'	 
		'
		SET @StrLocInsertToChallanMenuModifierTemp='
		insert into SNC.TblChallanMenuModifierTemp_'+ltrim(rtrim(@POSCode))+' 
		select 
			ReservationId,DayId,''0'',BanquetItemId,MenuHeadCode,MenuItemId,ModifierDescription,ModifierRate,IsFreeFlow
			,MenuHeadType,ModifierCost,Quantity,'''',0,'''',0,0,0,AmdCode,UpdatedFrom,CreatedBy,CreatedDate
			,ModifiedBy,ModifiedDate,GroupID,ClientID,'''+@Guid+'''
		from SNC.TblMenuModifier_'+ltrim(rtrim(@POSCode))+' 
		where  [ReservationId]='+ convert(varchar(20),@ReservationId) +'  and [DayId]='+ Convert(varchar(20),@DayId) +'	
		'
		SET @StrLocInsertToChallanMenuItemCostCenterTemp ='
		insert into SNC.TblChallanMenuItemCostCenterTemp_'+ltrim(rtrim(@POSCode))+' 
		select 
			ReservationId,DayId,''0'',BanquetItemId,MenuHeadId,MenuItemId,CostCenter,MenuHeadType,AmdCode
			,UpdatedFrom,CreatedBy,CreatedDate,ModifiedBy,ModifiedDate,GroupID,ClientID,'''+@Guid+'''
		from SNC.TblMenuItemCostCenter_'+ltrim(rtrim(@POSCode))+' 
		where  [ReservationId]='+ convert(varchar(20),@ReservationId) +'  and [DayId]='+ Convert(varchar(20),@DayId) +'	
		'
		SET @StrLocInsertToTblChallanServicesTemp ='
		insert into SNC.TblChallanServicesTemp_'+ltrim(rtrim(@POSCode))+' 
		select 
			ReservationId,DayId,''0'',ServiceID,Quantity,IsChargable,PerUnitRate,PerUnitChargableType1
			,PerUnitChargableType2,CalcualtedRate,CalcualtedCost,ServiceRateId,SupplierRateCode,PerUnitCost,IsDisplay
			,CostType,CostPer,'''',0,'''',0,0,0,AmdCode,UpdatedFrom,CreatedBy,CreatedDate,ModifiedBy
			,ModifiedDate,GroupID,ClientID,'''+@Guid+'''
		from SNC.TblServices_'+ltrim(rtrim(@POSCode))+' 
		where  [ReservationId]='+ convert(varchar(20),@ReservationId) +'  and [DayId]='+ Convert(varchar(20),@DayId) +'	
		'

		
		
	END
	ELSE IF(@IsPI=1)	
	BEGIN
		SET @StrLocInsertToChallanMenuBanquetItemTemp='
		insert into SNC.TblChallanMenuBanquetItemTemp_'+ltrim(rtrim(@POSCode))+' 		
		select 
			ReservationId,DayId,ProformaInvoiceId,BanquetItemId,GuarantedPax,ActualPax,PercentPremiumCharge,AmountPremiumCharge,PerPaxRate
			,CalculatedPaxRate,PremiumRate,CalculatedRate,BanquetItemPriceId,KitchenTime,ServeTime,[Status],TaxAmt,TaxStr,Rate,Discount,Qty
			,CostPrice,CalculatedPremium,AmdCode,UpdatedFrom,CreatedBy,CreatedDate,ModifiedBy,ModifiedDate,GroupID,ClientID,'''+@Guid+'''
		from SNC.TblChallanMenuBanquetItem_'+ltrim(rtrim(@POSCode))+' 
		where  [ReservationId]='+ convert(varchar(20),@ReservationId) +'  and [DayId]='+ Convert(varchar(20),@DayId) +'	
		'
		SET @StrLocInsertToChallanMenuItemTemp='
		insert into SNC.TblChallanMenuItemTemp_'+ltrim(rtrim(@POSCode))+' 
		select 
			ReservationId,DayId,ProformaInvoiceId,BanquetItemId,MenuHeadCode,MenuItemCode,IsTDHCost,Quantity,CostPrice
			,PerSalesPrice,CalculatedPrice,IsModifier,MenuItemRateCode,IsFreeFlow,MenuHeadType,Chargeble,'''',0,'''',0,0,0
			,AmdCode,UpdatedFrom,CreatedBy,CreatedDate,ModifiedBy,ModifiedDate,GroupID,ClientID,'''+@Guid+'''
		from SNC.TblChallanMenuItem_'+ltrim(rtrim(@POSCode))+'
		where  [ReservationId]='+ convert(varchar(20),@ReservationId) +'  and [DayId]='+ Convert(varchar(20),@DayId) +'	 
		'
		SET @StrLocInsertToChallanMenuModifierTemp='
		insert into SNC.TblChallanMenuModifierTemp_'+ltrim(rtrim(@POSCode))+' 
		select 
			ReservationId,DayId,ProformaInvoiceId,BanquetItemId,MenuHeadCode,MenuItemId,ModifierDescription,ModifierRate,IsFreeFlow
			,MenuHeadType,ModifierCost,Quantity,'''',0,'''',0,0,0,AmdCode,UpdatedFrom,CreatedBy,CreatedDate
			,ModifiedBy,ModifiedDate,GroupID,ClientID,'''+@Guid+'''
		from SNC.TblChallanMenuModifier_'+ltrim(rtrim(@POSCode))+' 
		where  [ReservationId]='+ convert(varchar(20),@ReservationId) +'  and [DayId]='+ Convert(varchar(20),@DayId) +'	
		'
		SET @StrLocInsertToChallanMenuItemCostCenterTemp ='
		insert into SNC.TblChallanMenuItemCostCenterTemp_'+ltrim(rtrim(@POSCode))+' 
		select 
			ReservationId,DayId,ProformaInvoiceId,BanquetItemId,MenuHeadId,MenuItemId,CostCenter,MenuHeadType,AmdCode
			,UpdatedFrom,CreatedBy,CreatedDate,ModifiedBy,ModifiedDate,GroupID,ClientID,'''+@Guid+'''
		from SNC.TblChallanMenuItemCostCenter_'+ltrim(rtrim(@POSCode))+' 
		where  [ReservationId]='+ convert(varchar(20),@ReservationId) +'  and [DayId]='+ Convert(varchar(20),@DayId) +'	
		'

		SET @StrLocInsertToTblChallanServicesTemp ='
		insert into SNC.TblChallanServicesTemp_'+ltrim(rtrim(@POSCode))+' 
		select 
			ReservationId,DayId,ProformaInvoiceId,ServiceID,Quantity,IsChargable,PerUnitRate,PerUnitChargableType1
			,PerUnitChargableType2,CalcualtedRate,CalcualtedCost,ServiceRateId,SupplierRateCode,PerUnitCost,IsDisplay
			,CostType,CostPer,[Status],TaxAmt,TaxStr,Rate,Discount,Qty,AmdCode,UpdatedFrom,CreatedBy,CreatedDate,ModifiedBy
			,ModifiedDate,GroupID,ClientID,'''+@Guid+'''
		from SNC.TblChallanServices_'+ltrim(rtrim(@POSCode))+' 
		where  [ReservationId]='+ convert(varchar(20),@ReservationId) +'  and [DayId]='+ Convert(varchar(20),@DayId) +'	
		'

			

	END

		EXECUTE sp_executesql  @StrLocInsertToChallanMenuBanquetItemTemp
		EXECUTE sp_executesql  @StrLocInsertToChallanMenuItemTemp
		EXECUTE sp_executesql  @StrLocInsertToChallanMenuModifierTemp
		EXECUTE sp_executesql  @StrLocInsertToChallanMenuItemCostCenterTemp
		EXECUTE sp_executesql  @StrLocInsertToTblChallanServicesTemp
		

END
GO

IF EXISTS(SELECT * FROM sysobjects WHERE type='P' AND name='SprSNCGetProformaInvoiceDetls')        
BEGIN
        DROP PROCEDURE SprSNCGetProformaInvoiceDetls
END
Go
Create PROCEDURE SprSNCGetProformaInvoiceDetls
(
	@ReservationNo VARCHAR(50),  
	@DayId VARCHAR(50),  
	@BanquetCode VARCHAR(50),  
	@ProformaInvoiceNo VARCHAR(50)  
)
AS  
BEGIN  
	DECLARE @StrQry VARCHAR(MAX)   
	DECLARE @TblNew TABLE   
	(  
	Type VARCHAR(50),  
	ReservationId VARCHAR(50),  
	DayId VARCHAR(50),  
	ItemName  VARCHAR(200), 
	Quantity nvarchar(20),
	PerPaxRate MONEY,  
	CalcualtedRate  MONEY,  
	ItemId VARCHAR(10),
	ModCode INT ,
	MenuHead Varchar(200)  
	)  
	SET   @StrQry = '     select  1 as Type, ''' + @ReservationNo + ''' As ReservationId, '''+ @DayId  +''' As DayId, ''Menu'' As ItemName, ''0'' As Quantity   ,  ''0'' As PerPaxRate,   ''0'' As CalcualtedRate  , '''' As ItemId , '''' As ModCode  ,'''' As MenuHead   
						Union All         
						select  2 as Type, a.ReservationId, a.DayId, b.ItemName, CONVERT(nvarchar(5),a.ActualPax) As Quantity , ((a.CalculatedPaxRate+a.calculatedpremium)/a.ActualPax)  as PerPaxRate, convert(decimal(38,2), (a.CalculatedPaxRate+a.calculatedpremium)) As CalcualtedRate,  a.BanquetItemId As ItemId , '''' As ModCode , '''' As MenuHead from  dbo.TblChallanMenuBanquetItemtemp_'+ @BanquetCode  +'  a, dbo.TblBanquetItem  b Where a.proformainvoiceid= ''' + @ProformaInvoiceNo + ''' and  a.BanquetItemId = b.Code and a.BanquetItemId <> ''A1LC'' and a.ReservationId=''' + @ReservationNo + ''' and a.DayId ='''+ @DayId  +'''            
						Union All        
						select  3 as Type, ReservationId, DayId, ''A - la - Carte''  As ItemName, CONVERT(nvarchar(5),GuarantedPax) As Quantity , PerPaxRate,  ''0''  As CalcualtedRate , '''' As ItemId , '''' As ModCode,  '''' As MenuHead from  dbo.TblChallanMenuBanquetItemtemp_'+ @BanquetCode  +'  Where proformainvoiceid= ''' + @ProformaInvoiceNo + ''' and  BanquetItemId =  ''A1LC'' and ReservationId=''' + @ReservationNo + ''' and DayId ='''+ @DayId  +'''            
						Union All         
						select  4 as Type, a.ReservationId , a.DayId , b.Name As ItemName, SUBSTRING(CONVERT(nvarchar(50),a.Quantity),1,(Len(a.Quantity)-(CASE WHEN ISNULL(b.QtyDecimal,0)= 0 THEN 4 ELSE 3 END))+ISNULL(b.QtyDecimal,0)) AS Quantity, a.PerSalesPrice AS PerPaxRate , convert(decimal(38,2),(SUBSTRING(CONVERT(nvarchar(50),a.Quantity),1,(Len(a.Quantity)-(CASE WHEN ISNULL(b.QtyDecimal,0)= 0 THEN 4 ELSE 3 END))+ISNULL(b.QtyDecimal,0)) * a.PerSalesPrice)) as CalcualtedRate ,  a.MenuItemId As ItemId , '''' As ModCode ,c.name  from dbo.TblChallanMenuItemtemp_'+ @BanquetCode  +'  a ,  dbo.TblMenuItem b , dbo.TblMenuHead c  where  a.Status= '''' and   a.MenuItemId = b.Code and b.MenuHead=c.code   and  a.BanquetItemId = ''A1LC'' and a.ReservationId= ''' + @ReservationNo + '''  and a.DayId ='''+ @DayId  +'''   and  proformainvoiceid= ''' + @ProformaInvoiceNo + ''' and a.IsTDHCost=''0''    
						Union All  
							select  4 as Type,  a.ReservationId , convert(varchar,a.DayId)  DayId , ''**''+a.ModifierDescription As ItemName , 
							--CONVERT(nvarchar(5),b.quantity) as Quantity ,
							SUBSTRING(CONVERT(nvarchar(50),b.Quantity),1,(Len(b.Quantity)-(CASE WHEN ISNULL(c.QtyDecimal,0)= 0 THEN 4 ELSE 3 END))+ISNULL(c.QtyDecimal,0))as Quantity ,
							a.modifierrate as  PerPaxRate , convert(decimal(38,2),(a.modifierrate*SUBSTRING(CONVERT(nvarchar(50),b.Quantity),1,(Len(b.Quantity)-(CASE WHEN ISNULL(c.QtyDecimal,0)= 0 THEN 4 ELSE 3 END))+ISNULL(c.QtyDecimal,0)))) As CalcualtedRate , b.MenuItemId As ItemId , a.modifierid As ModiCode, '''' As MenuHead from dbo.TblChallanMenuModifiertemp_'+ @BanquetCode  +' a 
							
							left outer join dbo.TblChallanMenuitemtemp_'+ @BanquetCode  +' b on a.proformainvoiceid= b.proformainvoiceid AND a.BanquetItemId=b.BanquetItemId and a.menuheadid=b.menuheadid and a.menuitemid=b.menuitemid 
							and a.ReservationId =b.ReservationId and a.DayId =b.DayId 
							left outer join tblmenuitem c on c.Code=b.MenuitemId   and a.ReservationId= b.ReservationId and a.DayId =b.dayid  where  a.proformainvoiceid= ''' + @ProformaInvoiceNo + ''' and a.BanquetItemId = ''A1LC'' and a.ReservationId= ''' + @ReservationNo + '''  and a.DayId ='''+ @DayId  +''' and b.IsTDHCost=''0''   
						Union All         
						select  6 as Type, ''' + @ReservationNo + ''' As ReservationId, '''+ @DayId  +''' As DayId, '''' As ItemName , ''0'' As Quantity   ,  ''0'' As PerPaxRate,   ''0'' As CalcualtedRate     , '''' As ItemId , '''' As ModCode  , '''' As MenuHead    
						Union All          
						select  7 as Type, ''' + @ReservationNo + ''' As ReservationId, '''+ @DayId  +''' As DayId, ''Services'' As ItemName ,''0'' As Quantity   ,  ''0'' As PerPaxRate,   ''0'' As CalcualtedRate  ,'''' As ItemId , '''' As ModCode , '''' As MenuHead           
			
							Union All   
							select  8 as Type, ''' + @ReservationNo + ''' As ReservationId, '''+ @DayId  +''' As DayId, b.Name As ItemName ,CONVERT(nvarchar(5),a.Quantity )   , a.PerUnitRate As PerPaxRate,convert(decimal(38,2),a.CalcualtedRate) As CalcualtedRate , a.ServiceID As ItemId , '''' As ModCode , '''' As MenuHead from  dbo.TblChallanServicestemp_'+ @BanquetCode  +'  a, dbo.TblService b  where a.IsDisplay = 1 and a.ServiceID = b.Code and proformainvoiceid= ''' + @ProformaInvoiceNo + ''' and a.ReservationId= ''' + @ReservationNo + '''  and a.DayId ='''+ @DayId  +'''    
			union all   
		select  9 as Type, ''' + @ReservationNo + ''' As ReservationId, '''+ @DayId  +''' As DayId, '''' As ItemName , ''0'' As Quantity   ,  ''0'' As PerPaxRate,   ''0'' As CalcualtedRate  , ''''  As ItemId , '''' As ModCode, '''' As MenuHead        
		union all   
		select  10 as Type, ReservationId, '''+ @DayId  +''' As DayId, ''Hall Hire Miscellaneous'' As ItemName , ''1'' As Quantity   ,  rate As PerPaxRate, rate As CalcualtedRate ,   '''' As ItemId , '''' As ModCode, '''' As MenuHead  from tblProformaInvoiceRHLtemp_'+ @BanquetCode  +' where RHL=''H'' and proformainvoiceid= ''' + @ProformaInvoiceNo + ''' and ReservationId = ''' + @ReservationNo + ''' and DayId = '''+ @DayId  +'''   
		Union All  
		select  11  as Type, ReservationId, '''+ @DayId  +''' As DayId, ''Venue Rental'' As ItemName , ''1'' As Quantity   ,  rate As PerPaxRate, rate   As CalcualtedRate ,   '''' As ItemId , '''' As ModCode, '''' As MenuHead  from tblProformaInvoiceRHLtemp_'+ @BanquetCode +' where RHL=''R'' and proformainvoiceid= ''' + @ProformaInvoiceNo + ''' and ReservationId = ''' + @ReservationNo + + ''' and DayId = '''+ @DayId  +'''       
		Union All   
		select  12  as Type, ReservationId, '''+ @DayId  +''' As DayId, ''Liquor License Amount'' As ItemName , ''1'' As Quantity   ,  rate As PerPaxRate, rate   As CalcualtedRate  , '''' As ItemId , '''' As ModCode, '''' As MenuHead from tblProformaInvoiceRHLtemp_'+ @BanquetCode  +' where RHL=''L'' and proformainvoiceid= ''' + @ProformaInvoiceNo + ''' and ReservationId = ''' + @ReservationNo + ''' and DayId = '''+ @DayId  +''''    
	
	print(@StrQry) 
	INSERT INTO @TblNew EXEC (@StrQry) 
	--print(@StrQry) 
	SELECT * FROM @TblNew  order by convert(int,[type]),itemid,modcode
	RETURN   
END
GO

IF EXISTS(SELECT * FROM sysobjects WHERE type='P' AND name='SprGetProformaInvoiceDetails')        
BEGIN
        DROP PROCEDURE SprGetProformaInvoiceDetails
END
Go
Create Procedure SprGetProformaInvoiceDetails
(
	@ProformaInvoiceNo Nvarchar(20),
	@POSCode Nvarchar(20),	
	@User varchar(4),
	@GroupId char(3),
	@ClientId char(3)

)
AS
BEGIN
	DECLARE @StrWhereClause nvarchar(max)
	DECLARE @StrLocQuery nvarchar(max)
	SET @StrWhereClause=''
	SET @StrLocQuery=''

	IF(@ProformaInvoiceNo!='')
	BEGIN
		SET @StrWhereClause=@StrWhereClause+'Where PRI.ProformaInvoiceId='''+@ProformaInvoiceNo+''' '
	END
	ELSE
	BEGIN
		SET @StrWhereClause=''
	END
	
	SET @StrLocQuery= @StrLocQuery+'
	Select 
		RD.ReservationId,RD.ReservationDetailId as DayID, PRI.FPNumber as FPNo,
		convert(varchar,convert(date,RD.Date,103),106) as Date ,RD.FromTime,RD.ToTime,
		RD.GuaranteedPax as MinPax ,RD.MaximumPax as MaxPax
		,F.FunctionName as FunctionName,A.AreaCode, A.Description As Area,RD.ReservationId,
		RD.ReservationDetailId,RH.PShortName,PRI.Diplomat,PRI.OverCounter,PRI.PayMode
	From 
		SNC.TblProformaInvoiceDetails_'+@POSCode+' PRI
	inner join 
		SNC.TblReservationHead_'+@POSCode+' RH on RH.ReservationId=PRI.ReservationId 
	inner join 
		SNC.TblReservationDetail_'+@POSCode+' RD on RD.ReservationId=PRI.ReservationId and RD.ReservationDetailId=PRI.DayId
	inner Join 
		SNC.TblAreaMst A on  RD.AreaCode = A.AreaCode
	inner join SNC.TblFunctionMst F on F.FunctionCode=RH.FunctionId
	
	 '+@StrWhereClause+ '
	 '

	Print @StrLocQuery
	EXECUTE sp_executesql  @StrLocQuery

END
GO

IF EXISTS(SELECT * FROM sysobjects WHERE type='P' AND name='SprSNCGetFPListByReservationid')        
BEGIN
        DROP PROCEDURE SprSNCGetFPListByReservationid
END
Go
Create Procedure SprSNCGetFPListByReservationid
(
	@ReservationID Nvarchar(20),
	@POSCode Nvarchar(20),	
	@User varchar(4),
	@GroupId char(3),
	@ClientId char(3)
)
AS
BEGIN
	Declare @StrLocQuery varchar(max)
	SET @StrLocQuery=''
	SET @StrLocQuery=@StrLocQuery+
	'	Select 
		RD.ReservationId,RD.ReservationDetailId as DayID, isnull(FP.FPNo,0) as FPNo,convert(varchar,convert(date,RD.Date,103),106) as Date ,
		RD.FromTime,RD.ToTime,RD.GuaranteedPax as MinPax ,RD.MaximumPax as MaxPax ,F.FunctionName as FunctionName,A.AreaCode, A.Description As Area,
		RD.ReservationId,RD.ReservationDetailId,RH.PShortName
		,isnull(PI.ProformaInvoiceId,0) as PINo
	From 
		SNC.TblReservationDetail_'+@POSCode+' RD
	inner join 
		SNC.TblReservationHead_'+@POSCode+' RH on RH.ReservationId=RD.ReservationId 
	left outer join 
		SNC.TblProvisionalFP_'+@POSCode+' FP on RD.ReservationId=FP.ReservationId and RD.ReservationDetailId=FP.DayId
	inner Join 
		SNC.TblAreaMst A on  RD.AreaCode = A.AreaCode
	inner join 
		SNC.TblFunctionMst F on F.FunctionCode=RH.FunctionId
	Left Outer Join
		SNC.TblProformaInvoiceDetails_'+@POSCode+' PI On PI.ReservationId=FP.ReservationId and PI.DayId=FP.DayId
	Where RH.ReservationId='''+@ReservationID+'''

	'
	print(@StrLocQuery)
	EXEC(@StrLocQuery)
END
GO

IF EXISTS(SELECT * FROM sysobjects WHERE type='P' AND name='SprSNCVoidProformaInvoice')        
BEGIN
        DROP PROCEDURE SprSNCVoidProformaInvoice
END
Go
Create 
PROCEDURE SprSNCVoidProformaInvoice
(
	@ReservationId nvarchar(100),
	@DayId nvarchar(100),
	@ProformaInvoiceId nvarchar(100),
	@POSCode Nvarchar(20),	
	@User varchar(4),
	@GroupId char(3),
	@ClientId char(3)
)
AS
BEGIN
	DECLARE @StrVoidPI nvarchar(Max)
	DECLARE @StrUpdateCostRevenue Nvarchar(MAx)

	DECLARE @DblLocCalculatedCost Decimal 
	DECLARE @DblLocCalculatedPrice Decimal

	SET @StrVoidPI=''
	SET @StrUpdateCostRevenue=''

	SET @StrVoidPI='
				DELETE SNC.TblMenuServiceOrder_'+@POSCode+' from SNC.TblMenuServiceOrder_'+@POSCode+'  where ReservationId='''+@ReservationId+''' and DayId='''+@DayId+'''
				DELETE FROM SNC.TblChallanMenubanquetitem_'+@POSCode+' WHERE ProformaInvoiceId='''+@ProformaInvoiceId+''' AND ReservationId='''+@ReservationId+''' AND DayId='''+@DayId+''' ;
				DELETE FROM SNC.TblChallanMenuItem_'+@POSCode+' WHERE ProformaInvoiceId='''+@ProformaInvoiceId+''' AND ReservationId='''+@ReservationId+''' AND DayId='''+@DayId+''' ;
				DELETE FROM SNC.TblChallanMenuModifier_'+@POSCode+' WHERE ProformaInvoiceId='''+@ProformaInvoiceId+''' AND ReservationId='''+@ReservationId+''' AND DayId='''+@DayId+''' ;
				DELETE FROM SNC.TblChallanMenuItemCostCenter_'+@POSCode+' WHERE ProformaInvoiceId='''+@ProformaInvoiceId+''' AND ReservationId='''+@ReservationId+''' AND DayId='''+@DayId+''' ;
				DELETE FROM SNC.TblChallanServices_'+@POSCode+' WHERE ProformaInvoiceId='''+@ProformaInvoiceId+''' AND ReservationId='''+@ReservationId+''' AND DayId='''+@DayId+''' ;
				--DELETE FROM SNC.tblProformaInvoiceRHL_'+@POSCode+' WHERE ProformaInvoiceId='''+@ProformaInvoiceId+''' AND ReservationId='''+@ReservationId+''' AND DayId='''+@DayId+''' ;
				DELETE FROM SNC.tblproformainvoicetax_'+@POSCode+' WHERE proformainvoiceno='''+@ProformaInvoiceId+''' AND ReservationId='''+@ReservationId+''' AND DayId='''+@DayId+''' ;
				DELETE FROM SNC.TblProformaInvoiceDetails_'+@POSCode+' WHERE ProformaInvoiceId='''+@ProformaInvoiceId+''' AND ReservationId='''+@ReservationId+''' AND DayId='''+@DayId+''' ;
				DELETE FROM SNC.TblChallanMenubanquetitemtemp_'+@POSCode+' WHERE ProformaInvoiceId='''+@ProformaInvoiceId+''' ;
				DELETE FROM SNC.TblChallanMenuItemtemp_'+@POSCode+' WHERE ProformaInvoiceId='''+@ProformaInvoiceId+''' ;
				DELETE FROM SNC.TblChallanMenuModifiertemp_'+@POSCode+' WHERE ProformaInvoiceId='''+@ProformaInvoiceId+''' ;
				DELETE FROM SNC.TblChallanMenuItemCostCentertemp_'+@POSCode+' WHERE ProformaInvoiceId='''+@ProformaInvoiceId+''' ;
				DELETE FROM SNC.TblChallanServicestemp_'+@POSCode+' WHERE ProformaInvoiceId='''+@ProformaInvoiceId+''' ;                                                
				--DELETE FROM SNC.tblProformaInvoiceRHLtemp_'+@POSCode+' WHERE ProformaInvoiceId='''+@ProformaInvoiceId+''' ;
				--DELETE FROM SNC.tblProformaInvoiceTaxtemp_'+@POSCode+' WHERE proformainvoiceno='''+@ProformaInvoiceId+''' ;
				--DELETE FROM SNC.TblProformaInvoiceTaxDetailTemp_'+@POSCode+' WHERE proformainvoiceno='''+@ProformaInvoiceId+''' ;
				--DELETE FROM SNC.tblproformainvoicedetails_temp_'+@POSCode+' WHERE ProformaInvoiceId='''+@ProformaInvoiceId+'''
				'

		
	SET @StrUpdateCostRevenue='
				
				
				SET @DblLocCalculatedCost=0
				SET @DblLocCalculatedPrice=0				
				SELECT @DblLocCalculatedCost=TotalCost,@DblLocCalculatedPrice=TotalRevenue  FROM SNC.TblCostRevenue_'+ltrim(rtrim(@POSCode))+' WHERE ReservationId='+ Convert(varchar(20),@ReservationId) +' AND ReservationDetailId='+ Convert(varchar(20),@DayId) +' AND Neumonic=''MENU''				
				UPDATE SNC.TblCostRevenue_'+ltrim(rtrim(@POSCode))+' SET TotalCost= Convert(float,'''+convert(varchar(20),isnull(@DblLocCalculatedCost,0))+'''),TotalRevenue= Convert(float,'''+convert(varchar(20),@DblLocCalculatedPrice)+'''),ModifiedBy ='''+convert(varchar(50),@User)+''', ModifiedOn = GETDATE() WHERE ReservationId='+ Convert(varchar(20),@ReservationId) +' AND ReservationDetailId='+ Convert(varchar(20),@DayId) +' AND Neumonic=''MENU''

				SET @DblLocCalculatedCost=0
				SET @DblLocCalculatedPrice=0
				SELECT @DblLocCalculatedCost=TotalCost,@DblLocCalculatedPrice=TotalRevenue  FROM SNC.TblCostRevenue_'+ltrim(rtrim(@POSCode))+' WHERE ReservationId='+ Convert(varchar(20),@ReservationId) +' AND ReservationDetailId='+ Convert(varchar(20),@DayId) +' AND Neumonic=''SERVICES''
				UPDATE SNC.TblCostRevenue_'+ltrim(rtrim(@POSCode))+' SET TotalCost= Convert(float,'''+convert(varchar(20),@DblLocCalculatedCost)+'''), TotalRevenue= Convert(float,'''+convert(varchar(20),@DblLocCalculatedPrice)+'''), ModifiedBy ='''+convert(varchar(50),@User)+''', ModifiedOn = GETDATE() WHERE ReservationId='+ Convert(varchar(20),@ReservationId) +' AND ReservationDetailId='+ Convert(varchar(20),@DayId) +' AND Neumonic=''SERVICES''
				'

	EXECUTE sp_executesql  @StrVoidPI
	EXECUTE sp_executesql  @StrUpdateCostRevenue
END
GO

IF EXISTS(SELECT * FROM sysobjects WHERE type='P' AND name='SprSNCResetPIGeneration')        
BEGIN
        DROP PROCEDURE SprSNCResetPIGeneration
END
Go
Create Procedure SprSNCResetPIGeneration
(
	@Guid Nvarchar(MAX),
	@POSCode Nvarchar(20),	
	@User varchar(4),
	@GroupId char(3),
	@ClientId char(3)
)
AS
BEGIN

	DECLARE @StrLocQuery nvarchar(max)
	SET @StrLocQuery=''
	SET @StrLocQuery =@StrLocQuery+'
				DELETE FROM SNC.TblChallanMenubanquetitemtemp_'+@POSCode+' WHERE Guid='''+@Guid+''' ;
				DELETE FROM SNC.TblChallanMenuItemtemp_'+@POSCode+' WHERE Guid='''+@Guid+''' ;
				DELETE FROM SNC.TblChallanMenuModifiertemp_'+@POSCode+' WHERE Guid='''+@Guid+''' ;
				DELETE FROM SNC.TblChallanMenuItemCostCentertemp_'+@POSCode+' WHERE Guid='''+@Guid+''' ;
				DELETE FROM SNC.TblChallanServicestemp_'+@POSCode+' WHERE Guid='''+@Guid+''' ;
				'

	EXECUTE sp_executesql  @StrLocQuery
END
GO
