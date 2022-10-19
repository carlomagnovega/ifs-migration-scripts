UPDATE routing_alternate_tab 
      SET   ROWSTATE = 'Tentative'
      WHERE CONTRACT = '33CX'
      AND   PART_NO  = part_no_;

DECLARE   
   CURSOR get_qaman IS
      SELECT
         qcpa.objid,
         qcpa.objversion,
         qcpa.PART_NO,
         qcpa.CONTRACT
      FROM ROUTING_HEAD qcpa  
      INNER JOIN ROUTING_ALTERNATE a ON qcpa.PART_NO = a.part_no AND
      qcpa.CONTRACT = a.CONTRACT      
      WHERE NOT EXISTS (SELECT 1 FROM ROUTING_OPERATION b WHERE qcpa.PART_NO = b.part_no AND
      qcpa.CONTRACT = b.CONTRACT)
      AND qcpa.CONTRACT = '33CX'
      AND a.objstate = 'Tentative';
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
BEGIN
   FOR row_ IN get_qaman LOOP 
      objid_      := row_.objid;
      objversion_ := row_.objversion;
      ROUTING_HEAD_API.REMOVE__( info_ , objid_ , objversion_ , 'DO' );
      COMMIT;
   END LOOP;   
END;

---------------------------------------------
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


-----------------------	
DECLARE   
   CURSOR get_qaman IS
      SELECT a.CONTRACT, 
             a.PART_NO
      FROM INVENTORY_PART_CFV a   
      WHERE a.CONTRACT = '20MEX' 
      AND PART_NO IN ('15748-AIM24EAKG',
             '15682-AIM24EAKG',
             '15683-AIM24EAKG',
             '15765-AIM24EAKG',
             '15687-AIM24EAKG',
             '15688-AIM24EAKG',
             '15772-AIM24EAKG1',
             '15773-AIM24EAKG1',
             '15990-AIM24EAKG',
             '15991-AIM24EAKG');
   
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