DECLARE 
   CURSOR get_qaman IS
      SELECT a.CONTRACT, 
             a.PART_NO, 
             a.CF$_AIM_ALLOYSPEC
      FROM INVENTORY_PART_CFV a
      WHERE a.CONTRACT = '40UK' 
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

------------------------------------Generate ControlPlans Headers
DECLARE 
   PART_NO_ VARCHAR2(25);
   
   CURSOR get_plan_ IS
      /*SELECT a.CONTRACT,
             a.PART_NO
      FROM INVENTORY_PART_CFV a
      WHERE CF$_ALLOYSPEC IN ('B0089S1', 'B0001S2', 'B0001S95', 'B0059S2','B0059S10','B0059S95','B0042S109','B0042S2','B0042S13','B0042S95','B0042S29','B0042S63','B0042S99','B0042S129')
	  AND TYPE_CODE_DB = '1'
      AND NOT EXISTS (SELECT 1 FROM QMAN_CONTROL_PLAN_INVENT b WHERE b.PART_NO = a.PART_NO AND b.CONTRACT = a.CONTRACT);*/
	/*SELECT a.CONTRACT,
		   a.PART_NO
	FROM INVENTORY_PART_CFV a
	WHERE CONTRACT = '20MEX'
	AND TYPE_CODE_DB = '1'	
    AND cf$_alloyspec IS NOT NULL
	AND NOT EXISTS (SELECT 1 FROM QMAN_CONTROL_PLAN_INVENT b WHERE b.PART_NO = a.PART_NO AND b.CONTRACT = a.CONTRACT); */

	SELECT a.CONTRACT,
             a.PART_NO
      FROM INVENTORY_PART_CFV a
      WHERE CF$_ALLOYSPEC IN ('B0052S2', 'B0046S2', 'B0045S95', 'B0059S2','B0048S2','B0048S95','B00186S1','B0171S2')
	  AND TYPE_CODE_DB = '1'
      AND NOT EXISTS (SELECT 1 FROM QMAN_CONTROL_PLAN_INVENT b WHERE b.PART_NO = a.PART_NO AND b.CONTRACT = a.CONTRACT);	
	   
   CURSOR get_cntrl_plan_ IS
      SELECT   CONTROL_PLAN_NO, 
               CTRL_PLAN_REVISION_NO
      FROM QMAN_CONTROL_PLAN_INVENT
      WHERE PART_NO LIKE CASE WHEN LENGTH(PART_NO_)>=9 THEN SUBSTR(PART_NO_,0,9) || '%' ELSE PART_NO_ end;
   
   CURSOR get_new_cntrl_plan_ IS
      --@IgnoreTableOrViewAccess
      SELECT 
         max(CASE WHEN LENGTH(PART_NO) >= 9 
            THEN CASE WHEN LENGTH(TRIM(TRANSLATE(nvl(SUBSTR(CONTROL_PLAN_NO,10, 2), '0'), ' +-.0123456789', ' '))) IS NULL 
                     THEN SUBSTR(PART_NO,0,9) || TRIM(TO_CHAR(TO_NUMBER(nvl(SUBSTR(CONTROL_PLAN_NO,10, 2), '0')) + 1, '00')) || 'I'
                     ELSE SUBSTR(PART_NO,0,9) || '01I' 
                  END
            ELSE SUBSTR(PART_NO,0,9) || TRIM(TO_CHAR(TO_NUMBER(nvl(SUBSTR(CONTROL_PLAN_NO,LENGTH(PART_NO)+1, LENGTH(CONTROL_PLAN_NO) - LENGTH(PART_NO) -1), '0')) + 1, '00')) || 'I'
         END)
      FROM QMAN_CONTROL_PLAN_INVENT 
      WHERE PART_NO LIKE CASE WHEN LENGTH(PART_NO_)>=9 THEN SUBSTR(PART_NO_,0,9) || '%' ELSE PART_NO_ end;
      
   info_                   VARCHAR2(32000);
   objid_                  VARCHAR2(32000);
   objversion_             VARCHAR2(32000);   
   attr_                   VARCHAR2(32000);   
   latest_revision_        VARCHAR2(4);
   sysdate_                DATE; 
   CONTROL_PLAN_NO_        VARCHAR2(100);   
   CTRL_PLAN_REVISION_NO_  VARCHAR2(10);   
BEGIN       
   sysdate_         := SYSDATE;   
   
   FOR row_ IN get_plan_ LOOP
      PART_NO_ := row_.PART_NO;
      
      OPEN get_cntrl_plan_;
      FETCH get_cntrl_plan_ INTO CONTROL_PLAN_NO_, CTRL_PLAN_REVISION_NO_;
      IF ( get_cntrl_plan_%FOUND) THEN
         OPEN get_new_cntrl_plan_;
         FETCH get_new_cntrl_plan_ INTO CONTROL_PLAN_NO_;
         IF ( get_new_cntrl_plan_%NOTFOUND) THEN
            CONTROL_PLAN_NO_ := SUBSTR(PART_NO_,0,9) || '01' || 'I';
         END IF;
         CLOSE get_new_cntrl_plan_;
      ELSE
         CONTROL_PLAN_NO_ := SUBSTR(PART_NO_,0,9) || '01' || 'I';
      END IF;
      CLOSE get_cntrl_plan_;
      CTRL_PLAN_REVISION_NO_  := 1;
      
      Client_SYS.Clear_Attr(attr_);   
      Client_SYS.Add_To_Attr('CONTROL_PLAN_NO', CONTROL_PLAN_NO_, attr_);
      Client_SYS.Add_To_Attr('CTRL_PLAN_REVISION_NO', CTRL_PLAN_REVISION_NO_, attr_);
      Client_SYS.Add_To_Attr('PART_NO', row_.PART_NO, attr_);
      Client_SYS.Add_To_Attr('CONTRACT', row_.CONTRACT, attr_);
      Client_SYS.Add_To_Attr('RESPONSIBLE_PERSON', '*', attr_);
      Client_SYS.Add_To_Attr('CTRL_PLAN_PHASE_IN_DATE', sysdate_, attr_);
      Client_SYS.Add_To_Attr('USE_CATCH_UOM_DB', 'N', attr_);
      
      QMAN_CONTROL_PLAN_INVENT_API.NEW__(info_, objid_, objversion_, attr_, 'DO'); 
      --COMMIT;
   END LOOP;
