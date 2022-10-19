---China
truncate table MTK_PURCHASE_PART_SUPPLIER_TAB;
insert INTO MTK_PURCHASE_PART_SUPPLIER_TAB
(PART_NO,
CONTRACT,
VENDOR_NO,
VENDOR_PART_DESCRIPTION,
VENDOR_PART_NO,
PRICE_UNIT_MEAS,
BUY_UNIT_MEAS,
CONV_FACTOR,
LIST_PRICE,
CURRENCY_CODE,
PRICE_CONV_FACTOR,
STANDARD_PACK_SIZE,
FLAG_VENDOR,
STATUS_CODE,
CONTACT,
MINIMUM_QTY,
VENDOR_MANUF_LEADTIME,
STD_MULTIPLE_QTY,
RECEIVE_CASE_DB,
INSPECTION_CODE,
SAMPLE_PERCENT,
SAMPLE_QTY,
MTK_MODE,
PART_OWNERSHIP_DB,
EXTERNAL_SERVICE_ALLOWED_DB,
INTERNAL_CONTROL_TIME,
MULTISITE_PLANNED_PART_DB,
FEE_CODE,
SUPPLY_CONFIGURATION_DB,
ORDERS_PRICE_OPTION_DB,
QTY_CALC_ROUNDING,
ASSORTMENT,
ADDITIONAL_COST_AMOUNT,
DISCOUNT)  
---Billet Baotai
SELECT a.PART_NO,
       a.CONTRACT,
       '9013' VENDOR_NO,
       '' VENDOR_PART_DESCRIPTION,
       '' VENDOR_PART_NO,
       DEFAULT_BUY_UNIT_MEAS PRICE_UNIT_MEAS,
       DEFAULT_BUY_UNIT_MEAS BUY_UNIT_MEAS,
       1 CONV_FACTOR,
       '' LIST_PRICE,
       Company_Finance_API.Get_Currency_Code(Site_API.Get_Company(a.CONTRACT)) CURRENCY_CODE,
       1 PRICE_CONV_FACTOR,
       1 STANDARD_PACK_SIZE,
       '' FLAG_VENDOR,
       2 STATUS_CODE,
       '' CONTACT,
       0 MINIMUM_QTY,
       '' VENDOR_MANUF_LEADTIME,
       1 STD_MULTIPLE_QTY,
       'INVDIR' RECEIVE_CASE_DB,
       '' INSPECTION_CODE,
       100 SAMPLE_PERCENT,
       '' SAMPLE_QTY,
       '*' MTK_MODE,
       '' PART_OWNERSHIP,
       '' EXTERNAL_SERVICE_ALLOWED_DB,
       '' INTERNAL_CONTROL_TIME,
       '' MULTISITE_PLANNED_PART_DB,
       'NO-TAX' FEE_CODE,
       '' SUPPLY_CONFIGURATION_DB,
       '' ORDERS_PRICE_OPTION_DB,
       4 QTY_CALC_ROUNDING,
       '' ASSORTMENT,
       '' ADDITIONAL_COST_AMOUNT,
       '' DISCOUNT
FROM purchase_part a
--INNER JOIN INVENTORY_PART b ON a.part_no = b.part_no AND a.CONTRACT = B.CONTRACT 
WHERE a.CONTRACT = '33CX'    
AND a.PART_NO IN ('60001-S235KG','60001A-S235KG','60001C-S235KG','60001D-S235KG','60001E-S235KG','60001MW-S235KG','60001S-S235KG','60001W-S235KG','60004-S235KG','60004S-S235KG','60004W-S235KG','60005W-S235KG','60006-S235KG','60006W-S235KG','60007W-S235KG','60008-S235KG','60008W-S235KG','60009-S235KG','60013-S235KG','60014-S235KG','60014W-S235KG','60015-S235KG','60016M-S235KG','60017-S235KG','60025-S235KG','60033-S235KG','60038W-S235KG','60039-S235KG','60039B-S235KG','60039W-S235KG','60068-S235KG','60068W-S235KG','60069-S235KG','60069W-S235KG')    
AND NOT EXISTS (SELECT 1
   FROM PURCHASE_PART_SUPPLIER c
   WHERE a.part_no = c.part_no
   AND a.CONTRACT = c.CONTRACT
   AND c.VENDOR_NO = '9013')
