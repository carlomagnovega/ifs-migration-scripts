UPDATE [IFSDEV-ManualUpload].[dbo].[COMMISSION_LINE$]
SET [RANGE TYPE] = 'QUANTITY'  
WHERE [RANGE TYPE] = '%'

UPDATE [IFSDEV-ManualUpload].[dbo].[COMMISSION_LINE$]
SET [RANGE TYPE] = 'AMOUNT'
WHERE [RANGE TYPE] = 'MONTANT'

--------------------------------------------------------------------------------------
DROP TABLE MTK_COMM_AGREE_LINE;
CREATE TABLE MTK_COMM_AGREE_LINE
(
   AGREEMENT_ID                       VARCHAR2(12)        NOT NULL,
   REVISION_NO                        NUMBER              NULL,
   LINE_NO                            NUMBER              NULL,
   SEQUENCE_ORDER                     NUMBER              NULL,
   PERCENTAGE                         NUMBER              NULL,
   AMOUNT                             NUMBER              NULL,
   COMMISSION_RANGE_TYPE              VARCHAR2(20)        NOT NULL,
   COMMISSION_CALC_METH               VARCHAR2(20)        NOT NULL,
   IDENTITY_TYPE                      VARCHAR2(20)        NULL,
   GROUP_ID                           VARCHAR2(20)        NULL,
   STAT_CUST_GRP                      VARCHAR2(10)        NULL,
   PART_PRODUCT_CODE                  VARCHAR2(5)         NULL,
   SALES_PRICE_GROUP_ID               VARCHAR2(10)        NULL,
   COMMODITY_CODE                     VARCHAR2(5)         NULL,
   CATALOG_GROUP                      VARCHAR2(10)        NULL,
   REGION_CODE                        VARCHAR2(10)        NULL,
   CATALOG_NO                         VARCHAR2(25)        NULL,
   COUNTRY_CODE                       VARCHAR2(2)         NULL,
   PART_PRODUCT_FAMILY                VARCHAR2(5)         NULL,
   MARKET_CODE                        VARCHAR2(10)        NULL,
   CUSTOMER_NO                        VARCHAR2(20)        NULL,
   NOTE_TEXT                          VARCHAR2(2000)      NULL,
   AIM_CATEGOTY                       VARCHAR2(2000)      NULL
)

