---Deleting Only Routings
DECLARE   
   CURSOR get_qaman IS
	    SELECT a.CONTRACT, 
			   a.PART_NO, 
			   b.objid,
			   b.objversion
		FROM INVENTORY_PART_CFV a
		INNER JOIN ROUTING_HEAD b ON a.PART_NO = b.PART_NO AND a.CONTRACT = b.CONTRACT
		WHERE a.CONTRACT = '40UK' 
		AND TYPE_CODE_DB = 1
		AND EXISTS (SELECT count(*) 
					FROM ROUTING_TEMPLATE_CLV c 
					WHERE c.CF$_CONTRACT = a.CONTRACT
					AND c.CF$_PLANNER LIKE '%' || a.PLANNER_BUYER  || '%'); 
					--HAVING count(*)  > 1); 
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000); 
BEGIN
   
   --@IgnoreTableOrViewAccess
   UPDATE routing_alternate_tab 
   SET ROWSTATE = 'Tentative'
   WHERE CONTRACT = '40UK'
   AND PART_NO IN (SELECT  a.PART_NO
					FROM INVENTORY_PART_CFV a
					INNER JOIN ROUTING_HEAD b ON a.PART_NO = b.PART_NO AND a.CONTRACT = b.CONTRACT
					WHERE a.CONTRACT = '40UK' 
					AND TYPE_CODE_DB = 1
					AND EXISTS (SELECT count(*) 
								FROM ROUTING_TEMPLATE_CLV c 
								WHERE c.CF$_CONTRACT = a.CONTRACT
								AND c.CF$_PLANNER LIKE '%' || a.PLANNER_BUYER  || '%'));
								--HAVING count(*)  > 1));
   
   FOR row_ IN get_qaman LOOP 
      BEGIN
         objid_      := row_.objid;
         objversion_ := row_.objversion;
         ROUTING_HEAD_API.REMOVE__( info_ , objid_ , objversion_ , 'DO' );       
      EXCEPTION
         WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(' failed deleting Routing_ControlPlan. Part_No: ' || row_.PART_NO);        
      END;
      COMMIT;
   END LOOP;   
END;


---Deleting
DECLARE   
   CURSOR get_qaman IS
      SELECT a.CONTRACT, 
         a.PART_NO
   FROM INVENTORY_PART_CFV a
   INNER JOIN ROUTING_HEAD b ON a.PART_NO = b.PART_NO AND a.CONTRACT = b.CONTRACT
   WHERE a.CONTRACT = '40UK' 
   AND TYPE_CODE_DB = 1;

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

------Generating Routings
DECLARE 
   CURSOR get_qaman IS	  
	  SELECT   a.CONTRACT, 
			   a.PART_NO, 
			   a.CF$_AIM_ALLOYSPEC,
			   (SELECT LISTAGG(CF$_OPERATION_NO, ',') WITHIN GROUP (ORDER BY CF$_OPERATION_NO) "OPERATION_NO"
					   FROM ROUTING_TEMPLATE_CLV c
					   WHERE c.CF$_CONTRACT = a.CONTRACT
					   AND   c.CF$_PLANNER LIKE '%' || a.PLANNER_BUYER  || '%') OPERATION_NO
		FROM INVENTORY_PART_CFV a
		LEFT JOIN ROUTING_HEAD b ON a.PART_NO = b.PART_NO AND a.CONTRACT = b.CONTRACT
		WHERE a.CONTRACT = '40UK' 
		AND TYPE_CODE_DB = 1
		AND EXISTS (SELECT count(*) 
					FROM ROUTING_TEMPLATE_CLV c 
					WHERE c.CF$_CONTRACT = a.CONTRACT
					AND c.CF$_PLANNER LIKE '%' || a.PLANNER_BUYER  || '%'
					HAVING count(*)  >= 1) 
		AND b.objid IS NULL; 					
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000);
BEGIN
   
   FOR row_ IN get_qaman LOOP
      INV_CST_AIM_API.Generate_Routing(row_.CONTRACT, row_.PART_NO, row_.OPERATION_NO);            
      COMMIT;
   END LOOP;   
END

---Buid Routings
DECLARE 
   CURSOR get_routings IS	  
		SELECT objid,
			   objversion
		FROM ROUTING_ALTERNATE a
		WHERE CONTRACT = '33CX'
		AND OBJSTATE = 'Tentative'
		AND EXISTS (SELECT 1 FROM ROUTING_OPERATION b WHERE a.contract = b.contract AND
			   a.part_no = b.part_no AND
			   a.routing_revision = b.routing_revision); 					
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000);
BEGIN   
   FOR row_ IN get_routings LOOP
         objid_      := row_.objid;
         objversion_ := row_.objversion;
         Client_SYS.Clear_Attr(info_);
         Client_SYS.Clear_Attr(attr_);
         ROUTING_ALTERNATE_API.BUILD__( info_ , objid_ , objversion_, attr_, 'DO' );      
   END LOOP;  