------Flux
UNION ALL
SELECT a.PART_NO,
       a.CONTRACT,
       d.SUPPLIER_ID VENDOR_NO,
       '' VENDOR_PART_DESCRIPTION,
       '' VENDOR_PART_NO,
       DEFAULT_BUY_UNIT_MEAS PRICE_UNIT_MEAS,
       DEFAULT_BUY_UNIT_MEAS BUY_UNIT_MEAS,
       1 CONV_FACTOR,
       '' LIST_PRICE,
       Company_Finance_API.Get_Currency_Code(Site_API.Get_Company(b.CONTRACT)) CURRENCY_CODE,
       --'USD' CURRENCY_CODE,
       1 PRICE_CONV_FACTOR,
       1 STANDARD_PACK_SIZE,
       '' FLAG_VENDOR,
       2 STATUS_CODE,
       '' CONTACT,
       0 MINIMUM_QTY,
       '' VENDOR_MANUF_LEADTIME,
       1 STD_MULTIPLE_QTY,
       'INVDIR' RECEIVE_CASE_DB,
       '' INSPECTION_CODE,
       100 SAMPLE_PERCENT,
       '' SAMPLE_QTY,
       '*' MTK_MODE,
       '' PART_OWNERSHIP,
       '' EXTERNAL_SERVICE_ALLOWED_DB,
       '' INTERNAL_CONTROL_TIME,
       '' MULTISITE_PLANNED_PART_DB,
       'NO-TAX' FEE_CODE,
       '' SUPPLY_CONFIGURATION_DB,
       '' ORDERS_PRICE_OPTION_DB,
       4 QTY_CALC_ROUNDING,
       '' ASSORTMENT,
       '' ADDITIONAL_COST_AMOUNT,
       '' DISCOUNT
FROM purchase_part a
INNER JOIN INVENTORY_PART b ON a.part_no = b.part_no AND a.CONTRACT = B.CONTRACT 
RIGHT JOIN SUPPLIER_INFO_GENERAL d ON d.SUPPLIER_ID IN ('9001', '9066', '9079', '9087', '9092')
WHERE a.CONTRACT = '33CX'    
AND b.PART_PRODUCT_FAMILY = '04'
AND b.PART_PRODUCT_CODE = '114'
AND NOT EXISTS (SELECT 1
   FROM PURCHASE_PART_SUPPLIER c
   WHERE a.part_no = c.part_no
   AND a.CONTRACT = c.CONTRACT
   AND c.VENDOR_NO = d.SUPPLIER_ID)
------Packaging
UNION ALL
SELECT a.PART_NO,
       a.CONTRACT,
       d.SUPPLIER_ID VENDOR_NO,
       '' VENDOR_PART_DESCRIPTION,
       '' VENDOR_PART_NO,
       DEFAULT_BUY_UNIT_MEAS PRICE_UNIT_MEAS,
       DEFAULT_BUY_UNIT_MEAS BUY_UNIT_MEAS,
       1 CONV_FACTOR,
       '' LIST_PRICE,
       Company_Finance_API.Get_Currency_Code(Site_API.Get_Company(b.CONTRACT)) CURRENCY_CODE,
       --'USD' CURRENCY_CODE,
       1 PRICE_CONV_FACTOR,
       1 STANDARD_PACK_SIZE,
       '' FLAG_VENDOR,
       2 STATUS_CODE,
       '' CONTACT,
       0 MINIMUM_QTY,
       '' VENDOR_MANUF_LEADTIME,
       1 STD_MULTIPLE_QTY,
       'INVDIR' RECEIVE_CASE_DB,
       '' INSPECTION_CODE,
       100 SAMPLE_PERCENT,
       '' SAMPLE_QTY,
       '*' MTK_MODE,
       '' PART_OWNERSHIP,
       '' EXTERNAL_SERVICE_ALLOWED_DB,
       '' INTERNAL_CONTROL_TIME,
       '' MULTISITE_PLANNED_PART_DB,
       'NO-TAX' FEE_CODE,
       '' SUPPLY_CONFIGURATION_DB,
       '' ORDERS_PRICE_OPTION_DB,
       4 QTY_CALC_ROUNDING,
       '' ASSORTMENT,
       '' ADDITIONAL_COST_AMOUNT,
       '' DISCOUNT
