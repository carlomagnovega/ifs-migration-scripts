----Print INvoices
DECLARE   
   CURSOR get_qaman IS
      SELECT invoice_id
      FROM CUSTOMER_ORDER_INV_HEAD_UIV
      WHERE upper( CLIENT_STATE ) LIKE upper( 'Post%' ) 
      AND CONTRACT = '10MTL' 
      AND ORDER_DATE BETWEEN to_date( '20220131', 'YYYYMMDD' ) AND to_date( '20220225', 'YYYYMMDD' ) + ( 1 - 1/ ( 60*60*24 ) );
      --AND ROWNUM < 2;   
   
   attr_          VARCHAR2(3200);
   print_job_id_  NUMBER;
   SYSDATE_       VARCHAR2(100);
   
BEGIN
   FOR row_ IN get_qaman LOOP
      SYSDATE_ := LOCALTIMESTAMP;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('INVOICE_ID', row_.invoice_id, attr_);
      Client_SYS.Add_To_Attr('SYSDATE1', SYSDATE_, attr_);
      SHOP_ORD_AIM_API.Create_Print_Jobs(print_job_id_, NULL, 'CUSTOMER_ORDER_COLL_IVC_REP', attr_);
      SHOP_ORD_AIM_API.Printing_Print_Jobs(print_job_id_);
      print_job_id_ := NULL;
      COMMIT;
   END LOOP;   
END;