END;



------------------Validate
SELECT CF$_SPEC_ID, 
       CF$_INSPECTION_CODE,
       CF$_OUTER_MIN,
       CF$_INNER_MIN,
       CF$_NORM_VALUE,
       CF$_INNER_MAX,
       CF$_OUTER_MAX
FROM CONTROL_PLAN_TEMPLATE_CLV
WHERE  (CF$_INNER_MIN >= CF$_NORM_VALUE 
OR CF$_OUTER_MIN >= CF$_NORM_VALUE
OR CF$_OUTER_MIN > CF$_INNER_MIN
OR CF$_INNER_MAX <= CF$_NORM_VALUE 
OR CF$_OUTER_MAX <= CF$_NORM_VALUE
OR CF$_OUTER_MAX < CF$_INNER_MAX)
ORDER BY CF$_SPEC_ID, CF$_INSPECTION_CODE

---------------Generate/Update
DECLARE    
   CURSOR get_plan_ IS
      SELECT qcp.CONTRACT, 
             qcp.PART_NO, 
             qcp.CF$_AIM_ALLOYSPEC
      FROM Inventory_Part_cfv qcp 
      INNER JOIN CONTROL_PLAN_TEMPL_HEADER_CLV a ON a.CF$_SPEC_ID = trim(qcp.CF$_AIM_ALLOYSPEC)
      WHERE TYPE_CODE_DB = 1
      AND qcp.CONTRACT = '40UK'
        AND qcp.CF$_AIM_ALLOYSPEC IS NOT NULL
        AND NOT EXISTS (  SELECT 1
                          FROM QMAN_CONTROL_PLAN_tab QPT 
                          INNER JOIN INVENTORY_PART_CFV IPT ON QPT.CONTRACT = IPT.CONTRACT 
                          AND QPT.PART_NO = IPT.PART_NO
                          WHERE QPT.PART_NO = qcp.PART_NO
                          AND QPT.CONTRACT = qcp.CONTRACT   
                          AND QPT.ROWTYPE = 'QmanControlPlanInvent'
                          AND QPT.rowstate = 'Active'
                          AND EXISTS (SELECT 1 
                          FROM CONTROL_PLAN_TEMPLATE_CLT CPT 
                          WHERE CPT.CF$_SPEC_ID = IPT.CF$_AIM_ALLOYSPEC))
        AND NOT EXISTS (SELECT CF$_SPEC_ID SPEC_ID, 
                                   CF$_INSPECTION_CODE INSPECTION_CODE
                            FROM CONTROL_PLAN_TEMPLATE_CLV b
                            WHERE b.CF$_SPEC_ID = a.CF$_SPEC_ID AND 
                            (CF$_INNER_MIN >= CF$_NORM_VALUE 
                            OR CF$_OUTER_MIN >= CF$_NORM_VALUE
                            OR CF$_OUTER_MIN > CF$_INNER_MIN
                            OR CF$_INNER_MAX <= CF$_NORM_VALUE 
                            OR CF$_OUTER_MAX <= CF$_NORM_VALUE
                            OR CF$_OUTER_MAX < CF$_INNER_MAX)); 
   
   CURSOR get_norm_err_ IS
      SELECT CF$_SPEC_ID SPEC_ID, 
             CF$_INSPECTION_CODE INSPECTION_CODE
      FROM CONTROL_PLAN_TEMPLATE_CLV
      WHERE (CF$_INNER_MIN >= CF$_NORM_VALUE 
      OR CF$_OUTER_MIN >= CF$_NORM_VALUE
      OR CF$_OUTER_MIN > CF$_INNER_MIN
      OR CF$_INNER_MAX <= CF$_NORM_VALUE 
      OR CF$_OUTER_MAX <= CF$_NORM_VALUE
      OR CF$_OUTER_MAX < CF$_INNER_MAX);
   
   error_ NUMBER := 0;
BEGIN  
   FOR rec_main_ IN get_norm_err_ LOOP       
      DBMS_OUTPUT.PUT_LINE(' Error Specification: ' || rec_main_.SPEC_ID || ' Component: ' || rec_main_.INSPECTION_CODE); 
      error_ := 1;
   END LOOP;
   
   FOR row_ IN get_plan_ LOOP
      INV_CST_AIM_API.Update_ControlPlan(row_.CF$_AIM_ALLOYSPEC, row_.PART_NO, row_.CONTRACT);	  	  
      COMMIT;
   END LOOP;      
END;