FROM purchase_part a
INNER JOIN INVENTORY_PART b ON a.part_no = b.part_no AND a.CONTRACT = B.CONTRACT 
RIGHT JOIN SUPPLIER_INFO_GENERAL d ON d.SUPPLIER_ID IN ('9010','9015','9020','9026','9029','9034','9032','9035','9039','9052','9054','9056','9058','9062','9071','9073','9076','9078','9080','9089','9091')
WHERE a.CONTRACT = '33CX'    
AND b.PART_PRODUCT_FAMILY = '12'
AND b.PART_PRODUCT_CODE = '119'
AND NOT EXISTS (SELECT 1
   FROM PURCHASE_PART_SUPPLIER c
   WHERE a.part_no = c.part_no
   AND a.CONTRACT = c.CONTRACT
   AND c.VENDOR_NO = d.SUPPLIER_ID)
------Powder
UNION ALL
SELECT a.PART_NO,
       a.CONTRACT,
       d.SUPPLIER_ID VENDOR_NO,
       '' VENDOR_PART_DESCRIPTION,
       '' VENDOR_PART_NO,
       DEFAULT_BUY_UNIT_MEAS PRICE_UNIT_MEAS,
       DEFAULT_BUY_UNIT_MEAS BUY_UNIT_MEAS,
       1 CONV_FACTOR,
       '' LIST_PRICE,
       Company_Finance_API.Get_Currency_Code(Site_API.Get_Company(b.CONTRACT)) CURRENCY_CODE,
       --'USD' CURRENCY_CODE,
       1 PRICE_CONV_FACTOR,
       1 STANDARD_PACK_SIZE,
       '' FLAG_VENDOR,
       2 STATUS_CODE,
       '' CONTACT,
       0 MINIMUM_QTY,
       '' VENDOR_MANUF_LEADTIME,
       1 STD_MULTIPLE_QTY,
       'INVDIR' RECEIVE_CASE_DB,
       '' INSPECTION_CODE,
       100 SAMPLE_PERCENT,
       '' SAMPLE_QTY,
       '*' MTK_MODE,
       '' PART_OWNERSHIP,
       '' EXTERNAL_SERVICE_ALLOWED_DB,
       '' INTERNAL_CONTROL_TIME,
       '' MULTISITE_PLANNED_PART_DB,
       'NO-TAX' FEE_CODE,
       '' SUPPLY_CONFIGURATION_DB,
       '' ORDERS_PRICE_OPTION_DB,
       4 QTY_CALC_ROUNDING,
       '' ASSORTMENT,
       '' ADDITIONAL_COST_AMOUNT,
       '' DISCOUNT
FROM purchase_part a
INNER JOIN INVENTORY_PART b ON a.part_no = b.part_no AND a.CONTRACT = B.CONTRACT 
RIGHT JOIN SUPPLIER_INFO_GENERAL d ON d.SUPPLIER_ID IN ('9012','9044','9053')
WHERE a.CONTRACT = '33CX'    
AND b.PART_PRODUCT_FAMILY = '06'
AND b.PART_PRODUCT_CODE = '123'
AND NOT EXISTS (SELECT 1
   FROM PURCHASE_PART_SUPPLIER c
   WHERE a.part_no = c.part_no
   AND a.CONTRACT = c.CONTRACT
   AND c.VENDOR_NO = d.SUPPLIER_ID)
