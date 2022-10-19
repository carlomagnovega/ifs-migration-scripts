DECLARE   
   CURSOR get_qaman IS
      SELECT    
         pol.order_no,
         pol.line_no,
         pol.release_no
      FROM  purchase_order_line_TAB pol 
      INNER JOIN purchase_order_TAB poh ON pol.order_no = poh.order_no                             
      
      LEFT JOIN CUSTOMER_ORDER_LINE_TAB col ON  col.order_no = pol.DEMAND_ORDER_NO
      AND col.line_no = pol.DEMAND_RELEASE
      AND col.rel_no = pol.DEMAND_SEQUENCE_NO
      LEFT JOIN CUSTOMER_ORDER_TAB coh ON col.order_no = coh.order_no 
      
      INNER JOIN CUSTOMER_ORDER_LINE_TAB col_ref ON col_ref.demand_order_ref1 = pol.ORDER_NO
      AND col_ref.demand_order_ref2 = pol.line_no
      AND col_ref.demand_order_ref3 = pol.release_no                        
      INNER JOIN CUSTOMER_ORDER_TAB coh_ref ON col_ref.order_no = coh_ref.order_no                                               
      
      LEFT JOIN document_text dph ON dph.note_id = poh.note_id   
      LEFT JOIN document_text dph_ref ON dph_ref.note_id = coh_ref.note_id AND dph_ref.output_type = dph.output_type 
      
      LEFT JOIN document_text dpl ON dpl.note_id = pol.note_id
      LEFT JOIN document_text dpl_ref ON dpl_ref.note_id = col_ref.note_id AND dpl_ref.output_type = dpl.output_type
      
      WHERE col_ref.DEMAND_CODE IN ('IPT', 'IPD')
      AND col_ref.ROWSTATE NOT IN ('Invoiced', 'Cancelled')
      AND (dph.note_text <> NVL(dph_ref.note_text, '---') OR dpl.note_text <> NVL(dpl_ref.note_text, '---')   OR    pol.PROMISED_DELIVERY_DATE <> col_ref.PROMISED_DELIVERY_DATE )
      GROUP BY pol.order_no, pol.line_no, pol.release_no  ;   
   
   attr_          VARCHAR2(2000);
   batch_desc_    VARCHAR2(100);
BEGIN
   FOR row_ IN get_qaman LOOP
      Client_SYS.Clear_Attr(attr_);      
      Client_SYS.Add_To_Attr('ORDER_NO', row_.ORDER_NO, attr_);
      Client_SYS.Add_To_Attr('LINE_NO', row_.LINE_NO, attr_);
      Client_SYS.Add_To_Attr('RELEASE_NO', row_.RELEASE_NO, attr_);
      PURCH_AIM_API.Update_PurchaseOrderLine(attr_);  
   END LOOP;   
END;