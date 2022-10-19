DROP TABLE MTK_ROUTING_TEMPLATE_TAB 
CREATE TABLE MTK_ROUTING_TEMPLATE_TAB
(
   CF$_CONTRACT                       VARCHAR2(15)        NULL,
   CF$_PART_NO                        VARCHAR2(25)        NULL,
   CF$_OPERATION_NO                   VARCHAR2(25)        NULL,   
   CF$_ALTERNATIVE_ID                 VARCHAR2(100)       NULL,
   CF$_WORKCENTERID                   VARCHAR2(100)       NULL,
   CF$_CREW_SIZE                      VARCHAR2(100)       NULL,
   CF$_LABOR_CLASS_NO                 VARCHAR2(100)       NULL,
   CF$_LABOR_RUN_FACTOR               VARCHAR2(100)       NULL,
   CF$_LABOR_SETUP_TIME               VARCHAR2(100)       NULL,
   CF$_MACH_RUN_FACTOR                VARCHAR2(100)       NULL,
   CF$_MACH_SETUP_TIME                VARCHAR2(100)       NULL,
   CF$_SETUP_CREW_SIZE                VARCHAR2(100)       NULL
)

----------------------
SELECT 'INSERT INTO MTK_ROUTING_TEMPLATE_TAB (CF$_CONTRACT,CF$_PART_NO,CF$_OPERATION_NO,CF$_ALTERNATIVE_ID,CF$_WORKCENTERID,CF$_CREW_SIZE,CF$_LABOR_RUN_FACTOR,CF$_LABOR_SETUP_TIME,CF$_MACH_RUN_FACTOR,CF$_MACH_SETUP_TIME,CF$_SETUP_CREW_SIZE) VALUES (''' 
+ LTRIM(RTRIM(CONTRACT)) 
+ ''',''' + PART_NO 
+ ''',''' + ISNULL(OPERATION_NO, '') 
+ ''',''' + ISNULL(ALTERNATIVE_ID, '') 
+ ''',''' + ISNULL(WORKCENTERID, '') 
+ ''',''' + CREW_SIZE 
+ ''',''' + ISNULL(LABOR_RUN_FACTOR, '') 
+ ''',''' + ISNULL(LABOR_SETUP_TIME, '') 
+ ''',''' + ISNULL(MACH_RUN_FACTOR, '') 
+ ''',''' + ISNULL(MACH_SETUP_TIME, '') 
+ ''',''' + ISNULL(SETUP_CREW_SIZE, '') 
+  ''');' aaa  
FROM ( 
SELECT 
      '10MTL' Contract
	  ,[Part_No]
      ,[Operation_No]
      ,[Alternative_No] ALTERNATIVE_ID
      ,'' WORKCENTERID
      ,[Crew_Size]
      ,[Labor_Run_Factor]
      ,[Labor_Setup_Time]
      ,[Mach_Run_Factor]
      ,[Mach_Setup_Time]
      ,[Setup_Crew_Size]
  FROM [dbo].[Routing%]
  ) aa;
  
 -----
alter session set NLS_NUMERIC_CHARACTERS = '.,';

   
  ---------------------------------
  ---Update Casting ROUTING_OPERATION 
DECLARE   
   CURSOR get_qaman IS
      SELECT   rot.objid,
			   rot.objversion,
			   rot.PART_NO,
			   alternative_no,
			   rot.operation_no,
			   rot.work_center_no,
			   CF$_MACH_SETUP_TIME,
			   CF$_MACH_RUN_FACTOR,
			   CF$_LABOR_CLASS_NO,
			   CF$_LABOR_SETUP_TIME,
			   CF$_LABOR_RUN_FACTOR,
			   CF$_SETUP_CREW_SIZE,
			   CF$_CREW_SIZE
		FROM ROUTING_OPERATION rot
      INNER JOIN MTK_ROUTING_TEMPLATE_TAB mrt ON   mrt.CF$_CONTRACT = rot.CONTRACT AND 
                                                   mrt.CF$_PART_NO = rot.PART_NO AND 
                                                   mrt.CF$_ALTERNATIVE_ID = rot.ALTERNATIVE_NO AND 
                                                   mrt.CF$_OPERATION_NO = rot.operation_no;
   
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
      Client_SYS.Clear_Attr(attr_cf_);
      Client_SYS.Add_To_Attr('LABOR_RUN_FACTOR', row_.CF$_LABOR_RUN_FACTOR, attr_cf_);
      Client_SYS.Add_To_Attr('LABOR_SETUP_TIME', row_.CF$_LABOR_SETUP_TIME, attr_cf_);
      Client_SYS.Add_To_Attr('MACH_RUN_FACTOR', row_.CF$_MACH_RUN_FACTOR, attr_cf_);
      Client_SYS.Add_To_Attr('MACH_SETUP_TIME', row_.CF$_MACH_SETUP_TIME, attr_cf_);
      Client_SYS.Add_To_Attr('CREW_SIZE', row_.CF$_CREW_SIZE, attr_cf_);      
      Client_SYS.Add_To_Attr('SETUP_CREW_SIZE', row_.CF$_SETUP_CREW_SIZE, attr_cf_);
 
      ROUTING_OPERATION_API.MODIFY__(info_, objid_, objversion_, attr_cf_, 'DO');
      COMMIT;
   END LOOP;   
END;

--------------------------
  ---Update Casting ROUTING_OPERATION 
SELECT 'INSERT INTO MTK_ROUTING_TEMPLATE_TAB (CF$_CONTRACT,CF$_PART_NO,CF$_LABOR_RUN_FACTOR) VALUES (''' 
+ LTRIM(RTRIM(CONTRACT)) 
+ ''',''' + PART_NO 
+ ''',''' + ISNULL(LABOR_RUN_FACTOR, '') 
+  ''');' aaa  
FROM ( 
SELECT 
      '41POL' Contract
	  ,[Part_No]
      ,[Labor_Run_Factor] [Labor_Run_Factor]
  FROM [dbo].[CorrectedLaborFactor$]
  ) aa;
  
  
alter session set NLS_NUMERIC_CHARACTERS = '.,';
DECLARE   
   CURSOR get_qaman IS
      SELECT  rot.objid,
			     rot.objversion,
			     --rot.PART_NO,			   
			     min(CF$_LABOR_RUN_FACTOR) CF$_LABOR_RUN_FACTOR
		FROM ROUTING_OPERATION rot
      INNER JOIN MTK_ROUTING_TEMPLATE_TAB mrt ON   mrt.CF$_CONTRACT = rot.CONTRACT AND mrt.CF$_PART_NO = rot.PART_NO
      GROUP BY rot.objid, rot.objversion;
   
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
      Client_SYS.Clear_Attr(attr_cf_);
      Client_SYS.Add_To_Attr('LABOR_RUN_FACTOR', row_.CF$_LABOR_RUN_FACTOR, attr_cf_);
 
      ROUTING_OPERATION_API.MODIFY__(info_, objid_, objversion_, attr_cf_, 'DO');
      COMMIT;
   END LOOP;   
END;
