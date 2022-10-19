USE [IFSDEV-ManualUpload]
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[InventoryPart$]
SET [PART_NO] = '59556'
WHERE [PART_NO] = '59556-LB'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[InventoryPart$]
SET [PART_NO] = '59545'
WHERE [PART_NO] = '59545-LB'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[InventoryPart$]
SET [PART_NO] = '58224-BULK'
WHERE [PART_NO] = '58224-BILK'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[InventoryPart$]
SET [PART_NO] = '59586'
WHERE [PART_NO] = '59586-LB'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[InventoryPart$]
SET [PART_NO] = '59568'
WHERE [PART_NO] = '59568-LB'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[InventoryPart$]
SET [PART_NO] = '59538'
WHERE [PART_NO] = '59538-LB'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[InventoryPart$]
SET [PART_NO] = '59557'
WHERE [PART_NO] = '59557-LB'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[InventoryPart$]
SET [PART_NO] = '59562'
WHERE [PART_NO] = '59562-LB'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[InventoryPart$]
SET [PART_NO] = '59665'
WHERE [PART_NO] = '59665-LB'
GO

TRUNCATE TABLE [dbo].[InventoryPart]
GO
INSERT INTO [dbo].[InventoryPart]
           ([PART_NO]
           ,[CONTRACT]
           ,[DESCRIPTION]
           ,[UNIT_MEAS]
           ,[TYPE_CODE]
           ,[PLANNER_BUYER]
           ,[PRIME_COMMODITY]
           ,[SECOND_COMMODITY]
           ,[ASSET_CLASS]
           ,[PART_STATUS]
           ,[ABC_CLASS]
           ,[CYCLE_PERIOD]
           ,[HAZARD_CODE]
           ,[ACCOUNTING_GROUP]
           ,[PART_PRODUCT_CODE]
           ,[PART_PRODUCT_FAMILY]
           ,[TYPE_DESIGNATION]
           ,[DIM_QUALITY]
           ,[WEIGHT_NET]
           ,[CREATE_DATE]
           ,[EXPECTED_LEADTIME]
           ,[DURABILITY_DAY]
           ,[SUPERSEDED_BY]
           ,[SUPERSEDES]
           ,[STD_NAME]
           ,[EAN_NO]
           ,[COUNTRY_OF_ORIGIN]
           ,[CUSTOMS_STAT_NO]
           ,[INTRASTAT_CONV_FACTOR]
           ,[TECHNICAL_COORDINATOR]
           ,[INVENTORY_VALUE]
           ,[ESTIMATED_MATERIAL_COST]
           ,[INVENTORY_VALUATION_METHOD]
           ,[INVENTORY_PART_COST_LEVEL]
           ,[ZERO_COST_FLAG]
           ,[ACTUAL_COST_DB]
           ,[PART_COST_GROUP_ID]
           ,[NEGATIVE_ON_HAND_DB]
           ,[SHORTAGE_FLAG]
           ,[PLANNING_METHOD]
           ,[MIN_ORDER_QTY]
           ,[MAX_ORDER_QTY]
           ,[MUL_ORDER_QTY]
           ,[SHRINKAGE_FAC]
           ,[SHRINKAGE_ROUNDING]
           ,[STD_ORDER_SIZE]
           ,[SAFETY_STOCK]
           ,[LOT_SIZE]
           ,[ORDER_POINT_QTY]
           ,[MAXWEEK_SUPPLY]
           ,[ORDER_REQUISITION_DB]
           ,[ENG_REVISION]
           ,[ENG_CHG_LEVEL]
           ,[ENG_REVISION_DESC]
           ,[ENG_ATTRIBUTE]
           ,[BACKFLUSH_PART_DB]
           ,[PROCESS_TYPE]
           ,[MTK_MODE]
           ,[STD_PLANNED]
           ,[FORECAST_CONSUMPTION_FLAG_DB]
           ,[ONHAND_ANALYSIS_FLAG_DB]
           ,[CYCLE_CODE_DB]
           ,[QTY_PREDICTED_CONSUMPTION]
           ,[NOTE_TEXT]
           ,[QTY_CALC_ROUNDING]
           ,[MANUF_ENGINEER]
           ,[PURCH_LEADTIME]
           ,[MANUF_LEADTIME]
           ,[PROPOSAL_RELEASE_DB]
           ,[AVERAGE_PURCHASE_PRICE]
           ,[INPUT_UNIT_MEAS_GROUP_ID]
           ,[SUPPLY_CODE_DB]
           ,[EXT_SERVICE_COST_METHOD_DB]
           ,[INVOICE_CONSIDERATION_DB]
           ,[DENSITY]
           ,[DOP_NETTING_DB]
           ,[CATCH_UNIT_MEAS]
           ,[MRP_CONTROL_FLAG_DB]
           ,[STORAGE_WIDTH_REQUIREMENT]
           ,[STORAGE_HEIGHT_REQUIREMENT]
           ,[STORAGE_DEPTH_REQUIREMENT]
           ,[STORAGE_VOLUME_REQUIREMENT]
           ,[STORAGE_WEIGHT_REQUIREMENT]
           ,[MIN_STORAGE_TEMPERATURE]
           ,[MAX_STORAGE_TEMPERATURE]
           ,[MIN_STORAGE_HUMIDITY]
           ,[MAX_STORAGE_HUMIDITY])
