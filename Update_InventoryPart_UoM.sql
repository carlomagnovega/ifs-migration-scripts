----Update InventoryPart	LotSize
DROP TABLE MTK_INVENTORY_PART_UOM_TAB;
CREATE TABLE MTK_INVENTORY_PART_UOM_TAB
(
   PART_NO                          VARCHAR2(25)        NOT NULL,
   CONTRACT                         VARCHAR2(5)         NOT NULL,
   BASE_UOM             		    VARCHAR2(50)        NULL   
);


----------
SELECT 'INSERT INTO MTK_INVENTORY_PART_UOM_TAB (PART_NO, CONTRACT, BASE_UOM) VALUES (''' 
+ LTRIM(RTRIM(PART_NO)) 
+ ''',''' + CONTRACT 
+ ''',''' + ISNULL(BASE_UOM, '') 
+  ''');' aaa  
FROM ( SELECT   [Part No] PART_NO, 
				[Site] CONTRACT, 
				[Base UoM] BASE_UOM
		FROM  [dbo].['InventoryPartsUOM$']) aa;
		
						
----Update Inventory_Part CustomFields
DECLARE   
   CURSOR get_qaman IS
      SELECT
            qcp.objid,
            ium.objkey CF$_AIM_BASEHUOM, 
            qcpa.PART_NO
      FROM MTK_INVENTORY_PART_UOM_TAB qcpa
      INNER JOIN Inventory_Part_CFV qcp ON qcp.PART_NO = qcpa.PART_NO AND qcp.CONTRACT = qcpa.CONTRACT
      LEFT JOIN INPUT_UNIT_MEAS_GROUP ium ON ium.input_unit_meas_group_id = qcpa.BASE_UOM;
   
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
 
      INVENTORY_PART_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');
      COMMIT;
   END LOOP;   
END;

---
 DECLARE   
   CURSOR get_qaman IS
      SELECT
            qcp.objid,
            ium.objkey CF$_AIM_BASEHUOM, 
            qcp.PART_NO
      FROM Inventory_Part_CFV qcp 
      LEFT JOIN INPUT_UNIT_MEAS_GROUP ium ON ium.input_unit_meas_group_id = 'UM_BASE_EA35GR'
      WHERE qcp.CONTRACT = '40UK' and upper( qcp.UNIT_MEAS ) = upper( 'ea35g' ) and qcp.PART_STATUS = 'A' and qcp.CF$_AIM_BASEHUOM is NULL;
   
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
 
      INVENTORY_PART_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');
      COMMIT;
   END LOOP;   
END;

