USE [IFSDEV-ManualUpload]
GO
TRUNCATE TABLE [dbo].[OnHandQuantity]
GO
INSERT INTO [dbo].[OnHandQuantity]
           ([CONTRACT]
           ,[PART_NO]
           ,[LOCATION_NO]
           ,[ENG_REVISION]
           ,[ENG_CHG_LEVEL]
           ,[LOT_BATCH_NO]
           ,[QUANTITY]
           ,[ZERO_COST_CHANGED_FLAG]
           ,[SERIAL_NO]
           ,[EXPIRATION_DATE]
           ,[RECEIPT_DATE]
           ,[PROJECT_ID]
           ,[SUB_PROJECT_ID]
           ,[ACTIVITY_NO]
           ,[ORDER_TYPE]
           ,[WAIV_DEV_REJ_NO]
           ,[ORDER_NO]
           ,[LINE_NO]
           ,[RELEASE_NO]
           ,[LINE_ITEM_NO]
           ,[LAST_COUNT_DATE]
           ,[LAST_ACTIVITY_DATE]
           ,[SUPPRESS_TRANSACTIONS]
           ,[CONDITION_CODE]
           ,[INVENTORY_VALUE]
           ,[AVAILABILITY_CONTROL_ID]
           ,[PART_OWNERSHIP]
           ,[OWNING_CUSTOMER_NO]
           ,[OWNING_VENDOR_NO]
           ,[FISCAL_NOTE_ID]
           ,[CATCH_QTY_ONHAND])
SELECT  [CONTRACT]
      ,[PART_NO]
      ,'27' [LOCATION_NO]
      ,null [ENG_REVISION]
      ,null [ENG_CHG_LEVEL]
      ,rtrim(ltrim([LOT_BATCH_NO])) [LOT_BATCH_NO]
      ,cast([QUANTITY] as float)
      ,null [ZERO_COST_CHANGED_FLAG]
      ,'*' [SERIAL_NO]
      ,'1900-01-01' [EXPIRATION_DATE]
      ,'1900-01-01' [RECEIPT_DATE ]
      ,null [PROJECT_ID]
      ,null [SUB_PROJECT_ID]
      ,null [ACTIVITY_NO]
      ,null [ORDER_TYPE]
      ,[WAIV_DEV_REJ_NO]
      ,null [ORDER_NO]
      ,null [LINE_NO]
      ,null [RELEASE_NO]
      ,null [LINE_ITEM_NO]
      ,'1900-01-01' [LAST_COUNT_DATE]
      ,'1900-01-01' [LAST_ACTIVITY_DATE]
      ,'N' [SUPPRESS_TRANSACTIONS]
      ,null [CONDITION_CODE]
      ,null [INVENTORY_VALUE]
      ,null [AVAILABILITY_CONTROL_ID]
      ,'COMPANY OWNED' [PART_OWNERSHIP]
      ,null [OWNING_CUSTOMER_NO]
      ,null [OWNING_VENDOR_NO ]
      ,0 [FISCAL_NOTE_ID]
      ,null [CATCH_QTY_ONHAND]
  FROM [OnHandQuantity$]
  WHERE [CONTRACT] IS NOT NULL
GO

-------------------------------------------
USE [IFSDEV-ManualUpload]
GO
TRUNCATE TABLE [dbo].[IPCostDetail]
GO
INSERT INTO [dbo].[IPCostDetail]
           ([CONTRACT]
           ,[PART_NO]
           ,[LOT_BATCH_NO]
           ,[SERIAL_NO]
           ,[CONDITION_CODE]
           ,[CONFIGURATION_ID]
           ,[COST_BUCKET_ID]
           ,[COST_SOURCE_ID]
           ,[ACCOUNTING_YEAR]
           ,[UNIT_COST])
SELECT [CONTRACT]
      ,[PART_NO]
      ,rtrim(ltrim([LOT_BATCH_NO]))
      ,'*' [SERIAL_NO]
      ,'' [CONDITION_CODE]
      ,[CONFIGURATION_ID]
      ,[COST_BUCKET_ID]
      ,[COST_SOURCE_ID]
      ,[ACCOUNTING_YEAR]
      ,[UNIT_COST]
  FROM [IFSDEV-ManualUpload].[dbo].[IPCostDetail$]
  WHERE [CONTRACT] IS NOT NULL
GO


UPDATE MTK_ONHAND_QUANTITY_TAB 
SET CONTRACT = '11RI'
WHERE CONTRACT = '11-RI';	

UPDATE MTK_IP_COST_DETAIL_TAB 
SET CONTRACT = '11RI'
WHERE CONTRACT = '11-RI';


update MTK_ONHAND_QUANTITY_TAB oqt
SET LOT_BATCH_NO = '*'
where exists
(select 1 FROM PART_CATALOG pct 
                        WHERE pct.PART_NO = oqt.PART_NO 
                        AND pct.LOT_TRACKING_CODE_DB = 'NOT LOT TRACKING');
						
----
update MTK_ONHAND_QUANTITY_TAB oqt
SET LOT_BATCH_NO = 'GOLIVE'
where LOT_BATCH_NO = '*' 
AND exists
(select 1 FROM PART_CATALOG pct 
                        WHERE pct.PART_NO = oqt.PART_NO 
                        AND pct.LOT_TRACKING_CODE_DB = 'LOT TRACKING');

