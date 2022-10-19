DROP TABLE MTK_EQUIPMENT_SERIAL_CF_TAB;

CREATE TABLE MTK_EQUIPMENT_SERIAL_CF_TAB
(
   PART_NO                           VARCHAR2(100)        NOT NULL,
   MCH_CODE                           VARCHAR2(100)        NOT NULL,
   CONTRACT                           VARCHAR2(5)         NOT NULL,   
   CF$_AIM_ALT_DESCRIPTION            VARCHAR2(100)       NULL,
   CF$_AIM_EQUIP_SERIAL               VARCHAR2(100)       NULL,
   CF$_AIM_IMPORT_INVOICE             VARCHAR2(100)       NULL,
   CF$_AIM_OLD_ASSET                  VARCHAR2(100)       NULL,
   CF$_AIM_MAXIMO_ID                  VARCHAR2(100)       NULL
);

SELECT 'INSERT INTO MTK_EQUIPMENT_SERIAL_CF_TAB (PART_NO,MCH_CODE,CONTRACT,CF$_AIM_ALT_DESCRIPTION,CF$_AIM_EQUIP_SERIAL,CF$_AIM_OLD_ASSET,CF$_AIM_MAXIMO_ID) VALUES (''' 
+ LTRIM(RTRIM(PART_NO)) 
+ ''',''' + LTRIM(RTRIM(MCH_CODE)) 
+ ''',''' + LTRIM(RTRIM(CONTRACT)) 
+ ''',''' + ISNULL(AIM_ALT_DESCRIPTION, '') 
+ ''',''' + ISNULL(AIM_EQUIP_SERIAL, '') 
+ ''',''' + ISNULL(AIM_OLD_ASSET, '') 
+ ''',''' + ISNULL(AIM_MAXIMO_ID, '') 
+  ''');' aaa  
FROM ( SELECT  [PART_NO]			PART_NO  
	  ,[MCH_CODE]					MCH_CODE
	  ,[CONTRACT]					CONTRACT
      ,replace(replace([ALT_DESCRIPTION], '"', '-'), '''', '-') 		AIM_ALT_DESCRIPTION
      ,[EQUIPMENT SERIAL MFG]    	AIM_EQUIP_SERIAL
      ,[OLD_ASSET]				    AIM_OLD_ASSET
      ,CAST([Maximo_ID] AS VARCHAR)				    AIM_MAXIMO_ID
  FROM [dbo].[EquipmentObject$] ipt) aa;

SELECT 'INSERT INTO MTK_EQUIPMENT_SERIAL_CF_TAB (PART_NO,MCH_CODE,CONTRACT,CF$_AIM_ALT_DESCRIPTION,CF$_AIM_IMPORT_INVOICE,CF$_AIM_MAXIMO_ID) VALUES (''' 
+ LTRIM(RTRIM(PART_NO)) 
+ ''',''' + LTRIM(RTRIM(MCH_CODE)) 
+ ''',''' + LTRIM(RTRIM(CONTRACT)) 
+ ''',''' + ISNULL(AIM_ALT_DESCRIPTION, '') 
+ ''',''' + ISNULL(AIM_IMPORT_INVOICE, '') 
+ ''',''' + ISNULL(AIM_MAXIMO_ID, '') 
+  ''');' aaa  
FROM ( SELECT  [PART_NO]			PART_NO  
	  ,[MCH_CODE]					MCH_CODE
	  ,[CONTRACT]					CONTRACT
      ,replace(replace([ALT_DESCRIPTION], '"', '-'), '''', '-') 		AIM_ALT_DESCRIPTION
      ,[PEDIMENTO DE IMPORTACION]				    AIM_IMPORT_INVOICE
      ,CAST([CF-AMPID] AS VARCHAR)				    AIM_MAXIMO_ID
  FROM [dbo].[EquipmentObjectMX$] ipt) aa;

  
----Update Serial Object CustomFields
DECLARE   
   CURSOR get_qaman IS
      SELECT
         qcp.MCH_CODE,
         qcpa.PART_NO,
            qcp.objid,
            qcpa.CF$_AIM_ALT_DESCRIPTION,   
            qcpa.CF$_AIM_EQUIP_SERIAL,
			qcpa.CF$_AIM_IMPORT_INVOICE,
            qcpa.CF$_AIM_OLD_ASSET,
            qcpa.CF$_AIM_MAXIMO_ID            
      FROM MTK_EQUIPMENT_SERIAL_CF_TAB qcpa
      INNER JOIN EQUIPMENT_SERIAL_CFV qcp ON qcp.PART_NO = qcpa.PART_NO AND qcp.MCH_CODE = qcpa.MCH_CODE AND qcp.CONTRACT = qcpa.CONTRACT;
   
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
      --Client_SYS.Add_To_Attr('CF$_AIM_EQUIP_SERIAL', row_.CF$_AIM_EQUIP_SERIAL, attr_cf_);
      --Client_SYS.Add_To_Attr('CF$_AIM_OLD_ASSET', row_.CF$_AIM_OLD_ASSET, attr_cf_);
	  
      Client_SYS.Add_To_Attr('CF$_AIM_IMPORT_INVOICE', row_.CF$_AIM_IMPORT_INVOICE, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIM_ALT_DESCRIPTION', row_.CF$_AIM_ALT_DESCRIPTION, attr_cf_);
	  Client_SYS.Add_To_Attr('CF$_AIM_MAXIMO_ID', row_.CF$_AIM_MAXIMO_ID, attr_cf_);

      EQUIPMENT_SERIAL_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');
   END LOOP;
   
END;