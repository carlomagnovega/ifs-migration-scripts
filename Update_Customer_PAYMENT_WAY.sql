DECLARE   
   CURSOR get_qaman IS
      SELECT a.IDENTITY 
      FROM MTK_CUST_PAYMENT_WAY_TAB a
      LEFT JOIN PAYMENT_WAY_PER_IDENTITY b ON a.IDENTITY = b.IDENTITY
      AND a.company = b.company
      AND a.PARTY_TYPE_DB = b.PARTY_TYPE_DB
      WHERE b.PARTY_TYPE_DB IS NULL;
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
BEGIN
   
   FOR row_ IN get_qaman LOOP
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('COMPANY', '41-POL', attr_);
      Client_SYS.Add_To_Attr('IDENTITY', row_.IDENTITY, attr_);
      Client_SYS.Add_To_Attr('PARTY_TYPE_DB', 'CUSTOMER', attr_);
      Client_SYS.Add_To_Attr('WAY_ID', 'WIRE', attr_);
      Client_SYS.Add_To_Attr('DEFAULT_PAYMENT_WAY', 'TRUE', attr_);
      
      PAYMENT_WAY_PER_IDENTITY_API.NEW__( info_ , objid_ , objversion_ , attr_, 'DO' );
      COMMIT;
   END LOOP;   
END;
