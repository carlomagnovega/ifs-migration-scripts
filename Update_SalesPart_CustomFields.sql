DROP TABLE MTK_SALESPART_CF_TAB;

CREATE TABLE MTK_SALESPART_CF_TAB
(
   CATALOG_NO                         VARCHAR2(25)        NOT NULL,
   CONTRACT                           VARCHAR2(5)         NOT NULL, 
   CF$_AIM_DESCR_ADUANA               VARCHAR2(200)        NULL,
   CF$_AIM_DISPLAY_CONVFACT           NUMBER              NULL,
   CF$_AIM_DISPLAY_UOM                VARCHAR2(25)        NULL,
   CF$_AIM_EXCLUDE_SALES_REP          VARCHAR2(20)        NULL,
   CF$_AIM_PRODSERVKEY                VARCHAR2(20)        NULL,
   CF$_AIM_STANDARD_COST              NUMBER              NULL,
   CF$_AIM_TARIFF_CODE                VARCHAR2(20)        NULL,
   CF$_AIM_UNIDAD_ADUANA              VARCHAR2(100)       NULL,
   CF$_AIM_UOM_CONV                   NUMBER              NULL   
);

SELECT 'INSERT INTO MTK_SALESPART_CF_TAB (CATALOG_NO,CF$_AIM_TARIFF_CODE) VALUES (''' 
+ LTRIM(RTRIM(CATALOG_NO)) 
+ ''',''' + ISNULL(AIM_TARIFF_CODE, '') 
+  ''');' aaa  
FROM ( SELECT  
       [Sales Part No]  	CATALOG_NO  
	  ,max([HS CODE])           AIM_TARIFF_CODE      
  FROM [dbo].[HsCode1$] ipt
  GROUP BY [Sales Part No]) aa;

SELECT 'INSERT INTO MTK_SALESPART_CF_TAB (CATALOG_NO,CONTRACT,CF$_AIM_TARIFF_CODE,CF$_AIM_UNIDAD_ADUANA,CF$_AIM_PRODSERVKEY,CF$_AIM_UOM_CONV,CF$_AIM_DESCR_ADUANA) VALUES (''' 
+ LTRIM(RTRIM(CATALOG_NO)) 
+ ''',''' + LTRIM(RTRIM(CONTRACT)) 
+ ''',''' + ISNULL(AIM_TARIFF_CODE, '') 
+ ''',''' + ISNULL(AIM_UNIDAD_ADUANA, '') 
+ ''',''' + ISNULL(AIM_PRODSERVKEY, '') 
+ ''',''' + ISNULL(AIM_UOM_CONV, '') 
+ ''',''' + ISNULL(AIM_DESCR_ADUANA, '') 
+  ''');' aaa  
FROM ( SELECT  
       [Catalog_No]			CATALOG_NO  
	  ,[Contract]			CONTRACT
      ,[HS_TARIF_CODE]		AIM_TARIFF_CODE
      ,[UoM Aduana]			AIM_UNIDAD_ADUANA
      ,[Clav SAT]			AIM_PRODSERVKEY 
	  ,[UoM Conversion]	    AIM_UOM_CONV
	  ,[Description Aduana]	AIM_DESCR_ADUANA
  FROM [dbo].[SalesPartMEX1$] ipt
  WHERE [Contract] = '20MEX') aa;
  
SELECT 'INSERT INTO MTK_SALESPART_CF_TAB (CATALOG_NO,CONTRACT,CF$_AIM_TARIFF_CODE,CF$_AIM_UNIDAD_ADUANA,CF$_AIM_PRODSERVKEY,CF$_AIM_UOM_CONV,CF$_AIM_DESCR_ADUANA) VALUES (''' 
+ LTRIM(RTRIM(CATALOG_NO)) 
+ ''',''' + LTRIM(RTRIM(CONTRACT)) 
+ ''',''' + ISNULL(AIM_TARIFF_CODE, '') 
+ ''',''' + ISNULL(AIM_UNIDAD_ADUANA, '') 
+ ''',''' + ISNULL(AIM_PRODSERVKEY, '') 
+ ''',''' + ISNULL(AIM_UOM_CONV, '') 
+ ''',''' + ISNULL(AIM_DESCR_ADUANA, '') 
+  ''');' aaa  
FROM ( SELECT  
       [Sales Part No]			CATALOG_NO  
	  ,'20MEX'			CONTRACT
      ,[HS Tariff Code]		AIM_TARIFF_CODE
      ,[UoM Aduana]			AIM_UNIDAD_ADUANA
      ,[Clave SAT]			AIM_PRODSERVKEY 
	  ,[UoM Convertion]	    AIM_UOM_CONV
	  ,[Descripcion Aduana]	AIM_DESCR_ADUANA
  FROM [dbo].[SalesPartMEXoat$] ipt) aa;  


SELECT 'INSERT INTO MTK_SALESPART_CF_TAB (CATALOG_NO,CONTRACT,CF$_AIM_TARIFF_CODE,CF$_AIM_UNIDAD_ADUANA,CF$_AIM_PRODSERVKEY) VALUES (''' 
+ LTRIM(RTRIM(CATALOG_NO)) 
+ ''',''' + LTRIM(RTRIM(CONTRACT)) 
+ ''',''' + ISNULL(AIM_TARIFF_CODE, '') 
+ ''',''' + ISNULL(AIM_UNIDAD_ADUANA, '') 
+ ''',''' + ISNULL(AIM_PRODSERVKEY, '') 
+  ''');' aaa  
FROM ( SELECT  
       [Catalog_No]		CATALOG_NO  
	  ,[Contract]				CONTRACT
      ,[Cf$_Aim_Tariff_Code]	    AIM_TARIFF_CODE
      ,[uom]				AIM_UNIDAD_ADUANA
      ,[Cf$_Aim_Prodservkey_Db]	    AIM_PRODSERVKEY
  FROM [dbo].[SalesPartMasterMX$] ipt) aa;

SELECT 'INSERT INTO MTK_SALESPART_CF_TAB (CATALOG_NO,CONTRACT,CF$_AIM_UOM_CONV) VALUES (''' 
+ LTRIM(RTRIM(CATALOG_NO)) 
+ ''',''' + LTRIM(RTRIM(CONTRACT)) 
+ ''',''' + ISNULL(CF$_AIM_UOM_CONV, '') 
+  ''');' aaa  
FROM ( SELECT  
       [Catalog_No]		CATALOG_NO  
	  ,[Contract]				CONTRACT
      ,[Cf$_Aim_Tariff_Code]	    CF$_AIM_UOM_CONV
  FROM [dbo].[SalesPartMasterMX$] ipt) aa;


-------------------------------------------------
SELECT 'INSERT INTO MTK_SALESPART_CF_TAB (CATALOG_NO,CONTRACT,CF$_AIM_DESCR_ADUANA,CF$_AIM_DISPLAY_CONVFACT,CF$_AIM_DISPLAY_UOM,CF$_AIM_EXCLUDE_SALES_REP,CF$_AIM_PRODSERVKEY,CF$_AIM_STANDARD_COST,CF$_AIM_TARIFF_CODE,CF$_AIM_UNIDAD_ADUANA,CF$_AIM_UOM_CONV) VALUES (''' 
|| CATALOG_NO
|| ''',''' || CONTRACT 
|| ''',''' || NVL(CF$_AIM_DESCR_ADUANA_DB, '') 
|| ''',''' || NVL(CF$_AIM_DISPLAY_CONVFACT, '') 
|| ''',''' || NVL(CF$_AIM_DISPLAY_UOM, '') 
|| ''',''' || NVL(CF$_AIM_EXCLUDE_SALES_REP_DB, '') 
|| ''',''' || NVL(CF$_AIM_PRODSERVKEY_DB, '') 
|| ''',''' || NVL(CF$_AIM_STANDARD_COST, '') 
|| ''',''' || NVL(CF$_AIM_TARIFF_CODE_DB, '') 
|| ''',''' || NVL(CF$_AIM_UNIDAD_ADUANA, '') 
|| ''',''' || NVL(CF$_AIM_UOM_CONV, '') 
||  ''');' aaa  
FROM (SELECT
   CONTRACT
   ,CATALOG_NO
   ,CF$_AIM_DESCR_ADUANA_DB
   ,CF$_AIM_DISPLAY_CONVFACT
   ,CF$_AIM_DISPLAY_UOM
   ,CF$_AIM_EXCLUDE_SALES_REP_DB
   ,CF$_AIM_PRODSERVKEY_DB
   ,CF$_AIM_STANDARD_COST
   ,CF$_AIM_TARIFF_CODE_DB
   ,CF$_AIM_UNIDAD_ADUANA
   ,CF$_AIM_UOM_CONV
FROM SALES_PART_CFV
WHERE CONTRACT ('32IND', '30HK')) aa;
  
----Update SalesPart CustomFields
DECLARE   
   CURSOR get_qaman IS
      SELECT
			qcp.objid
			,CF$_AIM_DESCR_ADUANA
		   ,CF$_AIM_DISPLAY_CONVFACT
		   ,CF$_AIM_DISPLAY_UOM
		   ,CF$_AIM_EXCLUDE_SALES_REP
		   ,CF$_AIM_PRODSERVKEY
		   ,CF$_AIM_STANDARD_COST
		   ,CF$_AIM_TARIFF_CODE
		   ,CF$_AIM_UNIDAD_ADUANA
		   ,CF$_AIM_UOM_CONV		 
      FROM MTK_SALESPART_CF_TAB qcpa
      INNER JOIN SALES_PART qcp ON qcp.CATALOG_NO = qcpa.CATALOG_NO AND qcp.CONTRACT = qcpa.CONTRACT;
   
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
      
	  Client_SYS.Add_To_Attr('CF$_AIM_DESCR_ADUANA_DB', row_.CF$_AIM_DESCR_ADUANA, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIM_DISPLAY_CONVFACT', row_.CF$_AIM_DISPLAY_CONVFACT, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIM_DISPLAY_UOM', row_.CF$_AIM_DISPLAY_UOM, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIM_EXCLUDE_SALES_REP_DB', row_.CF$_AIM_EXCLUDE_SALES_REP, attr_cf_);  
      Client_SYS.Add_To_Attr('CF$_AIM_PRODSERVKEY_DB', row_.CF$_AIM_PRODSERVKEY, attr_cf_);  
      Client_SYS.Add_To_Attr('CF$_AIM_STANDARD_COST', row_.CF$_AIM_STANDARD_COST, attr_cf_);  
      Client_SYS.Add_To_Attr('CF$_AIM_TARIFF_CODE', row_.CF$_AIM_TARIFF_CODE, attr_cf_);  
      Client_SYS.Add_To_Attr('CF$_AIM_UNIDAD_ADUANA', row_.CF$_AIM_UNIDAD_ADUANA, attr_cf_);  
      Client_SYS.Add_To_Attr('CF$_AIM_UOM_CONV', row_.CF$_AIM_UOM_CONV, attr_cf_);  
      
      SALES_PART_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');
   END LOOP;   
END;



DECLARE   
   CURSOR get_qaman IS
      SELECT
         qcp.objid
         ,qcpa.CATALOG_NO
         ,HsTariffCode.db_value CF$_AIM_TARIFF_CODE
         ,CF$_AIM_UNIDAD_ADUANA
         ,ClaveProdServ.db_value CF$_AIM_PRODSERVKEY
         ,CF$_AIM_UOM_CONV
         ,dat.db_value CF$_AIM_DESCR_ADUANA		 
      FROM MTK_SALESPART_CF_TAB qcpa
      INNER JOIN SALES_PART qcp ON qcp.CATALOG_NO = qcpa.CATALOG_NO AND qcp.CONTRACT = qcpa.CONTRACT
      LEFT JOIN CUSTOM_FIELD_ENUM_VALUES dat ON dat.lu = 'DescrAduana' AND dat.client_value = CF$_AIM_DESCR_ADUANA
      LEFT JOIN CUSTOM_FIELD_ENUM_VALUES HsTariffCode ON HsTariffCode.lu = 'HsTariffCode' AND HsTariffCode.db_value = CF$_AIM_TARIFF_CODE
      LEFT JOIN CUSTOM_FIELD_ENUM_VALUES ClaveProdServ ON ClaveProdServ.lu = 'ClaveProdServ' AND ClaveProdServ.db_value = CF$_AIM_PRODSERVKEY
      WHERE qcpa.CONTRACT = '20MEX';
   
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
      
      Client_SYS.Add_To_Attr('CF$_AIM_PRODSERVKEY_DB', row_.CF$_AIM_PRODSERVKEY, attr_cf_);        
      Client_SYS.Add_To_Attr('CF$_AIM_UNIDAD_ADUANA', row_.CF$_AIM_UNIDAD_ADUANA, attr_cf_);  
      Client_SYS.Add_To_Attr('CF$_AIM_PRODSERVKEY_DB', row_.CF$_AIM_PRODSERVKEY, attr_cf_);  
      Client_SYS.Add_To_Attr('CF$_AIM_UOM_CONV', row_.CF$_AIM_UOM_CONV, attr_cf_);  
      Client_SYS.Add_To_Attr('CF$_AIM_DESCR_ADUANA_DB', row_.CF$_AIM_DESCR_ADUANA, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIM_TARIFF_CODE_DB', row_.CF$_AIM_TARIFF_CODE, attr_cf_);
      
      SALES_PART_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');
   END LOOP;   
END;


DECLARE   
   CURSOR get_qaman IS
      SELECT
         qcp.objid,
         qcpa.CATALOG_NO,
         qcp.CONTRACT,
         qcpa.CF$_AIM_TARIFF_CODE CF$_AIM_HS_TARIFF_CODE
      FROM MTK_SALESPART_CF_TAB qcpa
      INNER JOIN SALES_PART qcp ON qcp.PART_NO = qcpa.CATALOG_NO AND qcp.CONTRACT = qcpa.CONTRACT;
   
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
      
      Client_SYS.Add_To_Attr('CF$_AIM_HS_TARIFF_CODE', row_.CF$_AIM_HS_TARIFF_CODE, attr_cf_);
      
      SALES_PART_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');
   END LOOP;   
END;

