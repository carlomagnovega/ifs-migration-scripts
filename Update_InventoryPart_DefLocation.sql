----Update InventoryPart	Def Location
DROP TABLE MTK_INVENTORY_PART_LOC_TAB;
CREATE TABLE MTK_INVENTORY_PART_LOC_TAB
(
   PART_NO                          VARCHAR2(25)        NOT NULL,
   CONTRACT                         VARCHAR2(5)         NOT NULL,
   LOCATION_NO             		    VARCHAR2(50)        NOT NULL   
);


----------
SELECT 'INSERT INTO MTK_INVENTORY_PART_LOC_TAB (PART_NO, CONTRACT, LOCATION_NO) VALUES (''' 
+ LTRIM(RTRIM(PART_NO)) 
+ ''',''' + CONTRACT 
+ ''',''' + LOCATION_NO 
+  ''');' aaa  
FROM ( SELECT   [Part_No] PART_NO, 
				[Contract] CONTRACT, 
				[Location_No] LOCATION_NO
		FROM  [dbo].[InventoryPartDefLoc$]) aa;
		
						
----Update Inventory_Part DefLocation
DECLARE   
   CURSOR get_qaman IS
		SELECT
			  qcpa.PART_NO,
			  qcpa.CONTRACT,
			  qcpa.LOCATION_NO
      FROM MTK_INVENTORY_PART_LOC_TAB qcpa
      INNER JOIN INVENTORY_PART b ON b.PART_NO = qcpa.PART_NO AND b.CONTRACT = qcpa.CONTRACT
		LEFT JOIN INVENTORY_PART_DEF_LOC_TAB ium ON ium.PART_NO = qcpa.PART_NO AND ium.CONTRACT = qcpa.CONTRACT
		WHERE ium.CONTRACT IS NULL;   
BEGIN
   FOR row_ IN get_qaman LOOP
      INVENTORY_PART_DEF_LOC_API.Create_Default_Location(row_.CONTRACT, row_.PART_NO, row_.LOCATION_NO);
      COMMIT;
   END LOOP;   
END;



------------------
DECLARE   
   CURSOR get_qaman IS
		SELECT
			  b.PART_NO,
			  b.CONTRACT,
			   68 LOCATION_NO
      FROM INVENTORY_PART b 
		LEFT JOIN INVENTORY_PART_DEF_LOC_TAB ium ON ium.PART_NO = b.PART_NO AND ium.CONTRACT = b.CONTRACT
      WHERE b.PART_NO LIKE 'SP_%'
      AND ium.CONTRACT IS NULL;   
BEGIN
   FOR row_ IN get_qaman LOOP
      INVENTORY_PART_DEF_LOC_API.Create_Default_Location(row_.CONTRACT, row_.PART_NO, row_.LOCATION_NO);
      COMMIT;
   END LOOP;   
END;

-----For Poland
DECLARE   
   CURSOR get_qaman IS
      SELECT
                 b.PART_NO,
                 b.CONTRACT,
                 planner_buyer,
                 CASE WHEN planner_buyer LIKE 'PAST%' THEN 184
                      WHEN planner_buyer LIKE 'FLUX%' THEN 186
                      WHEN planner_buyer LIKE 'EXTR%' THEN 183
                      WHEN planner_buyer LIKE 'CAST%' THEN 185
                      WHEN planner_buyer LIKE 'MEDI%' THEN 191
                      WHEN planner_buyer LIKE 'RECL%' THEN 191
                      WHEN planner_buyer LIKE 'SUPPL%' THEN 191
					  WHEN planner_buyer LIKE 'SPEC_RIBBON%' THEN 191
                 END LOCATION_NO
      FROM INVENTORY_PART b 
      LEFT JOIN INVENTORY_PART_DEF_LOC_TAB ium ON ium.PART_NO = b.PART_NO AND ium.CONTRACT = b.CONTRACT
      WHERE ium.CONTRACT IS NULL
      AND b.CONTRACT = '41POL'
      AND LOCATION_NO IS NOT NULL
      ORDER BY planner_buyer; 
BEGIN
   FOR row_ IN get_qaman LOOP
      INVENTORY_PART_DEF_LOC_API.Create_Default_Location(row_.CONTRACT, row_.PART_NO, row_.LOCATION_NO);
      COMMIT;
   END LOOP;   
END;  
    
-----For UK
DECLARE   
   CURSOR get_qaman IS
      SELECT
		   b.PART_NO,
		   b.CONTRACT,
		   planner_buyer,
		   CASE WHEN planner_buyer LIKE 'PAST%' THEN 199
		   WHEN planner_buyer LIKE 'FLUX%' THEN 201
		   WHEN planner_buyer LIKE 'POWD%' THEN 207
		   WHEN planner_buyer LIKE 'RESA%' THEN 207
		   WHEN planner_buyer LIKE 'RIBB%' THEN 207
		   WHEN planner_buyer LIKE 'EXTR%' THEN 202
		   WHEN planner_buyer LIKE 'CAST%' THEN 203
		   WHEN planner_buyer LIKE 'MEDI%' THEN 201
		   WHEN planner_buyer LIKE 'RECL%' THEN 208
		   WHEN planner_buyer LIKE 'SUPPL%' THEN 207
		   WHEN planner_buyer LIKE 'SPEC_%' THEN 207
		   END LOCATION_NO
FROM INVENTORY_PART b 
LEFT JOIN INVENTORY_PART_DEF_LOC_TAB ium ON ium.PART_NO = b.PART_NO AND ium.CONTRACT = b.CONTRACT
WHERE ium.CONTRACT IS NULL
AND b.CONTRACT = '40UK'
--AND LOCATION_NO IS NOT NULL
ORDER BY planner_buyer; 
BEGIN
   FOR row_ IN get_qaman LOOP
      INVENTORY_PART_DEF_LOC_API.Create_Default_Location(row_.CONTRACT, row_.PART_NO, row_.LOCATION_NO);
      COMMIT;
   END LOOP;   
END; 

------China
DECLARE   
   CURSOR get_qaman IS
      SELECT
         b.PART_NO,
         b.CONTRACT,
         planner_buyer,
         CASE WHEN planner_buyer LIKE 'PAST%' THEN 242
         WHEN planner_buyer LIKE 'FLUX%' THEN 241
         WHEN planner_buyer LIKE 'POWD%' THEN 248
         WHEN planner_buyer LIKE 'SPEC_BULK%' THEN 249
         WHEN planner_buyer LIKE '%EXTR%' THEN 240
         WHEN planner_buyer LIKE 'CAST%' THEN 239
         WHEN planner_buyer LIKE 'MEDI%' THEN 251
         WHEN planner_buyer LIKE 'MAINT%' THEN 246
         WHEN planner_buyer LIKE 'SPEC_RESALE%' THEN 249
         WHEN planner_buyer LIKE 'SUPPL%' THEN 250
         END LOCATION_NO
      FROM INVENTORY_PART b 
      LEFT JOIN INVENTORY_PART_DEF_LOC_TAB ium ON ium.PART_NO = b.PART_NO AND ium.CONTRACT = b.CONTRACT
      WHERE ium.CONTRACT IS NULL
      AND b.CONTRACT = '33CX'
      ORDER BY planner_buyer;
      
BEGIN
   FOR row_ IN get_qaman LOOP
      IF (row_.LOCATION_NO IS NOT NULL) THEN
         INVENTORY_PART_DEF_LOC_API.Create_Default_Location(row_.CONTRACT, row_.PART_NO, row_.LOCATION_NO);
         COMMIT;
      END IF;
   END LOOP;   
END; 
