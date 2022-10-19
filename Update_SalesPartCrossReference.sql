DROP TABLE SALES_PART_CROSS_REF_CF_TAB;
CREATE TABLE SALES_PART_CROSS_REF_CF_TAB
(
   CUSTOMER_PART_NO                   VARCHAR2(45)         NULL,
   CATALOG_NO		                   VARCHAR2(25)         NULL,
   CONTRACT                           VARCHAR2(5)          NULL,
   CUSTOMER_NO                        VARCHAR2(20)         NULL,
   AIM_PARTNO_LABEL               VARCHAR2(100)         NULL  
)

SELECT 'INSERT INTO SALES_PART_CROSS_REF_CF_TAB (CONTRACT,CUSTOMER_NO,CATALOG_NO,AIM_PARTNO_LABEL) VALUES (''' 
+ LTRIM(RTRIM(CONTRACT)) 
+ ''',''' + LTRIM(RTRIM(CUSTOMER_NO)) 
+ ''',''' + LTRIM(RTRIM(CATALOG_NO)) 
+ ''',''' + LTRIM(RTRIM(AIM_PARTNO_LABEL)) 
+  ''');' aaa 
FROM (
SELECT [Customer No]		CUSTOMER_NO
      ,[Site]				CONTRACT
      ,[Sales Part No]		CATALOG_NO
      ,REPLACE(REPLACE(AIM_PARTNO_LABEL,'''','-'),'&','-')   AIM_PARTNO_LABEL
  FROM [IFSDEV-ManualUpload].[dbo].[SalesPartCrossReference$]
  WHERE [AIM_PARTNO_LABEL]IS NOT NULL) aa;
-------------------
DECLARE   
   CURSOR get_qaman IS
      SELECT
         qcp.objid,
         qcp.CONTRACT,
         qcp.CUSTOMER_NO,
         qcp.CATALOG_NO,
         AIM_PARTNO_LABEL
      FROM SALES_PART_CROSS_REF_CF_TAB qcpa
      INNER JOIN SALES_PART_CROSS_REFERENCE qcp ON  qcp.CONTRACT = qcpa.CONTRACT 
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
      Client_SYS.Clear_Attr(attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIM_PARTNO_LABEL', row_.AIM_PARTNO_LABEL, attr_cf_);

      SALES_PART_CROSS_REFERENCE_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');
   END LOOP;   
END;


--------------------------------
DECLARE   
   CURSOR get_qaman IS
      SELECT
            objid,
			   CUSTOMER_PART_NO
      FROM SALES_PART_CROSS_REFERENCE_CFV
      WHERE CF$_AIM_PARTNO_LABEL IS NULL;
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      Client_SYS.Clear_Attr(attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIM_PARTNO_LABEL', row_.CUSTOMER_PART_NO, attr_cf_);

      SALES_PART_CROSS_REFERENCE_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');
   END LOOP;
   
END;