------Raw chemical
UNION ALL
SELECT a.PART_NO,
       a.CONTRACT,
       d.SUPPLIER_ID VENDOR_NO,
       '' VENDOR_PART_DESCRIPTION,
       '' VENDOR_PART_NO,
       DEFAULT_BUY_UNIT_MEAS PRICE_UNIT_MEAS,
       DEFAULT_BUY_UNIT_MEAS BUY_UNIT_MEAS,
       1 CONV_FACTOR,
       '' LIST_PRICE,
       Company_Finance_API.Get_Currency_Code(Site_API.Get_Company(b.CONTRACT)) CURRENCY_CODE,
       --'USD' CURRENCY_CODE,
       1 PRICE_CONV_FACTOR,
       1 STANDARD_PACK_SIZE,
       '' FLAG_VENDOR,
       2 STATUS_CODE,
       '' CONTACT,
       0 MINIMUM_QTY,
       '' VENDOR_MANUF_LEADTIME,
       1 STD_MULTIPLE_QTY,
       'INVDIR' RECEIVE_CASE_DB,
       '' INSPECTION_CODE,
       100 SAMPLE_PERCENT,
       '' SAMPLE_QTY,
       '*' MTK_MODE,
       '' PART_OWNERSHIP,
       '' EXTERNAL_SERVICE_ALLOWED_DB,
       '' INTERNAL_CONTROL_TIME,
       '' MULTISITE_PLANNED_PART_DB,
       'NO-TAX' FEE_CODE,
       '' SUPPLY_CONFIGURATION_DB,
       '' ORDERS_PRICE_OPTION_DB,
       4 QTY_CALC_ROUNDING,
       '' ASSORTMENT,
       '' ADDITIONAL_COST_AMOUNT,
       '' DISCOUNT
FROM purchase_part a
INNER JOIN INVENTORY_PART b ON a.part_no = b.part_no AND a.CONTRACT = B.CONTRACT 
RIGHT JOIN SUPPLIER_INFO_GENERAL d ON d.SUPPLIER_ID IN ('9028','9036','9040','9065','9068','9077','9088','9090')
WHERE a.CONTRACT = '33CX'    
AND b.PART_PRODUCT_FAMILY = '08'
AND b.PART_PRODUCT_CODE = '104'
AND NOT EXISTS (SELECT 1
   FROM PURCHASE_PART_SUPPLIER c
   WHERE a.part_no = c.part_no
   AND a.CONTRACT = c.CONTRACT
   AND c.VENDOR_NO = d.SUPPLIER_ID)
UNION ALL
---If they exit in 10MTL please create a supplier for purchase parts using the supplier 1751 in site 33CX
SELECT a.PART_NO,
       a.CONTRACT,
       d.SUPPLIER_ID VENDOR_NO,
       '' VENDOR_PART_DESCRIPTION,
       '' VENDOR_PART_NO,
       DEFAULT_BUY_UNIT_MEAS PRICE_UNIT_MEAS,
       DEFAULT_BUY_UNIT_MEAS BUY_UNIT_MEAS,
       1 CONV_FACTOR,
       '' LIST_PRICE,
       Company_Finance_API.Get_Currency_Code(Site_API.Get_Company(a.CONTRACT)) CURRENCY_CODE,
       --'USD' CURRENCY_CODE,
       1 PRICE_CONV_FACTOR,
       1 STANDARD_PACK_SIZE,
       '' FLAG_VENDOR,
       2 STATUS_CODE,
       '' CONTACT,
       0 MINIMUM_QTY,
       '' VENDOR_MANUF_LEADTIME,
       1 STD_MULTIPLE_QTY,
       'INVDIR' RECEIVE_CASE_DB,
       '' INSPECTION_CODE,
       100 SAMPLE_PERCENT,
       '' SAMPLE_QTY,
       '*' MTK_MODE,
       '' PART_OWNERSHIP,
       '' EXTERNAL_SERVICE_ALLOWED_DB,
       '' INTERNAL_CONTROL_TIME,
       '' MULTISITE_PLANNED_PART_DB,
       'NO-TAX' FEE_CODE,
       '' SUPPLY_CONFIGURATION_DB,
       '' ORDERS_PRICE_OPTION_DB,
       4 QTY_CALC_ROUNDING,
       '' ASSORTMENT,
       '' ADDITIONAL_COST_AMOUNT,
       '' DISCOUNT
