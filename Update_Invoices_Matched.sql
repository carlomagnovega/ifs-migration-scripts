DECLARE   
   CURSOR get_qaman IS
	  SELECT ICFV.OBJID
	  FROM CUSTOMER_ORDER_INV_HEAD_UIV COIH 
	  INNER JOIN INVOICE_CFV ICFV ON COIH.OBJKEY = ICFV.OBJKEY
	  INNER JOIN (SELECT INVOICE_ID, SUM(NVL(INVOICE_ITEM_CFP.GET_CF$_AIM_FREIGHT_COST(OBJKEY), 0)) FREIGHT
				  FROM CUSTOMER_ORDER_INV_ITEM_UIV
				  WHERE DECODE(NVL(CHARGE_SEQ_NO, RMA_CHARGE_NO) ,NULL, 'FALSE', 'TRUE') = 'TRUE'
				  AND SALES_CHARGE_TYPE_API.Get_Sales_Chg_Type_Category_db(CONTRACT, catalog_no) = 'FREIGHT'
				  GROUP BY INVOICE_ID) COII ON COIH.INVOICE_ID = COII.INVOICE_ID 
	  WHERE ICFV.OBJSTATE <> 'Posted'
	  AND ICFV.CF$_AIM_MATCHED_INV IS NULL
	  AND NVL(COII.FREIGHT, ICFV.CF$_AIM_ACCRUAL_AMT ) <> 0
      AND trunc(COIH.LATEST_DELIVERY_DATE) < ADD_MONTHS(SYSDATE, -3);
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      Client_SYS.Clear_Attr(attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIM_MATCHED_INV', 'Forced Matched', attr_cf_);     
 
      INVOICE_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');
      COMMIT;
   END LOOP;   
END;