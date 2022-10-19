 --Close ShopOrders 
DECLARE   
   CURSOR get_qaman IS
      SELECT  OBJID,
              OBJVERSION,
              ORDER_NO,
              RELEASE_NO,
              SEQUENCE_NO,
              CLOSE_DATE,
              OBJSTATE
      FROM Shop_Ord
      WHERE OBJSTATE <> (SELECT SHOP_ORD_API.FINITE_STATE_ENCODE__('Closed') FROM dual)
      AND CLOSE_DATE IS NOT NULL
      AND SHOP_ORD_API.Get_Oper_State__ (Order_No, Release_no, Sequence_No) = 'Completely Reported'
      AND SHOP_ORD_API.Get_Prod_State__ (Order_No, Release_no, Sequence_No) = 'Completely Received'
      ORDER BY CONTRACT, CLOSE_DATE;   
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_ VARCHAR2(32000);
   
BEGIN
   FOR row_ IN get_qaman LOOP
      Shop_Ord_API.Close_Shop_Order(row_.order_no, row_.release_no, row_.sequence_no);
      COMMIT;
   END LOOP;   
END;