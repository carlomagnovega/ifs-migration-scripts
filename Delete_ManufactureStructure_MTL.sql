----Delete Manuf Structure
DROP TABLE MTK_MANUF_STRUCTURE_DEL_TAB;
CREATE TABLE MTK_MANUF_STRUCTURE_DEL_TAB
(
   PART_NO                          VARCHAR2(25)        NOT NULL,
   CONTRACT                         VARCHAR2(5)         NOT NULL,
   COMPONENT_PART             		VARCHAR2(25)        NOT NULL   
);


----------
SELECT 'INSERT INTO MTK_MANUF_STRUCTURE_DEL_TAB (PART_NO, CONTRACT, COMPONENT_PART) VALUES (''' 
+ LTRIM(RTRIM(PART_NO)) 
+ ''',''' + CONTRACT 
+ ''',''' + COMPONENT_PART 
+  ''');' aaa  
FROM ( SELECT   [PART_NO] PART_NO, 
				[CONTRACT] CONTRACT, 
				[COMPONENT_PART] COMPONENT_PART
		FROM  [dbo].[ManufStructureToDELETE$]) aa;


DECLARE   
   CURSOR get_qaman IS
      SELECT a.objid,  
             a.objversion,
             a.Contract, 
             a.Part_No,
             a.eng_chg_level,
             a.bom_type,
             a.alternative_no
      FROM PROD_STRUCTURE a
      INNER JOIN MTK_MANUF_STRUCTURE_DEL_TAB b ON a.Contract = b.Contract AND a.Part_No = b.Part_No AND a.COMPONENT_PART = b.COMPONENT_PART;
   
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_qaman LOOP
      objid_      := row_.objid;
      objversion_ := row_.objversion;
      
      PROD_STRUCTURE_API.REMOVE__( info_ , objid_ , objversion_ , 'DO' );
      COMMIT;      
   END LOOP;   
END;