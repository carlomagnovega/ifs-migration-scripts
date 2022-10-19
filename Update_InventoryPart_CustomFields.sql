----Update Inventory_Part CustomFields
DROP TABLE MTK_INVENTORY_PART_CF_TAB;

CREATE TABLE MTK_INVENTORY_PART_CF_TAB
(
   PART_NO                            VARCHAR2(25)        NOT NULL,
   CONTRACT                           VARCHAR2(5)         NOT NULL,   
   CF$_AIM_BASEHUOM                   VARCHAR2(100)       NULL,
   CF$_AIM_COEF_METAL                 NUMBER              NULL,
   CF$_AIM_COEF_MFG                   NUMBER              NULL,
   CF$_AIM_FORMAT                     VARCHAR2(20)        NULL,
   CF$_AIM_ALLOYSPEC                  VARCHAR2(100)       NULL,
   CF$_MARKET                         VARCHAR2(100)       NULL,
   CF$_MICRON                         VARCHAR2(100)       NULL,
   CF$_DIAMETER                       VARCHAR2(50)        NULL,
   CF$_FG_FORMAT                      VARCHAR2(100)       NULL,
   CF$_FLUX_TYPE                      VARCHAR2(100)       NULL,
   CF$_LABEL_BOXES_LAYOUT             VARCHAR2(50)        NULL,
   CF$_LABEL_LAYOUT                   VARCHAR2(50)        NULL,
   CF$_LABEL_UM                       VARCHAR2(100)       NULL,
   CF$_AIM_LEADTYPE                   VARCHAR2(20)        NULL,
   CF$_PER_FLUX                       VARCHAR2(100)       NULL,
   CF$_PER_METAL                      VARCHAR2(100)       NULL,
   CF$_PROD_ALLOY1                    VARCHAR2(100)       NULL,
   CF$_PROD_ALLOY2                    VARCHAR2(100)       NULL,
   CF$_PROD_ALLOY3                    VARCHAR2(100)       NULL,
   CF$_QTY_PER_BOX                    VARCHAR2(100)       NULL,
   CF$_UNIT_WEIGHT                    VARCHAR2(100)       NULL,
   CF$_UPC                            VARCHAR2(100)       NULL
);
-----
DROP TABLE MTK_INVENTORY_PART_CF_TAB;
TRUNCATE TABLE MTK_INVENTORY_PART_CF_TAB; 
CREATE TABLE MTK_INVENTORY_PART_CF_TAB
(
   PART_NO                            VARCHAR2(25)        NOT NULL,
   CONTRACT                           VARCHAR2(5)         NOT NULL,   
   CF$_AIM_ALLOYSPEC                      VARCHAR2(50)        NULL,
   CF$_AIM_BASEHUOM                   VARCHAR2(50)        NULL,
   CF$_AIM_CLASSIFIC                  VARCHAR2(4000)      NULL,
   CF$_AIM_COEF_METAL                 NUMBER              NULL,
   CF$_AIM_COEF_MFG                   NUMBER              NULL,
   CF$_AIM_CONSIGNM_PART              VARCHAR2(50)        NULL,
   CF$_AIM_EXCLUDE_RECLAIM            VARCHAR2(20)        NULL,
   CF$_AIM_FORCE_HEATNO_GEN           VARCHAR2(20)        NULL,
   CF$_AIM_FORMAT                     VARCHAR2(20)        NULL,
   CF$_AIM_LABELTEMPLATE              VARCHAR2(20)        NULL,
   CF$_AIM_LABEL_ID                   VARCHAR2(100)       NULL,
   CF$_AIM_LEADTYPE                       VARCHAR2(50)        NULL,
   CF$_AIM_PRICESOURCE                VARCHAR2(20)        NULL,
   CF$_AIM_PRODUCTION_ALLOY           VARCHAR2(100)       NULL,
   CF$_AIM_RECEIVE_ENVELOPE           VARCHAR2(50)        NULL,
   CF$_AIM_RECL_BLOCK                 VARCHAR2(20)        NULL,
   CF$_AIM_STD_OPERATION              VARCHAR2(100)       NULL,
   CF$_AIM_UPDATE_PURCH_PART          VARCHAR2(20)        NULL,   
   CF$_DIAMETER                       VARCHAR2(50)        NULL,
   CF$_FG_FORMAT                      VARCHAR2(100)       NULL,
   CF$_FLUX_TYPE                      VARCHAR2(100)       NULL,
   CF$_LABEL_BOXES_LAYOUT             VARCHAR2(50)        NULL,
   CF$_LABEL_DATE_FORMAT              VARCHAR2(20)        NULL,
   CF$_LABEL_LAYOUT                   VARCHAR2(50)        NULL,
   CF$_LABEL_UM                       VARCHAR2(100)       NULL,
   CF$_MARKET                         VARCHAR2(50)        NULL,
   CF$_MICRON                         VARCHAR2(100)       NULL,
   CF$_PER_FLUX                       VARCHAR2(100)       NULL,
   CF$_PER_METAL                      VARCHAR2(100)       NULL,
   CF$_PROD_ALLOY1                    VARCHAR2(100)       NULL,
   CF$_PROD_ALLOY2                    VARCHAR2(100)       NULL,
   CF$_PROD_ALLOY3                    VARCHAR2(100)       NULL,   
   CF$_SHORT_PART_NO                  VARCHAR2(100)       NULL,
   CF$_UNIT_WEIGHT                    VARCHAR2(100)       NULL,   
   CF$_UPC                            VARCHAR2(100)       NULL,
   CF$_QTY_PER_BOX                    VARCHAR2(100)       NULL
   );
