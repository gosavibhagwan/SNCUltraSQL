IF EXISTS(SELECT * FROM sysobjects WHERE type='P' AND name='SprSNCGetSuppliersForService')        
BEGIN
        DROP PROCEDURE SprSNCGetSuppliersForService
END
Go
Create Procedure SprSNCGetSuppliersForService
(
	@ServiceCode varchar(20),
	@POSCode Nvarchar(20),
	@POSDate datetime,	
	@StrGroupId char(5),
	@StrClientId char(5)
)
AS
BEGIN		
	Select 		
		SM.SupplierCode,
		SRC.RateCode,
		TM.TitleDescription,
		SM.SupplierName,
		SRC.ServiceCode,
		SRC.SalesPrice,
		LTRIM(RTRIM(STR(CASE CONVERT(FLOAT,SRC.CostPrice) WHEN 0 THEN (SRC.SalesPrice * SRC.PercentageCostPrice / 100) ELSE SRC.CostPrice END,11,2))) AS CostRate, 
		SRC.Per1, 
		SRC.Per2, 
		LTRIM(RTRIM(CASE CONVERT(FLOAT,SRC.CostPrice) WHEN 0 THEN 'P' ELSE 'A' END)) AS CostType, 
		LTRIM(RTRIM(STR(CASE CONVERT(FLOAT,SRC.CostPrice) WHEN 0 THEN SRC.PercentageCostPrice ELSE 0 END,11,2))) AS CostPer
	FROM [SNC].[TblSupplierMaster] SM
		 inner join [SNC].[TblSupplierRateContract] SRC on SM.SupplierCode=SRC.SupplierCode
		 inner Join [SNC].[TblTitleMaster] TM on TM.TitleCode=SM.TitleCode
	WHERE SRC.ServiceCode=@ServiceCode
	and (SRC.Frmdate <= convert(datetime,@POSDate) and (SRC.ToDate >=  convert(datetime,@POSDate) OR SRC.ToDate =  cast('12/31/9999' as datetime)) )
	
END
GO

IF EXISTS(SELECT * FROM sysobjects WHERE type='P' AND name='SprSNCGetServiceDetailsForTrans')        
BEGIN
        DROP PROCEDURE SprSNCGetServiceDetailsForTrans
