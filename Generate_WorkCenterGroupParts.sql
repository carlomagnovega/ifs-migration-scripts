DECLARE   
   CURSOR get_qaman IS
      SELECT
         a.CONTRACT,
         a.PART_NO,
         b.CF$_WORK_CENTER_GRP WORK_CENTER_GRP,
         b.CF$_WORK_CENTER_NO WORK_CENTER_NO,
         min(d.LABOR_RUN_FACTOR) LABOR_RUN_FACTOR,
         min(d.LABOR_SETUP_TIME) LABOR_SETUP_TIME,
         min(d.MACH_RUN_FACTOR) MACH_RUN_FACTOR,
         min(d.MACH_SETUP_TIME) MACH_SETUP_TIME,
         min(d.CREW_SIZE) CREW_SIZE,
         min(d.SETUP_CREW_SIZE) SETUP_CREW_SIZE
      FROM INVENTORY_PART_CFV a
      inner JOIN WORK_CENTER_GROUP_LINES_CLV b ON b.CF$_CONTRACT = a.CONTRACT AND b.CF$_WORK_CENTER_GRP = '&WORK_CENTER_GRP'
      LEFT OUTER JOIN WORK_CENTER_GROUP_PARTS_CLV c ON c.CF$_CONTRACT = a.CONTRACT AND c.CF$_PART_NO = a.PART_NO
      LEFT OUTER JOIN ROUTING_OPERATION d ON a.PART_NO = d.PART_NO AND d.CONTRACT = a.CONTRACT
      WHERE  b.CF$_CONTRACT = '&CONTRACT'
         AND a.PART_STATUS = 'A'
         AND a.type_code_db = '1'
         AND INSTR('&PLANNER_BUYER', a.PLANNER_BUYER) > 0
         AND ('&LEADTYPE' IS NULL OR a.CF$_AIM_LEADTYPE = '&LEADTYPE' )
         AND c.CF$_PART_NO IS NULL
      GROUP BY a.CONTRACT,
         a.PART_NO,
         b.CF$_WORK_CENTER_GRP,
         b.CF$_WORK_CENTER_NO;
   
   info_                VARCHAR2(32000);
   objkey_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_qaman LOOP
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('CF$_CONTRACT', row_.CONTRACT, attr_);
      Client_SYS.Add_To_Attr('CF$_PART_NO', row_.PART_NO, attr_);
      Client_SYS.Add_To_Attr('CF$_WORK_CENTER_GRP', row_.WORK_CENTER_GRP, attr_);
      Client_SYS.Add_To_Attr('CF$_WORK_CENTER_NO', row_.WORK_CENTER_NO, attr_);
      
      Client_SYS.Add_To_Attr('CF$_LABOR_RUN_FACTOR', row_.LABOR_RUN_FACTOR, attr_);
      Client_SYS.Add_To_Attr('CF$_LABOR_SETUP_TIME', row_.LABOR_SETUP_TIME, attr_);
      Client_SYS.Add_To_Attr('CF$_MACH_RUN_FACTOR', row_.MACH_RUN_FACTOR, attr_);
      Client_SYS.Add_To_Attr('CF$_MACH_SETUP_TIME', row_.MACH_SETUP_TIME, attr_);
      Client_SYS.Add_To_Attr('CF$_CREW_SIZE', row_.CREW_SIZE, attr_);
      Client_SYS.Add_To_Attr('CF$_SETUP_CREW_SIZE', row_.SETUP_CREW_SIZE, attr_);
      
      WORK_CENTER_GROUP_PARTS_CLP.New__(info_, objkey_, objversion_, attr_, 'DO');
   END LOOP;   
END;
