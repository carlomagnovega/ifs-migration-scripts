DECLARE   
   CURSOR get_qaman IS
      SELECT objid,            
             objversion
      FROM CUSTOMER_DELIVERY_FEE_CODE
      WHERE company = '41-POL';
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000);   
BEGIN
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;      
      
      CUSTOMER_DELIVERY_FEE_CODE_API.REMOVE__(info_, objid_, objversion_, 'DO');
   END LOOP;   
END;