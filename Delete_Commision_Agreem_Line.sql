DECLARE   
   CURSOR get_qaman IS
      SELECT a.objid,  
             a.objversion
      FROM COMMISSION_AGREE_LINE a;
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_qaman LOOP
      objid_      := row_.objid;
      objversion_ := row_.objversion;
      
      COMMISSION_AGREE_LINE_API.REMOVE__( info_ , objid_ , objversion_ , 'DO' );
      COMMIT;      
   END LOOP;   
END;