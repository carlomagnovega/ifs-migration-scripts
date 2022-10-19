DECLARE   
   CURSOR get_qaman IS
      SELECT  
         a.objid, 
         a.objversion,
         a.SUPPLIER_ID
      FROM IDENTITY_INVOICE_INFO  a
      INNER JOIN SUPPLIER_INFO b ON a.SUPPLIER_ID = b.SUPPLIER_ID
      WHERE a.SUPPLIER_ID BETWEEN '6500' AND '7300'
      AND a.company = '41-POL'
      AND b.country = 'POLAND'
      AND (TAX_ID_TYPE IS NULL OR TAX_ID_TYPE <> 'NIP');
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
BEGIN
   
   FOR row_ IN get_qaman LOOP
      objid_      := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('TAX_ID_TYPE', 'NIP', attr_);
      
      IDENTITY_INVOICE_INFO_API.MODIFY__( info_ , objid_ , objversion_ , attr_, 'DO' );
      COMMIT;
   END LOOP;   
END;


