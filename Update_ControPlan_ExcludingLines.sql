DECLARE 
   CURSOR get_lines IS
      SELECT   QPLT.objid, 
               QPLT.objversion,                                
               QPLT.CONTROL_PLAN_NO,                                 
               QPLT.inspection_code,
               INVENTORY_PART_API.Get_Planner_Buyer(IPT.CONTRACT,IPT.PART_NO)
      FROM INVENTORY_PART_CFV IPT
      INNER JOIN QMAN_CONTROL_PLAN_tab QPT ON QPT.CONTRACT = IPT.CONTRACT AND QPT.PART_NO = IPT.PART_NO
      INNER JOIN QMAN_CONTROL_PLAN_LINE QPLT ON QPLT.control_plan_no = QPT.control_plan_no AND QPLT.ctrl_plan_revision_no = QPT.ctrl_plan_revision_no 
      INNER JOIN CONTROL_PLAN_TEMPLATE_CLV CPT ON CPT.CF$_SPEC_ID = IPT.CF$_ALLOYSPEC AND qplt.inspection_code = CPT.CF$_INSPECTION_CODE AND CPT.CF$_CONTROL_PLAN_EXCEP IS NOT NULL
      WHERE QPT.ROWTYPE = 'QmanControlPlanInvent'
      AND INVENTORY_PART_PLANNER_CFP.Get_Cf$_Control_Plan_Excep(INVENTORY_PART_PLANNER_CFP.Get_Objkey(INVENTORY_PART_API.Get_Planner_Buyer(IPT.CONTRACT,IPT.PART_NO))) IS NULL 
      AND INVENTORY_PRODUCT_CODE_CFP.Get_Cf$_Control_Plan_Excep(INVENTORY_PRODUCT_CODE_CFP.Get_Objkey(INVENTORY_PART_API.Get_Part_Product_Code(IPT.CONTRACT,IPT.PART_NO))) IS NULL;
   
   CURSOR get_qaman IS
      SELECT ROWID objid,  
             ltrim(lpad(to_char(rowversion,'YYYYMMDDHH24MISS'),2000)) objversion 
      FROM qman_control_plan_tab 
      WHERE ROWTYPE = 'QmanControlPlanInvent'
      AND ROWSTATE = 'Created';
   
   info_                   VARCHAR2(32000);
   objid_                  VARCHAR2(32000);
   objversion_             VARCHAR2(32000); 
   attr_                   VARCHAR2(32000);  
BEGIN
   
   UPDATE qman_control_plan_tab a
   SET ROWSTATE = 'Created'
   WHERE ROWTYPE = 'QmanControlPlanInvent'
   AND ROWSTATE = 'Active'
   AND EXISTS (SELECT 1 FROM INVENTORY_PART_CFV b 
   WHERE b.contract = a.contract 
   AND b.part_no = a.part_no
   AND INVENTORY_PART_PLANNER_CFP.Get_Cf$_Control_Plan_Excep(INVENTORY_PART_PLANNER_CFP.Get_Objkey(INVENTORY_PART_API.Get_Planner_Buyer(b.CONTRACT,b.PART_NO))) IS NULL 
   AND INVENTORY_PRODUCT_CODE_CFP.Get_Cf$_Control_Plan_Excep(INVENTORY_PRODUCT_CODE_CFP.Get_Objkey(INVENTORY_PART_API.Get_Part_Product_Code(b.CONTRACT,b.PART_NO))) IS NULL   
   AND EXISTS (SELECT 1 FROM CONTROL_PLAN_TEMPLATE_CLV c
   WHERE c.CF$_SPEC_ID = b.CF$_ALLOYSPEC
   AND c.CF$_CONTROL_PLAN_EXCEP IS NOT NULL));
   
   
   FOR row_lines_ IN get_lines
   LOOP
      objid_ := row_lines_.objid;
      objversion_ := row_lines_.objversion;   
      QMAN_CONTROL_PLAN_LINE_API.Remove__(info_, objid_, objversion_, 'DO'); 
   END LOOP; 
   
   FOR row_ IN get_qaman LOOP
      objid_      := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(info_);
      Client_SYS.Clear_Attr(attr_);
      QMAN_CONTROL_PLAN_API.ACTIVATE__( info_ , objid_ , objversion_, attr_, 'DO' );
   END LOOP;
   
END;