FROM purchase_part a
INNER JOIN INVENTORY_PART b ON a.part_no = b.part_no AND B.CONTRACT = '10MTL'
RIGHT JOIN SUPPLIER_INFO_GENERAL d ON d.SUPPLIER_ID IN ('1751')
WHERE a.CONTRACT = '33CX'    
AND NOT EXISTS (SELECT 1
   FROM PURCHASE_PART_SUPPLIER c
   WHERE a.part_no = c.part_no
   AND a.CONTRACT = c.CONTRACT
   AND c.VENDOR_NO = d.SUPPLIER_ID)
UNION ALL
---If they exit in 20MEX please create a supplier for purchase parts using the supplier 2995 in site 33CX
SELECT a.PART_NO,
       a.CONTRACT,
       d.SUPPLIER_ID VENDOR_NO,
       '' VENDOR_PART_DESCRIPTION,
       '' VENDOR_PART_NO,
       DEFAULT_BUY_UNIT_MEAS PRICE_UNIT_MEAS,
       DEFAULT_BUY_UNIT_MEAS BUY_UNIT_MEAS,
       1 CONV_FACTOR,
       '' LIST_PRICE,
       Company_Finance_API.Get_Currency_Code(Site_API.Get_Company(a.CONTRACT)) CURRENCY_CODE,
       --'USD' CURRENCY_CODE,
       1 PRICE_CONV_FACTOR,
       1 STANDARD_PACK_SIZE,
       '' FLAG_VENDOR,
       2 STATUS_CODE,
       '' CONTACT,
       0 MINIMUM_QTY,
       '' VENDOR_MANUF_LEADTIME,
       1 STD_MULTIPLE_QTY,
       'INVDIR' RECEIVE_CASE_DB,
       '' INSPECTION_CODE,
       100 SAMPLE_PERCENT,
       '' SAMPLE_QTY,
       '*' MTK_MODE,
       '' PART_OWNERSHIP,
       '' EXTERNAL_SERVICE_ALLOWED_DB,
       '' INTERNAL_CONTROL_TIME,
       '' MULTISITE_PLANNED_PART_DB,
       'NO-TAX' FEE_CODE,
       '' SUPPLY_CONFIGURATION_DB,
       '' ORDERS_PRICE_OPTION_DB,
       4 QTY_CALC_ROUNDING,
       '' ASSORTMENT,
       '' ADDITIONAL_COST_AMOUNT,
       '' DISCOUNT
FROM purchase_part a
INNER JOIN INVENTORY_PART b ON a.part_no = b.part_no AND B.CONTRACT = '20MEX'
RIGHT JOIN SUPPLIER_INFO_GENERAL d ON d.SUPPLIER_ID IN ('2995')
WHERE a.CONTRACT = '33CX'    
AND NOT EXISTS (SELECT 1
   FROM PURCHASE_PART_SUPPLIER c
   WHERE a.part_no = c.part_no
   AND a.CONTRACT = c.CONTRACT
   AND c.VENDOR_NO = d.SUPPLIER_ID)				 

   

