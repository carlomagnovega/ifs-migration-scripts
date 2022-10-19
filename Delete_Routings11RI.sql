DROP TABLE MTK_INVENTORY_PART_UOM_TAB;
CREATE TABLE MTK_INVENTORY_PART_UOM_TAB
(
   PART_NO                          VARCHAR2(25)        NOT NULL,
   CONTRACT                         VARCHAR2(5)         NOT NULL
);

SELECT 'INSERT INTO MTK_INVENTORY_PART_UOM_TAB (PART_NO, CONTRACT) VALUES (''' 
+ LTRIM(RTRIM(PART_NO)) 
+ ''',''' + CONTRACT 
+  ''');' aaa  
FROM ( SELECT   PART_NO, 
				[Site] CONTRACT
		FROM  [dbo].[NewROUTING$]) aa;
		
		
		
----Update Inventory_Part CustomFields
DECLARE   
   CURSOR get_qaman IS
      SELECT
            qcpa.PART_NO,
            qcpa.CONTRACT
      FROM MTK_INVENTORY_PART_UOM_TAB qcpa
      LEFT JOIN ROUTING_HEAD b ON b.PART_NO = qcpa.PART_NO AND b.CONTRACT = qcpa.CONTRACT
      WHERE b.PART_NO IS NULL;

BEGIN
   FOR row_ IN get_qaman LOOP 
      BEGIN
         INV_CST_AIM_API.Delete_Routing_ControlPlan(row_.CONTRACT, row_.PART_NO);         
      EXCEPTION
         WHEN OTHERS THEN
           DBMS_OUTPUT.PUT_LINE(' failed deleting Routing_ControlPlan. Part_No: ' || row_.PART_NO);        
      END;
      COMMIT;
   END LOOP;   
END;		