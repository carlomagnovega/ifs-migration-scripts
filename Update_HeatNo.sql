DECLARE   
   CURSOR get_qaman IS
      SELECT  CONTRACT,
              ORDER_NO,
              RELEASE_NO,
              SEQUENCE_NO
      FROM Shop_Ord_CFV
      WHERE OBJSTATE <> 'Closed' 
      AND OBJSTATE = 'Released'
      AND CF$_FABPLANDATE > to_date( '20200101', 'YYYYMMDD' ) + ( 1 - 1/ ( 60*60*24 ) ) AND CF$_HEAT_NO IS NULL;   
   
   attr_          VARCHAR2(2000);
   batch_desc_    VARCHAR2(100);
BEGIN
   FOR row_ IN get_qaman LOOP
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('CONTRACT', row_.contract, attr_);
      Client_SYS.Add_To_Attr('ORDER_NO', row_.order_no, attr_);
      Client_SYS.Add_To_Attr('RELEASE_NO', row_.release_no, attr_);
      Client_SYS.Add_To_Attr('SEQUENCE_NO', row_.sequence_no, attr_);
      SHOP_ORD_AIM_API.Update_HeatNo(attr_);
   END LOOP;   
END;
