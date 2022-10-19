--Validate Control Plans
SELECT CF$_SPEC_ID,
       CF$_TEST_OPERATION_NO,
       CF$_OUTER_MIN,
       CF$_INNER_MIN,
       CF$_NORM_VALUE,
       CF$_INNER_MAX,
       CF$_OUTER_MAX
FROM CONTROL_PLAN_TEMPLATE_CLt 
WHERE (CF$_INNER_MIN >= CF$_NORM_VALUE 
OR CF$_OUTER_MIN >= CF$_NORM_VALUE
OR CF$_OUTER_MIN > CF$_INNER_MIN
OR CF$_INNER_MAX <= CF$_NORM_VALUE 
OR CF$_OUTER_MAX <= CF$_NORM_VALUE
OR CF$_OUTER_MAX < CF$_INNER_MAX);

---- Add SCREEN lines
DECLARE   
   CURSOR get_qaman IS
      SELECT 
              CF$_ALLOYSPEC  CF$_SPEC_ID,
              250 CF$_TEST_OPERATION_NO,
              'SCREEN' CF$_INSPECTION_CODE,
              'Screen' CF$_INSPECTION_CODE_DESC,
              1 CF$_SAMPLE_PERCENT,
              -0.0001 CF$_INNER_MIN,
              -0.0001 CF$_OUTER_MIN,
              0 CF$_NORM_VALUE,
              0.01 CF$_INNER_MAX,
              0.01 CF$_OUTER_MAX,
              'FALSE' CF$_UDB_BALANCE,
              'FALSE' CF$_PRINT,
              4 CF$_DECIMALS
      FROM INVENTORY_PART_CFV IPT
      INNER JOIN CONTROL_PLAN_TEMPL_HEADER_CLT CPT ON CPT.CF$_SPEC_ID = IPT.CF$_ALLOYSPEC
      WHERE ((PLANNER_BUYER LIKE 'POWDER_FG' OR PLANNER_BUYER LIKE 'POWDER_SE-FG' ))
      AND IPT.CF$_ALLOYSPEC <> 'DEFAULT'
      AND IPT.CF$_ALLOYSPEC IS NOT NULL
      AND NOT EXISTS (SELECT 1 FROM CONTROL_PLAN_TEMPLATE_CLT CLPT 
                     WHERE CLPT.CF$_SPEC_ID = IPT.CF$_ALLOYSPEC
                     AND CLPT.CF$_INSPECTION_CODE = 'SCREEN')
      GROUP BY CF$_ALLOYSPEC; 
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_qaman LOOP
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('CF$_DECIMALS', row_.CF$_DECIMALS, attr_);
      Client_SYS.Add_To_Attr('CF$_INNER_MAX', row_.CF$_INNER_MAX, attr_);
      Client_SYS.Add_To_Attr('CF$_INNER_MIN', row_.CF$_INNER_MIN, attr_);
      Client_SYS.Add_To_Attr('CF$_INSPECTION_CODE', row_.CF$_INSPECTION_CODE, attr_);
      Client_SYS.Add_To_Attr('CF$_INSPECTION_CODE_DESC', row_.CF$_INSPECTION_CODE_DESC, attr_);
      Client_SYS.Add_To_Attr('CF$_NORM_VALUE', row_.CF$_NORM_VALUE, attr_);
      Client_SYS.Add_To_Attr('CF$_OUTER_MAX', row_.CF$_OUTER_MAX, attr_);
      Client_SYS.Add_To_Attr('CF$_OUTER_MIN', row_.CF$_OUTER_MIN, attr_);
      Client_SYS.Add_To_Attr('CF$_PRINT', row_.CF$_PRINT, attr_);
      Client_SYS.Add_To_Attr('CF$_SAMPLE_PERCENT', row_.CF$_SAMPLE_PERCENT, attr_);
      Client_SYS.Add_To_Attr('CF$_SPEC_ID', row_.CF$_SPEC_ID, attr_);
      Client_SYS.Add_To_Attr('CF$_TEST_OPERATION_NO', row_.CF$_TEST_OPERATION_NO, attr_);
      Client_SYS.Add_To_Attr('CF$_UDB_BALANCE', row_.CF$_UDB_BALANCE, attr_);
      
      CONTROL_PLAN_TEMPLATE_CLP.New__(info_, objid_, objversion_, attr_, 'DO');
      COMMIT;
   END LOOP;   
END;

-----
UPDATE CONTROL_PLAN_TEMPLATE_CLT SET CF$_CONTROL_PLAN_EXCEP = 'Powder'
WHERE CF$_INSPECTION_CODE = 'SCREEN'
AND CF$_CONTROL_PLAN_EXCEP IS NULL

------- Update QMAN already generated
DECLARE   
   CURSOR get_qaman IS
	select CF$_ALLOYSPEC ALLOY
      from INVENTORY_PART_CFV 
      where ((PLANNER_BUYER like 'POWDER_FG' or PLANNER_BUYER like 'POWDER_SE-FG' ))
      AND CF$_ALLOYSPEC <> 'DEFAULT'
      AND CF$_ALLOYSPEC IS NOT NULL
      GROUP BY CF$_ALLOYSPEC;   
BEGIN
   FOR row_ IN get_qaman LOOP
      INV_CST_AIM_API.Update_ControlPlan(row_.ALLOY);
      COMMIT;
   END LOOP;   
END;