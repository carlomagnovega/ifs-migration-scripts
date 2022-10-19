USE [IFSDEV-ManualUpload]
GO
DELETE FROM [dbo].[PurchasePart$]
WHERE [PART_NO] = '55645-LB'
GO
DELETE FROM [dbo].[PurchasePart$]
WHERE [PART_NO] = '55645-FT'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[PurchasePart$]
SET [PART_NO] = '59556'
WHERE [PART_NO] = '59556-LB'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[PurchasePart$]
SET [PART_NO] = '59545'
WHERE [PART_NO] = '59545-LB'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[PurchasePart$]
SET [PART_NO] = '58224-BULK'
WHERE [PART_NO] = '58224-BILK'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[PurchasePart$]
SET [PART_NO] = '59586'
WHERE [PART_NO] = '59586-LB'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[PurchasePart$]
SET [PART_NO] = '59568'
WHERE [PART_NO] = '59568-LB'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[PurchasePart$]
SET [PART_NO] = '59538'
WHERE [PART_NO] = '59538-LB'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[PurchasePart$]
SET [PART_NO] = '59557'
WHERE [PART_NO] = '59557-LB'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[PurchasePart$]
SET [PART_NO] = '59562'
WHERE [PART_NO] = '59562-LB'
GO
UPDATE [IFSDEV-ManualUpload].[dbo].[PurchasePart$]
SET [PART_NO] = '59665'
WHERE [PART_NO] = '59665-LB'
GO

TRUNCATE TABLE [dbo].[PurchasePart]
GO
INSERT INTO [dbo].[PurchasePart]
           ([PART_NO]
           ,[CONTRACT]
           ,[DESCRIPTION]
           ,[DATE_CRE]
           ,[DEFAULT_BUY_UNIT_MEAS]
           ,[STANDARD_PACK_SIZE]
           ,[BUYER_CODE]
           ,[TECHNICAL_COORDINATOR]
           ,[STAT_GRP]
           ,[CLOSE_TOLERANCE]
           ,[OVER_DELIVERY_TOLERANCE]
           ,[TAXABLE_DB]
           ,[MTK_MODE]
           ,[QC_CODE]
           ,[NOTE_TEXT]
           ,[QC_DATE])
SELECT [PART_NO]
      ,[CONTRACT]
      ,[DESCRIPTION]
      ,[DATE_CRE]
      ,[DEFAULT_BUY_UNIT_MEAS]
      ,[STANDARD_PACK_SIZE]
      ,'' [BUYER_CODE]
      ,[TECHNICAL_COORDINATOR]
      ,[STAT_GRP]
      ,[CLOSE_TOLERANCE]
      ,[OVER_DELIVERY_TOLERANCE]
      ,'TRUE' [TAXABLE_DB]
      ,[MTK_MODE]
      ,[QC_CODE]
      ,[NOTE_TEXT]
      ,[QC_DATE]
  FROM [IFSDEV-ManualUpload].[dbo].[PurchasePart$]
GO