---------------------------------------------------
SELECT PART_NO
      ,CONTRACT
      ,VENDOR_NO
      ,replace(VENDOR_PART_DESCRIPTION, '"', '-')  VENDOR_PART_DESCRIPTION
      ,VENDOR_PART_NO
      ,PRICE_UNIT_MEAS PRICE_UNIT_MEAS
      ,lower(BUY_UNIT_MEAS) BUY_UNIT_MEAS
      ,CONV_FACTOR
      ,LIST_PRICE
      ,CURRENCY_CODE
      ,PRICE_CONV_FACTOR
      ,'' EAN_NO
      ,STANDARD_PACK_SIZE
      ,'' FLAG_VENDOR
      ,STATUS_CODE
      ,CONTACT
      ,MINIMUM_QTY
      ,VENDOR_MANUF_LEADTIME
      ,STD_MULTIPLE_QTY
      ,RECEIVE_CASE_DB
      ,INSPECTION_CODE
      ,SAMPLE_PERCENT
      ,SAMPLE_QTY
      ,'*' MTK_MODE
      ,PART_OWNERSHIP
      ,EXTERNAL_SERVICE_ALLOWED_DB
      ,INTERNAL_CONTROL_TIME
      ,MULTISITE_PLANNED_PART_DB
      ,FEE_CODE
      ,SUPPLY_CONFIGURATION_DB
      ,ORDERS_PRICE_OPTION_DB
      ,QTY_CALC_ROUNDING
      ,ASSORTMENT
      ,ADDITIONAL_COST_AMOUNT
      ,DISCOUNT
      ,DELIVERY_PATTERN_ID
      ,'' SUFIX
FROM PURCHASE_PART_SUPPLIER
WHERE CONTRACT = '41POL'

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

-----------MissingSalesPart PROD
SELECT contract, part_no, description
FROM purchase_part a
WHERE contract = '40UK'
AND NOT EXISTS (SELECT 1 FROM sales_part b
WHERE a.part_no = b.catalog_no AND b.contract = '11RI')

---------------------------from PROD
SELECT PART_NO
      ,CONTRACT
      ,'4452' VENDOR_NO
      ,'' VENDOR_PART_DESCRIPTION
      ,'' VENDOR_PART_NO
      ,DEFAULT_BUY_UNIT_MEAS PRICE_UNIT_MEAS
      ,DEFAULT_BUY_UNIT_MEAS BUY_UNIT_MEAS
      ,1 CONV_FACTOR
      ,'' LIST_PRICE
      ,'EUR' CURRENCY_CODE
      ,1 PRICE_CONV_FACTOR
      ,'' EAN_NO
      ,1 STANDARD_PACK_SIZE
      ,'' FLAG_VENDOR
      ,2 STATUS_CODE
      ,'' CONTACT
      ,0 MINIMUM_QTY
      ,'' VENDOR_MANUF_LEADTIME
      ,1 STD_MULTIPLE_QTY
      ,'INVDIR' RECEIVE_CASE_DB
      ,'' INSPECTION_CODE
      ,100 SAMPLE_PERCENT
      ,'' SAMPLE_QTY
      ,'*' MTK_MODE
      ,'' PART_OWNERSHIP
      ,'' EXTERNAL_SERVICE_ALLOWED_DB
      ,'' INTERNAL_CONTROL_TIME
      ,'' MULTISITE_PLANNED_PART_DB
      ,'PURCHASE VAT 0%' FEE_CODE
      ,'' SUPPLY_CONFIGURATION_DB
      ,'' ORDERS_PRICE_OPTION_DB
      ,4 QTY_CALC_ROUNDING
      ,'' ASSORTMENT
      ,'' ADDITIONAL_COST_AMOUNT
      ,'' DISCOUNT
      ,'' DELIVERY_PATTERN_ID
FROM purchase_part a
WHERE contract = '40UK'
AND EXISTS (SELECT 1 FROM sales_part b
   WHERE b.part_no = a.part_no AND b.contract = '41POL')
   
   
