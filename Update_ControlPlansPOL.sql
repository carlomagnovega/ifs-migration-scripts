DECLARE 
   CURSOR get_qaman IS
      SELECT a.CONTRACT, 
             a.PART_NO, 
             a.CF$_AIM_ALLOYSPEC
      FROM INVENTORY_PART_CFV a
      WHERE a.CONTRACT = '41POL' 
      AND TYPE_CODE_DB = 1
      AND CF$_AIM_ALLOYSPEC IS NOT NULL
      AND NOT EXISTS (  SELECT 1
                        FROM QMAN_CONTROL_PLAN_tab QPT 
                        INNER JOIN INVENTORY_PART_CFV IPT ON QPT.CONTRACT = IPT.CONTRACT 
                                                            AND QPT.PART_NO = IPT.PART_NO
                        WHERE QPT.PART_NO = a.PART_NO
                        AND QPT.CONTRACT = a.CONTRACT   
                        AND QPT.ROWTYPE = 'QmanControlPlanInvent'
                        AND QPT.rowstate = 'Active'
                        AND EXISTS (SELECT 1 
                                    FROM CONTROL_PLAN_TEMPLATE_CLT CPT 
                                    WHERE CPT.CF$_SPEC_ID = IPT.CF$_AIM_ALLOYSPEC));    
   
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