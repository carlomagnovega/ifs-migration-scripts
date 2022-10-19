DECLARE   
   CURSOR get_qaman IS
	  SELECT ORDER_NO
     FROM CUSTOMER_ORDER 
     WHERE STATE NOT IN ('Cancelled', 'Invoiced/Closed');
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);   
   FOR row_ IN get_qaman LOOP
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('ORDER_NO', row_.ORDER_NO, attr_);    
 
      ORDER_AIM_API.Add_Commissions(attr_);
      COMMIT;
   END LOOP;   
END;