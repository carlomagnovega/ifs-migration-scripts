DECLARE   
   CURSOR get_qaman IS
      SELECT   a.objid,            
      			a.objversion,
               b.SUP_MCH_CODE,
               b.SUP_CONTRACT
      FROM  EQUIPMENT_SERIAL a
      INNER JOIN mtk_equipment_object b ON b.MCH_CODE = a.MCH_CODE 
      AND b.CONTRACT = a.CONTRACT;

   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000);   
   attr_cf_    			VARCHAR2(26000); 
   
BEGIN
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('SUP_MCH_CODE', row_.SUP_MCH_CODE, attr_);      
      Client_SYS.Add_To_Attr('SUP_CONTRACT', row_.SUP_CONTRACT, attr_);      
	  
      EQUIPMENT_SERIAL_API.MODIFY__( info_, objid_, objversion_, attr_, 'DO' ); 
      COMMIT;
   END LOOP;   
END;