SELECT [PART_NO]
      ,[CONTRACT]
      ,[DESCRIPTION]
      ,[UNIT_MEAS]
      ,[TYPE_CODE]
      ,[PLANNER_BUYER ]
      ,[PRIME_COMMODITY]
      ,[SECOND_COMMODITY]
      ,[ASSET_CLASS]
      ,[PART_STATUS]
      ,[ABC_CLASS]
      ,[CYCLE_PERIOD]
      ,[HAZARD_CODE]
      ,[ACCOUNTING_GROUP]
      ,[PART_PRODUCT_CODE]
      ,[PART_PRODUCT_FAMILY]
      ,[TYPE_DESIGNATION]
      ,[DIM_QUALITY]
      ,[WEIGHT_NET]
      ,[CREATE_DATE]
      ,[EXPECTED_LEADTIME]
      ,[DURABILITY_DAY]
      ,[SUPERSEDED_BY              ]
      ,[SUPERSEDES                 ]
      ,[STD_NAME]
      ,[EAN_NO]
      ,[COUNTRY_OF_ORIGIN]
      ,[CUSTOMS_STAT_NO]
      ,[INTRASTAT_CONV_FACTOR]
      ,[TECHNICAL_COORDINATOR ]
      ,[INVENTORY_VALUE]
      ,[ESTIMATED_MATERIAL_COST]
      ,[INVENTORY_VALUATION_METHOD]
      ,[INVENTORY_PART_COST_LEVEL]
      ,[ZERO_COST_FLAG]
      ,[ACTUAL_COST_DB]
      ,[PART_COST_GROUP_ID]
      ,[NEGATIVE_ON_HAND_DB]
      ,[SHORTAGE_FLAG]
      ,[PLANNING_METHOD]
      ,[MIN_ORDER_QTY]
      ,[MAX_ORDER_QTY]
      ,[MUL_ORDER_QTY]
      ,[SHRINKAGE_FAC]
      ,[SHRINKAGE_ROUNDING]
      ,[STD_ORDER_SIZE]
      ,[SAFETY_STOCK]
      ,'0' --[LOT_SIZE]
      ,[ORDER_POINT_QTY]
      ,[MAXWEEK_SUPPLY]
      ,[ORDER_REQUISITION_DB]
      ,[ENG_REVISION]
      ,[ENG_CHG_LEVEL]
      ,[ENG_REVISION_DESC]
      ,[ENG_ATTRIBUTE]
      ,[BACKFLUSH_PART_DB]
      ,[PROCESS_TYPE]
      ,[MTK_MODE]
      ,[STD_PLANNED]
      ,[FORECAST_CONSUMPTION_FLAG_DB]
      ,[ONHAND_ANALYSIS_FLAG_DB]
      ,[CYCLE_CODE_DB]
      ,[QTY_PREDICTED_CONSUMPTION]
      ,[NOTE_TEXT]
      ,0 [QTY_CALC_ROUNDING]
      ,[MANUF_ENGINEER]
      ,[PURCH_LEADTIME ]
      ,[MANUF_LEADTIME]
      ,[PROPOSAL_RELEASE_DB]
      ,[AVERAGE_PURCHASE_PRICE]
      ,[INPUT_UNIT_MEAS_GROUP_ID]
      ,[SUPPLY_CODE _DB]
      ,[EXT_SERVICE_COST_METHOD_DB]
      ,[INVOICE_CONSIDERATION_DB]
      ,[DENSITY]
      ,'NETT' --[DOP_NETTING_DB]
      ,[CATCH_UNIT_MEAS]
      ,[MRP_CONTROL_FLAG_DB]
      ,[STORAGE_WIDTH_REQUIREMENT]
      ,[STORAGE_HEIGHT_REQUIREMENT]
      ,[STORAGE_DEPTH_REQUIREMENT]
      ,[STORAGE_VOLUME_REQUIREMENT]
      ,[STORAGE_WEIGHT_REQUIREMENT]
      ,[MIN_STORAGE_TEMPERATURE]
      ,[MAX_STORAGE_TEMPERATURE]
      ,[MIN_STORAGE_HUMIDITY]
      ,[MAX_STORAGE_HUMIDITY]
  FROM [IFSDEV-ManualUpload].[dbo].[InventoryPart$]
