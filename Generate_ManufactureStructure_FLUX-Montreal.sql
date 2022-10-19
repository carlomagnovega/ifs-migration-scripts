USE [IFSDEV-ManualUpload]
GO


truncate table [dbo].[ManufStructure]
go
INSERT INTO [dbo].[ManufStructure]
           ([COMPONENT_PART]
           ,[PART_NO]
           ,[CONTRACT]
           ,[ENG_REVISION]
           ,[ENG_CHG_LEVEL]
           ,[ALTERNATIVE_NO]
           ,[BOM_TYPE_DB]
           ,[LINE_ITEM_NO]
           ,[COMPONENT_CONTRACT]
           ,[EFF_PHASE_IN_DATE]
           ,[EFF_PHASE_OUT_DATE]
           ,[QTY_PER_ASSEMBLY]
           ,[SHRINKAGE_FACTOR]
           ,[OPERATION_NO]
           ,[CREATE_DATE]
           ,[LAST_ACTIVITY_DATE]
           ,[CONSUMPTION_ITEM]
           ,[COMPONENT_SCRAP]
           ,[MTK_MODE]
           ,[ISSUE_TO_LOC]
           ,[DRAW_POS_NO]
           ,[STD_PLANNED_ITEM]
           ,[NOTE_TEXT]
           ,[PHANTOM_CONSUME_DB]
           ,[PROCEDURE_STEP])
SELECT [COMPONENT_PART]
	  ,[Part_No]
      ,'10MTL' [CONTRACT]
      ,'' --[ENG_REVISION]
      ,'1' [ENG_CHG_LEVEL]
      ,'*' [ALTERNATIVE_NO]
      ,'M' [BOM_TYPE_DB]
      ,[LINE_ITEM_NO]      
      ,'10MTL' [CONTRACT]
	  ,'01/01/2010' [EFF_PHASE_IN_DATE]
      ,'01/01/2010' [EFF_PHASE_OUT_DATE]
      ,[ Qty_Per_Assembly ] [Qty_Per_Assembly]
      ,0 [SHRINKAGE_FACTOR]
      ,'' --[OPERATION_NO]
      ,'01/01/2010' [CREATE_DATE]
      ,'01/01/2010' [LAST_ACTIVITY_DATE]
      ,'Y' [CONSUMPTION_ITEM]
      ,'' [COMPONENT_SCRAP]
      ,'*' [MTK_MODE]
      ,'' [ISSUE_TO_LOC]
      ,'' [DRAW_POS_NO]
      ,'' [STD_PLANNED_ITEM]
      ,'' [NOTE_TEXT]
      ,'' [PHANTOM_CONSUME_DB]
      ,'' [PROCEDURE_STEP]
  FROM [IFSDEV-ManualUpload].[dbo].[ManufactureStructure-FLUX$]
  WHERE [PART_NO] IS NOT NULL
  AND [COMPONENT_PART] IS NOT NULL
GO


TRUNCATE TABLE [dbo].[ManufStructAlternate]
GO
INSERT INTO [dbo].[ManufStructAlternate]
           ([PART_NO]
           ,[CONTRACT]
           ,[ENG_CHG_LEVEL]
           ,[ALTERNATIVE_NO]
           ,[BOM_TYPE_DB]
           ,[ROWSTATE]
           ,[ALTERNATIVE_DESCRIPTION]
           ,[NOTE_TEXT]
           ,[ENG_REVISION]
           ,[MTK_MODE])
 SELECT PART_NO, 
        CONTRACT,
        ENG_CHG_LEVEL, 
        ALTERNATIVE_NO, 
        BOM_TYPE_DB,
        'B' ROWSTATE, 
        'STANDARD' ALTERNATIVE_DESCRIPTION, 
        '' NOTE_TEXT, 
        ENG_REVISION,
        MTK_MODE
FROM [dbo].[ManufStructure]
GROUP BY PART_NO, 
        CONTRACT,
        ENG_CHG_LEVEL, 
        ALTERNATIVE_NO, 
        BOM_TYPE_DB,
        ENG_REVISION,
        MTK_MODE
GO

TRUNCATE TABLE [dbo].[ManufStructureHead]
GO
INSERT INTO [dbo].[ManufStructureHead]
           ([PART_NO]
           ,[CONTRACT]
           ,[ENG_REVISION]
           ,[ENG_CHG_LEVEL]
           ,[BOM_TYPE_DB]
           ,[ENG_CHG_ORDER]
           ,[CREATE_DATE]
           ,[CUST_WARRANTY_ID]
           ,[NOTE_TEXT]
           ,[MTK_MODE]
           ,[ROWTYPE])
SELECT [PART_NO]
      ,[CONTRACT]
      ,[ENG_REVISION]
      ,[ENG_CHG_LEVEL]
      ,[BOM_TYPE_DB]
      ,'' [ENG_CHG_ORDER]
      ,'' [CREATE_DATE]
      ,'' [CUST_WARRANTY_ID]
      ,'' [NOTE_TEXT]
      ,'*' [MTK_MODE]
      ,'ProdStructureHead' [ROWTYPE]
  FROM [dbo].[ManufStructure]
  GROUP BY [PART_NO]
      ,[CONTRACT]
      ,[ENG_REVISION]
      ,[ENG_CHG_LEVEL]
      ,[BOM_TYPE_DB]
GO