END
Go
Create Procedure SprSNCGetServiceDetailsForTrans
(
	@ServiceCode varchar(20),
	@POSCode Nvarchar(20),
	@POSDate datetime,	
	@StrGroupId char(5),
	@StrClientId char(5)
)
AS
BEGIN		
			Declare @StrLocFunDayOfWeek varchar(3) 
			Select @StrLocFunDayOfWeek = CASE DATEPART(dw,@POSDate) WHEN 1 THEN 'SUN' WHEN 2 THEN 'MON' WHEN 3 THEN 'TUE' WHEN 4 THEN 'WED' WHEN 5 THEN 'THR' WHEN 6 THEN 'FRI' WHEN 7 THEN 'SAT' END 
			

	Exec('SELECT top(1) 
		PM.[MenuItemCode] as ServiceCode,
		PM.[MenuItemDescription] as ServiceDescription,
		PM.RateCode as ServiceRateId,  
		PM.'+@StrLocFunDayOfWeek+' as ShowRate, 
		PM.Per1, 
		PM.Per2, 
		LTRIM(RTRIM(STR(CASE CONVERT(FLOAT,PM.FixedCost) WHEN 0 THEN (PM.'+@StrLocFunDayOfWeek+' * PM.CostInPer / 100) ELSE PM.FixedCost END,11,2))) AS CostRate, 
		LTRIM(RTRIM(CASE CONVERT(FLOAT,PM.FixedCost) WHEN 0 THEN ''P'' ELSE ''A'' END)) AS CostType, 
		LTRIM(RTRIM(STR(CASE CONVERT(FLOAT,PM.FixedCost) WHEN 0 THEN PM.CostInPer ELSE 0 END,11,2))) AS CostPer  
	FROM [TblRateMst] PM
	Inner Join TblMenuItemMst MI on	MI.MenuItemCode=PM.MenuItemCode
	WHERE PM.POSCode = '''+@POSCode	+'''
		--and PM.GroupID='''+@StrGroupId+'''
		--and PM.ClientID = '''+@StrClientId+'''
		--and PM.Price = 3 
		And MI.ItemType=''S''
		and PM.MenuItemCode ='+@ServiceCode+'
		and (PM.FromDate <= convert(datetime,'''+@POSDate+''') and (PM.ToDate >=  convert(datetime,'''+@POSDate+''') OR PM.ToDate =  cast(''12/31/9999'' as datetime)) )
	order by PM.CreatedDate')

	Select 		
		SM.SupplierCode,
		SRC.RateCode,
		TM.TitleDescription,
		SM.SupplierName,
		SRC.ServiceCode,
		SRC.SalesPrice,
		LTRIM(RTRIM(STR(CASE CONVERT(FLOAT,SRC.CostPrice) WHEN 0 THEN (SRC.SalesPrice * SRC.PercentageCostPrice / 100) ELSE SRC.CostPrice END,11,2))) AS CostRate, 
		SRC.Per1, 
		SRC.Per2, 
		LTRIM(RTRIM(CASE CONVERT(FLOAT,SRC.CostPrice) WHEN 0 THEN 'P' ELSE 'A' END)) AS CostType, 
		LTRIM(RTRIM(STR(CASE CONVERT(FLOAT,SRC.CostPrice) WHEN 0 THEN SRC.PercentageCostPrice ELSE 0 END,11,2))) AS CostPer
	FROM [SNC].[TblSupplierMaster] SM
		 inner join [SNC].[TblSupplierRateContract] SRC on SM.SupplierCode=SRC.SupplierCode
		 inner Join [SNC].[TblTitleMaster] TM on TM.TitleCode=SM.TitleCode
	WHERE SRC.ServiceCode=@ServiceCode
	and (SRC.Frmdate <= convert(datetime,@POSDate) and (SRC.ToDate >=  convert(datetime,@POSDate) OR SRC.ToDate =  cast('12/31/9999' as datetime)) )
	
END
GO

IF EXISTS(SELECT * FROM sysobjects WHERE type='P' AND name='SprSNCGetServiceDetailsByReservationId')        
BEGIN
        DROP PROCEDURE SprSNCGetServiceDetailsByReservationId
END
Go
Create Procedure SprSNCGetServiceDetailsByReservationId
(
	@ReservationId int,
	@DayId INT,
	@POSCode Nvarchar(20),
	@IsPI int,
	@Guid nvarchar(max),
	@ProformaInvoiceNo Nvarchar(20),
	@StrGroupId char(5),
	@StrClientId char(5)
)
AS
BEGIN
	DECLARE @StrQueryService Nvarchar(MAX)
	DECLARE @StrQueryDayTotal Nvarchar(MAX)
	DECLARE @StrQueryReservationTotal Nvarchar(MAX)
	Declare @ServiceCount Int

	
	IF (@IsPI=0)
	BEGIN

		SET @StrQueryService='			
					Select 
						S.ServiceID,
						MI.MenuItemDescription as Description,
						S.Quantity,
						S.PerUnitRate,
						S.CalcualtedRate,
						MI.IncomeHeadCode,						
						S.CalcualtedCost,						
						S.PerUnitChargableType1,
						S.PerUnitChargableType2,
						S.IsDisplay,
						S.IsChargable,
						S.ServiceRateId,
						s.SupplierRateCode,
						S.CostType,
						S.CostPer,
						S.PerUnitCost
					From 
						SNC.TblServices_'+ltrim(rtrim(@POSCode))+' S 
							left Outer JOIn TblMenuItemMst MI On  MI.MenuItemCode=S.ServiceId
					Where 
							S.ReservationId='+ convert(varchar(50),@ReservationId) +'
						And S.DayId='+ convert(varchar(50),@DayId) +'
					'
	END
	ELSE IF (@IsPI=1)
	BEGIN
		SET @StrQueryService='			
					Select 
						S.ServiceID,
						MI.MenuItemDescription as Description,
						S.Quantity,
						S.PerUnitRate,
						S.CalcualtedRate,
						MI.IncomeHeadCode,						
						S.CalcualtedCost,						
						S.PerUnitChargableType1,
						S.PerUnitChargableType2,
						S.IsDisplay,
						S.IsChargable,
						S.ServiceRateId,
						s.SupplierRateCode,
						S.CostType,
						S.CostPer,
						S.PerUnitCost
					From 
						SNC.TblChallanServices_'+ltrim(rtrim(@POSCode))+' S 
							left Outer JOIn TblMenuItemMst MI On  MI.MenuItemCode=S.ServiceId
					Where 
							S.ReservationId='+ convert(varchar(50),@ReservationId) +'
						And S.DayId='+ convert(varchar(50),@DayId) +'
						And S.ProformaInvoiceId='''+ convert(varchar(max),@ProformaInvoiceNo) +'''
						
					'
	END
	ELSE IF (@IsPI=2)
	BEGIN
		SET @StrQueryService='			
					Select 
						S.ServiceID,
						MI.MenuItemDescription as Description,
						S.Quantity,
						S.PerUnitRate,
						S.CalcualtedRate,
						MI.IncomeHeadCode,						
						S.CalcualtedCost,						
						S.PerUnitChargableType1,
						S.PerUnitChargableType2,
						S.IsDisplay,
						S.IsChargable,
						S.ServiceRateId,
						s.SupplierRateCode,
						S.CostType,
						S.CostPer,
						S.PerUnitCost
					From 
						SNC.TblChallanServicesTemp_'+ltrim(rtrim(@POSCode))+' S 
							left Outer JOIn TblMenuItemMst MI On  MI.MenuItemCode=S.ServiceId
					Where 
							S.ReservationId='+ convert(varchar(50),@ReservationId) +'
						And S.DayId='+ convert(varchar(50),@DayId) +'
						And S.Guid='''+ @Guid +'''
					'
	END
	
	SET @StrQueryDayTotal='
					Select 
						isnull(SUM(TotalRevenue),0) as DayTotal 
					From 
						SNC.TblCostRevenue_'+ltrim(rtrim(@POSCode))+'  
					Where 
							ReservationId='+ convert(varchar(50),@ReservationId) +'
						and ReservationDetailId='+ convert(varchar(50),@DayId) +'
						'
	SET @StrQueryReservationTotal='
					Select 
						isnull(SUM(TotalRevenue),0) as ReservationTotal 
					From 
						SNC.TblCostRevenue_'+ltrim(rtrim(@POSCode))+'  
					Where 
						ReservationId='+ convert(varchar(50),@ReservationId) +'
				'





	Exec	Sp_ExecuteSQL @StrQueryService
	Exec	Sp_ExecuteSQL @StrQueryDayTotal
	Exec	Sp_ExecuteSQL @StrQueryReservationTotal
	print(@StrQueryService)
END
GO

IF EXISTS(SELECT * FROM sysobjects WHERE type='P' AND name='SprSNCGetAllServices')        
BEGIN
        DROP PROCEDURE SprSNCGetAllServices
END
Go
Create PROCEDURE SprSNCGetAllServices
(	
	@IsPriced int,
	@POSCode Nvarchar(20),	
	@POSDate datetime,	
	@GroupId Nvarchar(20),
	@ClientId Nvarchar(20)
	
)
AS
BEGIN
	
	If(@IsPriced=1)
	BEGIN
		Select distinct MI.MenuItemCode As ServiceCode,MI.MenuItemDescription as ServiceDescription--,RM.POSCode,RM.RateCode,RM.Sun,RM.FromDate,RM.ToDate,RM.[TypeCode]
		From TblMenuItemMst MI 
		Inner join TblRateMst RM on RM.MenuItemCode=MI.MenuItemCode
		inner join TblPOSMst PM on RM.POSCode=PM.POSCode
		Where MI.ItemType='s' 
			and RM.POSCode=@POSCode
			and ((PM.POSDate between RM.FromDate and RM.ToDate ) OR (RM.ToDate = '12/31/9999')) 
	END
	ELSE
	BEGIN
		Select MI.MenuItemCode As ServiceCode,MI.MenuItemDescription as ServiceDescription
		From TblMenuItemMst MI 		
		Where MI.ItemType='s' 			
	END
END
GO


IF EXISTS(SELECT * FROM sysobjects WHERE type='P' AND name='SpSNCrDeleteServiceTran')        
BEGIN
        DROP PROCEDURE SpSNCrDeleteServiceTran
END
Go
Create PROCEDURE SpSNCrDeleteServiceTran
( 
	@POSCode Varchar(10),  
	@ReservationId Varchar(10),  
	@DayId varchar(3),  
	@ProformaId Varchar(10),  
	@IsProforma varchar(5) ,
	@Guid nvarchar(MAX)   
)
AS
Begin  
	Declare @SQLStringfinal varchar(8000)  
	if @IsProforma = 'N'  
	   Begin   
		  set @SQLStringfinal = 'DELETE FROM SNC.TblServices_'+ (rtrim(ltrim(cast(@POSCode as varchar(10))))) +' WHERE SNC.TblServices_'+ (rtrim(ltrim(cast(@POSCode as varchar(10))))) +'.ReservationId = ''' + (rtrim(ltrim(cast(@ReservationId as varchar(10))))) + ''' AND SNC.TblServices_'+ (rtrim(ltrim(cast(@POSCode as varchar(10))))) +'.DayId =''' + (rtrim(ltrim(cast(@DayId as varchar(10))))) + ''''  
	   end  
	else if @IsProforma = 'Y'  
	   Begin  
		  set @SQLStringfinal = 'DELETE FROM SNC.TblChallanServices_'+ (rtrim(ltrim(cast(@POSCode as varchar(10))))) +' WHERE SNC.TblChallanServices_'+ (rtrim(ltrim(cast(@POSCode as varchar(10))))) +'.Proformainvoiceid = ''' + (rtrim(ltrim(cast(@ProformaId as varchar(10))))) + ''' AND SNC.TblChallanServices_'+ (rtrim(ltrim(cast(@POSCode as varchar(10))))) +'.ReservationId = ''' + (rtrim(ltrim(cast(@ReservationId as varchar(10))))) + ''' AND SNC.TblChallanServices_'+ (rtrim(ltrim(cast(@POSCode as varchar(10))))) +'.DayId = ''' + (rtrim(ltrim(cast(@DayId as varchar(10))))) + ''' AND SNC.TblChallanServices_'+ (rtrim(ltrim(cast(@POSCode as varchar(10))))) +'.ProformaInvoiceId = ''' + (rtrim(ltrim(cast(@ProformaId as varchar(10))))) + ''' '  
	   End 
	else if @IsProforma = 'T'  
	   Begin  
		  set @SQLStringfinal = 'DELETE FROM SNC.TblChallanServicesTemp_'+ (rtrim(ltrim(cast(@POSCode as varchar(10))))) +' WHERE SNC.TblChallanServicestemp_'+ (rtrim(ltrim(cast(@POSCode as varchar(10))))) +'.ReservationId = ''' + (rtrim(ltrim(cast(@ReservationId as varchar(10))))) + ''' AND SNC.TblChallanServicestemp_'+ (rtrim(ltrim(cast(@POSCode as varchar(10))))) +'.DayId = ''' + (rtrim(ltrim(cast(@DayId as varchar(10))))) + ''' AND SNC.TblChallanServicestemp_'+ (rtrim(ltrim(cast(@POSCode as varchar(10))))) +'.Guid = '''+@Guid+''''  
	   End  

	exec(@SQLStringfinal)  

End
GO

IF EXISTS(SELECT * FROM sysobjects WHERE type='P' AND name='SprSNCInsertServiceTran')        
BEGIN
        DROP PROCEDURE SprSNCInsertServiceTran
END
Go
Create PROCEDURE SprSNCInsertServiceTran
(
	@POSCode VARCHAR(10),
	@ReservationId VARCHAR(24),
	@ReservationDetailId  VARCHAR(3),
	@DayId VARCHAR(3),
	@ProformaInvoiceId varchar(20),
	@ServiceID VARCHAR(24),
	@Quantity INT,
	@IsChargable BIT,
	@PerUnitRate MONEY,
	@PerUnitChargableType1 VARCHAR(24),
	@PerUnitChargableType2 VARCHAR(24),
	@CalcualtedRate MONEY,
	@CalcualtedCost MONEY,
	@ServiceRateId VARCHAR(24),
	@SupplierRateCode VARCHAR(24),	
	@PerUnitCost MONEY,
	@IsDisplay BIT,
	@CostType VARCHAR(5),
	@CostPer MONEY,
	@AmdCode INT,
	@CreatedBy  VARCHAR(24),	
	@IsProforma VARCHAR(5),
	@Guid nvarchar(MAX)
)
AS
DECLARE @SQLStringfinal VARCHAR(8000)
BEGIN
		IF  @IsProforma = 'N'
			BEGIN
				SET @SQLStringfinal = 'INSERT INTO [SNC].[TblServices_'+ (RTRIM(LTRIM(CAST(@POSCode AS VARCHAR(10))))) +'] ([ReservationId],[DayId] ,[ServiceID] ,[Quantity] ,[IsChargable] ,[PerUnitRate] ,[PerUnitChargableType1] ,[PerUnitChargableType2] ,[CalcualtedRate] ,[CalcualtedCost] ,[ServiceRateId] ,[SupplierRateCode] , [PerUnitCost], [IsDisplay], [CostType], [CostPer], [AmdCode], [CreatedBy]) VALUES '
				SET @SQLStringfinal = @SQLStringfinal + '('''+ @ReservationId +''' ,''' + @DayId + ''' ,''' + @ServiceID + ''' ,' + RTRIM(LTRIM(CAST(@Quantity AS VARCHAR(10)))) + ',' + RTRIM(LTRIM(CAST(@IsChargable AS VARCHAR(1)))) + ' ,' + RTRIM(LTRIM(CAST(@PerUnitRate AS VARCHAR(20)))) + ' ,''' + @PerUnitChargableType1 + ''' ,'''+ @PerUnitChargableType2 + ''' ,' + RTRIM(LTRIM(CAST(@CalcualtedRate AS VARCHAR(20)))) + ' ,' + RTRIM(LTRIM(CAST(@CalcualtedCost AS VARCHAR(20)))) + ' ,''' + @ServiceRateId + ''',''' + @SupplierRateCode + ''',' + RTRIM(LTRIM(CAST(@PerUnitCost AS VARCHAR(20)))) + ',' + RTRIM(LTRIM(CAST(@IsDisplay AS VARCHAR(10)))) + ',''' + RTRIM(LTRIM(CAST(@CostType AS VARCHAR(10)))) + ''',' + RTRIM(LTRIM(CAST(@CostPer AS VARCHAR(10)))) + ',' + RTRIM(LTRIM(CAST(@AmdCode AS VARCHAR(10)))) + ',''' + @CreatedBy + ''')'
			end
		ELSE IF  @IsProforma = 'Y'
			BEGIN
				SET @SQLStringfinal = 'INSERT INTO [SNC].[TblChallanServices_'+ (RTRIM(LTRIM(CAST(@POSCode AS VARCHAR(10))))) +'] ([ReservationId] ,[DayId],[ProformaInvoiceId] ,[ServiceID] ,[Quantity] ,[IsChargable] ,[PerUnitRate] ,[PerUnitChargableType1] ,[PerUnitChargableType2] ,[CalcualtedRate] ,[CalcualtedCost] ,[ServiceRateId] ,[SupplierRateCode] , [PerUnitCost], [IsDisplay], [CostType], [CostPer], [AmdCode], [CreatedBy]) VALUES '
				SET @SQLStringfinal = @SQLStringfinal + '('''+ @ReservationId +''' ,''' + @DayId + ''','''+ @ProformaInvoiceId +''' ,''' + @ServiceID + ''' ,' + RTRIM(LTRIM(CAST(@Quantity AS VARCHAR(10)))) + ',' + RTRIM(LTRIM(CAST(@IsChargable AS VARCHAR(1)))) + ' ,' + RTRIM(LTRIM(CAST(@PerUnitRate AS VARCHAR(20)))) + ' ,''' + @PerUnitChargableType1 + ''' ,'''+ @PerUnitChargableType2 + ''' ,' + RTRIM(LTRIM(CAST(@CalcualtedRate AS VARCHAR(20)))) + ' ,' + RTRIM(LTRIM(CAST(@CalcualtedCost AS VARCHAR(20)))) + ' ,''' + @ServiceRateId + ''',''' + @SupplierRateCode + ''',' + RTRIM(LTRIM(CAST(@PerUnitCost AS VARCHAR(20)))) + ',' + RTRIM(LTRIM(CAST(@IsDisplay AS VARCHAR(10)))) + ',''' + RTRIM(LTRIM(CAST(@CostType AS VARCHAR(10)))) + ''',' + RTRIM(LTRIM(CAST(@CostPer AS VARCHAR(10)))) + ',' + RTRIM(LTRIM(CAST(@AmdCode AS VARCHAR(10)))) + ',''' + @CreatedBy + ''')'
			end  
		ELSE IF  @IsProforma = 'T'
			BEGIN
				SET @SQLStringfinal = 'INSERT INTO [SNC].[TblChallanServicesTemp_'+ (RTRIM(LTRIM(CAST(@POSCode AS VARCHAR(10))))) +'] ([ReservationId] ,[DayId] ,[ProformaInvoiceId],[ServiceID] ,[Quantity] ,[IsChargable] ,[PerUnitRate] ,[PerUnitChargableType1] ,[PerUnitChargableType2] ,[CalcualtedRate] ,[CalcualtedCost] ,[ServiceRateId] ,[SupplierRateCode] , [PerUnitCost], [IsDisplay], [CostType], [CostPer], [AmdCode], [CreatedBy],Guid) VALUES '
				SET @SQLStringfinal = @SQLStringfinal + '('''+ @ReservationId +''' ,''' + @DayId + ''','''+ @ProformaInvoiceId +'''  ,''' + @ServiceID + ''' ,' + RTRIM(LTRIM(CAST(@Quantity AS VARCHAR(10)))) + ',' + RTRIM(LTRIM(CAST(@IsChargable AS VARCHAR(1)))) + ' ,' + RTRIM(LTRIM(CAST(@PerUnitRate AS VARCHAR(20)))) + ' ,''' + @PerUnitChargableType1 + ''' ,'''+ @PerUnitChargableType2 + ''' ,' + RTRIM(LTRIM(CAST(@CalcualtedRate AS VARCHAR(20)))) + ' ,' + RTRIM(LTRIM(CAST(@CalcualtedCost AS VARCHAR(20)))) + ' ,''' + @ServiceRateId + ''',''' + @SupplierRateCode + ''',' + RTRIM(LTRIM(CAST(@PerUnitCost AS VARCHAR(20)))) + ',' + RTRIM(LTRIM(CAST(@IsDisplay AS VARCHAR(10)))) + ',''' + RTRIM(LTRIM(CAST(@CostType AS VARCHAR(10)))) + ''',' + RTRIM(LTRIM(CAST(@CostPer AS VARCHAR(10)))) + ',' + RTRIM(LTRIM(CAST(@AmdCode AS VARCHAR(10)))) + ',''' + @CreatedBy + ''','''+@Guid+''')'
			end  
	EXEC (@SQLStringfinal)
	PRINT(@SQLStringfinal)
END
GO 

IF EXISTS(SELECT * FROM sysobjects WHERE type='P' AND name='SprSNCInsertMenuServiceOrder')        
BEGIN
        DROP PROCEDURE SprSNCInsertMenuServiceOrder
END
Go
Create procedure SprSNCInsertMenuServiceOrder
(
	@ReservationId varchar(24),
	@DayId varchar(3),
	@UpdatedFrom varchar(3),
	@BanquetItemId varchar(100),
	@CreatedBy varchar(100),
	@MenuHeadId varchar(50),
	@MenuItemId varchar(100),
	@ServiceID varchar(100),
	@POSCode Varchar(10)
)
as
Begin
	Declare @SQLStringfinal varchar(8000)  
	DECLARE @TempTableOrder AS TABLE (CountRow INT)
	Declare @count int 
	set @count=0
	declare @MenuServiceOrder Nvarchar(50) 
	set @SQLStringfinal='select ISNULL(max (MenuServiceOrder),0)+1 as CountRow from  SNC.TblMenuServiceOrder_'+@POSCode+' where ReservationId='''+@ReservationId+''''
	INSERT INTO @TempTableOrder Exec(@SQLStringfinal)
	select @MenuServiceOrder =CountRow from @TempTableOrder

	if @UpdatedFrom='MF' or @UpdatedFrom='PI'
	Begin

	if @BanquetItemId!='A1LC' and @UpdatedFrom<>'SF' and @UpdatedFrom<>'SPI'
	begin

	DECLARE @TempTable AS TABLE (CountRow INT)
	set @count=0
	set @SQLStringfinal='select count(*) as CountRow from SNC.TblMenuServiceOrder_'+@POSCode+' where ReservationId='''+@ReservationId+''' and DayId='''+@DayId+''' and BanquetItemId='''+@BanquetItemId+''''
	print @SQLStringfinal
	INSERT INTO @TempTable Exec(@SQLStringfinal)

	 select @count =CountRow from @TempTable
	 if @count=0
	 begin

	set @SQLStringfinal='INSERT INTO SNC.TblMenuServiceOrder_'+@POSCode+' (ReservationId, DayId,UpdatedFrom, BanquetItemId, MenuServiceOrder, CreatedBy,MenuHeadId,ALACARTE,ServiceID) 
	   values ('''+@ReservationId+''','''+@DayId+''','''+@UpdatedFrom+''','''+@BanquetItemId+''','''+@MenuServiceOrder+''','''+@CreatedBy+''','''+@MenuHeadId+''','''+@MenuItemId+''','''+@ServiceID+''')'
		Exec(@SQLStringfinal)
	end
	end
	-------------------------------------------------------------------------------------------------
	else if @BanquetItemId='A1LC'
	begin
	DECLARE @TempTableAlacate AS TABLE (CountRow INT)
	set @count=0

	set @SQLStringfinal='select count (*) as CountRow from SNC.TblMenuServiceOrder_'+@POSCode+' where ReservationId='''+@ReservationId+''' and DayId='''+@DayId+''' and ALACARTE='''+@MenuItemId+''' and BanquetItemId = ''A1LC'''
	INSERT INTO @TempTableAlacate Exec(@SQLStringfinal)
	 select @count =CountRow from @TempTableAlacate
	 if @count=0

	set @SQLStringfinal='INSERT INTO SNC.TblMenuServiceOrder_'+@POSCode+' (ReservationId, DayId,UpdatedFrom, BanquetItemId,MenuServiceOrder, CreatedBy,MenuHeadId,ALACARTE,ServiceID) 
	   values ('''+@ReservationId+''','''+@DayId+''','''+@UpdatedFrom+''','''+@BanquetItemId+''','''+@MenuServiceOrder+''','''+@CreatedBy+''','''+@MenuHeadId+''','''+@MenuItemId+''','''+@ServiceID+''')'
	  Exec(@SQLStringfinal)
	end
	end
	----------------------------------------------------------------------------------

	Else if @UpdatedFrom='SF' or @UpdatedFrom='SPI'
	Begin

	DECLARE @TempTableservices AS TABLE (CountRow INT)
	set @count=0

	set @SQLStringfinal='select count(*) as CountRow from SNC.TblMenuServiceOrder_'+@POSCode+' where ReservationId='''+@ReservationId+''' and DayId='''+@DayId+''' and ServiceID='''+@ServiceID+''''
	INSERT INTO @TempTableservices Exec(@SQLStringfinal)

	 select @count =CountRow from @TempTableservices
	 if @count=0
	begin
	set @SQLStringfinal='INSERT INTO SNC.TblMenuServiceOrder_'+@POSCode+' (ReservationId, DayId,UpdatedFrom, BanquetItemId,MenuServiceOrder, CreatedBy,MenuHeadId,ALACARTE,ServiceID) 
	   values ('''+ @ReservationId +''','''+@DayId+''','''+@UpdatedFrom+''','''+@BanquetItemId+''','''+@MenuServiceOrder+''','''+@CreatedBy+''','''+@MenuHeadId+''','''+@MenuItemId+''','''+@ServiceID+''')'
		Exec(@SQLStringfinal)
   

	end
	end
End
GO

IF EXISTS(SELECT * FROM sysobjects WHERE type='P' AND name='SprSNCUpdateFPAmdNo')        
BEGIN
        DROP PROCEDURE SprSNCUpdateFPAmdNo
END
Go
Create PROCEDURE SprSNCUpdateFPAmdNo
(
	@POSCode VARCHAR(5),
	@ReservationId INT,
	@DayId VARCHAR(5)
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @QueryUpdateAmdNo VARCHAR(1000);
	DECLARE @TblAmdNo TABLE(AmdNo INT DEFAULT(0), FPNo INT DEFAULT(0));
	DECLARE @TblMenuAmdNo TABLE(AmdNo  VARCHAR(20) DEFAULT('NA'));
	DECLARE @TblServiceAmdNo TABLE(AmdNo  VARCHAR(20) DEFAULT('NA'));
	DECLARE @AmdNo INT;
	DECLARE @MenuAmdNo VARCHAR(20);
	DECLARE @ServiceAmdNo VARCHAR(20);
	DECLARE @FPNo INT;
	DECLARE @SQLQuery VARCHAR(1000);
	DECLARE @MenuSQLQuery VARCHAR(1000);
	DECLARE @ServiceSQLQuery VARCHAR(1000);	
	DECLARE @InsertSQLQuery VARCHAR(1000);	
	SET @SQLQuery = 'SELECT AmdNo, FPNo FROM SNC.TblProvisionalFP_' + @POSCode + ' WHERE ReservationId=' + CONVERT(VARCHAR(50),@ReservationId) + ' AND DayId=' + CONVERT(VARCHAR(20),@DayId) + ' AND FPNo <> 0'
	INSERT INTO @TblAmdNo EXEC (@SQLQuery)
	IF EXISTS (SELECT * FROM @TblAmdNo)
	BEGIN
		SELECT @FPNo = FPNo FROM @TblAmdNo
		SELECT @AmdNo = (AmdNo + 1) FROM @TblAmdNo
		SET @QueryUpdateAmdNo='UPDATE SNC.TblProvisionalFP_Amd_' + @POSCode + ' SET AmdNo='+ CONVERT(VARCHAR(50),@AmdNo) + ' WHERE ReservationId='+ CONVERT(VARCHAR(50),@ReservationId) +' AND DayId=''' + CONVERT(VARCHAR(20),@DayId) + ''''
		EXEC (@QueryUpdateAmdNo)

		SET @MenuSQLQuery = 'SELECT ISNULL(CONVERT(VARCHAR(10),MAX(AmdCode)),''NA'') AS MenuAmdCode FROM SNC.TblMenuItem_' + @POSCode + ' WHERE ReservationId=' + CONVERT(VARCHAR(50),@ReservationId) + ' AND DayId=''' + CONVERT(VARCHAR(20),@DayId) + ''''
		INSERT INTO @TblMenuAmdNo EXEC (@MenuSQLQuery)
		SELECT @MenuAmdNo = AmdNo FROM @TblMenuAmdNo
		
		SET @ServiceSQLQuery = 'SELECT ISNULL(CONVERT(VARCHAR(10),MAX(AmdCode)),''NA'') AS ServiceAmdCode FROM SNC.TblServices_' + @POSCode + ' WHERE ReservationId=' + CONVERT(VARCHAR(50),@ReservationId) + ' AND DayId=''' + CONVERT(VARCHAR(20),@DayId) + ''''
		INSERT INTO @TblServiceAmdNo EXEC (@ServiceSQLQuery)
		SELECT @ServiceAmdNo = AmdNo FROM @TblServiceAmdNo
		SET @InsertSQLQuery = 'INSERT INTO [SNC].[TblProvisionalFP_Amd_' + @POSCode + ']  (FPNo,AmdNo,ReservationId,DayId,MenuAmdCode,ServiceAmdCode,CreatedBy,CreatedDate) VALUES (' + CONVERT(VARCHAR(50),@FPNo) + ', ' + CONVERT(VARCHAR(50),@AmdNo) + ', ' + CONVERT(VARCHAR(50),@ReservationId) + ', ''' + @DayId + ''', ''' + @MenuAmdNo + ''',''' + @ServiceAmdNo + ''', ''0'', GETDATE())'
		EXEC (@InsertSQLQuery)
	END		
END
GO

IF EXISTS(SELECT * FROM sysobjects WHERE type='P' AND name='SprSNCSaveServicesForReservation')        
BEGIN
        DROP PROCEDURE SprSNCSaveServicesForReservation
END
Go
Create Procedure SprSNCSaveServicesForReservation
(  
 @xmlReservationDetails varchar(MAX),  
 @xmlServicesDetails varchar(MAX),  
 @IsPI int,  
 @StrLocProformaInvNo nvarchar(MAX),  
 @Guid nvarchar(Max)  
)  
AS  
BEGIN  
  DECLARE @xmlHandle INT  
   
  Create Table #TblReservationDetails   
  (  
    [ReservationDetailId] [int]   
   ,[ReservationId] [int]      
   ,[AreaCode] [int]   
   ,[Date] [datetime]  
   ,[FromDate] [datetime]  
   ,[ToDate] [datetime]  
   ,[FromTime] [varchar] (10)  
   ,[ToTime] [varchar] (10)  
   ,[ResvTimeInHours] [int]   
   ,[IsThrooBooking] [bit]  
   ,[GuaranteedPax] [int]  
   ,[MaximumPax] [int]  
   ,[SubFunctionCode] [int]  
   ,[Status] [int]   
   ,[OtherDetail] [varchar] (150)    
  )  
  
  
  Create Table #TblServiceDetails   
  (  
    [ID] int  
   ,[ReservationId] int  
   ,[DayId] int  
   ,[ProformaInvoiceId] [varchar] (20)  
   ,[ServiceID] [varchar](24)  
   ,[Quantity] [int]  
   ,[PerUnitRate] [decimal](38,2)   
   ,[PerUnitCost] [decimal](38,2)   
   ,[IsChargable] [bit]   
   ,[IsDisplay] [bit]  
   ,[PerUnitChargableType1] [int]   
   ,[PerUnitChargableType2] [int]   
   ,[CostType] [varchar](5)   
   ,[CostPer]  [decimal](38,2)   
   ,[SupplierRateCode] [varchar](24)  
   ,[ServiceRateId] [varchar](24)  
   ,[CalcualtedRate] [decimal](38,2)  
   ,[CalcualtedCost] [decimal](38,2)  
   ,[AmdCode] [int]  
   ,[User] [varchar](4)  
   ,[GroupID] [char](3)  
   ,[ClientID] [char](3)  
   ,[PosCode] [Nvarchar](20)  
  )  
  
  EXEC sp_xml_preparedocument @xmlHandle output, @XmlReservationDetails    
     INSERT INTO #TblReservationDetails  
     SELECT [ReservationDetailId],[ReservationId],[AreaCode],[Date],[FromDate],[ToDate],[FromTime],[ToTime],[ResvTimeInHours],  
      [IsThrooBooking],[GuaranteedPax],[MaximumPax],[SubFunctionCode],[Status],[OtherDetail]  
     FROM  OPENXML (@xmlHandle, 'NewDataSet/DataTable',1)  
        WITH (   
          [ReservationDetailId] [int] '@IntPubReservationDayId',  
          [ReservationId] [int]'@IntPubReservationId',          
          [AreaCode] [int] '@IntPubAreaCode',  
          [Date] [datetime] '@StrPubDate',  
          [FromDate] [datetime] '@StrPubFromDate',  
          [ToDate] [datetime] '@StrPubToDate',  
          [FromTime] [varchar] (10) '@StrPubFromTime',  
          [ToTime] [varchar] (10) '@StrPubToTime',  
          [ResvTimeInHours] [int] '@IntLocResvTimeInHours',  
          [IsThrooBooking] [bit] '@EnReservationType',  
          [GuaranteedPax] [int]'@IntPubMinPax',  
          [MaximumPax] [int] '@IntPubMaxPax',  
          [SubFunctionCode] [int] '@IntSubFunctionCode',         
          [Status] [int] '@EnReservationStatus',  
          [OtherDetail] [varchar] (150) '@StrPubOtherDetails'  
          )  
  EXEC sp_xml_removedocument @xmlHandle  
  
  EXEC sp_xml_preparedocument @xmlHandle output, @xmlServicesDetails    
     INSERT INTO #TblServiceDetails  
     SELECT [ID],[ReservationId],[DayId],[ProformaInvoiceId],[ServiceID],[Quantity],[PerUnitRate],[PerUnitCost],[IsChargable],[IsDisplay],[PerUnitChargableType1],[PerUnitChargableType2],  
      [CostType],[CostPer],[SupplierRateCode],[ServiceRateId],[CalcualtedRate],[CalcualtedCost],[AmdCode],[User] ,[GroupID],[ClientID],[PosCode]  
     FROM  OPENXML (@xmlHandle, 'NewDataSet/DataTable',1)  
        WITH ( [ID] [int] '@ID',  
          [ReservationId] [int] '@ReservationId',  
          [DayId] [int] '@DayId',  
          [ProformaInvoiceId] [varchar] (20) '@StrPubProformaInvoiceId',  
          [ServiceID] [varchar](24) '@IntPubCode',  
          [Quantity] [int] '@IntPubQuantity',          
          [PerUnitRate] [decimal](38,2) '@DecPubRate',  
          [PerUnitCost] [decimal](38,2) '@DecPubCost',  
          [IsChargable] [bit] '@BlnPubChargeable',  
          [IsDisplay] [bit] '@BlnPubDisplay',  
          [PerUnitChargableType1] [int] '@EnPubCharge1',  
          [PerUnitChargableType2] [int] '@EnPubCharge2',  
          [CostType] [varchar](5) '@EnCostType',  
          [CostPer]  [decimal](38,2) '@DecPubCostPer',  
          [SupplierRateCode] [varchar](24) '@IntPubSupplierRateCode',  
          [ServiceRateId] [varchar](24) '@IntPubServiceRateId',  
          [CalcualtedRate] [decimal](38,2) '@DecPubCalculatedRate',         
          [CalcualtedCost] [decimal](38,2) '@DecPubCalculatedCost',  
          [AmdCode] [int] '@AmdCode',  
          [User] [varchar](4) '@User',  
          [GroupID] [char](3)  '@GroupID',  
          [ClientID] [char](3) '@ClientID',  
          [PosCode] [Nvarchar](20) '@PosCode'  
          
          )  
  EXEC sp_xml_removedocument @xmlHandle  
  
  DECLARE @POSCode Nvarchar(20)  
  DECLARE @User varchar(4)  
  DECLARE @GroupId char(3)  
  DECLARE @ClientId char(3)  
  DECLARE @ReservationId INT  
  DECLARE @DayId varchar(20)   
  DECLARE @ProformaInvoiceId varchar(20)   
  DECLARE @UserCode int   ---added for MyAcitvity         
  DECLARE @TaskId varchar(3)  ---added for MyAcitvity 
  select @UserCode=UserCode From TblUser where UserShortName=@User; --- added for MyAcitvity 
  select top 1   
    @ReservationId=[ReservationId],  
    @DayId=[ReservationDetailId]   
  from #TblReservationDetails  
  Select top 1  
     @User=[User],  
     @GroupID=[GroupID],  
     @ClientID=[ClientID],  
     @PosCode=[PosCode]  
     --@ProformaInvoiceId =isnull([ProformaInvoiceId],0)  
  from #TblServiceDetails  
  
  SET @ProformaInvoiceId=@StrLocProformaInvNo  
    
  select * from #TblServiceDetails  
  DECLARE @IntPubCode INT  
  DECLARE @IntPubQuantity INT  
  DECLARE @BlnPubChargeable bit  
  DECLARE @DecPubRate decimal  
  DECLARE @EnPubCharge1 INT  
  DECLARE @EnPubCharge2 INT  
  DECLARE @DblLocCalculatedPrice Decimal  
  DECLARE @DblLocCalculatedCost Decimal  
  DECLARE @IntPubServiceRateId INT  
  DECLARE @IntPubSupplierRateCode INT   
  DECLARE @DecPubCost Decimal  
  DECLARE @BlnPubDisplay bit  
  DECLARE @EnCostType INT  
  DECLARE @DecPubCostPer Decimal  
  DECLARE @AmdCodeFinal nvarchar(10)  
  
  DECLARE @StrQueryPartialDelete nvarchar(max)    
  DECLARE @StrQueryPartialInsert nvarchar(max)  
  DECLARE @StrQueryPartialCostRev nvarchar(max)  
  DECLARE @StrQueryPartialFP nvarchar(max)  
  
  DECLARE @StrQueryPartialDeletePI nvarchar(max)  
  DECLARE @StrQueryPartialInsertPI nvarchar(max)  
  DECLARE @StrQueryPartialCostRevPI nvarchar(max)  
  DECLARE @StrQueryPartialFPPI nvarchar(max)  
  
  DECLARE @StrQueryPartialInsertPITemp nvarchar(max)  
  
  DECLARE @StrQueryDeleteTempData nvarchar(MAX)  
--=======================================================================For FP Service Start Here====================================================================================================   
  IF (@IsPI=0)  
  BEGIN  
    SET @StrQueryPartialDelete='Select 0'  
    exec(@StrQueryPartialDelete)  
    SET @StrQueryPartialDelete=''  
    SET @StrQueryPartialDelete='  
     INSERT INTO SNC.TblServicesAmd_'+ltrim(rtrim(@POSCode))+'  
     select * from SNC.TblServices_'+ltrim(rtrim(@POSCode))+' where [ReservationId]='+ convert(varchar(50),@ReservationId) +'  and [DayId]='+ Convert(varchar(20),@DayId) +'  
  
     DECLARE @AmdCode int  
     SELECT @AmdCode=isnull(max(Amdcode),-1) from SNC.TblServices_'+ltrim(rtrim(@POSCode))+' where  [ReservationId]='+ convert(varchar(50),@ReservationId) +'  and [DayId]='+ Convert(varchar(20),@DayId) +'  
     
     IF @AmdCode<0  
     BEGIN  
      SELECT @AmdCode=isnull(max(Amdcode),-1) from SNC.TblServicesAmd_'+ltrim(rtrim(@POSCode))+' where [ReservationId]='+ convert(varchar(50),@ReservationId) +'  and [DayId]='+ Convert(varchar(20),@DayId) +'  
      IF @AmdCode<0  
      BEGIN  
       SET @AmdCode=0  
      END  
      ELSE  
      BEGIN  
       SET @AmdCode=@AmdCode+2  
      END  
     END  
     ELSE  
     BEGIN  
      SET @AmdCode=@AmdCode+1  
     END  
       
     SET @AmdCodeFinal=@AmdCode  
     
  
     Exec SpSNCrDeleteServiceTran '''+ Convert(varchar(20),@POSCode) +''' ,'''+ convert(varchar(50),@ReservationId) +''','''+ Convert(varchar(20),@DayId) +''','''',''N'','''+@Guid+'''  
     
     delete from SNC.TblMenuServiceOrder_'+ltrim(rtrim(@POSCode))+'   
     where ReservationId='+ convert(varchar(50),@ReservationId) +'and DayId='+ Convert(varchar(20),@DayId) +' and UpdatedFrom=''SF'' and ServiceID not in (select TblServices.ServiceID from SNC.TblServices_'+ltrim(rtrim(@POSCode))+' as TblServices join SNC.TblMenuServiceOrder_'+ltrim(rtrim(@POSCode))+' as TblMenuServiceOrder on TblMenuServiceOrder.ReservationId =TblServices.ReservationId and TblMenuServiceOrder.DayId =TblServices.DayId and TblMenuServiceOrder.ServiceID= TblServices.ServiceID where TblServices.ReservationId='+ convert(varchar(50),@ReservationId) +' and TblServices.DayId='+ convert(varchar(50),@DayId) +' and TblMenuServiceOrder.UpdatedFrom=''SF'')     
       
     IF (SELECT COUNT(*) FROM SNC.TblCostRevenue_'+ltrim(rtrim(@POSCode))+' WHERE ReservationId='''+ convert(varchar(50),@ReservationId) +''' AND ReservationDetailId='''+ Convert(varchar(20),@DayId) +''' AND Neumonic=''SERVICES'' ) >0  
      BEGIN  
       UPDATE SNC.TblCostRevenue_'+ltrim(rtrim(@POSCode))+' SET TotalCost= 0, TotalRevenue= 0, ModifiedBy ='''+convert(varchar(50),@User)+''', ModifiedOn = GETDATE() WHERE ReservationId='+ Convert(varchar(20),@ReservationId) +' AND ReservationDetailId='+Convert(varchar(20),@DayId) +' AND Neumonic=''SERVICES''  
     END  
     
    '  
    --print (@StrQueryPartialDelete)  
    DECLARE @ParmDefinition nvarchar(500);  
    SET @ParmDefinition = ' @AmdCodeFinal nvarchar(10) OUTPUT';  
    EXECUTE sp_executesql  @StrQueryPartialDelete,@ParmDefinition,@AmdCodeFinal=@AmdCodeFinal OUTPUT  
    Select @AmdCodeFinal as a  
  
    DECLARE @MyCursor CURSOR;  
    DECLARE @MyField int;  
    BEGIN  
     SET @MyCursor = CURSOR FOR  
     select ID from #TblServiceDetails  
         
  
     OPEN @MyCursor   
     FETCH NEXT FROM @MyCursor   
     INTO @MyField  
  
   
  
     WHILE @@FETCH_STATUS = 0  
     BEGIN  
  
      Select         
       @IntPubCode=[ServiceID],  
       @IntPubQuantity=[Quantity],  
       @BlnPubChargeable=[IsChargable],  
       @DecPubRate=[PerUnitRate],  
       @EnPubCharge1=[PerUnitChargableType1],  
       @EnPubCharge2=[PerUnitChargableType2],  
       @DblLocCalculatedPrice=[CalcualtedRate],  
       @DblLocCalculatedCost=[CalcualtedCost],  
       @IntPubServiceRateId=[ServiceRateId],  
       @IntPubSupplierRateCode=[SupplierRateCode],  
       @DecPubCost=[PerUnitCost] ,  
       @BlnPubDisplay=[IsDisplay],  
       @EnCostType=[CostType],  
       @DecPubCostPer=[CostPer]       
       
      From #TblServiceDetails where ID=@MyField  
           
  
      SET @StrQueryPartialInsert=''  
      SET @StrQueryPartialInsert='  
        Exec SprSNCInsertServiceTran '''+ Convert(varchar(20),@POSCode) +''' ,'''+ convert(varchar(50),@ReservationId) +''','''+ Convert(varchar(20),@DayId) +''',
		'''+ Convert(varchar(20),@DayId) +''','''+ Convert(varchar(20),@ProformaInvoiceId) +''','+Convert(varchar(20),@IntPubCode)+','+convert(varchar(50),@IntPubQuantity)+',
		'+convert(varchar(50),@BlnPubChargeable)+','''+convert(varchar(50),@DecPubRate)+''','+convert(varchar(50),@EnPubCharge1)+','+convert(varchar(50),@EnPubCharge2)+',
		'''+convert(varchar(50),@DblLocCalculatedPrice)+''','''+convert(varchar(50),@DblLocCalculatedCost)+''','''+convert(varchar(50),@IntPubServiceRateId)+''',
		'''+convert(varchar(50),@IntPubSupplierRateCode)+''','''+convert(varchar(50),@DecPubCost)+''','+convert(varchar(50),@BlnPubDisplay)+',
		'''+convert(varchar(50),@EnCostType)+''','''+convert(varchar(50),@DecPubCostPer)+''',@AmdCodeFinal,'''+convert(varchar(50),@User)+''',''N'',''''  
        
        EXEC SprSNCInsertMenuServiceOrder '''+ convert(varchar(50),@ReservationId) +''','''+ Convert(varchar(20),@DayId) +''',''SF'','''','''+convert(varchar(50),@User)+''','''','''','+Convert(varchar(20),@IntPubCode)+','''+ Convert(varchar(20),@POSCode) +'''   
      
      '  
  
      SET @StrQueryPartialCostRev=''  
      set @StrQueryPartialCostRev='     
        IF (SELECT COUNT(*) FROM SNC.TblCostRevenue_'+ltrim(rtrim(@POSCode))+' WHERE ReservationId='''+ convert(varchar(50),@ReservationId) +''' AND ReservationDetailId='''+ Convert(varchar(20),@DayId) +''' AND Neumonic=''SERVICES'' ) >0  
        BEGIN  
         UPDATE SNC.TblCostRevenue_'+ltrim(rtrim(@POSCode))+' SET TotalCost= TotalCost+Convert(float,'''+convert(varchar(20),@DblLocCalculatedCost)+'''), TotalRevenue= TotalRevenue+Convert(float,'''+convert(varchar(20),@DblLocCalculatedPrice)+'''), ModifiedBy ='''+convert(varchar(50),@User)+''', ModifiedOn = GETDATE() WHERE ReservationId='+ Convert(varchar(20),@ReservationId) +' AND ReservationDetailId='+ Convert(varchar(20),@DayId) +' AND Neumonic=''SERVICES''  
        END  
        ELSE  
       
        BEGIN  
         INSERT INTO SNC.TblCostRevenue_'+ltrim(rtrim(@POSCode))+'(ReservationId, ReservationDetailId, Neumonic, TotalCost, TotalRevenue, UpdatedFrom, CreatedBy, CreatedOn, ModifiedBy, ModifiedOn)  
             VALUES ('''+ convert(varchar(50),@ReservationId) +''', '''+ convert(varchar(50),@DayId) +''', ''SERVICES'', Convert(float,'''+convert(varchar(20),@DblLocCalculatedCost)+'''), Convert(float,'''+convert(varchar(20),@DblLocCalculatedPrice)+'''),''SNC'', '''+convert(varchar(50),@User)+''', GETDATE(), '''+convert(varchar(50),@User)+''', GETDATE())  
        END  
        '  
  
      
    
  
      --Print (@StrQueryPartialDelete)    
      --Print (@StrQueryPartialInsert)  
      --print('AAA')  
      --Print (@StrQueryPartialCostRev)  
      --Print (@StrQueryPartialFP)  
  
      
      DECLARE @ParmDefinitionI nvarchar(500);  
      
    select @IntPubCode  
      IF isnull(@IntPubCode,0)>0  
      BEGIN   
      Print('BBB')    
       SET @ParmDefinitionI = ' @AmdCodeFinal nvarchar(10)';  
       EXECUTE sp_executesql  @StrQueryPartialInsert,@ParmDefinitionI,@AmdCodeFinal=@AmdCodeFinal  
      END  
    
      Exec (@StrQueryPartialCostRev)    
                 
            
    
   
     FETCH NEXT FROM @MyCursor   
     INTO @MyField   
  
     END;   
  
     CLOSE @MyCursor ;  
     DEALLOCATE @MyCursor;  
  
    END;   
    
       
    SET @StrQueryPartialFP=''  
      SET @StrQueryPartialFP='  
       SprSNCUpdateFPAmdNo '''+ Convert(varchar(20),@POSCode) +''' ,'''+ convert(varchar(50),@ReservationId) +''','''+ Convert(varchar(20),@DayId) +'''  
       delete from SNC.TblMenuServiceOrder_'+ltrim(rtrim(@POSCode))+'  where ReservationId='''+ convert(varchar(50),@ReservationId) +''' and DayId='''+ convert(varchar(50),@DayId) +''' and UpdatedFrom=''SF'' and ServiceID not in (select TblServices.ServiceID from SNC.TblServices_'+ltrim(rtrim(@POSCode))+' as TblServices join SNC.TblMenuServiceOrder_'+ltrim(rtrim(@POSCode))+' as TblMenuServiceOrder on TblMenuServiceOrder.ReservationId =TblServices.ReservationId and TblMenuServiceOrder.DayId =TblServices.DayId and TblMenuServiceOrder.ServiceID= TblServices.ServiceID where TblServices.ReservationId='+ convert(varchar(50),@ReservationId) +' and TblServices.DayId='+ convert(varchar(50),@DayId) +' and TblMenuServiceOrder.UpdatedFrom=''SF'' )  
      '  
       
    Exec(@StrQueryPartialFP)  
  END  
--=======================================================================For FP Service End Here====================================================================================================   
--=======================================================================For PI Service Start Here====================================================================================================   
  ELSE IF (@IsPI=1)  
  BEGIN  
    SET @StrQueryPartialDeletePI='Select 0'  
    exec(@StrQueryPartialDeletePI)  
    SET @StrQueryPartialDeletePI=''  
    SET @StrQueryPartialDeletePI='  
     INSERT INTO SNC.TblChallanServicesAmd_'+ltrim(rtrim(@POSCode))+'  
     select * from SNC.TblChallanServices_'+ltrim(rtrim(@POSCode))+' where [ReservationId]='+ convert(varchar(50),@ReservationId) +'  and [DayId]='+ Convert(varchar(20),@DayId) +' and ProformaInvoiceId= '''+ Convert(varchar(20),@ProformaInvoiceId) +'''  
  
     DECLARE @AmdCode int  
     SELECT @AmdCode=isnull(max(Amdcode),-1) from SNC.TblChallanServices_'+ltrim(rtrim(@POSCode))+' where  [ReservationId]='+ convert(varchar(50),@ReservationId) +'  and [DayId]='+Convert(varchar(20),@DayId) +' and ProformaInvoiceId= '''+ Convert(varchar(20),@ProformaInvoiceId) +'''       
     IF @AmdCode<0  
     BEGIN  
      SELECT @AmdCode=isnull(max(Amdcode),-1) from SNC.TblChallanServicesAmd_'+ltrim(rtrim(@POSCode))+' where [ReservationId]='+ convert(varchar(50),@ReservationId) +'  and [DayId]='+Convert(varchar(20),@DayId) +' and ProformaInvoiceId= '''+ Convert(varchar(20),@ProformaInvoiceId) +'''  
      IF @AmdCode<0  
      BEGIN  
       SET @AmdCode=0  
      END  
      ELSE  
      BEGIN  
       SET @AmdCode=@AmdCode+2  
      END  
     END  
     ELSE  
     BEGIN  
      SET @AmdCode=@AmdCode+1  
     END  
       
     SET @AmdCodeFinal=@AmdCode  
     
  
     Exec SpSNCrDeleteServiceTran '''+ Convert(varchar(20),@POSCode) +''' ,'''+ convert(varchar(50),@ReservationId) +''','''+ Convert(varchar(20),@DayId) +''','''+ Convert(varchar(20),@ProformaInvoiceId) +''',''Y'','''+@Guid+'''  
     
     delete from SNC.TblMenuServiceOrder_'+ltrim(rtrim(@POSCode))+' where ReservationId='+ convert(varchar(50),@ReservationId) +'and DayId='+ Convert(varchar(20),@DayId) +' and UpdatedFrom=''SPI'' and ServiceID not in (select TblServices.ServiceID from SNC.TblChallanServices_'+ltrim(rtrim(@POSCode))+' as TblServices join SNC.TblMenuServiceOrder_'+ltrim(rtrim(@POSCode))+' as TblMenuServiceOrder on TblMenuServiceOrder.ReservationId =TblServices.ReservationId and TblMenuServiceOrder.DayId =TblServices.DayId and TblMenuServiceOrder.ServiceID= TblServices.ServiceID where TblServices.ReservationId='+ convert(varchar(50),@ReservationId) +' and TblServices.DayId='+ convert(varchar(50),@DayId) +' and TblMenuServiceOrder.UpdatedFrom=''SPI'')     
       
     IF (SELECT COUNT(*) FROM SNC.TblCostRevenue_'+ltrim(rtrim(@POSCode))+' WHERE ReservationId='''+ convert(varchar(50),@ReservationId) +''' AND ReservationDetailId='''+ Convert(varchar(20),@DayId) +''' AND Neumonic=''SERVICES'' ) >0  
      BEGIN  
       UPDATE SNC.TblCostRevenue_'+ltrim(rtrim(@POSCode))+' SET TotalCost= 0, TotalRevenue= 0, ModifiedBy ='''+convert(varchar(50),@User)+''', ModifiedOn = GETDATE() WHERE ReservationId='+ Convert(varchar(20),@ReservationId) +' AND ReservationDetailId='+Convert(varchar(20),@DayId) +' AND Neumonic=''SERVICES''  
     END  
     
    '  
    print (@StrQueryPartialDeletePI)  
    DECLARE @ParmDefinitionPI nvarchar(500);  
    SET @ParmDefinitionPI = ' @AmdCodeFinal nvarchar(10) OUTPUT';  
    EXECUTE sp_executesql  @StrQueryPartialDeletePI,@ParmDefinitionPI,@AmdCodeFinal=@AmdCodeFinal OUTPUT  
    Select @AmdCodeFinal as a  
  
      
    BEGIN  
     SET @MyCursor = CURSOR FOR  
     select ID from #TblServiceDetails  
         
  
     OPEN @MyCursor   
     FETCH NEXT FROM @MyCursor   
     INTO @MyField  
  
   
  
     WHILE @@FETCH_STATUS = 0  
     BEGIN  
  
      Select         
       @IntPubCode=[ServiceID],  
       @IntPubQuantity=[Quantity],  
       @BlnPubChargeable=[IsChargable],  
       @DecPubRate=[PerUnitRate],  
       @EnPubCharge1=[PerUnitChargableType1],  
       @EnPubCharge2=[PerUnitChargableType2],  
       @DblLocCalculatedPrice=[CalcualtedRate],  
       @DblLocCalculatedCost=[CalcualtedCost],  
       @IntPubServiceRateId=[ServiceRateId],  
       @IntPubSupplierRateCode=[SupplierRateCode],  
       @DecPubCost=[PerUnitCost] ,  
       @BlnPubDisplay=[IsDisplay],  
       @EnCostType=[CostType],  
       @DecPubCostPer=[CostPer]       
       
      From #TblServiceDetails where ID=@MyField  
        
        
  
      SET @StrQueryPartialInsertPI=''  
      SET @StrQueryPartialInsertPI='  
        Exec SprSNCInsertServiceTran '''+ Convert(varchar(20),@POSCode) +''' ,'''+ convert(varchar(50),@ReservationId) +''','''+ Convert(varchar(20),@DayId) +''',
		'''+ Convert(varchar(20),@DayId) +''','''+ Convert(varchar(20),@ProformaInvoiceId) +''','+Convert(varchar(20),@IntPubCode)+','+convert(varchar(50),@IntPubQuantity)+',
		'+convert(varchar(50),@BlnPubChargeable)+','''+convert(varchar(50),@DecPubRate)+''','+convert(varchar(50),@EnPubCharge1)+','+convert(varchar(50),@EnPubCharge2)+',
		'''+convert(varchar(50),@DblLocCalculatedPrice)+''','''+convert(varchar(50),@DblLocCalculatedCost)+''','''+convert(varchar(50),@IntPubServiceRateId)+''',
		'''+convert(varchar(50),@IntPubSupplierRateCode)+''','''+convert(varchar(50),@DecPubCost)+''','+convert(varchar(50),@BlnPubDisplay)+',
		'''+convert(varchar(50),@EnCostType)+''','''+convert(varchar(50),@DecPubCostPer)+''',@AmdCodeFinal,'''+convert(varchar(50),@User)+''',''Y'',''''  
        
        EXEC SprSNCInsertMenuServiceOrder '''+ convert(varchar(50),@ReservationId) +''','''+ Convert(varchar(20),@DayId) +''',''SPI'','''','''+convert(varchar(50),@User)+''','''','''','+Convert(varchar(20),@IntPubCode)+','''+ Convert(varchar(20),@POSCode)+'''   
      
      '  
  
      SET @StrQueryPartialCostRevPI=''  
      set @StrQueryPartialCostRevPI='     
        IF (SELECT COUNT(*) FROM SNC.TblCostRevenue_'+ltrim(rtrim(@POSCode))+' WHERE ReservationId='''+ convert(varchar(50),@ReservationId) +''' AND ReservationDetailId='''+ Convert(varchar(20),@DayId) +''' AND Neumonic=''SERVICES'' ) >0  
        BEGIN  
         UPDATE SNC.TblCostRevenue_'+ltrim(rtrim(@POSCode))+' SET TotalCost= TotalCost+Convert(float,'''+convert(varchar(20),@DblLocCalculatedCost)+'''), TotalRevenue= TotalRevenue+Convert(float,'''+convert(varchar(20),@DblLocCalculatedPrice)+'''), ModifiedBy ='''+convert(varchar(50),@User)+''', ModifiedOn = GETDATE() WHERE ReservationId='+ Convert(varchar(20),@ReservationId) +' AND ReservationDetailId='+ Convert(varchar(20),@DayId) +' AND Neumonic=''SERVICES''  
        END  
        ELSE  
       
        BEGIN  
         INSERT INTO SNC.TblCostRevenue_'+ltrim(rtrim(@POSCode))+'(ReservationId, ReservationDetailId, Neumonic, TotalCost, TotalRevenue, UpdatedFrom, CreatedBy, CreatedOn, ModifiedBy, ModifiedOn)  
             VALUES ('''+ convert(varchar(50),@ReservationId) +''', '''+ convert(varchar(50),@DayId) +''', ''SERVICES'', Convert(float,'''+convert(varchar(20),@DblLocCalculatedCost)+'''), Convert(float,'''+convert(varchar(20),@DblLocCalculatedPrice)+'''),''SNC'', '''+convert(varchar(50),@User)+''', GETDATE(), '''+convert(varchar(50),@User)+''', GETDATE())  
        END  
        '  
  
      
    
  
      --Print (@StrQueryPartialDelete)    
      --Print (@StrQueryPartialInsert)  
      --Print (@StrQueryPartialCostRev)  
      --Print (@StrQueryPartialFP)  
  
      
      DECLARE @ParmDefinitionIPI nvarchar(500);  
      
      
      IF isnull(@IntPubCode,0)>0  
      BEGIN     
       SET @ParmDefinitionIPI = ' @AmdCodeFinal nvarchar(10)';  
       EXECUTE sp_executesql  @StrQueryPartialInsertPI,@ParmDefinitionIPI,@AmdCodeFinal=@AmdCodeFinal  
      END  
    
      Exec (@StrQueryPartialCostRevPI)    
                 
            
    
   
     FETCH NEXT FROM @MyCursor   
     INTO @MyField   
  
     END;   
  
     CLOSE @MyCursor ;  
     DEALLOCATE @MyCursor;  
  
    END;   
    
    
      
    SET @StrQueryPartialFPPI=''  
      SET @StrQueryPartialFPPI='  
       SprSNCUpdateFPAmdNo '''+ Convert(varchar(20),@POSCode) +''' ,'''+ convert(varchar(50),@ReservationId) +''','''+ Convert(varchar(20),@DayId) +'''  
       delete from SNC.TblMenuServiceOrder_'+ltrim(rtrim(@POSCode))+'  where ReservationId='''+ convert(varchar(50),@ReservationId) +''' and DayId='''+ convert(varchar(50),@DayId) + ''' and UpdatedFrom=''SPI'' and ServiceID not in (select TblServices.ServiceID from SNC.TblChallanServices_'+ltrim(rtrim(@POSCode))+' as TblServices join SNC.TblMenuServiceOrder_'+ltrim(rtrim(@POSCode))+' as TblMenuServiceOrder on TblMenuServiceOrder.ReservationId =TblServices.ReservationId and TblMenuServiceOrder.DayId =TblServices.DayId and TblMenuServiceOrder.ServiceID= TblServices.ServiceID where TblServices.ReservationId='+ convert(varchar(50),@ReservationId) +' and TblServices.DayId='+ convert(varchar(50),@DayId) +' and TblMenuServiceOrder.UpdatedFrom=''SPI'' )  '  
      Exec(@StrQueryPartialFPPI)  
  
    SET @StrQueryDeleteTempData=''  
    SET @StrQueryDeleteTempData='Exec SpSNCrDeleteServiceTran '''+ Convert(varchar(20),@POSCode) +''' ,'''+ convert(varchar(50),@ReservationId) +''','''+ Convert(varchar(20),@DayId) +''','''+ Convert(varchar(20),@ProformaInvoiceId) +''',''T'','''+@Guid+'''; '  
    EXECUTE sp_executesql  @StrQueryDeleteTempData  
  
  END  
--=======================================================================For FP Service End Here====================================================================================================   
--=======================================================================For PI Service Temp Start Here====================================================================================================     
  ELSE IF(@IsPI=2)  
  BEGIN  
    SET @StrQueryDeleteTempData=''  
    SET @StrQueryDeleteTempData='Exec SpSNCrDeleteServiceTran '''+ Convert(varchar(20),@POSCode) +''' ,'''+ convert(varchar(50),@ReservationId) +''','''+ Convert(varchar(20),@DayId) +''','''',''T'','''+@Guid+'''; '  
    EXECUTE sp_executesql  @StrQueryDeleteTempData  
  
    BEGIN  
     SET @MyCursor = CURSOR FOR  
     select ID from #TblServiceDetails  
         
  
     OPEN @MyCursor   
     FETCH NEXT FROM @MyCursor   
     INTO @MyField  
  
   
  
     WHILE @@FETCH_STATUS = 0  
     BEGIN  
  
      Select         
       @IntPubCode=[ServiceID],  
       @IntPubQuantity=[Quantity],  
       @BlnPubChargeable=[IsChargable],  
       @DecPubRate=[PerUnitRate],  
       @EnPubCharge1=[PerUnitChargableType1],  
       @EnPubCharge2=[PerUnitChargableType2],  
       @DblLocCalculatedPrice=[CalcualtedRate],  
       @DblLocCalculatedCost=[CalcualtedCost],  
       @IntPubServiceRateId=[ServiceRateId],  
       @IntPubSupplierRateCode=[SupplierRateCode],  
       @DecPubCost=[PerUnitCost] ,  
       @BlnPubDisplay=[IsDisplay],  
       @EnCostType=[CostType],  
       @DecPubCostPer=[CostPer]       
       
      From #TblServiceDetails where ID=@MyField  
       
      SET @StrQueryPartialInsertPITemp=''  
      SET @StrQueryPartialInsertPITemp='          
        Exec SprSNCInsertServiceTran '''+ Convert(varchar(20),@POSCode) +''' ,'''+ convert(varchar(50),@ReservationId) +''','''+ Convert(varchar(20),@DayId) +''',
		'''+ Convert(varchar(20),@DayId) +''','''+ Convert(varchar(20),@ProformaInvoiceId) +''','+Convert(varchar(20),@IntPubCode)+','+convert(varchar(50),@IntPubQuantity)+',
		'+convert(varchar(50),@BlnPubChargeable)+','''+convert(varchar(50),@DecPubRate)+''','+convert(varchar(50),@EnPubCharge1)+','+convert(varchar(50),@EnPubCharge2)+',
		'''+convert(varchar(50),@DblLocCalculatedPrice)+''','''+convert(varchar(50),@DblLocCalculatedCost)+''','''+convert(varchar(50),@IntPubServiceRateId)+''',
		'''+convert(varchar(50),@IntPubSupplierRateCode)+''','''+convert(varchar(50),@DecPubCost)+''','+convert(varchar(50),@BlnPubDisplay)+',
		'''+convert(varchar(50),@EnCostType)+''','''+convert(varchar(50),@DecPubCostPer)+''',@AmdCodeFinal,'''+convert(varchar(50),@User)+''',''T'','''+@Guid+'''  
        '  
        
      DECLARE @ParmDefinitionIPITemp nvarchar(500);         
      IF isnull(@IntPubCode,0)>0  
      BEGIN     
       SET @ParmDefinitionIPITemp = ' @AmdCodeFinal nvarchar(10)';  
       EXECUTE sp_executesql  @StrQueryPartialInsertPITemp,@ParmDefinitionIPITemp,@AmdCodeFinal=0  
      END  
    
      Exec (@StrQueryPartialCostRevPI)    
                 
            
    
   
     FETCH NEXT FROM @MyCursor   
     INTO @MyField   
  
     END;   
  
     CLOSE @MyCursor ;  
     DEALLOCATE @MyCursor;  
  
    END;  
  END  
--=======================================================================For PI Service Temp End Here====================================================================================================   

---------------changesInsertTaskForMyActivity---------------------      
select  @TaskId=TaskId from [SNC].TblActivityMst where  UPPER(ltrim(rtrim(TaskName)))LIKE  '%SERVICE%';      
 exec SprSNCInsertTaskForMyActivity @ReservationId,@UserCode,@TaskId,@POSCode,@GroupID,@ClientID      
      
---------------changesInsertTaskForMyActivity---------------------   

END  
GO