GO

INSERT INTO [dbo].[InventoryPart]
           ([PART_NO]
           ,[CONTRACT]
           ,[DESCRIPTION]
           ,[UNIT_MEAS]
           ,[TYPE_CODE]
           ,[PLANNER_BUYER]
           ,[PRIME_COMMODITY]
           ,[SECOND_COMMODITY]
           ,[ASSET_CLASS]
           ,[PART_STATUS]
           ,[ABC_CLASS]
           ,[CYCLE_PERIOD]
           ,[HAZARD_CODE]
           ,[ACCOUNTING_GROUP]
           ,[PART_PRODUCT_CODE]
           ,[PART_PRODUCT_FAMILY]
           ,[TYPE_DESIGNATION]
           ,[DIM_QUALITY]
           ,[WEIGHT_NET]
           ,[CREATE_DATE]
           ,[EXPECTED_LEADTIME]
           ,[DURABILITY_DAY]
           ,[SUPERSEDED_BY]
           ,[SUPERSEDES]
           ,[STD_NAME]
           ,[EAN_NO]
           ,[COUNTRY_OF_ORIGIN]
           ,[CUSTOMS_STAT_NO]
           ,[INTRASTAT_CONV_FACTOR]
           ,[TECHNICAL_COORDINATOR]
           ,[INVENTORY_VALUE]
           ,[ESTIMATED_MATERIAL_COST]
           ,[INVENTORY_VALUATION_METHOD]
           ,[INVENTORY_PART_COST_LEVEL]
           ,[ZERO_COST_FLAG]
           ,[ACTUAL_COST_DB]
           ,[PART_COST_GROUP_ID]
           ,[NEGATIVE_ON_HAND_DB]
           ,[SHORTAGE_FLAG]
           ,[PLANNING_METHOD]
           ,[MIN_ORDER_QTY]
           ,[MAX_ORDER_QTY]
           ,[MUL_ORDER_QTY]
           ,[SHRINKAGE_FAC]
           ,[SHRINKAGE_ROUNDING]
           ,[STD_ORDER_SIZE]
           ,[SAFETY_STOCK]
           ,[LOT_SIZE]
           ,[ORDER_POINT_QTY]
           ,[MAXWEEK_SUPPLY]
           ,[ORDER_REQUISITION_DB]
           ,[ENG_REVISION]
           ,[ENG_CHG_LEVEL]
           ,[ENG_REVISION_DESC]
           ,[ENG_ATTRIBUTE]
           ,[BACKFLUSH_PART_DB]
           ,[PROCESS_TYPE]
           ,[MTK_MODE]
           ,[STD_PLANNED]
           ,[FORECAST_CONSUMPTION_FLAG_DB]
           ,[ONHAND_ANALYSIS_FLAG_DB]
           ,[CYCLE_CODE_DB]
           ,[QTY_PREDICTED_CONSUMPTION]
           ,[NOTE_TEXT]
           ,[QTY_CALC_ROUNDING]
           ,[MANUF_ENGINEER]
           ,[PURCH_LEADTIME]
           ,[MANUF_LEADTIME]
           ,[PROPOSAL_RELEASE_DB]
           ,[AVERAGE_PURCHASE_PRICE]
           ,[INPUT_UNIT_MEAS_GROUP_ID]
           ,[SUPPLY_CODE_DB]
           ,[EXT_SERVICE_COST_METHOD_DB]
           ,[INVOICE_CONSIDERATION_DB]
           ,[DENSITY]
           ,[DOP_NETTING_DB]
           ,[CATCH_UNIT_MEAS]
           ,[MRP_CONTROL_FLAG_DB]
           ,[STORAGE_WIDTH_REQUIREMENT]
           ,[STORAGE_HEIGHT_REQUIREMENT]
           ,[STORAGE_DEPTH_REQUIREMENT]
           ,[STORAGE_VOLUME_REQUIREMENT]
           ,[STORAGE_WEIGHT_REQUIREMENT]
           ,[MIN_STORAGE_TEMPERATURE]
           ,[MAX_STORAGE_TEMPERATURE]
           ,[MIN_STORAGE_HUMIDITY]
           ,[MAX_STORAGE_HUMIDITY])
