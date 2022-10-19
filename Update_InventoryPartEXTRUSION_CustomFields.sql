DROP TABLE MTK_INVENTORY_PART_CF_TAB;

CREATE TABLE MTK_INVENTORY_PART_CF_TAB
(
   PART_NO                            VARCHAR2(25)        NOT NULL,
   CONTRACT                           VARCHAR2(5)         NOT NULL,   
   CF$_SHORT_PART_NO                  VARCHAR2(100)       NULL,   
   CF$_DIAMETER                       VARCHAR2(50)        NULL,
   CF$_FG_FORMAT                      VARCHAR2(100)       NULL,
   CF$_FLUX_TYPE                      VARCHAR2(100)       NULL,
   CF$_LABEL_BOXES_LAYOUT             VARCHAR2(50)        NULL,
   CF$_LABEL_LAYOUT                   VARCHAR2(50)        NULL,
   CF$_LABEL_UM                       VARCHAR2(100)       NULL,
   CF$_LEADTYPE                       VARCHAR2(50)        NULL,
   CF$_MICRON                         VARCHAR2(100)       NULL,
   CF$_PER_FLUX                       VARCHAR2(100)       NULL,
   CF$_PER_METAL                      VARCHAR2(100)       NULL,
   CF$_PROD_ALLOY1                    VARCHAR2(100)       NULL,
   CF$_PROD_ALLOY2                    VARCHAR2(100)       NULL,
   CF$_PROD_ALLOY3                    VARCHAR2(100)       NULL,
   CF$_UNIT_WEIGHT                    VARCHAR2(100)       NULL,
   CF$_UPC                            VARCHAR2(100)       NULL
);

