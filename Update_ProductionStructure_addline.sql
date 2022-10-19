DROP TABLE MTK_PRODSTRUCT_AIM_TAB;

TRUNCATE TABLE MTK_PRODSTRUCT_AIM_TAB;
CREATE TABLE MTK_PRODSTRUCT_AIM_TAB 
(
   PART_NO   			VARCHAR2(25)        NOT NULL,
   CONTRACT	 			VARCHAR2(5)        NOT NULL,
   LINE_ITEM_NO         NUMBER              NOT NULL,
   COMPONENT_PART       VARCHAR2(25)        NOT NULL,
   QTY_PER_ASSEMBLY     NUMBER              NOT NULL
);

alter session set NLS_NUMERIC_CHARACTERS = '.,';

----------------
SELECT 'INSERT INTO MTK_PRODSTRUCT_AIM_TAB (PART_NO,CONTRACT,LINE_ITEM_NO,COMPONENT_PART,QTY_PER_ASSEMBLY) VALUES (''' 
		+ [Part_No]
		+ ''',''' + [Contract]
		+ ''',''' + [LINE_ITEM_NO]
		+ ''',''' + [COMPONENT_PART]
		+ ''',''' + [QTY_PER_ASSEMBLY_]
		+  ''');'   aa
FROM ( SELECT [Part_No]
	  ,[CONTRACT]
	  ,[LINE_ITEM_NO]
	  ,REPLACE([COMPONENT_PART], ' ', '') [COMPONENT_PART]
	  ,[QTY_PER_ASSEMBLY_]
	  FROM [IFSDEV-ManualUpload].[dbo].[ManufStructureEXTRA$]) aaa 
	  
------	  

DECLARE   
   CURSOR get_qaman IS
      SELECT 
		   IPT.CONTRACT,
		   IPT.PART_NO,
		   IPT.LINE_ITEM_NO,
		   IPT.COMPONENT_PART,
		   IPT.QTY_PER_ASSEMBLY
		FROM MTK_PRODSTRUCT_AIM_TAB IPT
		INNER JOIN PROD_STRUCTURE_HEAD CPT ON CPT.CONTRACT = IPT.CONTRACT AND CPT.PART_NO = IPT.PART_NO
		WHERE NOT EXISTS (SELECT *
		   FROM PROD_STRUCTURE a
		   WHERE CPT.CONTRACT = a.CONTRACT 
		   AND a.PART_NO = IPT.PART_NO
		   AND line_item_no = IPT.line_item_no)
		GROUP BY IPT.CONTRACT,
		   IPT.PART_NO,
		   IPT.LINE_ITEM_NO,
		   IPT.COMPONENT_PART,
		   IPT.QTY_PER_ASSEMBLY;
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_qaman LOOP
      Client_SYS.Clear_Attr(info_);
      Client_SYS.Clear_Attr(objid_);
      Client_SYS.Clear_Attr(objversion_);
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('PART_NO', row_.PART_NO, attr_);
      Client_SYS.Add_To_Attr('CONTRACT', row_.CONTRACT, attr_);
      Client_SYS.Add_To_Attr('ENG_CHG_LEVEL', '1', attr_);	  
      Client_SYS.Add_To_Attr('BOM_TYPE', 'Manufacturing', attr_);
      Client_SYS.Add_To_Attr('ALTERNATIVE_NO', '*', attr_);
      Client_SYS.Add_To_Attr('LINE_ITEM_NO', row_.LINE_ITEM_NO, attr_);
      Client_SYS.Add_To_Attr('COMPONENT_PART', row_.COMPONENT_PART, attr_);
      Client_SYS.Add_To_Attr('QTY_PER_ASSEMBLY', row_.QTY_PER_ASSEMBLY, attr_);
      Client_SYS.Add_To_Attr('COMPONENT_SCRAP', '0', attr_);
      Client_SYS.Add_To_Attr('SHRINKAGE_FACTOR', '0', attr_);
      Client_SYS.Add_To_Attr('CONSUMPTION_ITEM', 'Consumed', attr_);
      Client_SYS.Add_To_Attr('LEADTIME_OFFSET', '0', attr_);
      Client_SYS.Add_To_Attr('PROMISE_PLANNED', 'Promised', attr_);
      Client_SYS.Add_To_Attr('PHANTOM_CONSUME', 'Not Phantom Consume', attr_);
      Client_SYS.Add_To_Attr('CHARGED_ITEM', 'Item not charged', attr_);
      Client_SYS.Add_To_Attr('CREATE_DATE', '2010-01-01-00.00.00', attr_);
      Client_SYS.Add_To_Attr('LAST_ACTIVITY_DATE', '2010-01-01-00.00.00', attr_);
      Client_SYS.Add_To_Attr('PURCHASE_COMP_BACKFLUSH_DB', 'FALSE', attr_);
      Client_SYS.Add_To_Attr('STD_PLANNED_ITEM', '1', attr_);
      Client_SYS.Add_To_Attr('OPER_COST_DISTRIBUTION', '0', attr_);
      Client_SYS.Add_To_Attr('GEN_OH_COST_DISTRIBUTION', '0', attr_);
      Client_SYS.Add_To_Attr('EXCLUDE_FROM_AS_BUILT_DB', 'FALSE', attr_);
      
      PROD_STRUCTURE_API.New__(info_, objid_, objversion_, attr_, 'DO');
      --COMMIT;
   END LOOP;   
END;
