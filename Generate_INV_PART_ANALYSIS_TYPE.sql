DECLARE
	  
	CURSOR get_data IS
      SELECT 
		   b.contract,
		   b.part_no,
		   min(a.ANALYSIS_TYPE) ANALYSIS_TYPE       
		FROM Qman_Control_Plan_Line_Tab a
		inner join QMAN_CONTROL_PLAN_INVENT b ON  a.CONTROL_PLAN_NO = b.CONTROL_PLAN_NO 
												  AND a.CTRL_PLAN_REVISION_NO = b.CTRL_PLAN_REVISION_NO
		GROUP BY b.contract,
				 b.part_no;

	info_                   VARCHAR2(2000);
   attr_                   VARCHAR2(2000);
   attr_aux_               VARCHAR2(2000);
   attr_cf_                VARCHAR2(2000);
   objid_                  VARCHAR2(30);
   objversion_             VARCHAR2(30); 
	
	
BEGIN
	  
   FOR row_line_ IN get_data LOOP
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('ANALYSIS_TYPE', row_line_.ANALYSIS_TYPE, attr_);
      Client_SYS.Add_To_Attr('CONTRACT', row_line_.contract, attr_);
      Client_SYS.Add_To_Attr('PART_NO', row_line_.part_no, attr_);
     
      INV_PART_ANALYSIS_TYPE_API.NEW__(info_, objid_, objversion_, attr_, 'DO');
     
   END LOOP;	     
   COMMIT;
END;