---------------------------------------------
SELECT 'INSERT INTO MTK_INVENTORY_PART_CF_TAB (PART_NO,CONTRACT,CF$_AIM_ALLOYSPEC,CF$_AIM_BASEHUOM,CF$_AIM_CLASSIFIC,CF$_AIM_COEF_METAL,CF$_AIM_COEF_MFG,CF$_AIM_CONSIGNM_PART,CF$_AIM_EXCLUDE_RECLAIM,CF$_AIM_FORCE_HEATNO_GEN,CF$_AIM_FORMAT,CF$_AIM_LABELTEMPLATE,CF$_AIM_LABEL_ID,CF$_AIM_LEADTYPE,CF$_AIM_PRICESOURCE,CF$_AIM_PRODUCTION_ALLOY,CF$_AIM_RECEIVE_ENVELOPE,CF$_AIM_RECL_BLOCK,CF$_AIM_STD_OPERATION,CF$_AIM_UPDATE_PURCH_PART,CF$_DIAMETER,CF$_FG_FORMAT,CF$_FLUX_TYPE,CF$_LABEL_BOXES_LAYOUT,CF$_LABEL_DATE_FORMAT,CF$_LABEL_LAYOUT,CF$_LABEL_UM,CF$_MARKET,CF$_MICRON,CF$_PER_FLUX,CF$_PER_METAL,CF$_PROD_ALLOY1,CF$_PROD_ALLOY2,CF$_PROD_ALLOY3,CF$_SHORT_PART_NO,CF$_UNIT_WEIGHT,CF$_UPC) VALUES (''' 
+ LTRIM(RTRIM(PART_NO)) 
+ ''',''' + LTRIM(RTRIM(CONTRACT)) 
+ ''',''' + ISNULL([CF$_AIM_ALLOYSPEC], '') 
+ ''',''' + ISNULL([CF$_AIM_BASEHUOM], '') 
+ ''',''' + ISNULL([CF$_AIM_CLASSIFIC], '') 
+ ''',''' + ISNULL([CF$_AIM_COEF_METAL], '') 
+ ''',''' + ISNULL([CF$_AIM_COEF_MFG], '') 
+ ''',''' + ISNULL([CF$_AIM_CONSIGNM_PART], '') 
+ ''',''' + ISNULL([CF$_AIM_EXCLUDE_RECLAIM], '') 
+ ''',''' + ISNULL([CF$_AIM_FORCE_HEATNO_GEN], '') 
+ ''',''' + ISNULL([CF$_AIM_FORMAT], '') 
+ ''',''' + ISNULL([CF$_AIM_LABELTEMPLATE], '') 
+ ''',''' + ISNULL([CF$_AIM_LABEL_ID], '') 
+ ''',''' + ISNULL([CF$_AIM_LEADTYPE], '') 
+ ''',''' + ISNULL([CF$_AIM_PRICESOURCE], '') 
+ ''',''' + ISNULL([CF$_AIM_PRODUCTION_ALLOY], '') 
+ ''',''' + ISNULL([CF$_AIM_RECEIVE_ENVELOPE], '') 
+ ''',''' + ISNULL([CF$_AIM_RECL_BLOCK], '') 
+ ''',''' + ISNULL([CF$_AIM_STD_OPERATION], '') 
+ ''',''' + ISNULL([CF$_AIM_UPDATE_PURCH_PART], '') 
+ ''',''' + ISNULL([CF$_DIAMETER], '') 
+ ''',''' + ISNULL([CF$_FG_FORMAT], '') 
+ ''',''' + ISNULL([CF$_FLUX_TYPE], '') 
+ ''',''' + ISNULL([CF$_LABEL_BOXES_LAYOUT], '') 
+ ''',''' + ISNULL([CF$_LABEL_DATE_FORMAT], '') 
+ ''',''' + ISNULL([CF$_LABEL_LAYOUT], '') 
+ ''',''' + ISNULL([CF$_LABEL_UM], '') 
+ ''',''' + ISNULL([CF$_MARKET], '') 
+ ''',''' + ISNULL([CF$_MICRON], '') 
+ ''',''' + ISNULL([CF$_PER_FLUX], '') 
+ ''',''' + ISNULL([CF$_PER_METAL], '') 
+ ''',''' + ISNULL([CF$_PROD_ALLOY1], '') 
+ ''',''' + ISNULL([CF$_PROD_ALLOY2], '') 
+ ''',''' + ISNULL([CF$_PROD_ALLOY3], '') 
+ ''',''' + ISNULL([CF$_SHORT_PART_NO], '') 
+ ''',''' + ISNULL([CF$_UNIT_WEIGHT], '') 
+ ''',''' + ISNULL([CF$_UPC], '') 
+  ''');' aaa  
FROM ( SELECT  [Part_No]		PART_NO  
	  ,[CONTRACT]				CONTRACT
      ,[ALLOYSPEC] [CF$_AIM_ALLOYSPEC]
      ,[AIM_BASEHUOM] [CF$_AIM_BASEHUOM]
      ,'' [CF$_AIM_CLASSIFIC]
      ,CAST([AIM_COEF_METAL] AS VARCHAR) [CF$_AIM_COEF_METAL]
      ,CAST([AIM_COEF_MFG] AS VARCHAR) [CF$_AIM_COEF_MFG]
      ,'' [CF$_AIM_CONSIGNM_PART]
      ,'' [CF$_AIM_EXCLUDE_RECLAIM]
      ,'' [CF$_AIM_FORCE_HEATNO_GEN]
      ,[AIM_FORMAT] [CF$_AIM_FORMAT]
      ,'' [CF$_AIM_LABELTEMPLATE]
      ,[AIM_LABEL_ID] [CF$_AIM_LABEL_ID]
      ,[LEADTYPE] [CF$_AIM_LEADTYPE]
      ,'' [CF$_AIM_PRICESOURCE]
      ,[AIM_PRODUCTION_ALLOY] [CF$_AIM_PRODUCTION_ALLOY]
      ,'' [CF$_AIM_RECEIVE_ENVELOPE]
      ,'' [CF$_AIM_RECL_BLOCK]
      ,'' [CF$_AIM_STD_OPERATION]
      ,'' [CF$_AIM_UPDATE_PURCH_PART]
      ,[DIAMETER] [CF$_DIAMETER]
      ,[FG_FORMAT] [CF$_FG_FORMAT]
      ,[FLUX_TYPE] [CF$_FLUX_TYPE]
      ,[LABEL_BOXES_LAYOUT] [CF$_LABEL_BOXES_LAYOUT]
      ,[LABEL_DATE_FORMAT] [CF$_LABEL_DATE_FORMAT]
      ,[LABEL_LAYOUT] [CF$_LABEL_LAYOUT]
      ,[LABEL_UM] [CF$_LABEL_UM]
      ,[MARKET] [CF$_MARKET]
      ,CAST([MICRON] AS VARCHAR) [CF$_MICRON]
      ,[PER_FLUX] [CF$_PER_FLUX]
      ,[PER_METAL] [CF$_PER_METAL]
      ,[PROD_ALLOY1] [CF$_PROD_ALLOY1]
      ,[PROD_ALLOY2] [CF$_PROD_ALLOY2]
      ,[PROD_ALLOY3] [CF$_PROD_ALLOY3]
      ,[SHORT_PART_NO] [CF$_SHORT_PART_NO]
      ,[UNIT_WEIGHT] [CF$_UNIT_WEIGHT]
      ,CAST([UPC] AS VARCHAR)  [CF$_UPC]
  FROM [dbo].[InventoryPartMEX1$] ipt WHERE [Part_No] IS NOT NULL) aa; 
---------------------------------------------
SELECT 'INSERT INTO MTK_INVENTORY_PART_CF_TAB (PART_NO,CONTRACT,CF$_AIM_BASEHUOM,CF$_AIM_COEF_METAL,CF$_AIM_COEF_MFG,CF$_AIM_FORMAT,CF$_AIM_ALLOYSPEC,CF$_MARKET,CF$_MICRON,CF$_DIAMETER,CF$_FG_FORMAT,CF$_FLUX_TYPE,CF$_LABEL_BOXES_LAYOUT,CF$_LABEL_LAYOUT,CF$_LABEL_UM,CF$_AIM_LEADTYPE,CF$_PER_METAL,CF$_PROD_ALLOY1,CF$_PROD_ALLOY2,CF$_PROD_ALLOY3,CF$_QTY_PER_BOX,CF$_UNIT_WEIGHT,CF$_UPC) VALUES (''' 
                 || PART_NO
      || ''',''' || CONTRACT
      || ''',''' || CF$_AIM_BASEHUOM
      || ''',''' || CF$_AIM_COEF_METAL
      || ''',''' || CF$_AIM_COEF_MFG
      || ''',''' || CF$_AIM_FORMAT
      || ''',''' || CF$_AIM_ALLOYSPEC
      || ''',''' || CF$_MARKET
      || ''',''' || CF$_MICRON
      || ''',''' || CF$_DIAMETER
      || ''',''' || CF$_FG_FORMAT
      || ''',''' || CF$_FLUX_TYPE
      || ''',''' || CF$_LABEL_BOXES_LAYOUT
      || ''',''' || CF$_LABEL_LAYOUT
      || ''',''' || CF$_LABEL_UM
      || ''',''' || CF$_AIM_LEADTYPE
      || ''',''' || CF$_PER_METAL
      || ''',''' || CF$_PROD_ALLOY1
      || ''',''' || CF$_PROD_ALLOY2
      || ''',''' || CF$_PROD_ALLOY3
      || ''',''' || CF$_QTY_PER_BOX
      || ''',''' || CF$_UNIT_WEIGHT
      || ''',''' || CF$_UPC
		||  ''');'   aa
FROM (
SELECT qcpa.PART_NO,
         qcpa.CONTRACT,
         qcpa.CF$_AIM_BASEHUOM,
         qcpa.CF$_AIM_COEF_METAL,
         qcpa.CF$_AIM_COEF_MFG,
         CASE WHEN qcpa.CF$_AIM_FORMAT = 'PIECE' THEN '1' ELSE '2' END CF$_AIM_FORMAT,
         qcpa.CF$_AIM_ALLOYSPEC,
         qcpa.CF$_MARKET,
         qcpa.CF$_MICRON,
         REPLACE(REPLACE(qcpa.CF$_DIAMETER,'''','-'),'"','') CF$_DIAMETER,
         qcpa.CF$_FG_FORMAT,
         qcpa.CF$_FLUX_TYPE,
         qcpa.CF$_LABEL_BOXES_LAYOUT,
         qcpa.CF$_LABEL_LAYOUT,
         qcpa.CF$_LABEL_UM,
         qcpa.CF$_AIM_LEADTYPE,
         --qcpa.CF$_PER_FLUX,
         qcpa.CF$_PER_METAL,
         qcpa.CF$_PROD_ALLOY1,
         qcpa.CF$_PROD_ALLOY2,
         qcpa.CF$_PROD_ALLOY3,
         qcpa.CF$_QTY_PER_BOX,
         qcpa.CF$_UNIT_WEIGHT,
         qcpa.CF$_UPC
    FROM INVENTORY_PART_CFV qcpa
   WHERE qcpa.CONTRACT IN ('32IND', '30HK'))  aaa
   WHERE qcpa.CONTRACT IN ('32IND', '30HK'))  aaa

