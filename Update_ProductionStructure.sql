BEGIN 
&AO.PROD_STRUCTURE_API.MODIFY__( :p0 , :p1 , :p2 , :p3 , :p4 ); 
 
EXCEPTION 
WHEN OTHERS THEN 
rollback; 
raise; 
END;

p0	Alpha	InOut	
p1	Alpha	InOut	AAAaLvAAGAAGUKWAAO
p2	Alpha	InOut	20200219154840
p3	Alpha	InOut	QTY_PER_ASSEMBLY0.001
p4	Alpha	InOut	DO


DROP TABLE MTK_PRODSTRUCT_AIM_TAB;

CREATE TABLE MTK_PRODSTRUCT_AIM_TAB 
(
   PART_NO                            VARCHAR2(25)        NOT NULL,
   LINE_ITEM_NO                       NUMBER              NOT NULL,
   COMPONENT_PART                     VARCHAR2(25)        NOT NULL,
   QTY_PER_ASSEMBLY                   NUMBER              NOT NULL
);

  
SELECT 'INSERT INTO MTK_PRODSTRUCT_AIM_TAB (PART_NO,LINE_ITEM_NO,COMPONENT_PART,QTY_PER_ASSEMBLY) VALUES (''' 
		+ [Part_No]
		+ ''',''' + [Line_Sequence]
		+ ''',''' + [Component_Part]
		+ ''',''' + [New Qty_per_assembly]
		+  ''');'   aa
FROM ( SELECT [Part_No]
	  ,[Line_Sequence]
	  ,[Component_Part]
	  ,[New Qty_per_assembly]
	  FROM [IFSDEV-ManualUpload].[dbo].[ProdStructMEX$]) aaa 
---------
SELECT 'INSERT INTO MTK_PRODSTRUCT_AIM_TAB (PART_NO,LINE_ITEM_NO,COMPONENT_PART,QTY_PER_ASSEMBLY) VALUES (''' 
		+ [Part_No]
		+ ''',''' + [Line_Sequence]
		+ ''',''' + [Component_Part]
		+ ''',''' + [New Qty_per_assembly]
		+  ''');'   aa
FROM ( SELECT [Parent Part No] [Part_No]
	  ,cast([Line Item No] as varchar) [Line_Sequence]
	  ,[Component Part] [Component_Part]
	  ,cast([New Qty] as varchar) [New Qty_per_assembly]
	  FROM [IFSDEV-ManualUpload].[dbo].[ProdStructMEX1$]) aaa 
---------------------	  
	  
alter session set NLS_NUMERIC_CHARACTERS = '.,';	


----Update Serial Object CustomFields
DECLARE   
   CURSOR get_qaman IS
      SELECT
		   qcp.objid,
		   qcp.objversion,
		   qcpa.QTY_PER_ASSEMBLY            
		FROM MTK_PRODSTRUCT_AIM_TAB qcpa
		INNER JOIN PROD_STRUCTURE qcp ON qcp.PART_NO = qcpa.PART_NO AND
		qcp.LINE_ITEM_NO = qcpa.LINE_ITEM_NO AND
		qcp.COMPONENT_PART = qcpa.COMPONENT_PART AND 
        qcp.CONTRACT = '20MEX';
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_);      
      Client_SYS.Add_To_Attr('QTY_PER_ASSEMBLY', row_.QTY_PER_ASSEMBLY, attr_);
      
      PROD_STRUCTURE_API.MODIFY__( info_, objid_, objversion_, attr_, 'DO' );
   END LOOP;   
END;  

----
DECLARE   
   CURSOR get_qaman IS
      SELECT qcp.objid, qcp.objversion
  FROM PROD_STRUCTURE qcp
 WHERE qcp.PART_NO in ('13029-S2-24EA',
                       '13029-S2-AIM24EA',
                       '84551-S1+A2:A47943-AIM24EA',
                       '84653-AIM24EA')
   AND qcp.COMPONENT_PART = 'M10064'
   AND qcp.CONTRACT = '20MEX';
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_);      
      Client_SYS.Add_To_Attr('QTY_PER_ASSEMBLY', '0.0416', attr_);
      
      PROD_STRUCTURE_API.MODIFY__( info_, objid_, objversion_, attr_, 'DO' );
   END LOOP;   
END;