END;

-----------------------Generate ControlPlans
DECLARE 
   CURSOR get_qaman IS	  
      SELECT   a.CONTRACT, 
               a.PART_NO, 
               a.CF$_AIM_ALLOYSPEC
      FROM INVENTORY_PART_CFV a		
      WHERE a.CONTRACT = '40UK' 
      AND TYPE_CODE_DB = 1
      AND a.CF$_AIM_ALLOYSPEC IS NOT NULL; 					
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000);
BEGIN
   
   FOR row_ IN get_qaman LOOP
      INV_CST_AIM_API.Update_ControlPlan(row_.CF$_AIM_ALLOYSPEC, row_.PART_NO, row_.CONTRACT);
      COMMIT;
   END LOOP;   
END;



------------------------------------
SELECT
   PART_NO
   ,'20MEX' CONTRACT
   ,ROUTING_REVISION
   ,ALTERNATIVE_NO
   ,BOM_TYPE_DB
   ,OPERATION_NO
   ,RUN_TIME_CODE_DB
   ,LABOR_CLASS_NO
   ,LABOR_RUN_FACTOR
   ,LABOR_SETUP_TIME
   ,MACH_RUN_FACTOR
   ,MACH_SETUP_TIME
   ,OPERATION_DESCRIPTION
   ,OUTSIDE_OP_ITEM
   ,'' DEFAULT_BUY_UNIT_MEAS_MAP
   ,'WNDR3' WORK_CENTER_NO
   ,'' DEPARTMENT_NO
   ,MACHINE_NO
   ,CREW_SIZE
   ,LOT_QTY
   ,PARALLEL_OPERATION_DB
   ,MOVE_TIME
   ,NOTE_TEXT
   ,EFFICIENCY_FACTOR
   ,'' ROUTING_QUEUE
   ,OUTSIDE_OP_SUPPLY_TYPE_DB
   ,OUTSIDE_OP_BACKFLUSH_DB
   ,OVERLAP
   ,OVERLAP_UNIT_DB
   ,SETUP_CREW_SIZE
   ,SETUP_LABOR_CLASS_NO
FROM ROUTING_OPERATION a
WHERE ALTERNATIVE_NO = '*'
AND EXISTS (SELECT * FROM INVENTORY_PART_TAB b 
   WHERE a.PART_NO = b.PART_NO
   AND a.CONTRACT = '10MTL'
   AND b.TYPE_CODE = '1')
AND EXISTS (SELECT * FROM INVENTORY_PART_TAB c 
   WHERE a.PART_NO = c.PART_NO
   AND c.CONTRACT = '20MEX'
   AND (c.PLANNER_BUYER like 'EXTRUSION_FG_MX' or c.PLANNER_BUYER like 'EXTRUSION_SE-FG_MX')
   AND c.TYPE_CODE = '1')
   
---------------------------------- Ribon
SELECT
   PART_NO
   ,'20MEX' CONTRACT
   ,ROUTING_REVISION
   ,ALTERNATIVE_NO
   ,BOM_TYPE_DB
   ,OPERATION_NO
   ,RUN_TIME_CODE_DB
   ,LABOR_CLASS_NO
   ,LABOR_RUN_FACTOR
   ,LABOR_SETUP_TIME
   ,MACH_RUN_FACTOR
   ,MACH_SETUP_TIME
   ,OPERATION_DESCRIPTION
   ,OUTSIDE_OP_ITEM
   ,'' DEFAULT_BUY_UNIT_MEAS_MAP
   ,'RIBON' WORK_CENTER_NO
   ,'' DEPARTMENT_NO
   ,MACHINE_NO
   ,CREW_SIZE
   ,LOT_QTY
   ,PARALLEL_OPERATION_DB
   ,MOVE_TIME
   ,NOTE_TEXT
   ,EFFICIENCY_FACTOR
   ,'' ROUTING_QUEUE
   ,OUTSIDE_OP_SUPPLY_TYPE_DB
   ,OUTSIDE_OP_BACKFLUSH_DB
   ,OVERLAP
   ,OVERLAP_UNIT_DB
   ,SETUP_CREW_SIZE
   ,SETUP_LABOR_CLASS_NO
FROM ROUTING_OPERATION a
WHERE CONTRACT = '10MTL' 
AND ALTERNATIVE_NO = '*'
and (upper( INVENTORY_PART_API.Get_Planner_Buyer(contract,PART_NO) ) like upper( 'RIBBON_FG' ) or upper( INVENTORY_PART_API.Get_Planner_Buyer(contract,PART_NO) ) like upper( 'RIBBON_SE-FG' ))
AND EXISTS (SELECT * FROM INVENTORY_PART_TAB c 
   WHERE a.PART_NO = c.PART_NO
   AND c.CONTRACT = '20MEX'
   AND c.TYPE_CODE = '1')

