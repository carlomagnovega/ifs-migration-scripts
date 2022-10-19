DROP TABLE MTK_INVENTORY_PART_CF_TAB;

CREATE TABLE MTK_INVENTORY_PART_CF_TAB
(
   PART_NO                            VARCHAR2(25)        NOT NULL,
   CONTRACT                           VARCHAR2(5)         NOT NULL,   
   CF$_AIM_LABEL_FORMULA                      VARCHAR2(100)        NULL
   );
   

/**********************************
SELECT 'INSERT INTO MTK_INVENTORY_PART_CF_TAB (PART_NO,CONTRACT,CF$_AIM_LABEL_FORMULA) VALUES (''' 
+ LTRIM(RTRIM(PART_NO)) 
+ ''',''' + LTRIM(RTRIM(CONTRACT)) 
+ ''',''' + ISNULL([CF$_AIM_LABEL_FORMULA], '') 
+  ''');' aaa 
FROM ( SELECT  [Part No]		PART_NO  
	  ,'10MTL'				CONTRACT
      ,[Container Formula] [CF$_AIM_LABEL_FORMULA]
  FROM [dbo].[Container_forumla$] ipt) aa; 

   
*********************
UPDATE MTK_INVENTORY_PART_CF_TAB
      SET CF$_AIM_LABEL_FORMULA = 'J25'   
      WHERE CF$_AIM_LABEL_FORMULA = 'J25- Paste flux & Epoxy'


*************************************************************
DECLARE   
   CURSOR get_qaman IS
      SELECT
         qcp.objid,
         qcp.PART_NO,
         qcp.CONTRACT,
         smt.objkey CF$_AIM_LABEL_FORMULA
      FROM MTK_INVENTORY_PART_CF_TAB qcpa
      INNER JOIN Inventory_Part qcp ON qcp.PART_NO = qcpa.PART_NO AND qcp.CONTRACT = qcpa.CONTRACT
      LEFT JOIN LABEL_FORMULA_CLV smt ON smt.CF$_CONTAINER = qcpa.CF$_AIM_LABEL_FORMULA;
      
      info_                VARCHAR2(32000);
      objid_               VARCHAR2(32000);
      objversion_          VARCHAR2(32000);
      attr_cf_             VARCHAR2(26000);
      attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Clear_Attr(attr_cf_);
      
      Client_SYS.Add_To_Attr('CF$_AIM_LABEL_FORMULA', row_.CF$_AIM_LABEL_FORMULA, attr_cf_);
      
      INVENTORY_PART_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');
      COMMIT;
   END LOOP;   
END;

   