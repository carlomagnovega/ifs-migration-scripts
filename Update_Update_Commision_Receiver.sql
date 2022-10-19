---------------------------------
---Update Commision Receiver
DECLARE   
   CURSOR get_qaman IS
    select a.customer_id,
			 b.commission_receiver
	from CUST_ORD_CUSTOMER_ENT a,
		   COMMISSION_RECEIVER  b 
	WHERE a.commission_receiver <> b.commission_receiver
		AND NOT EXISTS (SELECT 1 FROM CUST_DEF_COM_RECEIVER c WHERE c.commission_receiver = b.commission_receiver AND c.customer_no = a.customer_id)
		--AND a.commission_receiver = 'Create'
	ORDER BY a.customer_id, b.commission_receiver;
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_qaman LOOP
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('CUSTOMER_NO', row_.customer_id, attr_);
      Client_SYS.Add_To_Attr('COMMISSION_RECEIVER', row_.commission_receiver, attr_);
 
      CUST_DEF_COM_RECEIVER_API.NEW__(info_, objid_, objversion_, attr_, 'DO');
      COMMIT;
   END LOOP;   
END;