SELECT 'INSERT INTO MTK_INVENTORY_PART_CF_TAB (PART_NO,CONTRACT,CF$_SHORT_PART_NO,CF$_DIAMETER,CF$_FG_FORMAT,CF$_FLUX_TYPE,CF$_LABEL_BOXES_LAYOUT,CF$_LABEL_LAYOUT,CF$_LABEL_UM,CF$_LEADTYPE,CF$_MICRON,CF$_PER_FLUX,CF$_PER_METAL,CF$_PROD_ALLOY1,CF$_PROD_ALLOY2,CF$_PROD_ALLOY3,CF$_UNIT_WEIGHT,CF$_UPC) VALUES (''' 
+ LTRIM(RTRIM(PART_NO)) 
+ ''',''' + LTRIM(RTRIM(CONTRACT)) 
+ ''',''' + ISNULL(CF$_SHORT_PART_NO, '') 
+ ''',''' + ISNULL(CF$_DIAMETER, '') 
+ ''',''' + ISNULL(CF$_FG_FORMAT, '') 
+ ''',''' + ISNULL(CF$_FLUX_TYPE, '') 
+ ''',''' + ISNULL(CF$_LABEL_BOXES_LAYOUT, '') 
+ ''',''' + ISNULL(CF$_LABEL_LAYOUT, '') 
+ ''',''' + ISNULL(CF$_LABEL_UM, '') 
+ ''',''' + ISNULL(CF$_LEADTYPE, '') 
+ ''',''' + ISNULL(CF$_MICRON, '') 
+ ''',''' + ISNULL(CF$_PER_FLUX, '') 
+ ''',''' + ISNULL(CF$_PER_METAL, '') 
+ ''',''' + ISNULL(CF$_PROD_ALLOY1, '') 
+ ''',''' + ISNULL(CF$_PROD_ALLOY2, '') 
+ ''',''' + ISNULL(CF$_PROD_ALLOY3, '') 
+ ''',''' + ISNULL(CF$_UNIT_WEIGHT, '') 
+ ''',''' + ISNULL(CF$_UPC, '') 
+  ''');' aaa  
FROM ( SELECT  [Part_No]			PART_NO  
	  ,'10MTL'					CONTRACT
      ,[Shortpartno]				CF$_SHORT_PART_NO
      ,[Cf$_Diameter]			CF$_DIAMETER
      ,[Cf$_Fg_Format]				CF$_FG_FORMAT
      ,[Cf$_Flux_Type]				CF$_FLUX_TYPE
      ,[Cf$_Label_Boxes_Layout]				CF$_LABEL_BOXES_LAYOUT
      ,[Cf$_Label_Layout]				CF$_LABEL_LAYOUT
      ,[Cf$_Label_Um]				CF$_LABEL_UM
      ,[Cf$_Leadtype]				CF$_LEADTYPE
      ,CAST([Cf$_Micron] AS VARCHAR)				CF$_MICRON
      ,[Cf$_Per_Flux]				CF$_PER_FLUX
      ,[Cf$_Per_Metal]				CF$_PER_METAL
      ,[Cf$_Prod_Alloy1]				CF$_PROD_ALLOY1
      ,[Cf$_Prod_Alloy2]				CF$_PROD_ALLOY2
      ,[Cf$_Prod_Alloy3]				CF$_PROD_ALLOY3
      ,[Cf$_Unit_Weight]				CF$_UNIT_WEIGHT
      ,[Cf$_Upc]				CF$_UPC
  FROM [dbo].[InventoryPartsEXTRUSION$] ipt) aa;

  
----Update Inventory_Part CustomFields
DECLARE   
   CURSOR get_qaman IS
      SELECT
            qcp.objid,
            qcpa.CF$_SHORT_PART_NO,   
            qcpa.CF$_DIAMETER,
            qcpa.CF$_FG_FORMAT,
            qcpa.CF$_FLUX_TYPE,
            qcpa.CF$_LABEL_BOXES_LAYOUT,
            qcpa.CF$_LABEL_LAYOUT,
            qcpa.CF$_LABEL_UM,
            qcpa.CF$_LEADTYPE,
            qcpa.CF$_MICRON,
            qcpa.CF$_PER_FLUX,
            qcpa.CF$_PER_METAL,
            qcpa.CF$_PROD_ALLOY1,
            qcpa.CF$_PROD_ALLOY2,
            qcpa.CF$_PROD_ALLOY3,
            qcpa.CF$_UNIT_WEIGHT,
            qcpa.CF$_UPC
      FROM MTK_INVENTORY_PART_CF_TAB qcpa
      INNER JOIN Inventory_Part_CFV qcp ON qcp.PART_NO = qcpa.PART_NO AND qcp.CONTRACT = qcpa.CONTRACT;
   
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
      Client_SYS.Add_To_Attr('CF$_SHORT_PART_NO', row_.CF$_SHORT_PART_NO, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_DIAMETER', row_.CF$_DIAMETER, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_FG_FORMAT', row_.CF$_FG_FORMAT, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_FLUX_TYPE', row_.CF$_FLUX_TYPE, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_LABEL_BOXES_LAYOUT', row_.CF$_LABEL_BOXES_LAYOUT, attr_cf_);      
      Client_SYS.Add_To_Attr('CF$_LABEL_LAYOUT', row_.CF$_LABEL_LAYOUT, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_LABEL_UM', row_.CF$_LABEL_UM, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_LEADTYPE', row_.CF$_LEADTYPE, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_MICRON', row_.CF$_MICRON, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_PER_FLUX', row_.CF$_PER_FLUX, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_PER_METAL', row_.CF$_PER_METAL, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_PROD_ALLOY1', row_.CF$_PROD_ALLOY1, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_PROD_ALLOY2', row_.CF$_PROD_ALLOY2, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_PROD_ALLOY3', row_.CF$_PROD_ALLOY3, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_UNIT_WEIGHT', row_.CF$_UNIT_WEIGHT, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_UPC', row_.CF$_UPC, attr_cf_);

      INVENTORY_PART_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');
   END LOOP;
   
END;