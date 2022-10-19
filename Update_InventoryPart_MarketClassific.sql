DROP TABLE MTK_INVENTORY_PART_CF_TAB;

CREATE TABLE MTK_INVENTORY_PART_CF_TAB
(
   PART_NO                            VARCHAR2(25)        NOT NULL,
   CONTRACT                           VARCHAR2(5)         NOT NULL,   
   CF$_MARKET					      VARCHAR2(100)       NULL,
   CF$_CLASSIFIC                      VARCHAR2(100)       NULL        
);


SELECT 'INSERT INTO MTK_INVENTORY_PART_CF_TAB (PART_NO,CONTRACT,CF$_MARKET,CF$_CLASSIFIC) VALUES (''' 
+ LTRIM(RTRIM(PART_NO)) 
+ ''',''' + CONTRACT 
+ ''',''' + ISNULL(CF$_MARKET, '') 
+ ''',''' + ISNULL(CF$_CLASSIFIC, '') 
+  ''');'   aa
FROM ( SELECT  [Part No]	PART_NO  
	  ,[Site]				CONTRACT
      ,[Market]				CF$_MARKET
      ,[Classification_SGM]	CF$_CLASSIFIC	  
  FROM [dbo].[InventoryPartsMARKET$]) aaa
  
  
  
----Update Inventory_Part CustomFields
DECLARE   
   CURSOR get_qaman IS
      SELECT
            qcp.objid,
            smt.objkey MARKET,
            qcpa.CF$_CLASSIFIC CLASSIFIC
      FROM MTK_INVENTORY_PART_CF_TAB qcpa
      INNER JOIN Inventory_Part_CFV qcp ON qcp.PART_NO = qcpa.PART_NO AND qcp.CONTRACT = qcpa.CONTRACT
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
      Client_SYS.Add_To_Attr('CF$_MARKET', row_.MARKET, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIM_CLASSIFIC', row_.CLASSIFIC, attr_cf_);
 
      INVENTORY_PART_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');
      COMMIT;
   END LOOP;
   
END;
  