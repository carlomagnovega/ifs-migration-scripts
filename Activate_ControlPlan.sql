DECLARE    
   CURSOR get_plan_ IS
      SELECT objid, objversion, contract, PART_NO, CONTROL_PLAN_NO, CTRL_PLAN_REVISION_NO
      FROM QMAN_CONTROL_PLAN_INVENT a
      WHERE actived_date IS NULL
      AND EXISTS (SELECT 1 FROM QMAN_CTRL_PLAN_LINE_FULL b WHERE a.CONTROL_PLAN_NO = b.CONTROL_PLAN_NO AND a.CTRL_PLAN_REVISION_NO = b.CTRL_PLAN_REVISION_NO )
      ORDER BY objversion desc;   
   
   info_                   VARCHAR2(32000);
   objid_                  VARCHAR2(32000);
   objversion_             VARCHAR2(32000);   
   attr_                   VARCHAR2(32000);   
BEGIN         
   FOR row_ IN get_plan_ LOOP
      /*
      UPDATE qman_control_plan_tab 
      SET ROWSTATE = 'Created'
      WHERE CONTRACT = row_.CONTRACT
      AND PART_NO = row_.PART_NO
      AND CONTROL_PLAN_NO = row_.CONTROL_PLAN_NO                   ---new
      AND CTRL_PLAN_REVISION_NO = row_.CTRL_PLAN_REVISION_NO       ---new
      AND ROWTYPE = 'QmanControlPlanInvent'
      AND ROWSTATE = 'Active'; 
      */
      
      info_ := '';
      objid_ := row_.objid;
      objversion_ := row_.objversion;   
      attr_ := '';
      
      QMAN_CONTROL_PLAN_INVENT_API.Activate__(info_, objid_, objversion_, attr_, 'DO');	  	  
      COMMIT;
   END LOOP;
END;

