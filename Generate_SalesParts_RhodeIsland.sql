USE [IFSDEV-ManualUpload]
GO
DELETE FROM [dbo].[SalesPart$]
WHERE [PART_NO] = '55645-LB'
GO
DELETE FROM [dbo].[SalesPart$]
WHERE [PART_NO] = '55645-FT'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[SalesPart$]
SET [PART_NO] = '59556'
WHERE [PART_NO] = '59556-LB'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[SalesPart$]
SET [PART_NO] = '59545'
WHERE [PART_NO] = '59545-LB'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[SalesPart$]
SET [PART_NO] = '58224-BULK'
WHERE [PART_NO] = '58224-BILK'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[SalesPart$]
SET [PART_NO] = '59586'
WHERE [PART_NO] = '59586-LB'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[SalesPart$]
SET [PART_NO] = '59568'
WHERE [PART_NO] = '59568-LB'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[SalesPart$]
SET [PART_NO] = '59538'
WHERE [PART_NO] = '59538-LB'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[SalesPart$]
SET [PART_NO] = '59557'
WHERE [PART_NO] = '59557-LB'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[SalesPart$]
SET [PART_NO] = '59562'
WHERE [PART_NO] = '59562-LB'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[SalesPart$]
SET [PART_NO] = '59665'
WHERE [PART_NO] = '59665-LB'
GO

TRUNCATE TABLE [dbo].[SalesPart]
GO
INSERT INTO [dbo].[SalesPart]
           ([CATALOG_NO]
           ,[CATALOG_TYPE_DB]
           ,[CATALOG_DESC]
           ,[PART_NO]
           ,[CONTRACT]
           ,[PRICE_UNIT_MEAS]
           ,[CONV_FACTOR]
           ,[PRICE_CONV_FACTOR]
           ,[SALES_UNIT_MEAS]
           ,[DATE_ENTERED]
           ,[LIST_PRICE]
           ,[SOURCING_OPTION]
           ,[RULE_ID]
           ,[SALES_PRICE_GROUP_ID]
           ,[CATALOG_GROUP]
           ,[DISCOUNT_GROUP]
           ,[TAXABLE_DB]
           ,[FEE_CODE]
           ,[ACTIVEIND_DB]
           ,[CLOSE_TOLERANCE]
           ,[PACKAGE_TYPE]
           ,[PROPOSED_PARCEL_QTY]
           ,[PACKAGE_WEIGHT]
           ,[WEIGHT_NET]
           ,[WEIGHT_GROSS]
           ,[VOLUME]
           ,[PRINT_CONTROL_CODE]
           ,[MTK_MODE]
           ,[NOTE_TEXT]
           ,[EAN_NO]
           ,[MINIMUM_QTY]
           ,[REPLACEMENT_PART_NO]
           ,[DATE_OF_REPLACEMENT]
           ,[CREATE_SM_OBJECT_OPTION_DB]
           ,[EXPECTED_AVERAGE_PRICE]
           ,[USE_SITE_SPECIFIC]
           ,[PALLET_TYPE]
           ,[PROPOSED_PALLET_QTY]
           ,[CUST_WARRANTY_ID]
           ,[AIM_TARIFF_CODE])
SELECT [CATALOG_NO]
      ,[_CATALOG_TYPE _DB]
      ,[CATALOG_DESC]
      ,[PART_NO]
      ,[CONTRACT]
      ,[PRICE_UNIT_MEAS]
      ,[CONV_FACTOR]
      ,[PRICE_CONV_FACTOR]
      ,[SALES_UNIT_MEAS]
      ,[DATE_ENTERED]
      ,[LIST_PRICE]
      ,[SOURCING_OPTION]
      ,[RULE_ID]
      ,[SALES_PRICE_GROUP_ID     ]
      ,[CATALOG_GROUP]
      ,[DISCOUNT_GROUP]
      ,'Use sales tax' [TAXABLE_DB]
      ,[FEE_CODE]
      ,[ACTIVEIND_DB]
      ,[CLOSE_TOLERANCE ]
      ,[PACKAGE_TYPE]
      ,[PROPOSED_PARCEL_QTY]
      ,[PACKAGE_WEIGHT]
      ,[WEIGHT_NET]
      ,[WEIGHT_GROSS]
      ,[VOLUME]
      ,[PRINT_CONTROL_CODE ]
      ,[MTK_MODE]
      ,[NOTE_TEXT]
      ,[EAN_NO ]
      ,[MINIMUM_QTY]
      ,[REPLACEMENT_PART_NO]
      ,[DATE_OF_REPLACEMENT]
      ,[CREATE_SM_OBJECT_OPTION_DB]
      ,[EXPECTED_AVERAGE_PRICE]
      ,[USE_SITE_SPECIFIC]
      ,[PALLET_TYPE]
      ,[PROPOSED_PALLET_QTY]
      ,[CUST_WARRANTY_ID]
      ,[HS_Tarif_Code]
  FROM [IFSDEV-ManualUpload].[dbo].[SalesPart$]


