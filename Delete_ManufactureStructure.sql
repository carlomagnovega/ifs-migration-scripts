----Delete Manuf Structure
DROP TABLE MTK_MANUF_STRUCTURE_DEL_TAB;
CREATE TABLE MTK_MANUF_STRUCTURE_DEL_TAB
(
   PART_NO                          VARCHAR2(25)        NOT NULL,
   CONTRACT                         VARCHAR2(5)         NOT NULL,
   COMPONENT_PART             		VARCHAR2(25)         NULL   
);


----------
SELECT 'INSERT INTO MTK_MANUF_STRUCTURE_DEL_TAB (PART_NO, CONTRACT) VALUES (''' 
+ LTRIM(RTRIM(PART_NO)) 
+ ''',''' + CONTRACT 
+  ''');' aaa  
FROM ( SELECT   [PART_NO] PART_NO, 
				[CONTRACT] CONTRACT
		FROM  [dbo].[InventoryPartMX$]
		WHERE [TYPE_CODE] = '4') aa;

-----------------Generate Manufacture STRUCTURE
truncate table [dbo].[ManufStructure]
go
INSERT INTO [dbo].[ManufStructure]
           ([COMPONENT_PART]
           ,[PART_NO]
           ,[CONTRACT]
           ,[ENG_REVISION]
           ,[ENG_CHG_LEVEL]
           ,[ALTERNATIVE_NO]
           ,[BOM_TYPE_DB]
           ,[LINE_ITEM_NO]
           ,[COMPONENT_CONTRACT]
           ,[EFF_PHASE_IN_DATE]
           ,[EFF_PHASE_OUT_DATE]
           ,[QTY_PER_ASSEMBLY]
           ,[SHRINKAGE_FACTOR]
           ,[OPERATION_NO]
           ,[CREATE_DATE]
           ,[LAST_ACTIVITY_DATE]
           ,[CONSUMPTION_ITEM]
           ,[COMPONENT_SCRAP]
           ,[MTK_MODE]
           ,[ISSUE_TO_LOC]
           ,[DRAW_POS_NO]
           ,[STD_PLANNED_ITEM]
           ,[NOTE_TEXT]
           ,[PHANTOM_CONSUME_DB]
           ,[PROCEDURE_STEP])
SELECT [Component Part] [COMPONENT_PART]
      ,[Parent Part No] [PART_NO]
      ,[Site] [CONTRACT]
      ,'' [ENG_REVISION]
      ,'1' [ENG_CHG_LEVEL]
      ,'*' [ALTERNATIVE_NO]
      ,'M' [BOM_TYPE_DB]
      ,[Line Item No] [LINE_ITEM_NO]
      ,[Site] [COMPONENT_CONTRACT]
      ,'20100101' [EFF_PHASE_IN_DATE]
      ,'' [EFF_PHASE_OUT_DATE]
      ,[Qty per Assembly] [QTY_PER_ASSEMBLY]
      ,0 [SHRINKAGE_FACTOR]
      ,'' [OPERATION_NO]
      ,'20100101' [CREATE_DATE]
      ,'20100101' [LAST_ACTIVITY_DATE]
      ,'Y' [CONSUMPTION_ITEM]
      ,0 [COMPONENT_SCRAP]
      ,'*' [MTK_MODE]
      ,'' [ISSUE_TO_LOC]
      ,'' [DRAW_POS_NO ]
      ,0 [STD_PLANNED_ITEM]
      ,'' [NOTE_TEXT]
      ,[Phantom Consume] [PHANTOM_CONSUME_DB]
      ,'' [PROCEDURE_STEP]	  
  FROM [IFSDEV-ManualUpload].[dbo].[ManufStructureMEX1$]
  WHERE [Parent Part No] IS NOT NULL
  AND [Component Part] IS NOT NULL
GO


TRUNCATE TABLE [dbo].[ManufStructAlternate]
GO
INSERT INTO [dbo].[ManufStructAlternate]
           ([PART_NO]
           ,[CONTRACT]
           ,[ENG_CHG_LEVEL]
           ,[ALTERNATIVE_NO]
           ,[BOM_TYPE_DB]
           ,[ROWSTATE]
           ,[ALTERNATIVE_DESCRIPTION]
           ,[NOTE_TEXT]
           ,[ENG_REVISION]
           ,[MTK_MODE])
 SELECT PART_NO, 
        CONTRACT,
        ENG_CHG_LEVEL, 
        ALTERNATIVE_NO, 
        BOM_TYPE_DB,
        'B' ROWSTATE, 
        'STANDARD' ALTERNATIVE_DESCRIPTION, 
        '' NOTE_TEXT, 
        ENG_REVISION,
        MTK_MODE
FROM [dbo].[ManufStructure]
GROUP BY PART_NO, 
        CONTRACT,
        ENG_CHG_LEVEL, 
        ALTERNATIVE_NO, 
        BOM_TYPE_DB,
        ENG_REVISION,
        MTK_MODE
GO

TRUNCATE TABLE [dbo].[ManufStructureHead]
GO
INSERT INTO [dbo].[ManufStructureHead]
           ([PART_NO]
           ,[CONTRACT]
           ,[ENG_REVISION]
           ,[ENG_CHG_LEVEL]
           ,[BOM_TYPE_DB]
           ,[ENG_CHG_ORDER]
           ,[CREATE_DATE]
           ,[CUST_WARRANTY_ID]
           ,[NOTE_TEXT]
           ,[MTK_MODE]
           ,[ROWTYPE])
SELECT [PART_NO]
      ,[CONTRACT]
      ,[ENG_REVISION]
      ,[ENG_CHG_LEVEL]
      ,[BOM_TYPE_DB]
      ,'' [ENG_CHG_ORDER]
      ,'' [CREATE_DATE]
      ,'' [CUST_WARRANTY_ID]
      ,'' [NOTE_TEXT]
      ,'*' [MTK_MODE]
      ,'ProdStructureHead' [ROWTYPE]
  FROM [dbo].[ManufStructure]
  GROUP BY [PART_NO]
      ,[CONTRACT]
      ,[ENG_REVISION]
      ,[ENG_CHG_LEVEL]
      ,[BOM_TYPE_DB]
GO
		
----Delete some PROD_STRUCTURE
UPDATE manuf_struct_alternate_tab PST
SET ROWSTATE = 'Tentative'
--SELECT * FROM manuf_struct_alternate_tab PST
WHERE EXISTS (SELECT 1 
                     FROM MTK_MANUF_STRUCTURE_HEAD_TAB MST 
                     where MST.CONTRACT = PST.CONTRACT  AND MST.PART_NO = PST.PART_NO);					 
					 
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
      INNER JOIN MTK_MANUF_STRUCTURE_HEAD_TAB b ON a.Contract = b.Contract AND a.Part_No = b.Part_No;
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



DECLARE   
   CURSOR get_qaman IS
      SELECT a.objid,  
             a.objversion,
             a.Contract, 
             a.Part_No
      FROM PROD_STRUCTURE_HEAD a
      WHERE EXISTS (SELECT 1 
                     FROM MTK_MANUF_STRUCTURE_HEAD_TAB b 
                     WHERE a.Contract = b.Contract AND a.Part_No = b.Part_No);
   
   
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
      
      PROD_STRUCTURE_HEAD_API.REMOVE__( info_ , objid_ , objversion_ , 'DO' );
      COMMIT;      
   END LOOP;   
END;


----------------------------------------------------------Update PhaseInDate
DECLARE   
   CURSOR get_qaman IS
      SELECT a.objid, a.objversion
		FROM PART_REVISION a
		INNER JOIN INVENTORY_PART b ON a.CONTRACT = b.CONTRACT AND a.PART_NO = b.PART_NO
		WHERE EXISTS (SELECT 1 FROM MTK_MANUF_STRUCTURE_TAB c WHERE c.CONTRACT = b.CONTRACT AND c.PART_NO = b.PART_NO) 
		OR EXISTS (SELECT 1 FROM MTK_MANUF_STRUCTURE_TAB c WHERE c.CONTRACT = b.CONTRACT AND c.COMPONENT_PART = b.PART_NO);      
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('EFF_PHASE_IN_DATE', '2010-01-01-00.00.00', attr_);
      
      PART_REVISION_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      COMMIT;
   END LOOP;   
END; 


----
DECLARE   
   CURSOR get_mfstr IS
      SELECT objid,  objversion 
      FROM PROD_STRUCT_ALTERNATE
	  WHERE use_cost_distribution_DB = 'STANDARD'
	  AND CONTRACT = '20MEX';      
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_mfstr LOOP
      objid_      := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(info_);
      Client_SYS.Clear_Attr(attr_);
	   Client_SYS.Add_To_Attr('USE_COST_DISTRIBUTION_DB', 'DISTRIBUTION', attr_);

      PROD_STRUCT_ALTERNATE_API.MODIFY__( info_ , objid_ , objversion_, attr_, 'DO' );      
      COMMIT;
   END LOOP;   
END;
