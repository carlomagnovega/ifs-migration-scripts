DROP TABLE MTK_INVENTORY_PART_CF_TAB;

CREATE TABLE MTK_INVENTORY_PART_CF_TAB
(
   PART_NO                            VARCHAR2(25)        NOT NULL,
   CONTRACT                           VARCHAR2(5)         NOT NULL,   
   DURABILITY_DAY   			      VARCHAR2(100)       NOT NULL,
   CF$_ALLOYSPEC     			      VARCHAR2(100)       NOT NULL
);


SELECT 'INSERT INTO MTK_INVENTORY_PART_CF_TAB (PART_NO,CONTRACT,DURABILITY_DAY,CF$_ALLOYSPEC) VALUES (''' 
+ LTRIM(RTRIM(PART_NO)) 
+ ''',''' + CONTRACT 
+ ''',''' + DURABILITY_DAY 
+ ''',''' + CF$_ALLOYSPEC 
+  ''');'   aa
FROM ( SELECT  [Part No]	PART_NO  
	  ,[Site]				CONTRACT
      ,[Shelf Life in Days]  DURABILITY_DAY
      ,[Alloy Specification]  CF$_ALLOYSPEC
  FROM [dbo].[InventoryPart-CF$]) aaa



DECLARE   
   CURSOR get_qaman IS
      SELECT a.CONTRACT,
             a.PART_NO,
             a.objid,            
			   a.objversion,
			   b.durability_day
		FROM  INVENTORY_PART a
	    INNER JOIN MTK_INVENTORY_PART_CF_TAB b ON b.PART_NO = a.PART_NO AND b.CONTRACT = a.CONTRACT;

   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000);   
   
BEGIN
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('DURABILITY_DAY', row_.DURABILITY_DAY, attr_);      
      INVENTORY_PART_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      --COMMIT;
   END LOOP;   
END;