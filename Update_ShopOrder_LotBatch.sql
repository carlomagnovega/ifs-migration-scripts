DECLARE   
   CURSOR get_qaman IS
      SELECT CONTRACT, ORDER_NO, RELEASE_NO, SEQUENCE_NO, revised_qty_due, part_no
      FROM SHOP_ORD a
      WHERE  NOT EXISTS (SELECT 1 FROM RESERVED_LOT_BATCH b WHERE order_ref1 = a.ORDER_NO AND 
      order_ref2 = a.RELEASE_NO AND 
      order_ref3 = a.SEQUENCE_NO)
      AND (OBJSTATE IN ('Planned''Released', 'Started', 'Reserved'));   
   
   attr_          VARCHAR2(2000);
   batch_desc_    VARCHAR2(100);
BEGIN
   FOR row_ IN get_qaman LOOP
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('CONTRACT', row_.contract, attr_);
      Client_SYS.Add_To_Attr('ORDER_NO', row_.order_no, attr_);
      Client_SYS.Add_To_Attr('RELEASE_NO', row_.release_no, attr_);
      Client_SYS.Add_To_Attr('SEQUENCE_NO', row_.sequence_no, attr_);
      Client_SYS.Add_To_Attr('PART_NO', row_.part_no, attr_);
      Client_SYS.Add_To_Attr('REVISED_QTY_DUE', row_.revised_qty_due, attr_);
      SHOP_ORD_AIM_API.Generate_LotBatch(attr_);
      
      
       Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('ORDER_NO', row_.order_no, attr_);
      Client_SYS.Add_To_Attr('LINE_NO', row_.release_no, attr_);
      Client_SYS.Add_To_Attr('REL_NO', row_.sequence_no, attr_);
      SHOP_ORD_AIM_API.Unpeg_ShopOrder(attr_);   
   END LOOP;   
END;