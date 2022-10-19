DECLARE
   SPEC_ID_                VARCHAR2(50);
   CONTROL_PLAN_NO_              VARCHAR2(40);
   CTRL_PLAN_REVISION_NO_        VARCHAR2(40);
   PART_NO_                VARCHAR2(40);
   CONTRACT_               VARCHAR2(40);
   
   CURSOR get_qman_lines_ IS
      SELECT   QPLT.objid,
               QPLT.objVERSION,
               NVL(CPT.CF$_UDB_BALANCE,'FALSE') UDB_BALANCE,
               NVL(CPT.CF$_PRINT,'FALSE') PRINT,
               CPT.CF$_DECIMALS    DECIMALS,
               CPT.CF$_INSPECTION_CODE_DESC INSPECTION_CODE_DESC,
               CPT.CF$_INNER_MIN INNER_MIN, 
               CPT.CF$_OUTER_MIN OUTER_MIN, 
               CPT.CF$_INNER_MAX INNER_MAX, 
               CPT.CF$_OUTER_MAX OUTER_MAX, 
               CPT.CF$_NORM_VALUE NORM_VALUE,
               CPT.CF$_INNER_MIN NUMBER_INNER_MIN, 
               CPT.CF$_OUTER_MIN NUMBER_OUTER_MIN, 
               CPT.CF$_INNER_MAX NUMBER_INNER_MAX, 
               CPT.CF$_OUTER_MAX NUMBER_OUTER_MAX, 
               CPT.CF$_NORM_VALUE NUMBER_NORM_VALUE
      FROM INVENTORY_PART_CFV IPT
      INNER JOIN QMAN_CONTROL_PLAN_tab QPT ON QPT.CONTRACT = IPT.CONTRACT AND QPT.PART_NO = IPT.PART_NO AND QPT.ROWTYPE = 'QmanControlPlanInvent'
      INNER JOIN QMAN_CONTROL_PLAN_LINE QPLT ON QPLT.control_plan_no = QPT.control_plan_no AND QPLT.ctrl_plan_revision_no = QPT.ctrl_plan_revision_no
      INNER JOIN CONTROL_PLAN_TEMPLATE_CLV CPT ON CPT.CF$_SPEC_ID = IPT.CF$_AIM_ALLOYSPEC AND CPT.CF$_INSPECTION_CODE = QPLT.inspection_code
      WHERE IPT.PART_NO = PART_NO_
      AND IPT.CONTRACT = CONTRACT_
      AND QPT.CONTROL_PLAN_NO = CONTROL_PLAN_NO_                   ---new
      AND QPT.CTRL_PLAN_REVISION_NO = CTRL_PLAN_REVISION_NO_;  
   
   CURSOR exist_CONTROL_PLAN_ IS 
      SELECT CONTROL_PLAN_NO,
             CTRL_PLAN_REVISION_NO
      FROM QMAN_CONTROL_PLAN_tab QPT 
      INNER JOIN INVENTORY_PART_CFV IPT ON QPT.CONTRACT = IPT.CONTRACT 
      AND QPT.PART_NO = IPT.PART_NO
      WHERE QPT.PART_NO = PART_NO_
      AND QPT.CONTRACT = CONTRACT_   
      AND QPT.ROWTYPE = 'QmanControlPlanInvent'
      AND QPT.rowstate = 'Active'
      AND EXISTS (SELECT 1 
         FROM CONTROL_PLAN_TEMPLATE_CLT CPT 
         WHERE CPT.CF$_SPEC_ID = IPT.CF$_AIM_ALLOYSPEC);  
   
   info_                   VARCHAR2(32000);
   objid_                  VARCHAR2(32000);
   objversion_             VARCHAR2(32000); 
   attr_                   VARCHAR2(32000);  
   attr_cf_                VARCHAR2(32000);  
   idum_                   PLS_INTEGER;
   dummy_                  NUMBER;
BEGIN      
   PART_NO_  := '97184';
   CONTRACT_ := '20MEX';
   
   SPEC_ID_             := INVENTORY_PART_CFP.Ref_Cf$_Aim_Alloyspec(INVENTORY_PART_CFP.Get_Cf$_aim_Alloyspec(INVENTORY_PART_CFP.Get_Objkey(contract_, part_no_)));
   
   --Add header if qman_control_plan_tab does not exists
   OPEN exist_CONTROL_PLAN_;
   FETCH exist_CONTROL_PLAN_ INTO CONTROL_PLAN_NO_, CTRL_PLAN_REVISION_NO_;
   
   UPDATE qman_control_plan_tab 
   SET ROWSTATE = 'Created'
   WHERE CONTRACT = CONTRACT_
   AND PART_NO = PART_NO_
   AND CONTROL_PLAN_NO = CONTROL_PLAN_NO_                   ---new
   AND CTRL_PLAN_REVISION_NO = CTRL_PLAN_REVISION_NO_       ---new
   AND ROWTYPE = 'QmanControlPlanInvent'
   AND ROWSTATE = 'Active';  
   
   FOR row_ IN get_qman_lines_ 
   LOOP      
      --Update CustomFields
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIMBALANCE_DB', row_.UDB_BALANCE, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIMPRINT_DB', row_.PRINT, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIMDECIMAL', row_.DECIMALS, attr_cf_);
      QMAN_CONTROL_PLAN_LINE_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');        
      
      Client_SYS.Clear_Attr(attr_);      
      Client_SYS.Add_To_Attr('TEST_OPERATION_DESCRIPTION', row_.INSPECTION_CODE_DESC, attr_);
      Client_SYS.Add_To_Attr('INSPECTION_CODE_DESC', row_.INSPECTION_CODE_DESC, attr_);
      Client_SYS.Add_To_Attr('OUTER_MIN', row_.OUTER_MIN, attr_);
      Client_SYS.Add_To_Attr('INNER_MIN', row_.INNER_MIN, attr_);
      Client_SYS.Add_To_Attr('OUTER_MAX', row_.OUTER_MAX, attr_);
      Client_SYS.Add_To_Attr('INNER_MAX', row_.INNER_MAX, attr_);
      Client_SYS.Add_To_Attr('NORM_VALUE', row_.NORM_VALUE, attr_);
      Client_SYS.Add_To_Attr('NUMBER_OUTER_MIN', row_.NUMBER_OUTER_MIN, attr_);
      Client_SYS.Add_To_Attr('NUMBER_INNER_MIN', row_.NUMBER_INNER_MIN, attr_);
      Client_SYS.Add_To_Attr('NUMBER_OUTER_MAX', row_.NUMBER_OUTER_MAX, attr_);
      Client_SYS.Add_To_Attr('NUMBER_INNER_MAX', row_.NUMBER_INNER_MAX, attr_);
      Client_SYS.Add_To_Attr('NUMBER_NORM_VALUE', row_.NUMBER_NORM_VALUE, attr_);
      
      QMAN_CONTROL_PLAN_LINE_API.Modify__(info_, objid_, objversion_, attr_, 'DO');        
   END LOOP;   
   
   UPDATE qman_control_plan_tab 
   SET ROWSTATE = 'Active'
   WHERE CONTRACT = CONTRACT_
   AND PART_NO = PART_NO_
   AND CONTROL_PLAN_NO = CONTROL_PLAN_NO_                   ---new
   AND CTRL_PLAN_REVISION_NO = CTRL_PLAN_REVISION_NO_       ---new
   AND ROWTYPE = 'QmanControlPlanInvent'
   AND ROWSTATE = 'Created';    
END;
