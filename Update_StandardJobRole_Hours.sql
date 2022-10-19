DECLARE   
   CURSOR get_qaman IS
      SELECT a.PLANNED_HOURS,
            b.objid,            
            b.objversion
      FROM mtk_standard_job_role_tab a
      INNER JOIN standard_job_role b ON a.STD_JOB_ID = b.STD_JOB_ID AND 
            a.STD_JOB_CONTRACT = b.STD_JOB_CONTRACT AND
            a.STD_JOB_REVISION = b.STD_JOB_REVISION AND
            a.ROW_NO = b.ROW_NO
      WHERE a.PLANNED_HOURS <>  b.PLANNED_HOURS;

   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000);   
   
BEGIN
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('PLANNED_HOURS', row_.PLANNED_HOURS, attr_);      
      
      STANDARD_JOB_ROLE_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      COMMIT;
   END LOOP;   
END;