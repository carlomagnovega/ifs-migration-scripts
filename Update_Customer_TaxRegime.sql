DECLARE   
   CURSOR get_qaman IS
      SELECT objid,            
             objversion
      FROM CUSTOMER_TAX_INFO
      WHERE company = '41-POL';
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000);   
BEGIN
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;      
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('TAX_REGIME', 'VAT', attr_);
      
      CUSTOMER_TAX_INFO_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
   END LOOP;   
END;