--------------------------   
TRUNCATE TABLE [RoutingOperation]
GO 
INSERT INTO [dbo].[RoutingOperation]
           ([PART_NO]
           ,[CONTRACT]
           ,[ROUTING_REVISION]
           ,[ALTERNATIVE_NO]
           ,[BOM_TYPE_DB]
           ,[OPERATION_NO]
           ,[RUN_TIME_CODE_DB]
           ,[LABOR_CLASS_NO]
           ,[LABOR_RUN_FACTOR]
           ,[LABOR_SETUP_TIME]
           ,[MACH_RUN_FACTOR]
           ,[MACH_SETUP_TIME]
           ,[OPERATION_DESCRIPTION]
           ,[OUTSIDE_OP_ITEM]
           ,[DEFAULT_BUY_UNIT_MEAS_MAP]
           ,[WORK_CENTER_NO]
           ,[DEPARTMENT_NO]
           ,[MACHINE_NO]
           ,[CREW_SIZE]
           ,[LOT_QTY]
           ,[PARALLEL_OPERATION_DB]
           ,[MOVE_TIME]
           ,[NOTE_TEXT]
           ,[EFFICIENCY_FACTOR]
           ,[ROUTING_QUEUE]
           ,[OUTSIDE_OP_SUPPLY_TYPE_DB]
           ,[OUTSIDE_OP_BACKFLUSH_DB]
           ,[OVERLAP]
           ,[OVERLAP_UNIT_DB]
           ,[SETUP_CREW_SIZE]
           ,[SETUP_LABOR_CLASS_NO])
SELECT [PART_NO]      
      ,[CONTRACT]
	  ,[ROUTING_REVISION]
	  ,[ALTERNATIVE_NO]
	  ,[BOM_TYPE_DB]
	  ,[OPERATION_NO]
	  ,[RUN_TIME_CODE_DB]
	  ,[LABOR_CLASS_NO]
      ,[LABOR_RUN_FACTOR]
      ,[LABOR_SETUP_TIME]
      ,[MACH_RUN_FACTOR]
      ,[MACH_SETUP_TIME]
      ,[OPERATION_DESCRIPTION]
	  ,[OUTSIDE_OP_ITEM]
      ,[DEFAULT_BUY_UNIT_MEAS_MAP]
      ,[WORK_CENTER_NO]
	  ,[DEPARTMENT_NO]  
	  ,[MACHINE_NO]
      ,[CREW_SIZE]
	  ,[LOT_QTY]
	  ,[PARALLEL_OPERATION_DB]
	  ,[MOVE_TIME]
	  ,[NOTE_TEXT]
	  ,[EFFICIENCY_FACTOR]
	  ,[ROUTING_QUEUE]
	  ,[OUTSIDE_OP_SUPPLY_TYPE_DB]
	  ,[OUTSIDE_OP_BACKFLUSH_DB]
	  ,[OVERLAP]
	  ,[OVERLAP_UNIT_DB]
      ,[SETUP_CREW_SIZE]
      ,[SETUP_LABOR_CLASS_NO]
  FROM [IFSDEV-ManualUpload].[dbo].[RoutingOperationMX$]
  GO
  
TRUNCATE TABLE [dbo].[RoutingAlternate]
GO
INSERT INTO [dbo].[RoutingAlternate]
		([PART_NO]
		,[CONTRACT]
		,[ROUTING_REVISION]
		,[ALTERNATIVE_NO]
		,[BOM_TYPE_DB]
		,[PHASE_IN_DATE]
		,[ALTERNATIVE_DESCRIPTION]
		,[MTK_MODE]
		,[ROWSTATE]
		,[ROUTING_TEMPLATE_ID]
		,[USERNAME_PROMOTED]
		,[TEMPL_COPY_REFERENCE]
		,[NOTE_TEXT])
SELECT [PART_NO]
		,[CONTRACT]
		,[ROUTING_REVISION]
		,[ALTERNATIVE_NO]
		,'M' [BOM_TYPE_DB]
		,'2010-01-01' [PHASE_IN_DATE]
		,CASE [ALTERNATIVE_NO]
		WHEN '*' THEN 'STANDARD'
		ELSE [ALTERNATIVE_NO] END [ALTERNATIVE_DESCRIPTION]
		,'*' [MTK_MODE]
		,'B' [ROWSTATE]
		,'' [ROUTING_TEMPLATE_ID]
		,'' [USERNAME_PROMOTED]
		,'' [TEMPL_COPY_REFERENCE]
		,'' [NOTE_TEXT]
FROM [dbo].[RoutingOperation]
GROUP BY [PART_NO] ,[CONTRACT],[ROUTING_REVISION],[ALTERNATIVE_NO]
GO	

