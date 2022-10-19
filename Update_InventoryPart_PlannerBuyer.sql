DROP TABLE MTK_INVENTORY_PART_CF_TAB;

CREATE TABLE MTK_INVENTORY_PART_CF_TAB
(
   PART_NO                            VARCHAR2(25)        NOT NULL,
   CONTRACT                           VARCHAR2(5)         NOT NULL,   
   PLANNER_BUYER                      VARCHAR2(100)       NULL        
);

SELECT 'INSERT INTO MTK_INVENTORY_PART_CF_TAB (PART_NO,CONTRACT,PLANNER_BUYER) VALUES (''' 
+ LTRIM(RTRIM(PART_NO)) 
+ ''',''' + CONTRACT 
+ ''',''' + ISNULL(PLANNER_BUYER, '') 
+  ''');'   aa
FROM ( SELECT  [IFS_PART_NO]	PART_NO  
	  ,[CONTRACT]				CONTRACT
      ,[PLANNER_BUYER ]	  
  FROM [dbo].[InventoryPartCHPlanner$]) aaa
--------------------------------------------
DECLARE   
   CURSOR get_qaman IS
		SELECT objid,            
             objversion,
             b.PLANNER_BUYER
      FROM  INVENTORY_PART a
      INNER JOIN MTK_INVENTORY_PART_CF_TAB b ON a.contract = b.contract AND a.part_no = b.part_no;
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000);   
   
BEGIN
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('PLANNER_BUYER', row_.PLANNER_BUYER, attr_);      
	  
      INVENTORY_PART_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      --COMMIT;
   END LOOP;   
END;
  
  

----Update InventoryPart 11RI
DECLARE   
   CURSOR get_qaman IS
		SELECT objid,            
			objversion 
		FROM  INVENTORY_PART
		where (PART_NO like '%BULK%' 
		and (CONTRACT = '11RI') 
		and (PLANNER_BUYER like 'SPEC_CASTING_FG' or PLANNER_BUYER like 'SPEC_CASTING_SE-FG' or PLANNER_BUYER like 'SPEC_CHEMICAL_FG' or PLANNER_BUYER like 'SPEC_CHEMICAL_SE-FG' or PLANNER_BUYER like 'SPEC_EXTRUSION_FG' or PLANNER_BUYER like 'SPEC_EXTRUSION_SE-FG' or PLANNER_BUYER like 'SPEC_GOLD_TIN_FG' or PLANNER_BUYER like 'SPEC_GOLD_TIN_SE-FG' or PLANNER_BUYER like 'SPEC_PASTE_FG' or PLANNER_BUYER like 'SPEC_PASTE_SE-FG' or PLANNER_BUYER like 'SPEC_PREFORM_FG' or PLANNER_BUYER like 'SPEC_PREFORM_SE-FG' or PLANNER_BUYER like 'SPEC_RAW' or PLANNER_BUYER like 'SPEC_RAW_FG' or PLANNER_BUYER like 'SPEC_RAW_SE-FG' or PLANNER_BUYER like 'SPEC_RESALE_FG' or PLANNER_BUYER like 'SPEC_RESALE_SE-FG' or PLANNER_BUYER like 'SPEC_RIBBON_FG' or PLANNER_BUYER like 'SPEC_RIBBON_SE-FG' or PLANNER_BUYER like 'SPEC_SHOT_FG' or PLANNER_BUYER like 'SPEC_SHOT_SE-FG'));
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000);   
   
BEGIN
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('PLANNER_BUYER', 'SPEC_BULK', attr_);      
	  
      INVENTORY_PART_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      --COMMIT;
   END LOOP;   
END;

----Update InventoryPart 10MTL
DECLARE   
   CURSOR get_qaman IS
		SELECT objid,            
       objversion,
       planner_buyer
FROM  INVENTORY_PART a
WHERE 
a.CONTRACT = '10MTL'
AND EXISTS (SELECT 1 FROM INVENTORY_PART b
WHERE (b.PART_NO like '%BULK%')
and (b.CONTRACT = '11RI') 
and (b.PLANNER_BUYER LIKE 'SPEC_%')
AND (b.PART_NO = a.PART_NO)
AND (b.CONTRACT <> a.CONTRACT));

   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000);   
   
BEGIN
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('PLANNER_BUYER', 'SPEC_BULK', attr_);      
	  
      INVENTORY_PART_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      --COMMIT;
   END LOOP;   
END;