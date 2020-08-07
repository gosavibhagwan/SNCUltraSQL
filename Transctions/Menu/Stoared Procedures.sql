IF EXISTS(SELECT * FROM sysobjects WHERE type='P' AND name='SprSNCGetMH_MG_MSG_CodeForBanquetItem')        
BEGIN
        DROP PROCEDURE SprSNCGetMH_MG_MSG_CodeForBanquetItem
END
Go
Create PROCEDURE SprSNCGetMH_MG_MSG_CodeForBanquetItem
(	
	@POSCode Nvarchar(20),
	@GroupId Nvarchar(20),
	@ClientId Nvarchar(20),
	@BanquetItemCode int,
	@ReservationId int,
	@DayId int
)
AS
BEGIN
	Declare @StrQuery Nvarchar(Max)
	SET @StrQuery='
		Select  isnull(GuarantedPax,0) as GuarantedPax , 
				isnull(PerPaxRate,0) as PerPaxRate,
				isnull(KitchenTime,0) as KitchenTime,
				isnull(ServeTime,0) as ServeTime,
				isnull(ActualPax,0) as ActualPax,
				isnull(percentpremiumcharge,0) as percentpremiumcharge,
				isnull(amountpremiumcharge,0) as amountpremiumcharge   
		From SNC.TblMenuBanquetItem_'+ltrim(rtrim(@POSCode))+' 
		Where
			 ReservationId= '''+ convert(varchar(50),@ReservationId) +''' 
			 and DayId= '''+ Convert(varchar(20),@DayId) +''' 
			 and BanquetItemId =''' + Convert(varchar(20),@BanquetItemCode) + '''
	'
	EXEC(@StrQuery)

	IF @BanquetItemCode <>0
	BEGIN
		SELECT 
			 MW.BanquetItemCode
			,MW.POSCode
			,Case when MW.MenuHeadCode<>0 then 'MH-'+MH.MenuHeadDescription Else case when MW.MenuGroupCode<>0 Then 'MG-'+MG.MenuGroupDescription else 'MSG-'+MSG.MenuSubGroupDescription end ENd as MH_MG_MSG_Description
			,Case when MW.MenuHeadCode<>0 then MH.MenuHeadCode Else case when MW.MenuGroupCode<>0 Then MG.MenuGroupCode else MSG.MenuSubGroupCode end ENd as MH_MG_MSG_Code
			,Case when MW.MenuHeadCode<>0 then 1 Else case when MW.MenuGroupCode<>0 Then 3 else 2 end ENd as MH_MG_MSG_Type
		FROM 
			SNC.TblMenuWizard MW
			Left outer Join TblMenuHeadMst MH ON MH.MenuHeadCode=MW.MenuHeadCode And MH.POSCode=MW.POSCode
			Left outer Join TblMenuSubGroupMst MSG ON MSG.MenuSubGroupCode=MW.MenuSubGroupCode
			Left outer Join TblMenuGroupMst MG ON MG.MenuGroupCode=MW.MenuGroupCode
		WHERE 
			MW.POSCode=@POSCode ANd MW.BanquetItemCode=@BanquetItemCode
	END
	ELSE
	BEGIN
		SELECT 
			 MW.BanquetItemCode
			,MW.POSCode
			,Case when MW.MenuHeadCode<>0 then 'MH-'+MH.MenuHeadDescription Else case when MW.MenuGroupCode<>0 Then 'MG-'+MG.MenuGroupDescription else 'MSG-'+MSG.MenuSubGroupDescription end ENd as MH_MG_MSG_Description
			,Case when MW.MenuHeadCode<>0 then MH.MenuHeadCode Else case when MW.MenuGroupCode<>0 Then MG.MenuGroupCode else MSG.MenuSubGroupCode end ENd as MH_MG_MSG_Code
			,Case when MW.MenuHeadCode<>0 then 1 Else case when MW.MenuGroupCode<>0 Then 3 else 2 end ENd as MH_MG_MSG_Type
		FROM 
			SNC.TblMenuWizard MW
			Left outer Join TblMenuHeadMst MH ON MH.MenuHeadCode=MW.MenuHeadCode And MH.POSCode=MW.POSCode
			Left outer Join TblMenuSubGroupMst MSG ON MSG.MenuSubGroupCode=MW.MenuSubGroupCode
			Left outer Join TblMenuGroupMst MG ON MG.MenuGroupCode=MW.MenuGroupCode
		WHERE 
			MW.POSCode=@POSCode 
	END

END
GO

IF EXISTS(SELECT * FROM sysobjects WHERE type='P' AND name='SprSNCGetBanquetItemsForMenu')        
BEGIN
        DROP PROCEDURE SprSNCGetBanquetItemsForMenu
END
Go
Create PROCEDURE SprSNCGetBanquetItemsForMenu
(	
	@POSCode Nvarchar(20),
	@GroupId Nvarchar(20),
	@ClientId Nvarchar(20)
)
AS
BEGIN

	SELECT distinct 
		MW.BanquetItemCode
	   ,BI.BanquetItemName 
	   --,MW.IdealQty
	   --,MW.MaximumQty,
	   ,BI.IncomeHeadCode
	FROM 
		SNC.TblMenuWizard MW 
		inner join SNC.TblBanquetItemMst BI ON MW.BanquetItemCode=BI.BanquetItemCode
	Where 
		MW.POSCode=@POSCode	
END
GO

IF EXISTS(SELECT * FROM sysobjects WHERE type='P' AND name='SprSNCMenuPreRequisities')        
BEGIN
        DROP PROCEDURE SprSNCMenuPreRequisities
END
Go
Create PROCEDURE SprSNCMenuPreRequisities
(	
	@POSCode Nvarchar(20),
	@GroupId Nvarchar(20),
	@ClientId Nvarchar(20)
)
AS
BEGIN

	EXEC SprSNCGetBanquetItemsForMenu @POSCode,@GroupId,@ClientId
	EXEC SprSNCGetMH_MG_MSG_CodeForBanquetItem @POSCode,@GroupId,@ClientId

END
GO

IF EXISTS(SELECT * FROM sysobjects WHERE type='P' AND name='SprSNCGetMenuDetails')        
BEGIN
        DROP PROCEDURE SprSNCGetMenuDetails