SELECT [PART_NO]
      ,'10MTL' [CONTRACT]
      ,[DESCRIPTION]
      ,[UNIT_MEAS]
      ,'4' [TYPE_CODE]
      ,[PLANNER_BUYER ]
      ,[PRIME_COMMODITY]
      ,[SECOND_COMMODITY]
      ,[ASSET_CLASS]
      ,[PART_STATUS]
      ,[ABC_CLASS]
      ,[CYCLE_PERIOD]
      ,[HAZARD_CODE]
      ,[ACCOUNTING_GROUP]
      ,[PART_PRODUCT_CODE]
      ,[PART_PRODUCT_FAMILY]
      ,[TYPE_DESIGNATION]
      ,[DIM_QUALITY]
      ,[WEIGHT_NET]
      ,[CREATE_DATE]
      ,[EXPECTED_LEADTIME]
      ,[DURABILITY_DAY]
      ,[SUPERSEDED_BY              ]
      ,[SUPERSEDES                 ]
      ,[STD_NAME]
      ,[EAN_NO]
      ,[COUNTRY_OF_ORIGIN]
      ,[CUSTOMS_STAT_NO]
      ,[INTRASTAT_CONV_FACTOR]
      ,[TECHNICAL_COORDINATOR ]
      ,[INVENTORY_VALUE]
      ,[ESTIMATED_MATERIAL_COST]
      ,[INVENTORY_VALUATION_METHOD]
      ,[INVENTORY_PART_COST_LEVEL]
      ,[ZERO_COST_FLAG]
      ,[ACTUAL_COST_DB]
      ,[PART_COST_GROUP_ID]
      ,[NEGATIVE_ON_HAND_DB]
      ,[SHORTAGE_FLAG]
      ,[PLANNING_METHOD]
      ,[MIN_ORDER_QTY]
      ,[MAX_ORDER_QTY]
      ,[MUL_ORDER_QTY]
      ,[SHRINKAGE_FAC]
      ,[SHRINKAGE_ROUNDING]
      ,[STD_ORDER_SIZE]
      ,[SAFETY_STOCK]
      ,'0' --[LOT_SIZE]
      ,[ORDER_POINT_QTY]
      ,[MAXWEEK_SUPPLY]
      ,[ORDER_REQUISITION_DB]
      ,[ENG_REVISION]
      ,[ENG_CHG_LEVEL]
      ,[ENG_REVISION_DESC]
      ,[ENG_ATTRIBUTE]
      ,[BACKFLUSH_PART_DB]
      ,[PROCESS_TYPE]
      ,[MTK_MODE]
      ,[STD_PLANNED]
      ,[FORECAST_CONSUMPTION_FLAG_DB]
      ,[ONHAND_ANALYSIS_FLAG_DB]
      ,[CYCLE_CODE_DB]
      ,[QTY_PREDICTED_CONSUMPTION]
      ,[NOTE_TEXT]
      ,0 [QTY_CALC_ROUNDING]
      ,[MANUF_ENGINEER]
      ,[PURCH_LEADTIME ]
      ,[MANUF_LEADTIME]
      ,[PROPOSAL_RELEASE_DB]
      ,[AVERAGE_PURCHASE_PRICE]
      ,[INPUT_UNIT_MEAS_GROUP_ID]
      ,[SUPPLY_CODE _DB]
      ,[EXT_SERVICE_COST_METHOD_DB]
      ,[INVOICE_CONSIDERATION_DB]
      ,[DENSITY]
      ,'NETT' --[DOP_NETTING_DB]
      ,[CATCH_UNIT_MEAS]
      ,[MRP_CONTROL_FLAG_DB]
      ,[STORAGE_WIDTH_REQUIREMENT]
      ,[STORAGE_HEIGHT_REQUIREMENT]
      ,[STORAGE_DEPTH_REQUIREMENT]
      ,[STORAGE_VOLUME_REQUIREMENT]
      ,[STORAGE_WEIGHT_REQUIREMENT]
      ,[MIN_STORAGE_TEMPERATURE]
      ,[MAX_STORAGE_TEMPERATURE]
      ,[MIN_STORAGE_HUMIDITY]
      ,[MAX_STORAGE_HUMIDITY]
  FROM [IFSDEV-ManualUpload].[dbo].[InventoryPart$]

UPDATE [dbo].[InventoryPart]
   SET [PROCESS_TYPE] = ''
 WHERE [TYPE_CODE]= '4'
GO



