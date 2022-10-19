CREATE TABLE SALES_PART_CROSS_REF_CF_TAB
(
   CUSTOMER_PART_NO                   VARCHAR2(45)        NOT NULL,
   CONTRACT                           VARCHAR2(5)         NOT NULL,
   CUSTOMER_NO                        VARCHAR2(20)        NOT NULL,
   CATALOG_NO                         VARCHAR2(25)        NOT NULL  
)

--------------------------------------------
SELECT 'INSERT INTO SALES_PART_CROSS_REF_CF_TAB (CUSTOMER_PART_NO,CONTRACT,CUSTOMER_NO,CATALOG_NO) VALUES (''' 
+ LTRIM(RTRIM(CUSTOMER_PART_NO)) 
+ ''',''' + LTRIM(RTRIM(CONTRACT)) 
+ ''',''' + LTRIM(RTRIM(CUSTOMER_NO)) 
+ ''',''' + LTRIM(RTRIM(CATALOG_NO)) 
+  ''');' aaa 
FROM ( SELECT [Customer's Part No] CUSTOMER_PART_NO
	  ,[Coordinador ] CONTRACT
      ,[Customer No] CUSTOMER_NO
      ,[Sales Part No] CATALOG_NO
  FROM [IFSDEV-ManualUpload].[dbo].[Cross_salespart$] ipt) aa; 

----------------------------------------------------------
DECLARE   
   CURSOR get_qaman IS
      SELECT
         qcp.objid,
         qcp.CUSTOMER_PART_NO,
         qcp.CONTRACT,
         qcp.CUSTOMER_NO,
         qcp.CATALOG_NO
      FROM SALES_PART_CROSS_REF_CF_TAB qcpa
      INNER JOIN SALES_PART_CROSS_REFERENCE qcp ON qcp.CUSTOMER_PART_NO = qcpa.CUSTOMER_PART_NO
      AND qcp.CONTRACT = qcpa.CONTRACT 
      AND qcp.CUSTOMER_NO = qcpa.CUSTOMER_NO
      AND qcp.CATALOG_NO = qcpa.CATALOG_NO;
      
      info_                VARCHAR2(32000);
      objid_               VARCHAR2(32000);
      objversion_          VARCHAR2(32000);
      attr_cf_             VARCHAR2(26000);
      attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Clear_Attr(attr_cf_);
      
      Client_SYS.Add_To_Attr('CF$_AIM_SUPPLY_CODE', 'Invent Order', attr_cf_);
      
      SALES_PART_CROSS_REFERENCE_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');
      COMMIT;
   END LOOP;   
END;