USE [IFSDEV-ManualUpload]
GO
DELETE FROM [dbo].[PartMaster$]
WHERE [PART_NO] = '55645-LB'
GO
DELETE FROM [dbo].[PartMaster$]
WHERE [PART_NO] = '55645-FT'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[PartMaster$]
SET [PART_NO] = '59556'
WHERE [PART_NO] = '59556-LB'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[PartMaster$]
SET [PART_NO] = '59545'
WHERE [PART_NO] = '59545-LB'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[PartMaster$]
SET [PART_NO] = '58224-BULK'
WHERE [PART_NO] = '58224-BILK'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[PartMaster$]
SET [PART_NO] = '59586'
WHERE [PART_NO] = '59586-LB'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[PartMaster$]
SET [PART_NO] = '59568'
WHERE [PART_NO] = '59568-LB'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[PartMaster$]
SET [PART_NO] = '59538'
WHERE [PART_NO] = '59538-LB'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[PartMaster$]
SET [PART_NO] = '59557'
WHERE [PART_NO] = '59557-LB'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[PartMaster$]
SET [PART_NO] = '59562'
WHERE [PART_NO] = '59562-LB'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[PartMaster$]
SET [PART_NO] = '59665'
WHERE [PART_NO] = '59665-LB'
GO

TRUNCATE TABLE [dbo].[PartMaster]
GO
INSERT INTO [dbo].[PartMaster]
           ([PART_NO]
           ,[DESCRIPTION]
           ,[PROVIDE_DB]
           ,[PART_CLASS]
           ,[PART_RESPONSIBLE]
           ,[STD_PLANNED]
           ,[UNIT_CODE]
           ,[LOT_TRACKING_CODE_DB]
           ,[PART_MAIN_GROUP]
           ,[ENG_SERIAL_TRACKING_CODE_DB]
           ,[SERIAL_TRACKING_CODE_DB]
           ,[SERIAL_RULE_DB]
           ,[END_ITEM]
           ,[PREFIX]
           ,[SUFFIX]
           ,[STD_NAME]
           ,[INFO_TEXT]
           ,[CONFIGURABLE_DB]
           ,[CONDITION_CODE_USAGE_DB]
           ,[POSITIONPART_DB]
           ,[LOT_QUANTITY_RULE]
           ,[SUB_LOT_RULE_DB]
           ,[IS_ENG_PART]
           ,[MTK_MODE]
           ,[DME_NAICS_CODE]
           ,[MULTILEVEL_TRACKING_DB]
           ,[INPUT_UNIT_MEAS_GROUP_ID]
           ,[CATCH_UNIT_CODE]
           ,[CATCH_UNIT_ENABLED]
           ,[DME_PC_FLEX1]
           ,[DME_PC_FLEX2]
           ,[DME_PC_FLEX3]
           ,[DME_PC_FLEX4]
           ,[DME_PC_FLEX5]
           ,[DME_PC_FLEX6]
           ,[ALLOW_AS_NOT_CONSUMED]
           ,[WEIGHT_NET]
           ,[VOLUME_NET]
           ,[UOM_FOR_WEIGHT_NET]
           ,[UOM_FOR_VOLUME_NET]
           ,[FREIGHT_FACTOR]
           ,[STORAGE_WIDTH_REQUIREMENT]
           ,[STORAGE_HEIGHT_REQUIREMENT]
           ,[STORAGE_DEPTH_REQUIREMENT]
           ,[STORAGE_VOLUME_REQUIREMENT]
           ,[STORAGE_WEIGHT_REQUIREMENT]
           ,[MIN_STORAGE_TEMPERATURE]
           ,[MAX_STORAGE_TEMPERATURE]
           ,[MIN_STORAGE_HUMIDITY]
           ,[MAX_STORAGE_HUMIDITY]
           ,[UOM_FOR_LENGTH]
           ,[UOM_FOR_WEIGHT]
           ,[UOM_FOR_VOLUME]
           ,[UOM_FOR_TEMPERATURE]
           ,[CAPACITY_REQ_GROUP_ID]
           ,[CONDITION_REQ_GROUP_ID]
           ,[CAPABILITY_REQ_GROUP_ID]
           ,[AS400GROUP])
SELECT a.[PART_NO]
      ,[DESCRIPTION]
      ,[PROVIDE_DB]
      ,[PART_CLASS]
      ,[PART_RESPONSIBLE]
      ,0 --[STD_PLANNED]
      ,[UNIT_CODE]
      ,[LOT_TRACKING_CODE_DB]
      ,[PART_MAIN_GROUP]
      ,'NOT SERIAL TRACKING' [ENG_SERIAL_TRACKING_CODE_DB]
      ,'NOT SERIAL TRACKING' [SERIAL_TRACKING_CODE_DB]
      ,'MANUAL' [SERIAL_RULE_DB]
      ,[END_ITEM]
      ,[PREFIX]
      ,[SUFFIX]
      ,0 --[STD_NAME]
      ,[INFO_TEXT]
      ,'NOT CONFIGURED' [CONFIGURABLE_DB]
      ,'NOT_ALLOW_COND_CODE' [CONDITION_CODE_USAGE_DB]
      ,'NOT POSITION PART' [POSITIONPART_DB]
      ,'MULTI_LOTS' [LOT_QUANTITY_RULE]
      ,'NO_SUBLOTS' [SUB_LOT_RULE_DB]
      ,'N' [IS_ENG_PART]
      ,'*' [MTK_MODE]
      ,[DME_NAICS_CODE]
      ,'TRACKING_ON' [MULTILEVEL_TRACKING_DB]
      ,[INPUT_UNIT_MEAS_GROUP_ID]
      ,[CATCH_UNIT_CODE]
      ,[CATCH_UNIT_ENABLED]
      ,[DME_PC_FLEX1]
      ,[DME_PC_FLEX2]
      ,[DME_PC_FLEX3]
      ,[DME_PC_FLEX4]
      ,[DME_PC_FLEX5]
      ,[DME_PC_FLEX6]
      ,[ALLOW_AS_NOT_CONSUMED]
      ,1 --[WEIGHT_NET]
      ,[VOLUME_NET]
      ,'lb' [UOM_FOR_WEIGHT_NET]
      ,[UOM_FOR_VOLUME_NET]
      ,[FREIGHT_FACTOR]
      ,[STORAGE_WIDTH_REQUIREMENT]
      ,[STORAGE_HEIGHT_REQUIREMENT]
      ,[STORAGE_DEPTH_REQUIREMENT]
      ,[STORAGE_VOLUME_REQUIREMENT]
      ,[STORAGE_WEIGHT_REQUIREMENT]
      ,[MIN_STORAGE_TEMPERATURE]
      ,[MAX_STORAGE_TEMPERATURE]
      ,[MIN_STORAGE_HUMIDITY]
      ,[MAX_STORAGE_HUMIDITY]
      ,[UOM_FOR_LENGTH]
      ,[UOM_FOR_WEIGHT]
      ,[UOM_FOR_VOLUME]
      ,[UOM_FOR_TEMPERATURE]
      ,[CAPACITY_REQ_GROUP_ID]
      ,[CONDITION_REQ_GROUP_ID]
      ,[CAPABILITY_REQ_GROUP_ID]
      ,[AS400GROUP]
  FROM [IFSDEV-ManualUpload].[dbo].[PartMaster$] a
  LEFT JOIN [IFSDEV-ManualUpload].[dbo].[PartMasterAux$] b ON a.[PART_NO] = b.[Part_No]  
  WHERE b.[PART_NO] IS NULL
GO


