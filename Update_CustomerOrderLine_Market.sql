DECLARE   
   CURSOR get_qaman IS
		SELECT
			  a.objid,
			  ORDER_AIM_API.Get_Salesman_Market(ORDER_NO, PART_NO) MARKET
		FROM CUSTOMER_ORDER_LINE_CFV a
      WHERE (STATE <> 'Cancelled')
      AND CF$_AIM_SALESMAN_MARKET IS NULL;
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_qaman LOOP
      IF (row_.MARKET IS NOT NULL) THEN
         objid_ := row_.objid;
         Client_SYS.Clear_Attr(attr_cf_);
         Client_SYS.Add_To_Attr('CF$_AIM_SALESMAN_MARKET', row_.MARKET, attr_cf_); 
         CUSTOMER_ORDER_LINE_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');
         COMMIT;
      END IF;      
   END LOOP;   
END;