END
Go
Create PROCEDURE SprSNCGetMenuDetails
(	
	@ReservationId int,
	@DayId int,
	@POSCode Nvarchar(20),
	@POSDate datetime,	
	@IsPI int,
	@Guid Nvarchar(max),
	@ProformaInvoiceNo Nvarchar(20),
	@GroupId Nvarchar(20),
	@ClientId Nvarchar(20)
)
AS
BEGIN
	DECLARE @StrQuerySelect varchar(Max)
	IF(@IsPI=0)
	BEGIN
		SET @StrQuerySelect='		
		Select case When TBI.banquetItemId=''A1LC'' then ''A-la-Carte'' else BI.BanquetItemName end as BanquetItemName,isnull(BI.IncomeHeadCode,0) as IncomeHeadCode,TBI.*,'''' as ProformaInvoiceId,'''' as Status,0 as TaxAmt,'''' as TaxStr,0 as Rate,0 as Discount,0 as Qty From [SNC].[TblMenuBanquetItem_'+ltrim(rtrim(@POSCode))+'] TBI Left Outer join SNC.TblBanquetItemMst BI ON TBI.BanquetItemId=convert(varchar(24),BI.BanquetItemCode) where ReservationId= '+ convert(varchar(50),@ReservationId) +'and DayId= '+ Convert(varchar(20),@DayId) +'
		Select MI.MenuItemDescription,MI.IncomeHeadCode,MI.UnitCode,UM.UnitDescription,MW.OrderBy,Case when MW.MenuHeadCode<>0 then ''MH-''+MH.MenuHeadDescription Else case when MW.MenuGroupCode<>0 Then ''MG-''+MG.MenuGroupDescription else ''MSG-''+MSG.MenuSubGroupDescription end ENd as MH_MG_MSG_Description,TMI.*,'''' as ProformaInvoiceId,'''' as Status,0 as TaxAmt,'''' as TaxStr,0 as Rate,0 as Discount,0 as Qty From [SNC].[TblMenuItem_'+ltrim(rtrim(@POSCode))+'] TMI Inner Join TblMenuItemMst MI On TMI.MenuItemCode=MI.MenuItemCode inner join TblUnitOfMeasureMst UM ON UM.UnitCode=MI.UnitCode  inner join SNC.TblMenuWizard MW ON TMI.BanquetItemId=convert(varchar,MW.BanquetItemCode) And TMI.MenuHeadCode=(case when MW.MenuHeadCode <>0 then MW.MenuHeadCode else Case when MW.MenuGroupCode<>0 then MW.MenuGroupCode Else MW.MenuSubGroupCode end end) And TMI.MenuHeadType=(case when MW.MenuHeadCode <>0 then 1 else Case when MW.MenuGroupCode<>0 then 2 Else 3 end end) Left outer Join TblMenuHeadMst MH ON MH.MenuHeadCode=MW.MenuHeadCode And MH.POSCode=MW.POSCode	Left outer Join TblMenuSubGroupMst MSG ON MSG.MenuSubGroupCode=MW.MenuSubGroupCode Left outer Join TblMenuGroupMst MG ON MG.MenuGroupCode=MW.MenuGroupCode             where ReservationId= '+ convert(varchar(50),@ReservationId) +'and DayId= '+ Convert(varchar(20),@DayId) +'
		union all
		Select MI.MenuItemDescription,MI.IncomeHeadCode,MI.UnitCode,UM.UnitDescription,9999 as OrderBy,''MH-''+MH.MenuHeadDescription,TMI.*,'''' as ProformaInvoiceId,'''' as Status,0 as TaxAmt,'''' as TaxStr,0 as Rate,0 as Discount,0 as Qty From [SNC].[TblMenuItem_06] TMI Inner Join TblMenuItemMst MI On TMI.MenuItemCode=MI.MenuItemCode inner join TblUnitOfMeasureMst UM ON UM.UnitCode=MI.UnitCode  Left outer Join TblMenuHeadMst MH ON MH.MenuHeadCode=TMI.MenuHeadCode And MH.POSCode='''+@POSCode+''' where  ReservationId= '+ convert(varchar(50),@ReservationId) +'and DayId= '+ Convert(varchar(20),@DayId) +' and BanquetItemId=''A1LC''
		union all
		Select MI.FreeFlowMenuItemName as MenuItemDescription,''0'' as IncomeHeadCode,MI.UnitMeasureCode as UnitCode,UM.UnitDescription,''9999'' as OrderBy, ''MH-''+MH.MenuHeadDescription as MH_MG_MSG_Description,TMI.*,'''' as ProformaInvoiceId,'''' as Status,0 as TaxAmt,'''' as TaxStr,0 as Rate,0 as Discount,0 as Qty From [SNC].[TblMenuItem_'+ltrim(rtrim(@POSCode))+'] TMI Inner Join SNC.TblFreeFlowMenuItemMst MI On TMI.MenuItemCode=MI.FreeFlowMenuItemId inner join TblUnitOfMeasureMst UM ON UM.UnitCode=MI.UnitMeasureCode  Left outer Join TblMenuHeadMst MH ON MH.MenuHeadCode=MI.MenuHead And MH.POSCode=MI.POSCode	 where BanquetItemId<>''A1LC'' and ReservationId= '+ convert(varchar(50),@ReservationId) +'and DayId= '+ Convert(varchar(20),@DayId) + ' AND  TMI.IsFreeFlow=''1''
		Select *,'''' as ProformaInvoiceId,'''' as Status,0 as TaxAmt,'''' as TaxStr,0 as Rate,0 as Discount,0 as Qty From [SNC].[TblMenuModifier_'+ltrim(rtrim(@POSCode))+'] where ReservationId= '+ convert(varchar(50),@ReservationId) +'and DayId= '+ Convert(varchar(20),@DayId) +'
		Select *,'''' as ProformaInvoiceId From [SNC].[TblMenuItemCostCenter_'+ltrim(rtrim(@POSCode))+'] where ReservationId= '+ convert(varchar(50),@ReservationId) +'and DayId= '+ Convert(varchar(20),@DayId) +'
		'
	END
	ELSE IF(@IsPI=1)
	BEGIN
		SET @StrQuerySelect='		
		Select isnull(BI.BanquetItemName,'''') as BanquetItemName ,isnull(BI.IncomeHeadCode,0)as IncomeHeadCode,TBI.* From [SNC].[TblChallanMenuBanquetItem_'+ltrim(rtrim(@POSCode))+'] TBI Left Outer join SNC.TblBanquetItemMst BI ON TBI.BanquetItemId=convert(varchar(24),BI.BanquetItemCode) where ReservationId= '+ convert(varchar(50),@ReservationId) +'and DayId= '+ Convert(varchar(20),@DayId) +' and ProformaInvoiceId= '''+ Convert(varchar(20),@ProformaInvoiceNo) +''' 
		Select MI.MenuItemDescription,MI.IncomeHeadCode,MI.UnitCode,UM.UnitDescription,MW.OrderBy,Case when MW.MenuHeadCode<>0 then ''MH-''+MH.MenuHeadDescription Else case when MW.MenuGroupCode<>0 Then ''MG-''+MG.MenuGroupDescription else ''MSG-''+MSG.MenuSubGroupDescription end ENd as MH_MG_MSG_Description,TMI.*,'''' as ProformaInvoiceId,'''' as Status,0 as TaxAmt,'''' as TaxStr,0 as Rate,0 as Discount,0 as Qty From [SNC].[TblChallanMenuItem_'+ltrim(rtrim(@POSCode))+'] TMI Inner Join TblMenuItemMst MI On TMI.MenuItemCode=MI.MenuItemCode inner join TblUnitOfMeasureMst UM ON UM.UnitCode=MI.UnitCode inner join SNC.TblMenuWizard MW ON TMI.BanquetItemId=convert(nvarchar,MW.BanquetItemCode) And TMI.MenuHeadCode=(case when MW.MenuHeadCode <>0 then MW.MenuHeadCode else Case when MW.MenuGroupCode<>0 then MW.MenuGroupCode Else MW.MenuSubGroupCode end end) And TMI.MenuHeadType=(case when MW.MenuHeadCode <>0 then 1 else Case when MW.MenuGroupCode<>0 then 2 Else 3 end end) Left outer Join TblMenuHeadMst MH ON MH.MenuHeadCode=MW.MenuHeadCode And MH.POSCode=MW.POSCode	Left outer Join TblMenuSubGroupMst MSG ON MSG.MenuSubGroupCode=MW.MenuSubGroupCode Left outer Join TblMenuGroupMst MG ON MG.MenuGroupCode=MW.MenuGroupCode  where ReservationId= '+ convert(varchar(50),@ReservationId) +'and DayId= '+ Convert(varchar(20),@DayId) +' and ProformaInvoiceId= '''+ Convert(varchar(20),@ProformaInvoiceNo) +'''   
		union all
		Select MI.MenuItemDescription,MI.IncomeHeadCode,MI.UnitCode,UM.UnitDescription,9999 as OrderBy,''MH-''+MH.MenuHeadDescription,TMI.*,'''' as ProformaInvoiceId,'''' as Status,0 as TaxAmt,'''' as TaxStr,0 as Rate,0 as Discount,0 as Qty From [SNC].[TblChallanMenuItem_06] TMI Inner Join TblMenuItemMst MI On TMI.MenuItemCode=MI.MenuItemCode inner join TblUnitOfMeasureMst UM ON UM.UnitCode=MI.UnitCode  Left outer Join TblMenuHeadMst MH ON MH.MenuHeadCode=TMI.MenuHeadCode And MH.POSCode='''+@POSCode+'''  where ReservationId= '+ convert(varchar(50),@ReservationId) +'and DayId= '+ Convert(varchar(20),@DayId) +'  and BanquetItemId=''A1LC''
		union all
		Select MI.FreeFlowMenuItemName as MenuItemDescription,''0'' as IncomeHeadCode,MI.UnitMeasureCode as UnitCode,UM.UnitDescription,''9999'' as OrderBy, ''MH-''+MH.MenuHeadDescription as MH_MG_MSG_Description,TMI.*,'''' as ProformaInvoiceId,'''' as Status,0 as TaxAmt,'''' as TaxStr,0 as Rate,0 as Discount,0 as Qty From [SNC].[TblChallanMenuItem_'+ltrim(rtrim(@POSCode))+'] TMI Inner Join SNC.TblFreeFlowMenuItemMst MI On TMI.MenuItemCode=MI.FreeFlowMenuItemId inner join TblUnitOfMeasureMst UM ON UM.UnitCode=MI.UnitMeasureCode  Left outer Join TblMenuHeadMst MH ON MH.MenuHeadCode=MI.MenuHead And MH.POSCode=MI.POSCode	 where  BanquetItemId<>''A1LC'' and  ReservationId= '+ convert(varchar(50),@ReservationId) +'and DayId= '+ Convert(varchar(20),@DayId) +' AND  TMI.IsFreeFlow=''1''
		Select * From [SNC].[TblChallanMenuModifier_'+ltrim(rtrim(@POSCode))+'] where ReservationId= '+ convert(varchar(50),@ReservationId) +'and DayId= '+ Convert(varchar(20),@DayId) +' and ProformaInvoiceId= '''+ Convert(varchar(20),@ProformaInvoiceNo) +'''  
		Select * From [SNC].[TblChallanMenuItemCostCenter_'+ltrim(rtrim(@POSCode))+'] where ReservationId= '+ convert(varchar(50),@ReservationId) +'and DayId= '+ Convert(varchar(20),@DayId) +' and ProformaInvoiceId= '''+ Convert(varchar(20),@ProformaInvoiceNo) +'''  
		'
	END
	ELSE IF(@IsPI=2)
	BEGIN
		SET @StrQuerySelect='		
		Select isnull(BI.BanquetItemName,''A-la-Carte'') as BanquetItemName ,isnull(BI.IncomeHeadCode,0)as IncomeHeadCode,TBI.* From [SNC].[TblChallanMenuBanquetItemTemp_'+ltrim(rtrim(@POSCode))+'] TBI Left Outer join SNC.TblBanquetItemMst BI ON TBI.BanquetItemId=convert(varchar(24),BI.BanquetItemCode) where ReservationId= '+ convert(varchar(50),@ReservationId) +'and DayId= '+ Convert(varchar(20),@DayId) +' and Guid='''+ @Guid +''' 
		Select MI.MenuItemDescription,MI.IncomeHeadCode,MI.UnitCode,UM.UnitDescription,MW.OrderBy,Case when MW.MenuHeadCode<>0 then ''MH-''+MH.MenuHeadDescription Else case when MW.MenuGroupCode<>0 Then ''MG-''+MG.MenuGroupDescription else ''MSG-''+MSG.MenuSubGroupDescription end ENd as MH_MG_MSG_Description,TMI.*,'''' as ProformaInvoiceId,'''' as Status,0 as TaxAmt,'''' as TaxStr,0 as Rate,0 as Discount,0 as Qty From [SNC].[TblChallanMenuItemTemp_'+ltrim(rtrim(@POSCode))+'] TMI Inner Join TblMenuItemMst MI On TMI.MenuItemCode=MI.MenuItemCode inner join TblUnitOfMeasureMst UM ON UM.UnitCode=MI.UnitCode inner join SNC.TblMenuWizard MW ON TMI.BanquetItemId=convert(nvarchar,MW.BanquetItemCode) And TMI.MenuHeadCode=(case when MW.MenuHeadCode <>0 then MW.MenuHeadCode else Case when MW.MenuGroupCode<>0 then MW.MenuGroupCode Else MW.MenuSubGroupCode end end) And TMI.MenuHeadType=(case when MW.MenuHeadCode <>0 then 1 else Case when MW.MenuGroupCode<>0 then 2 Else 3 end end) Left outer Join TblMenuHeadMst MH ON MH.MenuHeadCode=MW.MenuHeadCode And MH.POSCode=MW.POSCode	Left outer Join TblMenuSubGroupMst MSG ON MSG.MenuSubGroupCode=MW.MenuSubGroupCode Left outer Join TblMenuGroupMst MG ON MG.MenuGroupCode=MW.MenuGroupCode  where ReservationId= '+ convert(varchar(50),@ReservationId) +'and DayId= '+ Convert(varchar(20),@DayId) +' and Guid='''+ @Guid +''' 
		union all
		Select MI.MenuItemDescription,MI.IncomeHeadCode,MI.UnitCode,UM.UnitDescription,9999 as OrderBy,''MH-''+MH.MenuHeadDescription,TMI.*,'''' as ProformaInvoiceId,'''' as Status,0 as TaxAmt,'''' as TaxStr,0 as Rate,0 as Discount,0 as Qty From [SNC].[TblChallanMenuItemTemp_06] TMI Inner Join TblMenuItemMst MI On TMI.MenuItemCode=MI.MenuItemCode inner join TblUnitOfMeasureMst UM ON UM.UnitCode=MI.UnitCode  Left outer Join TblMenuHeadMst MH ON MH.MenuHeadCode=TMI.MenuHeadCode And MH.POSCode='''+@POSCode+'''  where ReservationId= '+ convert(varchar(50),@ReservationId) +'and DayId= '+ Convert(varchar(20),@DayId) +' and BanquetItemId=''A1LC'' and Guid='''+ @Guid +''' 
		union all
		Select MI.FreeFlowMenuItemName as MenuItemDescription,''0'' as IncomeHeadCode,MI.UnitMeasureCode as UnitCode,UM.UnitDescription,''9999'' as OrderBy, ''MH-''+MH.MenuHeadDescription as MH_MG_MSG_Description,TMI.*,'''' as ProformaInvoiceId,'''' as Status,0 as TaxAmt,'''' as TaxStr,0 as Rate,0 as Discount,0 as Qty From [SNC].[TblChallanMenuItemTemp_'+ltrim(rtrim(@POSCode))+'] TMI Inner Join SNC.TblFreeFlowMenuItemMst MI On TMI.MenuItemCode=MI.FreeFlowMenuItemId inner join TblUnitOfMeasureMst UM ON UM.UnitCode=MI.UnitMeasureCode  Left outer Join TblMenuHeadMst MH ON MH.MenuHeadCode=MI.MenuHead And MH.POSCode=MI.POSCode where  BanquetItemId<>''A1LC'' and  ReservationId= '+ convert(varchar(50),@ReservationId) +'and DayId= '+ Convert(varchar(20),@DayId) +' and Guid='''+ @Guid +''' AND  TMI.IsFreeFlow=''1''
		Select * From [SNC].[TblChallanMenuModifierTemp_'+ltrim(rtrim(@POSCode))+'] where ReservationId= '+ convert(varchar(50),@ReservationId) +'and DayId= '+ Convert(varchar(20),@DayId) +' and Guid='''+ @Guid +''' 
		Select * From [SNC].[TblChallanMenuItemCostCenterTemp_'+ltrim(rtrim(@POSCode))+'] where ReservationId= '+ convert(varchar(50),@ReservationId) +'and DayId= '+ Convert(varchar(20),@DayId) +' and Guid='''+ @Guid +''' 
		'
	END
	Print(@StrQuerySelect)
	EXEC(@StrQuerySelect)
		
		
	Exec SprSNCGetAllMenuItemsCostDetails @POSCode,@POSDate,@GroupId,@ClientId
	select * from TblCostCenterMst where POSCode=@POSCode

END
GO

IF EXISTS(SELECT * FROM sysobjects WHERE type='P' AND name='SprSNCGetAllMenuItemsCostDetails')        
BEGIN
        DROP PROCEDURE SprSNCGetAllMenuItemsCostDetails
END
Go
Create PROCEDURE SprSNCGetAllMenuItemsCostDetails
(		
	@POSCode Nvarchar(20),	
	@POSDate datetime,	
	@GroupId Nvarchar(20),
	@ClientId Nvarchar(20)
	
)
AS
BEGIN
			Declare @StrLocFunDayOfWeek varchar(3) 
			Select @StrLocFunDayOfWeek = CASE DATEPART(dw,@POSDate) WHEN 1 THEN 'SUN' WHEN 2 THEN 'MON' WHEN 3 THEN 'TUE' WHEN 4 THEN 'WED' WHEN 5 THEN 'THR' WHEN 6 THEN 'FRI' WHEN 7 THEN 'SAT' END 
			

	
		Exec('select distinct ''A1LC'' as BanquetItemCode, isnull(a.MenuItemDescription,'''') as MenuItemDescription,   CONVERT(VARCHAR,a.MenuItemCode) AS Code ,
				a.TouchDescription as ItemDetail,
				convert(decimal,(case when c.CostInPer>0 then (c.'+@StrLocFunDayOfWeek+'*c.CostInPer/100) else c.FixedCost end)) as Cost , 
				''No'' As Modifier  ,c.'+@StrLocFunDayOfWeek+' as Rate ,''Cover''=1, c.Ratecode as ItemRateId, u.UnitDescription as Unit , u.UnitCode,a.IncomeHeadCode 
				,LTRIM(RTRIM(CASE CONVERT(FLOAT,c.FixedCost) WHEN 0 THEN ''P'' ELSE ''A'' END)) AS CostType
				,c.CostCenterCode as CostCenterCodes,''0'' as IsFreeFlow,1 as MH_MG_MSG_Type
		from TblMenuItemMst a
			inner join TblRateMst  c on a.MenuItemCode= c.MenuItemCode
			inner join TblunitofMeasureMst u on u.UnitCode =a.UnitCode 
		where c.TypeCode=''3'' 
				and (('''+@POSDate+''' between c.FromDate and c.ToDate ) OR (c.ToDate = ''01/01/1900'')) 
				and c.POSCode='''+@POSCode+'''

		union all

		Select distinct convert(varchar,isnull(cm.BanquetItemCode,0)),isnull(a.MenuItemDescription,'''') as MenuItemDescription,  CONVERT(VARCHAR,a.MenuItemCode) AS Code ,a.TouchDescription as ItemDetail, 
						isnull(cm.Costincurredperunit,0) as Cost , 
						''No'' As Modifier  ,
						c.'+@StrLocFunDayOfWeek+' as Rate ,''Cover''=isnull(com.CoversCateredPerPortion,1), 
						c.Ratecode as ItemRateId, u.UnitDescription as Unit , u.UnitCode,a.IncomeHeadCode
						,LTRIM(RTRIM(CASE CONVERT(FLOAT,c.FixedCost) WHEN 0 THEN ''P'' ELSE ''A'' END)) AS CostType
						,c.CostCenterCode as CostCenterCodes,''0'' as IsFreeFlow,1 as  MH_MG_MSG_Type
						from TblMenuItemMst a							 
							 inner join TblRateMst  c on c.MenuItemCode =a.MenuItemCode
							 inner join TblunitofMeasureMst u on u.UnitCode =a.UnitCode
							 Left outer join SNC.TblMenuHeadCostMatrix cm on cm.MenuHdCode=c.MenuHeadCode
							 Left outer join SNC.TblMenuHeadCoverMatrix com on com.MenuHdCode=c.MenuHeadCode
						where c.TypeCode=''3'' 
							 and (('''+@POSDate+''' between c.FromDate and c.ToDate ) OR (c.ToDate = ''01/01/1900'')) 
							 and c.POSCode='''+@POSCode+'''
		Union 
				
		Select   convert(varchar,isnull(cm.BanquetItemCode,0)),isnull(FreeFlowMenuItemName,'''') as Name ,  + ''F'' +CONVERT(VARCHAR, FreeFlowMenuItemId) As Code ,'''' As ItemDetail ,
				isnull(cm.Costincurredperunit,0) as Cost ,  
				''No'' As Modifier, 0 as Rate ,
				''Cover''=isnull(com.CoversCateredPerPortion,1),
				''0'' as ItemRateId, ISNULL(u.UnitDescription,'''') as  Unit, u.UnitCode,1 as IncomeHeadCode
				,''A''AS CostType,0 as CostCenterCodes,''1'' as IsFreeFlow,1 as MH_MG_MSG_Type
				from SNC.TblFreeFlowMenuItemMst f			
				left outer join TblunitofMeasureMst u on UnitMeasureCode=u.UnitCode  
				Left outer join SNC.TblMenuHeadCostMatrix cm on cm.MenuHdCode=f.MenuHead 
				Left outer join SNC.TblMenuHeadCoverMatrix com on com.MenuHdCode=f.MenuHead
				where   Active <> 0
	Union All

		Select distinct  convert(varchar,isnull(cm.BanquetItemCode,0)),isnull(a.MenuItemDescription,'''') as MenuItemDescription, a.MenuItemCode ,a.TouchDescription, 
		isnull(cm.Costincurredperunit,0) as Cost ,  
		''No'' As Modifier  , c.'+@StrLocFunDayOfWeek+' as Rate ,
		''Cover''=isnull(com.CoversCateredPerPortion,1),
		c.Ratecode as ItemRateId, u.UnitDescription as Unit , u.UnitCode,a.IncomeHeadCode
		,LTRIM(RTRIM(CASE CONVERT(FLOAT,c.FixedCost) WHEN 0 THEN ''P'' ELSE ''A'' END)) AS CostType
		,c.CostCenterCode as CostCenterCodes,''0'' as IsFreeFlow,2 as MH_MG_MSG_Type
		from TblMenuItemMst a			
			inner join TblRateMst  c on c.MenuItemCode=a.MenuItemCode
			inner join TblunitofMeasureMst u on u.UnitCode =a.UnitCode
			Left outer join SNC.TblMenuHeadCostMatrix cm on cm.MenuHdCode=c.MenuHeadCode 
			Left outer join SNC.TblMenuHeadCoverMatrix com on com.MenuHdCode=c.MenuHeadCode 
		where  c.TypeCode=''3''
				  and a.UnitCode = u.UnitCode 
				  and a.MenuSubGroupCode  in (select MenuSubGroupCode  from TblMenuSubGroupMst) 
				  and (('''+@POSDate+''' between c.FromDate and c.ToDate ) OR (c.ToDate = ''01/01/1900''))  
				  and c.POSCode='''+@POSCode+'''
	Union All

		select distinct  convert(varchar,isnull(cm.BanquetItemCode,0)),isnull(a.MenuItemDescription,'''') as MenuItemDescription, a.MenuItemCode ,a.TouchDescription, 
		isnull(cm.Costincurredperunit,0) as Cost ,  
		''No'' As Modifier  , c.'+@StrLocFunDayOfWeek+' as Rate ,
		''Cover''=isnull(com.CoversCateredPerPortion,1),
		c.Ratecode as ItemRateId, u.UnitDescription as Unit , u.UnitCode,a.IncomeHeadCode 
		,LTRIM(RTRIM(CASE CONVERT(FLOAT,c.FixedCost) WHEN 0 THEN ''P'' ELSE ''A'' END)) AS CostType
		,c.CostCenterCode as CostCenterCodes,''0'' as IsFreeFlow,3 as MH_MG_MSG_Type
		from TblMenuItemMst a	
			inner join TblRateMst  c on c.MenuItemCode=a.MenuItemCode
			inner join TblunitofMeasureMst u on u.UnitCode =a.UnitCode
			Left outer join SNC.TblMenuHeadCostMatrix cm on cm.MenuHdCode=c.MenuHeadCode 
			Left outer join SNC.TblMenuHeadCoverMatrix com on com.MenuHdCode=c.MenuHeadCode
		 where c.TypeCode=''3''				 
				 and (('''+@POSDate+''' between c.FromDate and c.ToDate ) OR (c.ToDate = ''01/01/1900'')) 
				 and c.POSCode='''+@POSCode+'''

		 ' )
	
END
GO


IF EXISTS(SELECT * FROM sysobjects WHERE type='P' AND name='SprSNCGetDetailsForBanquetItem')        
BEGIN
        DROP PROCEDURE SprSNCGetDetailsForBanquetItem
END
Go
Create PROCEDURE SprSNCGetDetailsForBanquetItem
(	
	@POSCode varchar(20),
	@POSDate varchar(10),	
	@GroupId Nvarchar(20),
	@ClientId Nvarchar(20),
	@BanquetItemCode varchar(20),
	@ReservationId int,
	@DayId int
)
AS
BEGIN
	Declare @StrQuery Nvarchar(Max)
	Declare @StrLocFunDayOfWeek varchar(3) 
	Select @StrLocFunDayOfWeek = CASE DATEPART(dw,@POSDate) WHEN 1 THEN 'SUN' WHEN 2 THEN 'MON' WHEN 3 THEN 'TUE' WHEN 4 THEN 'WED' WHEN 5 THEN 'THR' WHEN 6 THEN 'FRI' WHEN 7 THEN 'SAT' END 

	SET @StrQuery='SELECT
				 BI.BanquetItemCode as StrPubBanquetItemCode
				,RM.'+@StrLocFunDayOfWeek+' as  DblPubRate
				,RM.RateCode as IntPubRateCode
				, case PRM.[Type] When ''P'' THEN 2 ELSE 1 End as EnPubPremiumType
				,PRM.[PremiumOn] as PremiumOn
				,case PRM.[Type] WHEN  ''P'' THEN PRM.PremiumPercent ELSE PRM.PremiumAmount END As DblPubPremiumCharge									
				,'''' as StrPubKitchenTime
				,'''' as StrPubServiceTime
				,LTRIM(RTRIM(CASE CONVERT(FLOAT,RM.FixedCost) WHEN 0 THEN ''2'' ELSE ''1'' END)) AS EnPubCostType
				,LTRIM(RTRIM(STR(CASE CONVERT(FLOAT,RM.FixedCost) WHEN 0 THEN (RM.'+@StrLocFunDayOfWeek+' * RM.CostInPer / 100) ELSE RM.FixedCost END,11,2))) AS DblPubCostPrice		
				,0 as DblPubCalculatedCost 
				,0 as DblPubCalculatedRate 
				,0 as DblPubCalculatedPremium 
				,0 as IntPubActualPax
				From  SNC.TblBanquetItemMst BI
				Inner Join TblRateMst RM On RM.MenuItemCode = BI.BanquetItemCode
				left Outer Join  SNC.TblSetMenuPremiumMst PRM on PRM.POSCode= '''+@POSCode	+''' and (PRM.FromDate <= convert(datetime,'''+@POSDate+''') and (PRM.ToDate >=  convert(datetime,'''+@POSDate+''') OR PRM.ToDate =  cast(''12/31/9999'' as datetime)) ) 
				WHERE RM.POSCode = '''+@POSCode	+''' And RM.TypeCode=''3'' 
				--and RM.GroupID='''+@GroupId+'''
				--and RM.ClientID = '''+@ClientId+'''		
				--And RM.ItemType=''B''
				and RM.MenuItemCode ='''+@BanquetItemCode+'''
				and (RM.FromDate <= convert(datetime,'''+@POSDate+''') and (RM.ToDate >=  convert(datetime,'''+@POSDate+''') OR RM.ToDate =  cast(''12/31/9999'' as datetime)) )
				order by RM.CreatedDate'
			 
	
	Exec(@StrQuery)
	

	IF @BanquetItemCode <>'0'
	BEGIN
		If @BanquetItemCode='A1LC'
		BEGIN
			SELECT 
			 'A1LC' as MenBanquetItemCode
			,MH.POSCode
			,MH.MenuHeadDescription as MH_MG_MSG_Description
			,MH.MenuHeadCode as MH_MG_MSG_Code
			,1 as MH_MG_MSG_Type
			,0 as IdealQty
			,0 as MaximumQty
		FROM
			 TblMenuHeadMst MH 
		WHERE 
			MH.POSCode=@POSCode 
		END
		ELSE
		BEGIN
			SELECT 
			 MW.BanquetItemCode
			,MW.POSCode
			,Case when MW.MenuHeadCode<>0 then 'MH-'+MH.MenuHeadDescription Else case when MW.MenuGroupCode<>0 Then 'MG-'+MG.MenuGroupDescription else 'MSG-'+MSG.MenuSubGroupDescription end ENd as MH_MG_MSG_Description
			,Case when MW.MenuHeadCode<>0 then MH.MenuHeadCode Else case when MW.MenuGroupCode<>0 Then MG.MenuGroupCode else MSG.MenuSubGroupCode end ENd as MH_MG_MSG_Code
			,Case when MW.MenuHeadCode<>0 then 1 Else case when MW.MenuGroupCode<>0 Then 3 else 2 end ENd as MH_MG_MSG_Type
			,MW.IdealQty
			,MW.MaximumQty
		FROM 
			SNC.TblMenuWizard MW
			Left outer Join TblMenuHeadMst MH ON MH.MenuHeadCode=MW.MenuHeadCode And MH.POSCode=MW.POSCode
			Left outer Join TblMenuSubGroupMst MSG ON MSG.MenuSubGroupCode=MW.MenuSubGroupCode
			Left outer Join TblMenuGroupMst MG ON MG.MenuGroupCode=MW.MenuGroupCode
		WHERE 
			MW.POSCode=@POSCode ANd MW.BanquetItemCode=@BanquetItemCode
		END
	END
	ELSE
	BEGIN
		SELECT 
			 MW.BanquetItemCode
			,MW.POSCode
			,Case when MW.MenuHeadCode<>0 then 'MH-'+MH.MenuHeadDescription Else case when MW.MenuGroupCode<>0 Then 'MG-'+MG.MenuGroupDescription else 'MSG-'+MSG.MenuSubGroupDescription end ENd as MH_MG_MSG_Description
			,Case when MW.MenuHeadCode<>0 then MH.MenuHeadCode Else case when MW.MenuGroupCode<>0 Then MG.MenuGroupCode else MSG.MenuSubGroupCode end ENd as MH_MG_MSG_Code
			,Case when MW.MenuHeadCode<>0 then 1 Else case when MW.MenuGroupCode<>0 Then 3 else 2 end ENd as MH_MG_MSG_Type
			,MW.IdealQty
			,MW.MaximumQty
		FROM 
			SNC.TblMenuWizard MW
			Left outer Join TblMenuHeadMst MH ON MH.MenuHeadCode=MW.MenuHeadCode And MH.POSCode=MW.POSCode
			Left outer Join TblMenuSubGroupMst MSG ON MSG.MenuSubGroupCode=MW.MenuSubGroupCode
			Left outer Join TblMenuGroupMst MG ON MG.MenuGroupCode=MW.MenuGroupCode
		WHERE 
			MW.POSCode=@POSCode 
	END
END
GO


IF EXISTS(SELECT * FROM sysobjects WHERE type='P' AND name='SprSNCGetMenuItemsForMH_MG_MSG_Code')        
BEGIN
        DROP PROCEDURE SprSNCGetMenuItemsForMH_MG_MSG_Code
END
Go
Create PROCEDURE SprSNCGetMenuItemsForMH_MG_MSG_Code
(	
	@BanquetItemCode nvarchar(50),
	@MH_MG_MSG_Type int,
	@MH_MG_MSG_Code int,
	@POSCode Nvarchar(20),	
	@POSDate datetime,
	@FunctionId int,
	@ProfileId int,	
	@GroupId Nvarchar(20),
	@ClientId Nvarchar(20)
	
)
AS
BEGIN
			Declare @StrLocFunDayOfWeek varchar(3) 
			Select @StrLocFunDayOfWeek = CASE DATEPART(dw,@POSDate) WHEN 1 THEN 'SUN' WHEN 2 THEN 'MON' WHEN 3 THEN 'TUE' WHEN 4 THEN 'WED' WHEN 5 THEN 'THR' WHEN 6 THEN 'FRI' WHEN 7 THEN 'SAT' END 
			

	If @MH_MG_MSG_Type=1 --MenuHead
	Begin
		Exec('Select distinct a.MenuItemDescription,  CONVERT(VARCHAR,a.MenuItemCode) AS Code ,a.TouchDescription as ItemDetail, 
						isnull(cm.Costincurredperunit,0) as Cost , 
						''No'' As Modifier  ,
						c.'+@StrLocFunDayOfWeek+' as Rate ,''Cover''=isnull(com.CoversCateredPerPortion,1), 
						c.Ratecode as ItemRateId, u.UnitDescription as Unit , u.UnitCode,a.IncomeHeadCode,MW.OrderBy
						,LTRIM(RTRIM(CASE CONVERT(FLOAT,c.FixedCost) WHEN 0 THEN ''P'' ELSE ''A'' END)) AS CostType
						,c.CostCenterCode as CostCenterCodes,''0'' as IsFreeFlow
						from TblMenuItemMst a
							 inner join SNC.TblMenuWizard MW ON MW.BanquetItemCode='''+@BanquetItemCode+''' And MW.MenuHeadCode='''+@MH_MG_MSG_Code+'''	
							 inner join TblRateMst  c on c.MenuItemCode =a.MenuItemCode
							 inner join TblunitofMeasureMst u on u.UnitCode =a.UnitCode
							 Left outer join SNC.TblMenuHeadCostMatrix cm on cm.MenuHdCode=c.MenuHeadCode and cm.BanquetItemCode='''+@BanquetItemCode+'''
							 Left outer join SNC.TblMenuHeadCoverMatrix com on com.MenuHdCode=c.MenuHeadCode and com.BanquetItemCode='''+@BanquetItemCode+'''
						where c.TypeCode=''3'' --and c.Category = ''2''
							 and (('''+@POSDate+''' between c.FromDate and c.ToDate ) OR (c.ToDate = ''01/01/1900'')) 
							 and c.POSCode='''+@POSCode+''' and c.MenuHeadCode='''+@MH_MG_MSG_Code+'''
		Union 
				
		Select  FreeFlowMenuItemName as Name ,  + ''F'' +CONVERT(VARCHAR, FreeFlowMenuItemId) As Code ,'''' As ItemDetail ,
				isnull(cm.Costincurredperunit,0) as Cost ,  
				''No'' As Modifier, 0 as Rate ,
				''Cover''=isnull(com.CoversCateredPerPortion,1),
				''0'' as ItemRateId, ISNULL(u.UnitDescription,'''') as  Unit, u.UnitCode,1 as IncomeHeadCode,9999 as  OrderBy
				,''A''AS CostType,0 as CostCenterCodes,''1'' as IsFreeFlow
				from SNC.TblFreeFlowMenuItemMst f			
				left outer join TblunitofMeasureMst u on UnitMeasureCode=u.UnitCode  
				Left outer join SNC.TblMenuHeadCostMatrix cm on cm.MenuHdCode=f.MenuHead and cm.BanquetItemCode='''+@BanquetItemCode+'''
				Left outer join SNC.TblMenuHeadCoverMatrix com on com.MenuHdCode=f.MenuHead and com.BanquetItemCode='''+@BanquetItemCode+'''
				where  MenuHead ='''+@MH_MG_MSG_Code+''' and Active <> 0')
	End
	Else If @MH_MG_MSG_Type=3 --MenuGroup
	Begin
		EXEC('Select distinct a.MenuItemDescription, a.MenuItemCode ,a.TouchDescription, 
		isnull(cm.Costincurredperunit,0) as Cost ,  
		''No'' As Modifier  , c.'+@StrLocFunDayOfWeek+' as Rate ,
		''Cover''=isnull(com.CoversCateredPerPortion,1),
		c.Ratecode as ItemRateId, u.UnitDescription as Unit , u.UnitCode,a.IncomeHeadCode ,MW.OrderBy
		,LTRIM(RTRIM(CASE CONVERT(FLOAT,c.FixedCost) WHEN 0 THEN ''P'' ELSE ''A'' END)) AS CostType
		,c.CostCenterCode as CostCenterCodes,''0'' as IsFreeFlow
		from TblMenuItemMst a
			inner join SNC.TblMenuWizard MW ON MW.BanquetItemCode='''+@BanquetItemCode+'''
			inner join TblRateMst  c on c.MenuItemCode=a.MenuItemCode
			inner join TblunitofMeasureMst u on u.UnitCode =a.UnitCode
			Left outer join SNC.TblMenuHeadCostMatrix cm on cm.MenuHdCode=c.MenuHeadCode and cm.BanquetItemCode='''+@BanquetItemCode+'''
			Left outer join SNC.TblMenuHeadCoverMatrix com on com.MenuHdCode=c.MenuHeadCode and com.BanquetItemCode='''+@BanquetItemCode+'''
		where  c.TypeCode=''3'' --and c.Category = ''2'' 
				  and a.UnitCode = u.UnitCode 
				  and a.MenuSubGroupCode  in (select MenuSubGroupCode  from TblMenuSubGroupMst  where MenuGroupCode = '''+@MH_MG_MSG_Code+''') 
				  and (('''+@POSDate+''' between c.FromDate and c.ToDate ) OR (c.ToDate = ''01/01/1900''))  
				  and c.POSCode='''+@POSCode+'''')
	End
	Else If @MH_MG_MSG_Type =2 --MenuSubGroup
	Begin
		EXEC('select distinct a.MenuItemDescription, a.MenuItemCode ,a.TouchDescription, 
		isnull(cm.Costincurredperunit,0) as Cost ,  
		''No'' As Modifier  , c.'+@StrLocFunDayOfWeek+' as Rate ,
		''Cover''=isnull(com.CoversCateredPerPortion,1),
		c.Ratecode as ItemRateId, u.UnitDescription as Unit , u.UnitCode,a.IncomeHeadCode ,9999 as  OrderBy
		,LTRIM(RTRIM(CASE CONVERT(FLOAT,c.FixedCost) WHEN 0 THEN ''P'' ELSE ''A'' END)) AS CostType
		,c.CostCenterCode as CostCenterCodes,''0'' as IsFreeFlow
		from TblMenuItemMst a
			inner join SNC.TblMenuWizard MW ON MW.BanquetItemCode='''+@BanquetItemCode+'''
			inner join TblRateMst  c on c.MenuItemCode=a.MenuItemCode
			inner join TblunitofMeasureMst u on u.UnitCode =a.UnitCode
			Left outer join SNC.TblMenuHeadCostMatrix cm on cm.MenuHdCode=c.MenuHeadCode and cm.BanquetItemCode='''+@BanquetItemCode+'''
			Left outer join SNC.TblMenuHeadCoverMatrix com on com.MenuHdCode=c.MenuHeadCode and com.BanquetItemCode='''+@BanquetItemCode+'''
		 where c.TypeCode=''3'' --and c.Category = ''2'' 
				 and a.MenuSubGroupCode ='''+@MH_MG_MSG_Code+'''
				 and (('''+@POSDate+''' between c.FromDate and c.ToDate ) OR (c.ToDate = ''01/01/1900'')) 
				 and c.POSCode='''+@POSCode+'''')
	End
	Else If @MH_MG_MSG_Type =4 --A-La-Carte
	Begin
		EXEC('select distinct a.MenuItemDescription,   CONVERT(VARCHAR,a.MenuItemCode) AS Code ,
				a.TouchDescription as ItemDetail,
				convert(decimal,(case when c.CostInPer>0 then (c.'+@StrLocFunDayOfWeek+'*c.CostInPer/100) else c.FixedCost end)) as Cost , 
				''No'' As Modifier  ,c.'+@StrLocFunDayOfWeek+' as Rate ,''Cover''=1, c.Ratecode as ItemRateId, u.UnitDescription as Unit , u.UnitCode,a.IncomeHeadCode ,9999 as  OrderBy
				,LTRIM(RTRIM(CASE CONVERT(FLOAT,c.FixedCost) WHEN 0 THEN ''P'' ELSE ''A'' END)) AS CostType
				,c.CostCenterCode as CostCenterCodes,''0'' as IsFreeFlow
		from TblMenuItemMst a
			inner join TblRateMst  c on a.MenuItemCode= c.MenuItemCode
			inner join TblunitofMeasureMst u on u.UnitCode =a.UnitCode 
		where c.TypeCode=''3'' --and c.Category = ''2'' 
				and c.MenuHeadCode='''+@MH_MG_MSG_Code+'''
				and (('''+@POSDate+''' between c.FromDate and c.ToDate ) OR (c.ToDate = ''01/01/1900'')) 
				and c.POSCode='''+@POSCode+''' ' )
	End
	
END
GO


IF EXISTS(SELECT * FROM sysobjects WHERE type='P' AND name='SprSNCSaveMenuForReservation')        
BEGIN
        DROP PROCEDURE SprSNCSaveMenuForReservation
END
Go
Create Procedure SprSNCSaveMenuForReservation
(
	@xmlReservationDetails varchar(MAX),
	@xmlMenuBanquetItemDetails varchar(MAX),
	@xmlMenuItemDetails varchar(MAX),
	@xmlMenuModifierDetails varchar(MAX),
	@xmlMenuItemCostCenterDetails varchar(MAX),
	@IsPI int,
	@StrLocProformaInvNo nvarchar(MAX),
	@Guid nvarchar(MAX),
	@POSCode Nvarchar(20),	
	@User varchar(4),
	@GroupId char(3),
	@ClientId char(3)
)	
AS	
BEGIN
	DECLARE @xmlHandle INT
	DECLARE @ReservationId INT
	DECLARE @ProformaInvoiceId varchar(20)
	DECLARE @DayId varchar(20)		
	DECLARE @AmdCodeFinal nvarchar(10)
	DECLARE @DblLocCalculatedPrice Decimal
	DECLARE @DblLocCalculatedCost Decimal
	DECLARE @BanquetItemId varchar (24)
	DECLARE @MenuHeadCode int
	DECLARE @MenuItemCode int
	
	CREATE TABLE #TblReservationDetails 
	(
		 [ReservationDetailId] [int]	
		,[ReservationId] [int]				
		,[AreaCode] [int]	
		,[Date] [datetime]
		,[FromDate] [datetime]
		,[ToDate] [datetime]
		,[FromTime] [varchar] (10)
		,[ToTime]	[varchar] (10)
		,[ResvTimeInHours] [int]	
		,[IsThrooBooking] [bit]
		,[GuaranteedPax] [int]
		,[MaximumPax] [int]
		,[SubFunctionCode] [int]
		,[Status] [int]	
		,[OtherDetail] [varchar] (150)		
	)

	CREATE TABLE #TblMenuBanquetItem 
	(
		 [ReservationId] [varchar] (20) 
		,[DayId] [varchar] (20) 
		,[ProformaInvoiceId] [varchar] (20) 
		,[BanquetItemId] [varchar](24) 
		,[GuarantedPax] [int] 
		,[ActualPax] [int] 
		,[PercentPremiumCharge] [decimal](38,2)
		,[AmountPremiumCharge] [decimal](38,2)
		,[PerPaxRate] [decimal](38,2)
		,[CalculatedPaxRate] [decimal](38,2)
		,[PremiumRate] [decimal](38,2)
		,[CalculatedRate] [decimal](38,2)
		,[BanquetItemPriceId] [varchar](24)
		,[KitchenTime] [varchar](30)
		,[ServeTime] [varchar](30)
		,[Status] [varchar](5)
		,[TaxAmt] [money]
		,[TaxStr] [varchar](5000)
		,[Rate] [decimal](38,2)
		,[Discount] [decimal](38,2)
		,[Qty] [int]
		,[CostPrice] [decimal](38,2)
		,[CalculatedPremium] [decimal](38,2)
		,[AmdCode] [int]
		,[UpdatedFrom] [varchar](5)		
	)

	CREATE TABLE #TblMenuItem
	(
		 [ID] int 
		,[ReservationId] [varchar](24)
		,[DayId] [varchar](3)
		,[ProformaInvoiceId] [varchar] (20) 
		,[BanquetItemId] [varchar](24)
		,[MenuHeadCode] [varchar](24)
		,[MenuItemCode] [varchar](24)
		,[IsTDHCost] [bit]
		,[Quantity] [decimal](38, 3)
		,[CostPrice] [decimal](38,2)
		,[PerSalesPrice] [decimal](38,2)
		,[CalculatedPrice] [decimal](38,2)
		,[IsModifier] [bit]
		,[MenuItemRateCode] [varchar](24)
		,[IsFreeFlow] [bit]
		,[MenuHeadType] [varchar](10)
		,[Chargeble] [varchar](5)
		,[Status] [varchar](5)
		,[TaxAmt] [money]
		,[TaxStr] [varchar](5000)
		,[Rate] [decimal](38,2)
		,[Discount] [decimal](38,2)
		,[Qty] [int]
		,[AmdCode] [int]
		,[UpdatedFrom] [varchar](5)		
	)

	CREATE TABLE #TblMenuModifier
	(
		 [ReservationId] [varchar](24)
		,[DayId] [varchar](3)
		,[ProformaInvoiceId] [varchar] (20) 
		,[BanquetItemId] [varchar](24)
		,[MenuHeadCode] [varchar](24)
		,[MenuItemId] [varchar](24)		
		,[ModifierDescription] [varchar](500)
		,[ModifierRate] [decimal] (38,2)
		,[IsFreeFlow] [bit]
		,[MenuHeadType] [varchar](10)
		,[ModifierCost] [decimal] (38,2)
		,[Quantity] [nvarchar](50)
		,[Status] [varchar](5)
		,[TaxAmt] [money]
		,[TaxStr] [varchar](5000)
		,[Rate] [decimal](38,2)
		,[Discount] [decimal](38,2)
		,[Qty] [int]
		,[AmdCode] [int]
		,[UpdatedFrom] [varchar](5)		
	)

	CREATE TABLE #TblMenuItemCostCenter
	(
		 [ReservationId] [varchar](24)
		,[DayId] [varchar](3)
		,[ProformaInvoiceId] [varchar] (20) 
		,[BanquetItemId] [varchar](24)
		,[MenuHeadId] [varchar](24)
		,[MenuItemId] [varchar](24)
		,[CostCenter] [varchar](10)
		,[MenuHeadType] [varchar](10)
		,[AmdCode] [int]
		,[UpdatedFrom] [varchar](5)		
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
								[ToTime]	[varchar] (10) '@StrPubToTime',
								[ResvTimeInHours] [int] '@IntLocResvTimeInHours',
								[IsThrooBooking] [bit] '@EnReservationType',
								[GuaranteedPax]	[int]'@IntPubMinPax',
								[MaximumPax] [int] '@IntPubMaxPax',
								[SubFunctionCode] [int] '@IntSubFunctionCode',							
								[Status] [int] '@EnReservationStatus',
								[OtherDetail] [varchar] (150) '@StrPubOtherDetails'
								)
	EXEC sp_xml_removedocument @xmlHandle

	

	select top 1 
			@ReservationId=[ReservationId],
			@DayId=[ReservationDetailId] 
	from #TblReservationDetails

	SET @ProformaInvoiceId=@StrLocProformaInvNo

	EXEC sp_xml_preparedocument @xmlHandle output, @xmlMenuBanquetItemDetails  
		INSERT INTO #TblMenuBanquetItem
		SELECT @ReservationId,@DayId,@ProformaInvoiceId,[BanquetItemId],[GuarantedPax],[ActualPax],Case When [EnPubPremiumType]=2 then [PremiumRate] else 0 End as [PercentPremiumCharge],Case When [EnPubPremiumType]=2 then [PerPaxRate]*([PremiumRate]/100) else [PremiumRate] End as [AmountPremiumCharge],
			   [PerPaxRate],[CalculatedRate],0,0,[BanquetItemPriceId],[KitchenTime],[ServeTime],'',0,'',0,0,0,[CostPrice],[CalculatedPremium],0,'SNC'
		FROM  OPENXML (@xmlHandle, 'NewDataSet/DataTable',1)
						WITH (									
								 [BanquetItemId] [varchar](24) '@StrPubBanquetItemCode'
								,[GuarantedPax] [int] '@IntPubGuarantedPax'
								,[ActualPax] [int] '@IntPubActualPax'								
								,[PerPaxRate] [decimal](38,2) '@DblPubRate'
								,[CalculatedPaxRate] [decimal](38,2) '@DblPubRate'
								,[EnPubPremiumType] int '@EnPubPremiumType'
								,[PremiumRate] [decimal](38,2) '@DblPubPremiumCharge'
								,[CalculatedRate] [decimal](38,2) '@DblPubCalculatedRate'
								,[BanquetItemPriceId] [varchar](24) '@IntPubRateCode'
								,[KitchenTime] [varchar](30) '@StrPubKitchenTime'
								,[ServeTime] [varchar](30) '@StrPubServiceTime'								
								,[CostPrice] [decimal](38,2) '@DblPubCalculatedCost'
								,[CalculatedPremium] [decimal](38,2) '@DblPubCalculatedPremium'								
								)
	EXEC sp_xml_removedocument @xmlHandle
	
	

	EXEC sp_xml_preparedocument @xmlHandle output, @xmlMenuItemDetails  
		INSERT INTO #TblMenuItem
		SELECT [ID],@ReservationId,@DayId,@ProformaInvoiceId,[BanquetItemId],[MenuHeadCode],[MenuItemCode],[IsTDHCost],[Quantity],[CostPrice],[PerSalesPrice],
			   [CalculatedPrice],[IsModifier],[MenuItemRateCode],[IsFreeFlow],[MenuHeadType],[Chargeble],'',0,'',0,0,0,0,'SNC'
		FROM  OPENXML (@xmlHandle, 'NewDataSet/DataTable',1)
						WITH (	
								 [ID] int '@ID'								
								,[BanquetItemId] [varchar](24) '@StrPubBanquetItemCode'
								,[MenuHeadCode] [varchar](24) '@IntPub_MH_MG_MSG_Code'
								,[MenuItemCode] [varchar](24) '@IntPubMenuItemCode'
								,[IsTDHCost] [bit] '@BlnPubIsFreeFlow'
								,[Quantity] [decimal](38, 3) '@IntPubQuantity'
								--,[CostPrice] [decimal](38,2) '@DblPubCalculatedCost'
								,[CostPrice] [decimal](38,2) '@DblPubCost'
								,[PerSalesPrice] [decimal](38,2) '@DblPubRate'
								,[CalculatedPrice] [decimal](38,2) '@DblPubCalculatedRate'
								,[IsModifier] [bit] '@BlnPubIsModifier'
								,[MenuItemRateCode] [varchar](24) '@IntPubRateCode'
								,[IsFreeFlow] [bit] '@BlnPubIsFreeFlow'
								,[MenuHeadType] [varchar](10) '@EnPub_MH_MG_MSG_Type'
								,[Chargeble] [varchar](5) '@BlnIsCharged'								
								)
	EXEC sp_xml_removedocument @xmlHandle


	EXEC sp_xml_preparedocument @xmlHandle output, @xmlMenuModifierDetails  
		INSERT INTO #TblMenuModifier
		SELECT @ReservationId,@DayId,@ProformaInvoiceId,[BanquetItemId],[MenuHeadCode],[MenuItemId],[ModifierDescription],[ModifierRate],[IsFreeFlow],
			   [MenuHeadType],[ModifierCost],[Quantity],'',0,'',0,0,0,0,'SNC'
		FROM  OPENXML (@xmlHandle, 'NewDataSet/DataTable',1)
						WITH (	
								 [BanquetItemId] [varchar](24) '@StrPubBanquetItemCode'
								,[MenuHeadCode] [varchar](24) '@IntPub_MH_MG_MSG_Code'
								,[MenuItemId] [varchar](24) '@IntPubMenuItemCode'						
								,[ModifierDescription] [varchar](500) '@StrPubModifierName'
								,[ModifierRate] [decimal] (38,2) '@DblPubRate'
								,[IsFreeFlow] [bit] '@BlnPubIsFreeFlow'
								,[MenuHeadType] [varchar](10) '@EnPub_MH_MG_MSG_Type'
								,[ModifierCost] [decimal] (38,2) '@DblPubCost'
								,[Quantity] [nvarchar](50) '@IntPubQuantity'								
							)
	EXEC sp_xml_removedocument @xmlHandle

	EXEC sp_xml_preparedocument @xmlHandle output, @xmlMenuItemCostCenterDetails  
		INSERT INTO #TblMenuItemCostCenter
		SELECT @ReservationId,@DayId,@ProformaInvoiceId,[BanquetItemId],[MenuHeadId],[MenuItemId],[CostCenter],[MenuHeadType],0,'SNC'
		FROM  OPENXML (@xmlHandle, 'NewDataSet/DataTable',1)
						WITH (	
								 [BanquetItemId] [varchar](24) '@StrPubBanquetItemCode'
								,[MenuHeadId] [varchar](24) '@IntPub_MH_MG_MSG_Code'
								,[MenuItemId] [varchar](24) '@IntPubMenuItemCode'
								,[CostCenter] [varchar](10) '@IntPubCostCenterCode'
								,[MenuHeadType] [varchar](10) '@EnPub_MH_MG_MSG_Type'
								)
	EXEC sp_xml_removedocument @xmlHandle
	
	
	

	DECLARE @StrQueryPartialInsertAmdTableAndDelete nvarchar(max)
	DECLARE @StrQueryPartialInsertAmdTableAndDelete1 nvarchar(max)
	DECLARE @StrQueryPartialInsertTable nvarchar(max)
	DECLARE @StrQueryPartialInsertTableMenuServiceOrder nvarchar(max)
	DECLARE @StrQueryPartialInsertCostRev nvarchar(max)

	DECLARE @StrQueryPartialInsertAmdTableAndDeletePI nvarchar(max)
	DECLARE @StrQueryPartialInsertAmdTableAndDelete1PI nvarchar(max)
	DECLARE @StrQueryPartialInsertTablePI nvarchar(max)
	DECLARE @StrQueryPartialInsertTableMenuServiceOrderPI nvarchar(max)
	DECLARE @StrQueryPartialInsertCostRevPI nvarchar(max)

	DECLARE @StrLocQueryDeleteTempData nvarchar(MAX)

	
	DECLARE @StrQueryPartialInsertTablePITemp nvarchar(max)

--=======================================================================For FP Menu Start Here====================================================================================================	
	IF (@IsPI=0)
	BEGIN
			SET @StrQueryPartialInsertAmdTableAndDelete=''		
			SET @StrQueryPartialInsertAmdTableAndDelete='
					INSERT INTO SNC.TblMenuBanquetItemAmd_'+ltrim(rtrim(@POSCode))+'  (ReservationId, DayId, BanquetItemId, GuarantedPax, ActualPax, PercentPremiumCharge, AmountPremiumCharge, PerPaxRate, CalculatedPaxRate, PremiumRate,  CalculatedRate, BanquetItemPriceId, KitchenTime, ServeTime, CalculatedPremium, CostPrice, Amdcode, UpdatedFrom, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate)		select ReservationId, DayId, BanquetItemId, GuarantedPax, ActualPax, PercentPremiumCharge, AmountPremiumCharge, PerPaxRate, convert(float ,ActualPax) * convert(float ,PerPaxRate), PremiumRate,  CalculatedRate, BanquetItemPriceId, KitchenTime, ServeTime, CalculatedPremium, CostPrice, Amdcode, UpdatedFrom, CreatedBy, CreatedDate, '''+ltrim(rtrim(@User))+''', GetDate()  	from SNC.TblMenuBanquetItem_'+ltrim(rtrim(@POSCode))+' where ReservationId= '+ convert(varchar(50),@ReservationId) +' and DayId= '+ Convert(varchar(20),@DayId) +'
					INSERT INTO SNC.TblMenuItemAmd_'+ltrim(rtrim(@POSCode))+'   (ReservationId, DayId, BanquetItemId, MenuHeadCode, MenuItemCode, IsTDHCost, Quantity, CostPrice, PerSalesPrice, CalculatedPrice, IsModifier, MenuItemRateCode, Amdcode, UpdatedFrom, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, IsFreeFlow, MenuHeadType, Chargeble) select ReservationId, DayId, BanquetItemId, MenuHeadCode, MenuItemCode, IsTDHCost, Quantity, CostPrice, PerSalesPrice, CalculatedPrice, IsModifier, MenuItemRateCode, Amdcode, UpdatedFrom, CreatedBy, CreatedDate, '''+ltrim(rtrim(@User))+''', GetDate(), IsFreeFlow, MenuHeadType, Chargeble from SNC.TblMenuItem_'+ltrim(rtrim(@POSCode))+' where ReservationId='+ convert(varchar(50),@ReservationId) +' and DayId= '+ Convert(varchar(20),@DayId) +'                             
					INSERT INTO SNC.TblMenuModifierAmd_'+ltrim(rtrim(@POSCode))+'  (ReservationId, DayId, BanquetItemId, MenuHeadCode, MenuItemId, ModifierId, ModifierDescription, ModifierRate, Amdcode, UpdatedFrom, CreatedDate, CreatedBy, ModifiedBy, ModifiedDate, IsFreeFlow, MenuHeadType,ModifierCost,Quantity) select ReservationId, DayId, BanquetItemId, MenuHeadCode, MenuItemId, ModifierId, ModifierDescription, ModifierRate, Amdcode, UpdatedFrom, CreatedDate, CreatedBy, '''+ltrim(rtrim(@User))+''', GetDate(), IsFreeFlow, MenuHeadType,ModifierCost,Quantity from SNC.TblMenuModifier_'+ltrim(rtrim(@POSCode))+' where ReservationId= '+ convert(varchar(50),@ReservationId) +'and  DayId= '+ Convert(varchar(20),@DayId) +'
					INSERT INTO SNC.TblMenuItemCostCenterAmd_'+ltrim(rtrim(@POSCode))+'  (ReservationId, DayId, BanquetItemId, MenuHeadId, MenuItemId, CostCenter, Amdcode, UpdatedFrom, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, MenuHeadType) select ReservationId, DayId, BanquetItemId, MenuHeadId, MenuItemId, CostCenter, Amdcode, UpdatedFrom, CreatedBy, CreatedDate,'''+ltrim(rtrim(@User))+''',   GetDate(), MenuHeadType from SNC.TblMenuItemCostCenter_'+ltrim(rtrim(@POSCode))+' where ReservationId= '+ convert(varchar(50),@ReservationId) +' and  DayId='+ Convert(varchar(20),@DayId) +'			
					DECLARE @AmdCode int
					SELECT @AmdCode=isnull(max(Amdcode),-1) from SNC.TblMenuItem_'+ltrim(rtrim(@POSCode))+' where  [ReservationId]='+ convert(varchar(50),@ReservationId) +'  and [DayId]='+ Convert(varchar(20),@DayId) +'			
					IF @AmdCode<0
					BEGIN SELECT @AmdCode=isnull(max(Amdcode),-1) from SNC.TblMenuItemAmd_'+ltrim(rtrim(@POSCode))+' where [ReservationId]='+ convert(varchar(50),@ReservationId) +'  and [DayId]='+ Convert(varchar(20),@DayId) +'
					IF @AmdCode<0 BEGIN SET @AmdCode=0 END ELSE BEGIN SET @AmdCode=@AmdCode+2 END END ELSE BEGIN SET @AmdCode=@AmdCode+1	END					
					SET @AmdCodeFinal=@AmdCode
					'
					SET @StrQueryPartialInsertAmdTableAndDelete1=''
					SET @StrQueryPartialInsertAmdTableAndDelete1='
					Delete from SNC.TblMenuBanquetItem_'+ltrim(rtrim(@POSCode))+' where ReservationId= '+ convert(varchar(50),@ReservationId) +'and DayId= '+ Convert(varchar(20),@DayId) +';	Delete from SNC.TblMenuItem_'+ltrim(rtrim(@POSCode))+' where ReservationId='+ convert(varchar(50),@ReservationId) +' and DayId= '+ Convert(varchar(20),@DayId) +' 	;			Delete from SNC.TblMenuModifier_'+ltrim(rtrim(@POSCode))+' where ReservationId= '+ convert(varchar(50),@ReservationId) +' and  DayId= '+ Convert(varchar(20),@DayId) +'  ;			Delete from SNC.TblMenuItemCostCenter_'+ltrim(rtrim(@POSCode))+' where ReservationId= '+ convert(varchar(50),@ReservationId) +' and  DayId='+ Convert(varchar(20),@DayId) +'
					Delete from SNC.TblMenuServiceOrder_'+ltrim(rtrim(@POSCode))+' where BanquetItemId=''A1LC'' and ALACARTE not in (select MenuItemCode from SNC.TblMenuItem_'+ltrim(rtrim(@POSCode))+' as TblMenuItem join SNC.TblMenuServiceOrder_'+ltrim(rtrim(@POSCode))+' as TblMenuServiceOrder on TblMenuItem.MenuItemCode=TblMenuServiceOrder.ALACARTE and TblMenuServiceOrder.MenuHeadId=TblMenuItem.MenuHeadCode and TblMenuServiceOrder.ReservationId=TblMenuItem.ReservationId and TblMenuItem.DayId=TblMenuServiceOrder.DayId where  (TblMenuServiceOrder.UpdatedFrom =''MF'' or TblMenuServiceOrder.UpdatedFrom =''PI'') and TblMenuServiceOrder.ReservationId= '+ convert(varchar(50),@ReservationId) +' and TblMenuServiceOrder.DayId='+ Convert(varchar(20),@DayId) +') and ReservationId='+ convert(varchar(50),@ReservationId) +'  and DayId='+ Convert(varchar(20),@DayId) +' and (UpdatedFrom =''MF'' or UpdatedFrom =''PI'') 
					Delete from SNC.TblMenuServiceOrder_'+ltrim(rtrim(@POSCode))+' where BanquetItemId!=''A1LC'' and BanquetItemId not in (select TblMenuBanquetItem.BanquetItemId from SNC.TblMenuBanquetItem_'+ltrim(rtrim(@POSCode))+' as TblMenuBanquetItem join SNC.TblMenuServiceOrder_'+ltrim(rtrim(@POSCode))+' as TblMenuServiceOrder on TblMenuBanquetItem.BanquetItemId=TblMenuServiceOrder.BanquetItemId and TblMenuServiceOrder.ReservationId=TblMenuBanquetItem.ReservationId and TblMenuServiceOrder.DayId=TblMenuBanquetItem.DayId where  (TblMenuServiceOrder.UpdatedFrom =''MF'' or TblMenuServiceOrder.UpdatedFrom =''PI'') and TblMenuServiceOrder.ReservationId='+ convert(varchar(50),@ReservationId) +'  and TblMenuServiceOrder.DayId='+ Convert(varchar(20),@DayId) +') and ReservationId='+ convert(varchar(50),@ReservationId) +'  and DayId='+ Convert(varchar(20),@DayId) +' and (UpdatedFrom =''MF'' or UpdatedFrom =''PI'')	
					UPDATE SNC.TblCostRevenue_'+ltrim(rtrim(@POSCode))+' SET TotalCost=Convert(float,'''+convert(varchar(20),0)+'''),TotalRevenue=Convert(float,'''+convert(varchar(20),0)+'''),ModifiedBy ='''+convert(varchar(50),@User)+''', ModifiedOn = GETDATE() WHERE ReservationId='+ Convert(varchar(20),@ReservationId) +' AND ReservationDetailId='+ Convert(varchar(20),@DayId) +' AND Neumonic=''MENU''
					'
			Print(@StrQueryPartialInsertAmdTableAndDelete)
			DECLARE @ParmDefinition nvarchar(500);
			SET @ParmDefinition = ' @AmdCodeFinal nvarchar(10) OUTPUT';
			EXECUTE sp_executesql  @StrQueryPartialInsertAmdTableAndDelete,@ParmDefinition,@AmdCodeFinal=@AmdCodeFinal OUTPUT
			EXECUTE sp_executesql  @StrQueryPartialInsertAmdTableAndDelete1

			Select @AmdCodeFinal as a


			SET @StrQueryPartialInsertTable=''
			SET @StrQueryPartialInsertTable='
				INSERT INTO SNC.TblMenuBanquetItem_'+ltrim(rtrim(@POSCode))+'
					(ReservationId,DayId,BanquetItemId,GuarantedPax,ActualPax,PercentPremiumCharge,AmountPremiumCharge
					,PerPaxRate,CalculatedPaxRate,PremiumRate,CalculatedRate,BanquetItemPriceId,KitchenTime,ServeTime,CostPrice,CalculatedPremium,AmdCode,UpdatedFrom,CreatedBy,CreatedDate,ModifiedBy,ModifiedDate,GroupID,ClientID)
				SELECT ReservationId,DayId,BanquetItemId,GuarantedPax,ActualPax,PercentPremiumCharge,AmountPremiumCharge
					,PerPaxRate,CalculatedPaxRate,PremiumRate,CalculatedRate,BanquetItemPriceId,KitchenTime,ServeTime,CostPrice,CalculatedPremium,@AmdCodeFinal,UpdatedFrom,'''+ltrim(rtrim(@User))+''',GetDate(),'''+ltrim(rtrim(@User))+''',GetDate(),'''+ltrim(rtrim(@GroupId))+''','''+ltrim(rtrim(@ClientId))+''' 
				From #TblMenuBanquetItem
		
				INSERT INTO SNC.TblMenuItem_'+ltrim(rtrim(@POSCode))+' 
					(ReservationId,DayId,BanquetItemId,MenuHeadCode,MenuItemCode,IsTDHCost,Quantity,CostPrice,PerSalesPrice,CalculatedPrice,IsModifier,MenuItemRateCode
					,IsFreeFlow,MenuHeadType,Chargeble,AmdCode,UpdatedFrom,CreatedBy,CreatedDate,ModifiedBy,ModifiedDate,GroupID,ClientID)
				SELECT ReservationId,DayId,BanquetItemId,MenuHeadCode,MenuItemCode,IsTDHCost,Quantity,CostPrice,PerSalesPrice,CalculatedPrice,IsModifier,MenuItemRateCode
					,IsFreeFlow,MenuHeadType,Chargeble,@AmdCodeFinal,UpdatedFrom,'''+ltrim(rtrim(@User))+''',GetDate(),'''+ltrim(rtrim(@User))+''',GetDate(),'''+ltrim(rtrim(@GroupId))+''','''+ltrim(rtrim(@ClientId))+''' 
				From #TblMenuItem

				INSERT INTO SNC.TblMenuModifier_'+ltrim(rtrim(@POSCode))+' 
					(ReservationId,DayId,BanquetItemId,MenuHeadCode,MenuItemId,ModifierDescription,ModifierRate,IsFreeFlow,MenuHeadType,ModifierCost,Quantity
					,AmdCode,UpdatedFrom,CreatedBy,CreatedDate,ModifiedBy,ModifiedDate,GroupID,ClientID)
				SELECT ReservationId,DayId,BanquetItemId,MenuHeadCode,MenuItemId,ModifierDescription,ModifierRate,IsFreeFlow,MenuHeadType,ModifierCost,Quantity
					,@AmdCodeFinal,UpdatedFrom,'''+ltrim(rtrim(@User))+''',GetDate(),'''+ltrim(rtrim(@User))+''',GetDate(),'''+ltrim(rtrim(@GroupId))+''','''+ltrim(rtrim(@ClientId))+''' 		
				From #TblMenuModifier

				INSERT INTO SNC.TblMenuItemCostCenter_'+ltrim(rtrim(@POSCode))+'
					(ReservationId,DayId,BanquetItemId,MenuHeadId,MenuItemId,CostCenter,MenuHeadType,AmdCode,UpdatedFrom
					,CreatedBy,CreatedDate,ModifiedBy,ModifiedDate,GroupID,ClientID)
				SELECT ReservationId,DayId,BanquetItemId,MenuHeadId,MenuItemId,CostCenter,MenuHeadType,@AmdCodeFinal,UpdatedFrom
					,'''+ltrim(rtrim(@User))+''',GetDate(),'''+ltrim(rtrim(@User))+''',GetDate(),'''+ltrim(rtrim(@GroupId))+''','''+ltrim(rtrim(@ClientId))+''' 
				From #TblMenuItemCostCenter
			'
			DECLARE @ParmDefinitionInsert nvarchar(500);				
			SET @ParmDefinitionInsert = ' @AmdCodeFinal nvarchar(10)';
			EXECUTE sp_executesql  @StrQueryPartialInsertTable,@ParmDefinitionInsert,@AmdCodeFinal=@AmdCodeFinal
		
			DECLARE @MyCursor CURSOR;
				DECLARE @MyField int;
				BEGIN
					SET @MyCursor = CURSOR FOR
					select ID from #TblMenuItem
       

					OPEN @MyCursor 
					FETCH NEXT FROM @MyCursor 
					INTO @MyField						

					WHILE @@FETCH_STATUS = 0
					BEGIN

						Select 			   
							 @BanquetItemId=[BanquetItemId]
							,@MenuHeadCode=[MenuHeadCode]
							,@MenuItemCode=[MenuItemCode]
							,@DblLocCalculatedCost=[Quantity] *[CostPrice]
						From #TblMenuItem where ID=@MyField						

						SET @StrQueryPartialInsertCostRev=''
						set @StrQueryPartialInsertCostRev='			
							IF (SELECT COUNT(*) FROM SNC.TblCostRevenue_'+ltrim(rtrim(@POSCode))+' WHERE ReservationId='''+ convert(varchar(50),@ReservationId) +''' AND ReservationDetailId='''+ Convert(varchar(20),@DayId) +''' AND Neumonic=''MENU'' ) >0
							BEGIN
								UPDATE SNC.TblCostRevenue_'+ltrim(rtrim(@POSCode))+' SET TotalCost= TotalCost+Convert(float,'''+convert(varchar(20),isnull(@DblLocCalculatedCost,0))+'''),ModifiedBy ='''+convert(varchar(50),@User)+''', ModifiedOn = GETDATE() WHERE ReservationId='+ Convert(varchar(20),@ReservationId) +' AND ReservationDetailId='+ Convert(varchar(20),@DayId) +' AND Neumonic=''MENU''
							END
							ELSE					
							BEGIN
								INSERT INTO SNC.TblCostRevenue_'+ltrim(rtrim(@POSCode))+'(ReservationId, ReservationDetailId, Neumonic, TotalCost, TotalRevenue, UpdatedFrom, CreatedBy, CreatedOn, ModifiedBy, ModifiedOn)
								VALUES ('''+ convert(varchar(50),@ReservationId) +''', '''+ convert(varchar(50),@DayId) +''', ''MENU'', Convert(float,'''+convert(varchar(20),isnull(@DblLocCalculatedCost,0))+'''), Convert(float,'''+convert(varchar(20),0.00)+'''), ''SNC'', '''+convert(varchar(50),@User)+''', GETDATE(), '''+convert(varchar(50),@User)+''', GETDATE())
							END
						'
						EXECUTE sp_executesql  @StrQueryPartialInsertCostRev

						SET @StrQueryPartialInsertTableMenuServiceOrder=''
						SET @StrQueryPartialInsertTableMenuServiceOrder='
								EXEC SprSNCInsertMenuServiceOrder '''+ convert(varchar(50),@ReservationId) +''','''+ Convert(varchar(20),@DayId) +''',''MF'','''+Convert(varchar(20),@BanquetItemId)+''','''+convert(varchar(50),@User)+''','''+CONVERT(varchar(50),@MenuHeadCode)+''','''+CONVERT(varchar(50),@MenuItemCode)+''','''','''+ Convert(varchar(20),@POSCode) +'''  
							'
						EXECUTE sp_executesql  @StrQueryPartialInsertTableMenuServiceOrder	
						
		
	
					FETCH NEXT FROM @MyCursor 
					INTO @MyField 

					END; 

					CLOSE @MyCursor ;
					DEALLOCATE @MyCursor;

				END;

				
				
				BEGIN
					SET @MyCursor = CURSOR FOR
					select [CalculatedPaxRate] from #TblMenuBanquetItem       

					OPEN @MyCursor 
					FETCH NEXT FROM @MyCursor 
					INTO @MyField						

					WHILE @@FETCH_STATUS = 0
					BEGIN				

						SET @StrQueryPartialInsertCostRev=''
						set @StrQueryPartialInsertCostRev='									
								UPDATE SNC.TblCostRevenue_'+ltrim(rtrim(@POSCode))+' SET  TotalRevenue= TotalRevenue+Convert(float,'''+convert(varchar(20),isnull(@MyField,0))+'''),ModifiedBy ='''+convert(varchar(50),@User)+''', ModifiedOn = GETDATE() WHERE ReservationId='+ Convert(varchar(20),@ReservationId) +' AND ReservationDetailId='+ Convert(varchar(20),@DayId) +' AND Neumonic=''MENU''
							
						'
						EXECUTE sp_executesql  @StrQueryPartialInsertCostRev
						
					FETCH NEXT FROM @MyCursor 
					INTO @MyField 

					END; 

					CLOSE @MyCursor ;
					DEALLOCATE @MyCursor;

				END;	

	END
--=======================================================================For FP Menu End Here====================================================================================================


--=======================================================================For PI Start Here====================================================================================================
	ELSE IF (@IsPI=1)	
	BEGIN
	
			SET @StrQueryPartialInsertAmdTableAndDeletePI=''		
			SET @StrQueryPartialInsertAmdTableAndDeletePI='
					INSERT INTO SNC.TblChallanMenuBanquetItemAmd_'+ltrim(rtrim(@POSCode))+'  (ReservationId, DayId,ProformaInvoiceId, BanquetItemId, GuarantedPax, ActualPax, PercentPremiumCharge, AmountPremiumCharge, PerPaxRate, CalculatedPaxRate, PremiumRate,  CalculatedRate, BanquetItemPriceId, KitchenTime, ServeTime,Status,TaxAmt,TaxStr,Rate,Discount,Qty,CalculatedPremium, CostPrice, Amdcode, UpdatedFrom, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate)		select ReservationId, DayId, ProformaInvoiceId,BanquetItemId, GuarantedPax, ActualPax, PercentPremiumCharge, AmountPremiumCharge, PerPaxRate, convert(float ,ActualPax) * convert(float ,PerPaxRate), PremiumRate,  CalculatedRate, BanquetItemPriceId, KitchenTime, ServeTime,Status,TaxAmt,TaxStr,Rate,Discount,Qty,CalculatedPremium, CostPrice, Amdcode, UpdatedFrom, CreatedBy, CreatedDate, '''+ltrim(rtrim(@User))+''', GetDate()  	from SNC.TblChallanMenuBanquetItem_'+ltrim(rtrim(@POSCode))+' where ReservationId= '+ convert(varchar(50),@ReservationId) +' and DayId= '+ Convert(varchar(20),@DayId) +' and ProformaInvoiceId= '''+ Convert(varchar(20),@ProformaInvoiceId) +'''
					INSERT INTO SNC.TblChallanMenuItemAmd_'+ltrim(rtrim(@POSCode))+'   (ReservationId, DayId,ProformaInvoiceId, BanquetItemId, MenuHeadCode, MenuItemCode, IsTDHCost, Quantity, CostPrice, PerSalesPrice, CalculatedPrice, IsModifier, MenuItemRateCode, Amdcode, UpdatedFrom, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, IsFreeFlow, MenuHeadType,Chargeble,Status,TaxAmt,TaxStr,Rate,Discount,Qty) select ReservationId, DayId,ProformaInvoiceId, BanquetItemId, MenuHeadCode, MenuItemCode, IsTDHCost, Quantity, CostPrice, PerSalesPrice, CalculatedPrice, IsModifier, MenuItemRateCode, Amdcode, UpdatedFrom, CreatedBy, CreatedDate, '''+ltrim(rtrim(@User))+''', GetDate(), IsFreeFlow, MenuHeadType,Chargeble,Status,TaxAmt,TaxStr,Rate,Discount,Qty from SNC.TblChallanMenuItem_'+ltrim(rtrim(@POSCode))+' where ReservationId='+ convert(varchar(50),@ReservationId) +' and DayId= '+ Convert(varchar(20),@DayId) +'and ProformaInvoiceId= '''+ Convert(varchar(20),@ProformaInvoiceId) +'''
					INSERT INTO SNC.TblChallanMenuModifierAmd_'+ltrim(rtrim(@POSCode))+'  (ReservationId, DayId,ProformaInvoiceId, BanquetItemId, MenuHeadCode, MenuItemId, ModifierId, ModifierDescription, ModifierRate, Amdcode, UpdatedFrom, CreatedDate, CreatedBy, ModifiedBy, ModifiedDate, IsFreeFlow, MenuHeadType,ModifierCost,Quantity,Status,TaxAmt,TaxStr,Rate,Discount,Qty) select ReservationId, DayId,ProformaInvoiceId, BanquetItemId, MenuHeadCode, MenuItemId, ModifierId, ModifierDescription, ModifierRate, Amdcode, UpdatedFrom, CreatedDate, CreatedBy, '''+ltrim(rtrim(@User))+''', GetDate(), IsFreeFlow, MenuHeadType,ModifierCost,Quantity,Status,TaxAmt,TaxStr,Rate,Discount,Qty from SNC.TblChallanMenuModifier_'+ltrim(rtrim(@POSCode))+' where ReservationId= '+ convert(varchar(50),@ReservationId) +'and  DayId= '+ Convert(varchar(20),@DayId) +' and ProformaInvoiceId= '''+ Convert(varchar(20),@ProformaInvoiceId) +'''
					INSERT INTO SNC.TblChallanMenuItemCostCenterAmd_'+ltrim(rtrim(@POSCode))+'  (ReservationId, DayId,ProformaInvoiceId, BanquetItemId, MenuHeadId, MenuItemId, CostCenter, Amdcode, UpdatedFrom, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, MenuHeadType) select ReservationId, DayId, ProformaInvoiceId,BanquetItemId, MenuHeadId, MenuItemId, CostCenter, Amdcode, UpdatedFrom, CreatedBy, CreatedDate,'''+ltrim(rtrim(@User))+''',   GetDate(), MenuHeadType from SNC.TblChallanMenuItemCostCenter_'+ltrim(rtrim(@POSCode))+' where ReservationId= '+ convert(varchar(50),@ReservationId) +' and  DayId='+ Convert(varchar(20),@DayId) +' and ProformaInvoiceId= '''+ Convert(varchar(20),@ProformaInvoiceId) +'''
					DECLARE @AmdCode int
					SELECT @AmdCode=isnull(max(Amdcode),-1) from SNC.TblChallanMenuItem_'+ltrim(rtrim(@POSCode))+' where  [ReservationId]='+ convert(varchar(50),@ReservationId) +'  and [DayId]='+ Convert(varchar(20),@DayId) +'	and ProformaInvoiceId= '''+ Convert(varchar(20),@ProformaInvoiceId) +'''	
					IF @AmdCode<0
					BEGIN SELECT @AmdCode=isnull(max(Amdcode),-1) from SNC.TblChallanMenuItemAmd_'+ltrim(rtrim(@POSCode))+' where [ReservationId]='+ convert(varchar(50),@ReservationId) +'  and [DayId]='+ Convert(varchar(20),@DayId) +' and ProformaInvoiceId= '''+ Convert(varchar(20),@ProformaInvoiceId) +'''
					IF @AmdCode<0 BEGIN SET @AmdCode=0 END ELSE BEGIN SET @AmdCode=@AmdCode+2 END END ELSE BEGIN SET @AmdCode=@AmdCode+1	END					
					SET @AmdCodeFinal=@AmdCode
					'
					SET @StrQueryPartialInsertAmdTableAndDelete1PI=''
					SET @StrQueryPartialInsertAmdTableAndDelete1PI='
					Delete from SNC.TblChallanMenuBanquetItem_'+ltrim(rtrim(@POSCode))+' where ReservationId= '+ convert(varchar(50),@ReservationId) +'and DayId= '+ Convert(varchar(20),@DayId) +' and ProformaInvoiceId= '''+ Convert(varchar(20),@ProformaInvoiceId) +''';	Delete from SNC.TblChallanMenuItem_'+ltrim(rtrim(@POSCode))+' where ReservationId='+ convert(varchar(50),@ReservationId) +' and DayId= '+ Convert(varchar(20),@DayId) +' and ProformaInvoiceId= '''+ Convert(varchar(20),@ProformaInvoiceId) +'''	;			Delete from SNC.TblChallanMenuModifier_'+ltrim(rtrim(@POSCode))+' where ReservationId= '+ convert(varchar(50),@ReservationId) +' and  DayId= '+ Convert(varchar(20),@DayId) +' and ProformaInvoiceId= '''+ Convert(varchar(20),@ProformaInvoiceId) +''' ;			Delete from SNC.TblChallanMenuItemCostCenter_'+ltrim(rtrim(@POSCode))+' where ReservationId= '+ convert(varchar(50),@ReservationId) +' and  DayId='+ Convert(varchar(20),@DayId) +' and ProformaInvoiceId= '''+ Convert(varchar(20),@ProformaInvoiceId) +'''
					Delete from SNC.TblMenuServiceOrder_'+ltrim(rtrim(@POSCode))+' where BanquetItemId=''A1LC'' and ALACARTE not in (select MenuItemCode from SNC.TblChallanMenuItem_'+ltrim(rtrim(@POSCode))+' as TblMenuItem join SNC.TblMenuServiceOrder_'+ltrim(rtrim(@POSCode))+' as TblMenuServiceOrder on TblMenuItem.MenuItemCode=TblMenuServiceOrder.ALACARTE and TblMenuServiceOrder.MenuHeadId=TblMenuItem.MenuHeadCode and TblMenuServiceOrder.ReservationId=TblMenuItem.ReservationId and TblMenuItem.DayId=TblMenuServiceOrder.DayId where  TblMenuServiceOrder.UpdatedFrom =''PI'' and TblMenuServiceOrder.ReservationId= '+ convert(varchar(50),@ReservationId) +' and TblMenuServiceOrder.DayId='+ Convert(varchar(20),@DayId) +' and TblMenuItem.ProformaInvoiceId= '''+ Convert(varchar(20),@ProformaInvoiceId) +''') and ReservationId='+ convert(varchar(50),@ReservationId) +'  and DayId='+ Convert(varchar(20),@DayId) +' and UpdatedFrom =''PI''
					Delete from SNC.TblMenuServiceOrder_'+ltrim(rtrim(@POSCode))+' where BanquetItemId!=''A1LC'' and BanquetItemId not in (select TblMenuBanquetItem.BanquetItemId from SNC.TblChallanMenuBanquetItem_'+ltrim(rtrim(@POSCode))+' as TblMenuBanquetItem join SNC.TblMenuServiceOrder_'+ltrim(rtrim(@POSCode))+' as TblMenuServiceOrder on TblMenuBanquetItem.BanquetItemId=TblMenuServiceOrder.BanquetItemId and TblMenuServiceOrder.ReservationId=TblMenuBanquetItem.ReservationId and TblMenuServiceOrder.DayId=TblMenuBanquetItem.DayId where  TblMenuServiceOrder.UpdatedFrom =''PI'' and TblMenuServiceOrder.ReservationId='+ convert(varchar(50),@ReservationId) +'  and TblMenuServiceOrder.DayId='+ Convert(varchar(20),@DayId) + ' and TblMenuBanquetItem.ProformaInvoiceId= '''+ Convert(varchar(20),@ProformaInvoiceId) +''') and ReservationId='+ convert(varchar(50),@ReservationId) +'  and DayId='+ Convert(varchar(20),@DayId) +' and UpdatedFrom =''PI''
					UPDATE SNC.TblCostRevenue_'+ltrim(rtrim(@POSCode))+' SET TotalCost=Convert(float,'''+convert(varchar(20),0)+'''),TotalRevenue=Convert(float,'''+convert(varchar(20),0)+'''),ModifiedBy ='''+convert(varchar(50),@User)+''', ModifiedOn = GETDATE() WHERE ReservationId='+ Convert(varchar(20),@ReservationId) +' AND ReservationDetailId='+ Convert(varchar(20),@DayId) +' AND Neumonic=''MENU''
					'

			Print(@StrQueryPartialInsertAmdTableAndDeletePI)
			DECLARE @ParmDefinitionPI nvarchar(500);
			SET @ParmDefinitionPI = ' @AmdCodeFinal nvarchar(10) OUTPUT';
			EXECUTE sp_executesql  @StrQueryPartialInsertAmdTableAndDeletePI,@ParmDefinitionPI,@AmdCodeFinal=@AmdCodeFinal OUTPUT
			EXECUTE sp_executesql  @StrQueryPartialInsertAmdTableAndDelete1PI

			--Select @AmdCodeFinal as a


			SET @StrQueryPartialInsertTablePI=''
			SET @StrQueryPartialInsertTablePI='
				INSERT INTO SNC.TblChallanMenuBanquetItem_'+ltrim(rtrim(@POSCode))+'
					(ReservationId,DayId,ProformaInvoiceId,BanquetItemId,GuarantedPax,ActualPax,PercentPremiumCharge,AmountPremiumCharge
					,PerPaxRate,CalculatedPaxRate,PremiumRate,CalculatedRate,BanquetItemPriceId,KitchenTime,ServeTime,Status,TaxAmt,TaxStr
					,Rate,Discount,Qty,CostPrice,CalculatedPremium,AmdCode,UpdatedFrom,CreatedBy,CreatedDate,ModifiedBy,ModifiedDate,GroupID,ClientID)
				SELECT ReservationId,DayId,ProformaInvoiceId,BanquetItemId,GuarantedPax,ActualPax,PercentPremiumCharge,AmountPremiumCharge
					,PerPaxRate,CalculatedPaxRate,PremiumRate,CalculatedRate,BanquetItemPriceId,KitchenTime,ServeTime,Status,TaxAmt,TaxStr
					,Rate,Discount,Qty,CostPrice,CalculatedPremium,@AmdCodeFinal,UpdatedFrom,'''+ltrim(rtrim(@User))+''',GetDate(),'''+ltrim(rtrim(@User))+''',GetDate(),'''+ltrim(rtrim(@GroupId))+''','''+ltrim(rtrim(@ClientId))+''' 
				From #TblMenuBanquetItem
		
				INSERT INTO SNC.TblChallanMenuItem_'+ltrim(rtrim(@POSCode))+' 
					(ReservationId,DayId,ProformaInvoiceId,BanquetItemId,MenuHeadCode,MenuItemCode,IsTDHCost,Quantity,CostPrice,PerSalesPrice,CalculatedPrice,IsModifier,MenuItemRateCode
					,IsFreeFlow,MenuHeadType,Chargeble,Status,TaxAmt,TaxStr,Rate,Discount,Qty,AmdCode,UpdatedFrom,CreatedBy,CreatedDate,ModifiedBy,ModifiedDate,GroupID,ClientID)
				SELECT ReservationId,DayId,ProformaInvoiceId,BanquetItemId,MenuHeadCode,MenuItemCode,IsTDHCost,Quantity,CostPrice,PerSalesPrice,CalculatedPrice,IsModifier,MenuItemRateCode
					,IsFreeFlow,MenuHeadType,Chargeble,Status,TaxAmt,TaxStr,Rate,Discount,Qty,@AmdCodeFinal,UpdatedFrom,'''+ltrim(rtrim(@User))+''',GetDate(),'''+ltrim(rtrim(@User))+''',GetDate(),'''+ltrim(rtrim(@GroupId))+''','''+ltrim(rtrim(@ClientId))+''' 
				From #TblMenuItem

				INSERT INTO SNC.TblChallanMenuModifier_'+ltrim(rtrim(@POSCode))+' 
					(ReservationId,DayId,ProformaInvoiceId,BanquetItemId,MenuHeadCode,MenuItemId,ModifierDescription,ModifierRate,IsFreeFlow,MenuHeadType,ModifierCost,Quantity
					,Status,TaxAmt,TaxStr,Rate,Discount,Qty,AmdCode,UpdatedFrom,CreatedBy,CreatedDate,ModifiedBy,ModifiedDate,GroupID,ClientID)
				SELECT ReservationId,DayId,ProformaInvoiceId,BanquetItemId,MenuHeadCode,MenuItemId,ModifierDescription,ModifierRate,IsFreeFlow,MenuHeadType,ModifierCost,Quantity
					,Status,TaxAmt,TaxStr,Rate,Discount,Qty,@AmdCodeFinal,UpdatedFrom,'''+ltrim(rtrim(@User))+''',GetDate(),'''+ltrim(rtrim(@User))+''',GetDate(),'''+ltrim(rtrim(@GroupId))+''','''+ltrim(rtrim(@ClientId))+''' 		
				From #TblMenuModifier

				INSERT INTO SNC.TblChallanMenuItemCostCenter_'+ltrim(rtrim(@POSCode))+'
					(ReservationId,DayId,ProformaInvoiceId,BanquetItemId,MenuHeadId,MenuItemId,CostCenter,MenuHeadType,AmdCode,UpdatedFrom
					,CreatedBy,CreatedDate,ModifiedBy,ModifiedDate,GroupID,ClientID)
				SELECT ReservationId,DayId,ProformaInvoiceId,BanquetItemId,MenuHeadId,MenuItemId,CostCenter,MenuHeadType,@AmdCodeFinal,UpdatedFrom
					,'''+ltrim(rtrim(@User))+''',GetDate(),'''+ltrim(rtrim(@User))+''',GetDate(),'''+ltrim(rtrim(@GroupId))+''','''+ltrim(rtrim(@ClientId))+''' 
				From #TblMenuItemCostCenter
			'
			DECLARE @ParmDefinitionInsertPI nvarchar(500);				
			SET @ParmDefinitionInsertPI = ' @AmdCodeFinal nvarchar(10)';
			EXECUTE sp_executesql  @StrQueryPartialInsertTablePI,@ParmDefinitionInsertPI,@AmdCodeFinal=@AmdCodeFinal
	
	
				
				BEGIN
					SET @MyCursor = CURSOR FOR
					select ID from #TblMenuItem       

					OPEN @MyCursor 
					FETCH NEXT FROM @MyCursor 
					INTO @MyField						

					WHILE @@FETCH_STATUS = 0
					BEGIN

						Select 			   
							 @BanquetItemId=[BanquetItemId]
							,@MenuHeadCode=[MenuHeadCode]
							,@MenuItemCode=[MenuItemCode]
							,@DblLocCalculatedCost=[Quantity] *[CostPrice]
						From #TblMenuItem where ID=@MyField						

						SET @StrQueryPartialInsertCostRev=''
						set @StrQueryPartialInsertCostRev='			
							IF (SELECT COUNT(*) FROM SNC.TblCostRevenue_'+ltrim(rtrim(@POSCode))+' WHERE ReservationId='''+ convert(varchar(50),@ReservationId) +''' AND ReservationDetailId='''+ Convert(varchar(20),@DayId) +''' AND Neumonic=''MENU'' ) >0
							BEGIN
								UPDATE SNC.TblCostRevenue_'+ltrim(rtrim(@POSCode))+' SET TotalCost= TotalCost+Convert(float,'''+convert(varchar(20),isnull(@DblLocCalculatedCost,0))+'''),ModifiedBy ='''+convert(varchar(50),@User)+''', ModifiedOn = GETDATE() WHERE ReservationId='+ Convert(varchar(20),@ReservationId) +' AND ReservationDetailId='+ Convert(varchar(20),@DayId) +' AND Neumonic=''MENU''
							END
							ELSE					
							BEGIN
								INSERT INTO SNC.TblCostRevenue_'+ltrim(rtrim(@POSCode))+'(ReservationId, ReservationDetailId, Neumonic, TotalCost, TotalRevenue, UpdatedFrom, CreatedBy, CreatedOn, ModifiedBy, ModifiedOn)
								VALUES ('''+ convert(varchar(50),@ReservationId) +''', '''+ convert(varchar(50),@DayId) +''', ''MENU'', Convert(float,'''+convert(varchar(20),isnull(@DblLocCalculatedCost,0))+'''), Convert(float,'''+convert(varchar(20),0.00)+'''), ''SNC'', '''+convert(varchar(50),@User)+''', GETDATE(), '''+convert(varchar(50),@User)+''', GETDATE())
							END
						'
						EXECUTE sp_executesql  @StrQueryPartialInsertCostRev

						SET @StrQueryPartialInsertTableMenuServiceOrder=''
						SET @StrQueryPartialInsertTableMenuServiceOrder='
								EXEC SprSNCInsertMenuServiceOrder '''+ convert(varchar(50),@ReservationId) +''','''+ Convert(varchar(20),@DayId) +''',''MF'','''+Convert(varchar(20),@BanquetItemId)+''','''+convert(varchar(50),@User)+''','''+CONVERT(varchar(50),@MenuHeadCode)+''','''+CONVERT(varchar(50),@MenuItemCode)+''','''','''+ Convert(varchar(20),@POSCode) +'''  
							'
						EXECUTE sp_executesql  @StrQueryPartialInsertTableMenuServiceOrder	
						
		
	
					FETCH NEXT FROM @MyCursor 
					INTO @MyField 

					END; 

					CLOSE @MyCursor ;
					DEALLOCATE @MyCursor;

				END;

				
				
				BEGIN
					SET @MyCursor = CURSOR FOR
					select [CalculatedPaxRate] from #TblMenuBanquetItem       

					OPEN @MyCursor 
					FETCH NEXT FROM @MyCursor 
					INTO @MyField						

					WHILE @@FETCH_STATUS = 0
					BEGIN				

						SET @StrQueryPartialInsertCostRev=''
						set @StrQueryPartialInsertCostRev='									
								UPDATE SNC.TblCostRevenue_'+ltrim(rtrim(@POSCode))+' SET TotalRevenue= TotalRevenue+Convert(float,'''+convert(varchar(20),isnull(@MyField,0))+'''),ModifiedBy ='''+convert(varchar(50),@User)+''', ModifiedOn = GETDATE() WHERE ReservationId='+ Convert(varchar(20),@ReservationId) +' AND ReservationDetailId='+ Convert(varchar(20),@DayId) +' AND Neumonic=''MENU''
							
						'
						EXECUTE sp_executesql  @StrQueryPartialInsertCostRev
						
					FETCH NEXT FROM @MyCursor 
					INTO @MyField 

					END; 

					CLOSE @MyCursor ;
					DEALLOCATE @MyCursor;

				END;	
				
				
				SET @StrLocQueryDeleteTempData=''
				SET @StrLocQueryDeleteTempData='Delete from SNC.TblChallanMenuBanquetItemTemp_'+ltrim(rtrim(@POSCode))+' where ReservationId= '+ convert(varchar(50),@ReservationId) +'and DayId= '+ Convert(varchar(20),@DayId) +' and Guid= '''+ @Guid +''';	
				Delete from SNC.TblChallanMenuItemTemp_'+ltrim(rtrim(@POSCode))+' where ReservationId='+ convert(varchar(50),@ReservationId) +' and DayId= '+ Convert(varchar(20),@DayId) +' and Guid= '''+ @Guid +'''	;			
				Delete from SNC.TblChallanMenuModifierTemp_'+ltrim(rtrim(@POSCode))+' where ReservationId= '+ convert(varchar(50),@ReservationId) +' and  DayId= '+ Convert(varchar(20),@DayId) +' and Guid= '''+ @Guid +''' ;			
				Delete from SNC.TblChallanMenuItemCostCenterTemp_'+ltrim(rtrim(@POSCode))+' where ReservationId= '+ convert(varchar(50),@ReservationId) +' and  DayId='+ Convert(varchar(20),@DayId) +' and Guid= '''+ @Guid +'''
				'
				EXECUTE sp_executesql  @StrLocQueryDeleteTempData

	END
--=======================================================================For PI End Here====================================================================================================


--=======================================================================For PI Temp Start Here====================================================================================================
	ELSE IF (@IsPI=2)
	BEGIN			
			SET @StrLocQueryDeleteTempData=''
			SET @StrLocQueryDeleteTempData='Delete from SNC.TblChallanMenuBanquetItemTemp_'+ltrim(rtrim(@POSCode))+' where ReservationId= '+ convert(varchar(50),@ReservationId) +'and DayId= '+ Convert(varchar(20),@DayId) +';	
			Delete from SNC.TblChallanMenuItemTemp_'+ltrim(rtrim(@POSCode))+' where ReservationId='+ convert(varchar(50),@ReservationId) +' and DayId= '+ Convert(varchar(20),@DayId) +' 	;			
			Delete from SNC.TblChallanMenuModifierTemp_'+ltrim(rtrim(@POSCode))+' where ReservationId= '+ convert(varchar(50),@ReservationId) +' and  DayId= '+ Convert(varchar(20),@DayId) +'  ;			
			Delete from SNC.TblChallanMenuItemCostCenterTemp_'+ltrim(rtrim(@POSCode))+' where ReservationId= '+ convert(varchar(50),@ReservationId) +' and  DayId='+ Convert(varchar(20),@DayId) +'
			'
			EXECUTE sp_executesql  @StrLocQueryDeleteTempData
					
			SET @StrQueryPartialInsertTablePITemp=''
			SET @StrQueryPartialInsertTablePITemp='				
				INSERT INTO SNC.TblChallanMenuBanquetItemTemp_'+ltrim(rtrim(@POSCode))+'
					(ReservationId,DayId,ProformaInvoiceId,BanquetItemId,GuarantedPax,ActualPax,PercentPremiumCharge,AmountPremiumCharge
					,PerPaxRate,CalculatedPaxRate,PremiumRate,CalculatedRate,BanquetItemPriceId,KitchenTime,ServeTime,Status,TaxAmt,TaxStr
					,Rate,Discount,Qty,CostPrice,CalculatedPremium,AmdCode,UpdatedFrom,CreatedBy,CreatedDate,ModifiedBy,ModifiedDate,GroupID,ClientID,Guid)
				SELECT ReservationId,DayId,ProformaInvoiceId,BanquetItemId,GuarantedPax,ActualPax,PercentPremiumCharge,AmountPremiumCharge
					,PerPaxRate,CalculatedPaxRate,PremiumRate,CalculatedRate,BanquetItemPriceId,KitchenTime,ServeTime,Status,TaxAmt,TaxStr
					,Rate,Discount,Qty,CostPrice,CalculatedPremium,@AmdCodeFinal,UpdatedFrom,
					'''+ltrim(rtrim(@User))+''',GetDate(),'''+ltrim(rtrim(@User))+''',GetDate(),'''+ltrim(rtrim(@GroupId))+''','''+ltrim(rtrim(@ClientId))+''' ,'''+@Guid+'''
				From #TblMenuBanquetItem
		
				INSERT INTO SNC.TblChallanMenuItemTemp_'+ltrim(rtrim(@POSCode))+' 
					(ReservationId,DayId,ProformaInvoiceId,BanquetItemId,MenuHeadCode,MenuItemCode,IsTDHCost,Quantity,CostPrice,PerSalesPrice,CalculatedPrice,IsModifier,MenuItemRateCode
					,IsFreeFlow,MenuHeadType,Chargeble,Status,TaxAmt,TaxStr,Rate,Discount,Qty,AmdCode,UpdatedFrom,CreatedBy,CreatedDate,ModifiedBy,ModifiedDate,GroupID,ClientID,Guid)
				SELECT ReservationId,DayId,ProformaInvoiceId,BanquetItemId,MenuHeadCode,MenuItemCode,IsTDHCost,Quantity,CostPrice,PerSalesPrice,CalculatedPrice,IsModifier,MenuItemRateCode
					,IsFreeFlow,MenuHeadType,Chargeble,Status,TaxAmt,TaxStr,Rate,Discount,Qty,@AmdCodeFinal,UpdatedFrom,
					'''+ltrim(rtrim(@User))+''',GetDate(),'''+ltrim(rtrim(@User))+''',GetDate(),'''+ltrim(rtrim(@GroupId))+''','''+ltrim(rtrim(@ClientId))+''' ,'''+@Guid+'''
				From #TblMenuItem

				INSERT INTO SNC.TblChallanMenuModifierTemp_'+ltrim(rtrim(@POSCode))+' 
					(ReservationId,DayId,ProformaInvoiceId,BanquetItemId,MenuHeadCode,MenuItemId,ModifierDescription,ModifierRate,IsFreeFlow,MenuHeadType,ModifierCost,Quantity
					,Status,TaxAmt,TaxStr,Rate,Discount,Qty,AmdCode,UpdatedFrom,CreatedBy,CreatedDate,ModifiedBy,ModifiedDate,GroupID,ClientID,Guid)
				SELECT ReservationId,DayId,ProformaInvoiceId,BanquetItemId,MenuHeadCode,MenuItemId,ModifierDescription,ModifierRate,IsFreeFlow,MenuHeadType,ModifierCost,Quantity
					,Status,TaxAmt,TaxStr,Rate,Discount,Qty,@AmdCodeFinal,UpdatedFrom,
					'''+ltrim(rtrim(@User))+''',GetDate(),'''+ltrim(rtrim(@User))+''',GetDate(),'''+ltrim(rtrim(@GroupId))+''','''+ltrim(rtrim(@ClientId))+''' ,'''+@Guid+'''		
				From #TblMenuModifier

				INSERT INTO SNC.TblChallanMenuItemCostCenterTemp_'+ltrim(rtrim(@POSCode))+'
					(ReservationId,DayId,ProformaInvoiceId,BanquetItemId,MenuHeadId,MenuItemId,CostCenter,MenuHeadType,AmdCode,UpdatedFrom
					,CreatedBy,CreatedDate,ModifiedBy,ModifiedDate,GroupID,ClientID,Guid)
				SELECT ReservationId,DayId,ProformaInvoiceId,BanquetItemId,MenuHeadId,MenuItemId,CostCenter,MenuHeadType,@AmdCodeFinal,UpdatedFrom
					,'''+ltrim(rtrim(@User))+''',GetDate(),'''+ltrim(rtrim(@User))+''',GetDate(),'''+ltrim(rtrim(@GroupId))+''','''+ltrim(rtrim(@ClientId))+''' ,'''+@Guid+'''
				From #TblMenuItemCostCenter
			'
			DECLARE @ParmDefinitionInsertPITemp nvarchar(500);				
			SET @ParmDefinitionInsertPITemp = ' @AmdCodeFinal nvarchar(10)';
			EXECUTE sp_executesql  @StrQueryPartialInsertTablePITemp,@ParmDefinitionInsertPITemp,@AmdCodeFinal=0
	END
--=======================================================================For PI Temp End Here====================================================================================================
---------------changesInsertTaskForMyActivity---------------------      
select  @TaskId=TaskId from [SNC].TblActivityMst where  UPPER(ltrim(rtrim(TaskName)))LIKE  '%MENU%';      
 exec SprSNCInsertTaskForMyActivity @ReservationId,@UserCode,@TaskId,@POSCode,@GroupID,@ClientID      
      
---------------changesInsertTaskForMyActivity---------------------      

END
GO