--update MTK_ONHAND_QUANTITY_TAB oqt
--SET LOT_BATCH_NO = 'LIVE'
--where LOT_BATCH_NO = '*' 
--AND exists
--(select 1 FROM PART_CATALOG pct 
--                        WHERE pct.PART_NO = oqt.PART_NO 
--                        AND pct.LOT_TRACKING_CODE_DB = 'LOT TRACKING');						
	
UPDATE MTK_ONHAND_QUANTITY_TAB a
SET LOCATION_NO = INVENTORY_PART_DEF_LOC_API.Get_Location_No(a.CONTRACT,a.PART_NO)
WHERE INVENTORY_PART_DEF_LOC_API.Get_Location_No(a.CONTRACT,a.PART_NO) IS NOT NULL;
	
---
UPDATE MTK_ONHAND_QUANTITY_TAB 
SET CATCH_QTY_ONHAND = NULL;		

----				
update MTK_IP_COST_DETAIL_TAB oqt
SET LOT_BATCH_NO = '*'
where LOT_BATCH_NO <> '*' 
AND exists (select 1 FROM PART_CATALOG pct 
                        WHERE pct.PART_NO = oqt.PART_NO 
                        AND pct.LOT_TRACKING_CODE_DB = 'NOT LOT TRACKING');

----------------						
--update MTK_IP_COST_DETAIL_TAB oqt
--SET LOT_BATCH_NO = 'GOLIVE'
--where LOT_BATCH_NO = '*' 
--AND exists
--(select 1 FROM PART_CATALOG pct 
--                        WHERE pct.PART_NO = oqt.PART_NO 
--                       AND pct.LOT_TRACKING_CODE_DB = 'LOT TRACKING');
						
--
UPDATE MTK_ONHAND_QUANTITY_TAB
SET INVENTORY_VALUE = NULL;	

   
UPDATE MTK_ONHAND_QUANTITY_TAB
SET PART_OWNERSHIP_DB = 'COMPANY OWNED';	


update MTK_IP_COST_DETAIL_TAB oqt
SET LOT_BATCH_NO = '*'
where LOT_BATCH_NO <> '*' 
AND exists (select 1 FROM INVENTORY_PART pct 
                        WHERE pct.PART_NO = oqt.PART_NO 
                        AND pct.CONTRACT = oqt.CONTRACT 
                        AND pct.inventory_part_cost_level_db = 'COST PER PART')
						
update MTK_ONHAND_QUANTITY_TAB oqt
SET LOT_BATCH_NO = '*'
where LOT_BATCH_NO <> '*' 
AND exists (select 1 FROM INVENTORY_PART pct 
                        WHERE pct.PART_NO = oqt.PART_NO 
                        AND pct.CONTRACT = oqt.CONTRACT 
                        AND pct.inventory_part_cost_level_db = 'COST PER PART')						

--Aggregate Qty
UPDATE MTK_ONHAND_QUANTITY_TAB M1
SET QUANTITY = (SELECT SUM(QUANTITY) 
   FROM MTK_ONHAND_QUANTITY_TAB M2
   WHERE M1.CONTRACT = M2.CONTRACT AND M1.PART_NO = M2.PART_NO AND M1.LOT_BATCH_NO = M2.LOT_BATCH_NO
GROUP BY M2.CONTRACT, M2.PART_NO, M2.LOT_BATCH_NO);

--Delete Duplicated
DELETE FROM MTK_ONHAND_QUANTITY_TAB A 
WHERE ROWID > (SELECT min(rowid) FROM MTK_ONHAND_QUANTITY_TAB B
               WHERE A.CONTRACT = B.CONTRACT AND A.PART_NO = B.PART_NO AND A.LOT_BATCH_NO = B.LOT_BATCH_NO);
			   
DELETE FROM MTK_IP_COST_DETAIL_TAB A 
WHERE ROWID > (SELECT min(rowid) FROM MTK_IP_COST_DETAIL_TAB B
               WHERE A.CONTRACT = B.CONTRACT AND A.PART_NO = B.PART_NO AND A.LOT_BATCH_NO = B.LOT_BATCH_NO);			   
			   
--VERIFY
SELECT PART_NO, CONTRACT, LOT_BATCH_NO, QTY 
FROM (
	SELECT PART_NO, CONTRACT, LOT_BATCH_NO, COUNT(*) QTY
	FROM MTK_ONHAND_QUANTITY_TAB A 
	GROUP BY PART_NO, CONTRACT, LOT_BATCH_NO) aa
WHERE QTY > 1

SELECT PART_NO, CONTRACT, LOT_BATCH_NO, QTY 
FROM (
	SELECT PART_NO, CONTRACT, LOT_BATCH_NO, COUNT(*) QTY
	FROM MTK_IP_COST_DETAIL_TAB A 
	GROUP BY PART_NO, CONTRACT, LOT_BATCH_NO) aa
WHERE QTY > 1

SELECT * 
from mtk_onhand_quantity_vw m1 
INNER JOIN mtk_ip_cost_detail_tab m2 
ON M1.CONTRACT = M2.CONTRACT AND M1.PART_NO = M2.PART_NO AND M1.LOT_BATCH_NO = M2.LOT_BATCH_NO
			   
	