----Update ControPlan_Part CustomFields
----Update ControPlan_Part CustomFields
DECLARE   
   CURSOR get_qaman IS
      SELECT
		   qcp.objid,
		   qcp.inspection_code,
		   qcp.CF$_AIMPRINT PRIN,
		   qcp.CF$_AIMDECIMAL DECIM,
		   inv.CF$_ALLOYSPEC,
		   inv.PLANNER_BUYER,
		   qph.ROWSTATE   
		FROM  Inventory_Part_CFV inv  
		INNER JOIN qman_control_plan_tab qph ON inv.PART_NO = qph.PART_NO 
											  AND inv.CONTRACT = qph.CONTRACT 
		INNER JOIN QMAN_CTRL_PLAN_LINE_FULL_CFV qcp ON qcp.CONTROL_PLAN_NO = qph.CONTROL_PLAN_NO 
		AND qcp.CTRL_PLAN_REVISION_NO = qph.CTRL_PLAN_REVISION_NO
		WHERE inv.CONTRACT = '10MTL' 
		AND PLANNER_BUYER IN ('FLUX_FG', 'FLUX_RAW', 'FLUX_SE-FG', 'MEDIUM_FG', 'MEDIUM_SE-FG')
		--AND (qcp.CF$_AIMPRINT IS NULL OR qcp.CF$_AIMPRINT = 'False');
        AND (qcp.CF$_AIMDECIMAL IS NULL);
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      Client_SYS.Clear_Attr(attr_cf_);
      --Client_SYS.Add_To_Attr('CF$_AIMPRINT_DB', 'TRUE', attr_cf_);
	  Client_SYS.Add_To_Attr('CF$_AIMDECIMAL', '4', attr_cf_);
      
      QMAN_CONTROL_PLAN_LINE_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');
      COMMIT;
   END LOOP;   
END;