----------------------------------
SELECT 'INSERT INTO MTK_COMM_AGREE_LINE (AGREEMENT_ID,SEQUENCE_ORDER,PERCENTAGE,AMOUNT,COMMISSION_RANGE_TYPE,COMMISSION_CALC_METH,CATALOG_NO,AIM_CATEGOTY) VALUES (''' 
+ [AGREEMENT_ID] 
+ ''',''' +ISNULL([SEQUENCE_ORDER], '') 
+ ''',''' +ISNULL([Percentage], '') 
+ ''',''' +ISNULL([AdjustedAmount], '') 
+ ''',''' +ISNULL([COMMISSION_RANGE_TYPE], '') 
+ ''',''' +ISNULL([COMMISSION_CALC_METH], '') 
+ ''',''' +ISNULL([CATALOG_NO], '') 
+ ''',''' +ISNULL([AIM_CATEGOTY], '') 
+  ''');' aa  
FROM ( SELECT  
       [AGREEMENT_ID]
	   ,[SEQUENCE_ORDER]
	   ,[AIM_CATEGOTY]
       ,[Percentage]
       ,[AdjustedAmount]
       ,[RANGE TYPE] [COMMISSION_RANGE_TYPE]
       ,'EXCLUSIVE' [COMMISSION_CALC_METH]
       ,[Sales Part No] [CATALOG_NO]
  FROM [IFSDEV-ManualUpload].[dbo].[COMMISSION_LINE$] a) ss
	   
---------------------------
----------------------------
DECLARE	  
	CURSOR get_comission_agree_line IS
      SELECT   
            a.AGREEMENT_ID,
            a.REVISION_NO,
			   d.LINE_NO,
			   a.SEQUENCE_ORDER,
			   a.PERCENTAGE,
			   a.COMMISSION_RANGE_TYPE,
			   a.COMMISSION_CALC_METH,
			   a.IDENTITY_TYPE,
			   a.GROUP_ID,
			   a.STAT_CUST_GRP,
			   a.PART_PRODUCT_CODE,
			   a.SALES_PRICE_GROUP_ID,
			   a.COMMODITY_CODE,
			   a.CATALOG_GROUP,
			   a.REGION_CODE,
			   a.CATALOG_NO,
			   a.COUNTRY_CODE,
			   a.PART_PRODUCT_FAMILY,
			   a.MARKET_CODE,
			   a.CUSTOMER_NO,
            a.NOTE_TEXT,
            a.AIM_CATEGOTY,
            a.AMOUNT,
            d.objid,
            d.objversion,
            e.objid range_objid,
            e.objversion range_objversion
      FROM MTK_COMM_AGREE_LINE a
      LEFT JOIN COMMISSION_AGREE_LINE d ON a.AGREEMENT_ID = d.AGREEMENT_ID
               AND a.REVISION_NO = d.REVISION_NO 
               AND a.SEQUENCE_ORDER = d.SEQUENCE_ORDER
      LEFT JOIN COMMISSION_RANGE e ON a.AGREEMENT_ID = e.AGREEMENT_ID
               AND a.REVISION_NO = e.REVISION_NO 
               AND d.LINE_NO = e.LINE_NO               
      WHERE EXISTS (SELECT 1 FROM SALES_PART_TAB c 
                     WHERE  a.CATALOG_NO = c.CATALOG_NO
                     AND c.CONTRACT = '10MTL');
      --AND a.AGREEMENT_ID IN ('A', 'B', 'C');

	info_                   VARCHAR2(2000);
   attr_                   VARCHAR2(2000);
   attr_aux_               VARCHAR2(2000);
   attr_cf_                VARCHAR2(2000);
   objid_                  VARCHAR2(30);
   objversion_             VARCHAR2(30); 	
	
BEGIN
	  
   FOR row_line_ IN get_comission_agree_line LOOP
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('PERCENTAGE', row_line_.PERCENTAGE, attr_);
      Client_SYS.Add_To_Attr('COMMISSION_RANGE_TYPE_DB', row_line_.COMMISSION_RANGE_TYPE, attr_);
      Client_SYS.Add_To_Attr('COMMISSION_CALC_METH_DB', row_line_.COMMISSION_CALC_METH, attr_);
      Client_SYS.Add_To_Attr('IDENTITY_TYPE', row_line_.IDENTITY_TYPE, attr_);
      Client_SYS.Add_To_Attr('GROUP_ID', row_line_.GROUP_ID, attr_);
      Client_SYS.Add_To_Attr('STAT_CUST_GRP', row_line_.STAT_CUST_GRP, attr_);
      Client_SYS.Add_To_Attr('PART_PRODUCT_CODE', row_line_.PART_PRODUCT_CODE, attr_);
      Client_SYS.Add_To_Attr('SALES_PRICE_GROUP_ID', row_line_.SALES_PRICE_GROUP_ID, attr_);
      Client_SYS.Add_To_Attr('COMMODITY_CODE', row_line_.COMMODITY_CODE, attr_);
      Client_SYS.Add_To_Attr('CATALOG_GROUP', row_line_.CATALOG_GROUP, attr_);
      Client_SYS.Add_To_Attr('REGION_CODE', row_line_.REGION_CODE, attr_);
      Client_SYS.Add_To_Attr('CATALOG_NO', row_line_.CATALOG_NO, attr_);
      Client_SYS.Add_To_Attr('COUNTRY_CODE', row_line_.COUNTRY_CODE, attr_);
      Client_SYS.Add_To_Attr('PART_PRODUCT_FAMILY', row_line_.PART_PRODUCT_FAMILY, attr_);
      Client_SYS.Add_To_Attr('MARKET_CODE', row_line_.MARKET_CODE, attr_);
      Client_SYS.Add_To_Attr('CUSTOMER_NO', row_line_.CUSTOMER_NO, attr_);
      Client_SYS.Add_To_Attr('NOTE_TEXT', row_line_.NOTE_TEXT, attr_);
      
      IF (row_line_.objid IS NULL) THEN
         Client_SYS.Add_To_Attr('AGREEMENT_ID', row_line_.AGREEMENT_ID, attr_);
         Client_SYS.Add_To_Attr('REVISION_NO', row_line_.REVISION_NO, attr_);
         Client_SYS.Add_To_Attr('SEQUENCE_ORDER', row_line_.SEQUENCE_ORDER, attr_);
         COMMISSION_AGREE_LINE_API.NEW__(info_, objid_, objversion_, attr_, 'DO');
      ELSE
         objid_ := row_line_.objid;
         objversion_ := row_line_.objversion;
         COMMISSION_AGREE_LINE_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      END IF;
        
      Client_SYS.Clear_Attr(attr_cf_);
      Client_SYS.Clear_Attr(attr_aux_);
      Client_SYS.Add_To_Attr('CF$_AIM_AMOUNT', row_line_.AMOUNT, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIM_CATEGORY', row_line_.AIM_CATEGOTY, attr_cf_);
      COMMISSION_AGREE_LINE_CFP.Cf_Modify__ ( info_, objid_, attr_cf_, attr_aux_,  'DO');
        
      IF (row_line_.COMMISSION_RANGE_TYPE <> 'QUANTITY') THEN
         Client_SYS.Add_To_Attr('AMOUNT', row_line_.AMOUNT, attr_);
         IF (row_line_.range_objid IS NULL) THEN
            Client_SYS.Add_To_Attr('AGREEMENT_ID', row_line_.AGREEMENT_ID, attr_);
            Client_SYS.Add_To_Attr('REVISION_NO', row_line_.REVISION_NO, attr_);
            Client_SYS.Add_To_Attr('MIN_VALUE', '1', attr_);
            COMMISSION_RANGE_API.NEW__(info_, objid_, objversion_, attr_, 'DO');
         ELSE
            COMMISSION_RANGE_API.MODIFY__(info_, row_line_.range_objid, row_line_.range_objversion, attr_, 'DO');
         END IF;          
      END IF;          
   END LOOP;	     
   COMMIT;
END;