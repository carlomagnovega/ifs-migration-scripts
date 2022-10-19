USE [IFSDEV-ManualUpload]
GO
DELETE FROM [dbo].[PurchPartSupplier$]
WHERE [PART_NO] = '55645-LB'
GO
DELETE FROM [dbo].[PurchPartSupplier$]
WHERE [PART_NO] = '55645-FT'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[PurchPartSupplier$]
SET [PART_NO] = '59556'
WHERE [PART_NO] = '59556-LB'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[PurchPartSupplier$]
SET [PART_NO] = '59545'
WHERE [PART_NO] = '59545-LB'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[PurchPartSupplier$]
SET [PART_NO] = '58224-BULK'
WHERE [PART_NO] = '58224-BILK'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[PurchPartSupplier$]
SET [PART_NO] = '59586'
WHERE [PART_NO] = '59586-LB'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[PurchPartSupplier$]
SET [PART_NO] = '59568'
WHERE [PART_NO] = '59568-LB'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[PurchPartSupplier$]
SET [PART_NO] = '59538'
WHERE [PART_NO] = '59538-LB'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[PurchPartSupplier$]
SET [PART_NO] = '59557'
WHERE [PART_NO] = '59557-LB'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[PurchPartSupplier$]
SET [PART_NO] = '59562'
WHERE [PART_NO] = '59562-LB'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[PurchPartSupplier$]
SET [PART_NO] = '59665'
WHERE [PART_NO] = '59665-LB'
GO

TRUNCATE TABLE [dbo].[PurchPartSupplier]
GO
INSERT INTO [dbo].[PurchPartSupplier]
           ([PART_NO]
           ,[CONTRACT]
           ,[VENDOR_NO]
           ,[VENDOR_PART_DESCRIPTION]
           ,[VENDOR_PART_NO]
           ,[PRICE_UNIT_MEAS]
           ,[BUY_UNIT_MEAS]
           ,[CONV_FACTOR]
           ,[LIST_PRICE]
           ,[CURRENCY_CODE]
           ,[PRICE_CONV_FACTOR]
           ,[EAN_NO]
           ,[STANDARD_PACK_SIZE]
           ,[FLAG_VENDOR]
           ,[STATUS_CODE]
           ,[CONTACT]
           ,[MINIMUM_QTY]
           ,[VENDOR_MANUF_LEADTIME]
           ,[STD_MULTIPLE_QTY]
           ,[RECEIVE_CASE_DB]
           ,[INSPECTION_CODE]
           ,[SAMPLE_PERCENT]
           ,[SAMPLE_QTY]
           ,[MTK_MODE]
           ,[PART_OWNERSHIP]
           ,[EXTERNAL_SERVICE_ALLOWED_DB]
           ,[INTERNAL_CONTROL_TIME]
           ,[MULTISITE_PLANNED_PART_DB]
           ,[FEE_CODE]
           ,[SUPPLY_CONFIGURATION_DB]
           ,[ORDERS_PRICE_OPTION_DB]
           ,[QTY_CALC_ROUNDING]
           ,[ASSORTMENT]
           ,[ADDITIONAL_COST_AMOUNT]
           ,[DISCOUNT]
           ,[DELIVERY_PATTERN_ID])
SELECT [PART_NO]
      ,[CONTRACT]
      ,[VENDOR_NO]
      ,[VENDOR_PART_DESCRIPTION]
      ,[VENDOR_PART_NO]
      ,[PRICE_UNIT_MEAS]
      ,[BUY_UNIT_MEAS]
      ,[CONV_FACTOR]
      ,0 [LIST_PRICE]
      ,[CURRENCY_CODE]
      ,[PRICE_CONV_FACTOR]
      ,[EAN_NO]
      ,[STANDARD_PACK_SIZE]
      ,[FLAG_VENDOR]
      ,[STATUS_CODE]
      ,[CONTACT]
      ,[MINIMUM_QTY]
      ,[VENDOR_MANUF_LEADTIME]
      ,[STD_MULTIPLE_QTY]
      ,[RECEIVE_CASE_DB]
      ,[INSPECTION_CODE]
      ,[SAMPLE_PERCENT]
      ,[SAMPLE_QTY]
      ,[MTK_MODE]
      ,[PART_OWNERSHIP]
      ,[EXTERNAL_SERVICE_ALLOWED_DB]
      ,[INTERNAL_CONTROL_TIME]
      ,[MULTISITE_PLANNED_PART_DB]
      ,[FEE_CODE]
      ,[SUPPLY_CONFIGURATION_DB]
      ,[ORDERS_PRICE_OPTION_DB]
      ,[QTY_CALC_ROUNDING]
      ,[ASSORTMENT]
      ,[ADDITIONAL_COST_AMOUNT]
      ,[DISCOUNT]
      ,[DELIVERY_PATTERN_ID]
  FROM [IFSDEV-ManualUpload].[dbo].[PurchPartSupplier$]