-------------------------------------------------------
DECLARE   
   CURSOR get_qaman IS
      SELECT
				 qcp.objid,
				 qcp.PART_NO,
				 qcp.CONTRACT,
				 ium.objkey CF$_AIM_BASEHUOM,
				 qcpa.CF$_AIM_COEF_METAL,
				 qcpa.CF$_AIM_COEF_MFG,
				 qcpa.CF$_AIM_FORMAT,
				 a.objkey CF$_AIM_ALLOYSPEC,
				 smt.objkey CF$_MARKET,
				 qcpa.CF$_MICRON,
				 qcpa.CF$_DIAMETER,
				 qcpa.CF$_FG_FORMAT,
				 qcpa.CF$_FLUX_TYPE,
				 qcpa.CF$_LABEL_BOXES_LAYOUT,
				 qcpa.CF$_LABEL_LAYOUT,
				 qcpa.CF$_LABEL_UM,
				 qcpa.CF$_AIM_LEADTYPE,
				 qcpa.CF$_PER_FLUX,
				 qcpa.CF$_PER_METAL,
				 qcpa.CF$_PROD_ALLOY1,
				 qcpa.CF$_PROD_ALLOY2,
				 qcpa.CF$_PROD_ALLOY3,
				 qcpa.CF$_QTY_PER_BOX,
				 qcpa.CF$_UNIT_WEIGHT,
				 qcpa.CF$_UPC
		FROM Inventory_Part qcp
		INNER JOIN MTK_INVENTORY_PART_CF_TAB qcpa ON qcp.PART_NO = qcpa.PART_NO AND qcp.CONTRACT = qcpa.CONTRACT
		LEFT JOIN CONTROL_PLAN_TEMPL_HEADER_CLV a ON a.CF$_SPEC_ID = qcpa.CF$_AIM_ALLOYSPEC
		LEFT JOIN INPUT_UNIT_MEAS_GROUP ium ON ium.input_unit_meas_group_id = UPPER(qcpa.CF$_AIM_BASEHUOM)
		LEFT JOIN SALES_MARKET smt ON MARKET_CODE = qcpa.CF$_MARKET;
   
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
      Client_SYS.Add_To_Attr('CF$_AIM_BASEHUOM', row_.CF$_AIM_BASEHUOM, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIM_COEF_METAL', row_.CF$_AIM_COEF_METAL, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIM_COEF_MFG', row_.CF$_AIM_COEF_MFG, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIM_FORMAT_DB', row_.CF$_AIM_FORMAT, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIM_ALLOYSPEC', row_.CF$_AIM_ALLOYSPEC, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_MARKET', row_.CF$_MARKET, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_MICRON', row_.CF$_MICRON, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_DIAMETER', row_.CF$_DIAMETER, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_FG_FORMAT', row_.CF$_FG_FORMAT, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_FLUX_TYPE', row_.CF$_FLUX_TYPE, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_LABEL_BOXES_LAYOUT', row_.CF$_LABEL_BOXES_LAYOUT, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_LABEL_LAYOUT', row_.CF$_LABEL_LAYOUT, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_LABEL_UM', row_.CF$_LABEL_UM, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIM_LEADTYPE', row_.CF$_AIM_LEADTYPE, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_PER_FLUX', row_.CF$_PER_FLUX, attr_cf_);
	   Client_SYS.Add_To_Attr('CF$_PER_METAL', row_.CF$_PER_METAL, attr_cf_);      
      Client_SYS.Add_To_Attr('CF$_PROD_ALLOY1', row_.CF$_PROD_ALLOY1, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_PROD_ALLOY2', row_.CF$_PROD_ALLOY2, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_PROD_ALLOY3', row_.CF$_PROD_ALLOY3, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_QTY_PER_BOX', row_.CF$_QTY_PER_BOX, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_UNIT_WEIGHT', row_.CF$_UNIT_WEIGHT, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_UPC', row_.CF$_UPC, attr_cf_);
 
      INVENTORY_PART_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');
      COMMIT;
   END LOOP;
   
END;
