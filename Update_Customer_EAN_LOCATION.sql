DECLARE   
   CURSOR get_qaman IS
      SELECT a.objid,
             a.OBJVERSION,
             a.CUSTOMER_ID, 
             a.EAN_LOCATION || '-' || a.CUSTOMER_ID NEW_EAN_LOCATION
      FROM CUSTOMER_INFO_ADDRESS a
      WHERE ean_location='MAIN';
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000);   
BEGIN
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;      
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('EAN_LOCATION', row_.NEW_EAN_LOCATION, attr_);
      CUSTOMER_INFO_ADDRESS_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
   END LOOP;   
END;