-----------------------------
truncate table MTK_PURCHASE_PART_SUPPLIER_TAB;
insert INTO MTK_PURCHASE_PART_SUPPLIER_TAB
  (PART_NO,
   CONTRACT,
   VENDOR_NO,
   VENDOR_PART_DESCRIPTION,
   VENDOR_PART_NO,
   PRICE_UNIT_MEAS,
   BUY_UNIT_MEAS,
   CONV_FACTOR,
   LIST_PRICE,
   CURRENCY_CODE,
   PRICE_CONV_FACTOR,
   STANDARD_PACK_SIZE,
   FLAG_VENDOR,
   STATUS_CODE,
   CONTACT,
   MINIMUM_QTY,
   VENDOR_MANUF_LEADTIME,
   STD_MULTIPLE_QTY,
   RECEIVE_CASE_DB,
   INSPECTION_CODE,
   SAMPLE_PERCENT,
   SAMPLE_QTY,
   MTK_MODE,
   PART_OWNERSHIP_DB,
   EXTERNAL_SERVICE_ALLOWED_DB,
   INTERNAL_CONTROL_TIME,
   MULTISITE_PLANNED_PART_DB,
   FEE_CODE,
   SUPPLY_CONFIGURATION_DB,
   ORDERS_PRICE_OPTION_DB,
   QTY_CALC_ROUNDING,
   ASSORTMENT,
   ADDITIONAL_COST_AMOUNT,
   DISCOUNT)
  SELECT a.PART_NO,
         a.CONTRACT,
         CASE
           WHEN b.CONTRACT = '10MTL' THEN
            '1751'
           WHEN b.CONTRACT = '33CX' THEN
            '1229'
           WHEN b.CONTRACT = '34MAY' THEN
            '2815'
           WHEN b.CONTRACT = '41POL' THEN
            '4452'
		   WHEN b.CONTRACT = '20MEX' THEN
            '2995'	
           ELSE
            '---'
         END VENDOR_NO,
         '' VENDOR_PART_DESCRIPTION,
         '' VENDOR_PART_NO,
         DEFAULT_BUY_UNIT_MEAS PRICE_UNIT_MEAS,
         DEFAULT_BUY_UNIT_MEAS BUY_UNIT_MEAS,
         1 CONV_FACTOR,
         '' LIST_PRICE,
         --Company_Finance_API.Get_Currency_Code(Site_API.Get_Company(b.CONTRACT)) CURRENCY_CODE,
         'USD' CURRENCY_CODE,
         1 PRICE_CONV_FACTOR,
         1 STANDARD_PACK_SIZE,
         '' FLAG_VENDOR,
         2 STATUS_CODE,
         '' CONTACT,
         0 MINIMUM_QTY,
         '' VENDOR_MANUF_LEADTIME,
         1 STD_MULTIPLE_QTY,
         'INVDIR' RECEIVE_CASE_DB,
         '' INSPECTION_CODE,
         100 SAMPLE_PERCENT,
         '' SAMPLE_QTY,
         '*' MTK_MODE,
         '' PART_OWNERSHIP,
         '' EXTERNAL_SERVICE_ALLOWED_DB,
         '' INTERNAL_CONTROL_TIME,
         '' MULTISITE_PLANNED_PART_DB,
         'NO-TAX' FEE_CODE,
         '' SUPPLY_CONFIGURATION_DB,
         '' ORDERS_PRICE_OPTION_DB,
         4 QTY_CALC_ROUNDING,
         '' ASSORTMENT,
         '' ADDITIONAL_COST_AMOUNT,
         '' DISCOUNT
    FROM purchase_part a
   INNER JOIN SALES_PART b
      ON a.part_no = b.catalog_no
   WHERE a.CONTRACT = '33CX'
     AND B.CONTRACT IN ('10MTL', '20MEX')
     AND NOT EXISTS (select 1
            from PURCHASE_PART_SUPPLIER c
           where a.part_no = c.part_no
             AND a.CONTRACT = c.CONTRACT
             AND c.VENDOR_NO = CASE
                   WHEN b.CONTRACT = '10MTL' THEN
                    '1751'
                   WHEN b.CONTRACT = '33CX' THEN
                    '1229'
                   WHEN b.CONTRACT = '34MAY' THEN
                    '2815'
                   WHEN b.CONTRACT = '41POL' THEN
                    '4452'
				   WHEN b.CONTRACT = '20MEX' THEN
                    '2995'	
                   ELSE
                    '---'
                 END)