GO


SELECT pps.[PART_NO]
      ,pps.[CONTRACT]
      ,[VENDOR_NO]
      ,replace([VENDOR_PART_DESCRIPTION], '"', '-')  [VENDOR_PART_DESCRIPTION]
      ,[VENDOR_PART_NO]
      ,[PRICE_UNIT_MEAS] [PRICE_UNIT_MEAS]
      ,lower([BUY_UNIT_MEAS]) [BUY_UNIT_MEAS]
      ,[CONV_FACTOR]
      ,[LIST_PRICE]
      ,pps.[CURRENCY_CODE]
      ,[PRICE_CONV_FACTOR]
      ,[EAN_NO]
      ,pps.[STANDARD_PACK_SIZE]
      ,[FLAG_VENDOR]
      ,[STATUS_CODE]
      ,[CONTACT]
      ,[MINIMUM_QTY]
      ,[VENDOR_MANUF_LEADTIME]
      ,[STD_MULTIPLE_QTY]
      ,[RECEIVE_CASE_DB]
      ,[INSPECTION_CODE]
      ,[SAMPLE_PERCENT]
      ,[SAMPLE_QTY]
      ,pps.[MTK_MODE]
      ,[PART_OWNERSHIP]
      ,[EXTERNAL_SERVICE_ALLOWED_DB]
      ,[INTERNAL_CONTROL_TIME]
      ,[MULTISITE_PLANNED_PART_DB]
      ,[FEE_CODE]
      ,[SUPPLY_CONFIGURATION_DB]
      ,[ORDERS_PRICE_OPTION_DB]
      ,[QTY_CALC_ROUNDING]
      ,[ASSORTMENT]
      ,pps.[ADDITIONAL_COST_AMOUNT]
      ,pps.[DISCOUNT]
      ,[DELIVERY_PATTERN_ID]
      ,[SUFIX]
  FROM [IFSDEV-ManualUpload].[dbo].[PurchPartSupplier] pps
  INNER JOIN [dbo].[PurchasePart] pmt on pps.PART_NO = pmt.PART_NO AND pps.CONTRACT = pmt.CONTRACT
  
  
  ------For DELTA
  TRUNCATE TABLE [dbo].[PurchPartSupplier]
GO
INSERT INTO [dbo].[PurchPartSupplier]
           ([PART_NO]
           ,[CONTRACT]
           ,[VENDOR_NO]
           ,[VENDOR_PART_DESCRIPTION]
           ,[VENDOR_PART_NO]
           ,[PRICE_UNIT_MEAS]
           ,[BUY_UNIT_MEAS]
           ,[CONV_FACTOR]
           ,[LIST_PRICE]
           ,[CURRENCY_CODE]
           ,[PRICE_CONV_FACTOR]
           ,[EAN_NO]
           ,[STANDARD_PACK_SIZE]
           ,[FLAG_VENDOR]
           ,[STATUS_CODE]
           ,[CONTACT]
           ,[MINIMUM_QTY]
           ,[VENDOR_MANUF_LEADTIME]
           ,[STD_MULTIPLE_QTY]
           ,[RECEIVE_CASE_DB]
           ,[INSPECTION_CODE]
           ,[SAMPLE_PERCENT]
           ,[SAMPLE_QTY]
           ,[MTK_MODE]
           ,[PART_OWNERSHIP]
           ,[EXTERNAL_SERVICE_ALLOWED_DB]
           ,[INTERNAL_CONTROL_TIME]
           ,[MULTISITE_PLANNED_PART_DB]
           ,[FEE_CODE]
           ,[SUPPLY_CONFIGURATION_DB]
           ,[ORDERS_PRICE_OPTION_DB]
           ,[QTY_CALC_ROUNDING]
           ,[ASSORTMENT]
           ,[ADDITIONAL_COST_AMOUNT]
           ,[DISCOUNT]
           ,[DELIVERY_PATTERN_ID])
SELECT [PART_NO]
      ,[CONTRACT]
	  ,'1015'
      ,''
      ,''
      ,[DEFAULT_BUY_UNIT_MEAS]
      ,[DEFAULT_BUY_UNIT_MEAS]
      ,'1'
      ,''
      ,'USD'
      ,'1'
      ,''
      ,'1'
      ,''
      ,'2'
      ,''
      ,'0'
      ,''
      ,'1'
      ,'INVDIR'
      ,''
      ,'100'
      ,''
      ,'*'
      ,''
      ,''
      ,''
      ,''
      ,''
      ,''
      ,''
      ,'4'
      ,''
      ,''
      ,''
      ,''

  FROM [IFSDEV-ManualUpload].[dbo].[PurchasePart]


