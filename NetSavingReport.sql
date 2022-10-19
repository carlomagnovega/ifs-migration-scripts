SELECT issue_times,
   invoice_no,
   company,
   po_ref_number,
   invoice_date,
   Supplier_id,
   Supplier_Name,
   Invoice_Identity,
   Currency Original_Currency,
   Lead_Type,
   part_no,
   description,      
   lot_batch_no,
   --wdr,   
   Arrived_Qty,
   metal_rec,
   Purchase_Price,
   Paid_Amount,
   order_no,
   release_no,
   sequence_no,
   Lot_Size,
   UoM,
   Lot_No,
   Perc_Receiv,
   ANALYSIS_NO,
   SN_perc,
   PB_perc,
   AG_perc,
   AU_perc,
   Sn_Price, 
   Pb_Price, 
   AG_Price, 
   AU_Price,
   SN_perc * metal_rec / 100.0 Weight_Sn,
   PB_perc * metal_rec / 100.0 Weight_Pb,
   AG_perc * metal_rec / 100.0 Weight_Ag,
   AU_perc * metal_rec / 100.0 Weight_Au,
   (SN_Price * SN_perc * metal_rec / 100.0) + 
   (PB_Price * PB_perc * metal_rec / 100.0) +  
   (AG_Price * AG_perc * metal_rec / 100.0) +  
   (AU_Price * AU_perc * metal_rec / 100.0) Total_Metal_Value,
   0.2 Net_Cost,
   metal_rec * 0.2 Value_Net_Cost,
   Arrived_Qty * 0.1 Freight ,
   CASE WHEN sales.quantity > 0 THEN sales.ammount / sales.quantity ELSE 0 END Avg_Resale_Price,       
   sales.quantity Total_Resale_Qty,       
   sales.ammount Total_Resale_Value,
   sales.date_applied,
   sales.customer_no Sold_to_Customer,
   metal_rec - nvl(sales.quantity,0) Qty_Internal_Use,
   (SN_Price * SN_perc * metal_rec / 100.0) + (PB_Price * PB_perc * metal_rec / 100.0) +  (AG_Price * AG_perc * metal_rec / 100.0) +  (AU_Price * AU_perc * metal_rec / 100.0) - (metal_rec * 0.2) - Paid_Amount Projected_Profit,
   (metal_rec - nvl(sales.quantity,0)) / metal_rec * ((SN_Price * SN_perc * metal_rec / 100.0) + (PB_Price * PB_perc * metal_rec / 100.0) +  (AG_Price * AG_perc * metal_rec / 100.0) +  (AU_Price * AU_perc * metal_rec / 100.0) - (metal_rec * 0.2) - Paid_Amount) Net_Saving_Scrap_Usage   
FROM (SELECT
         msi.invoice_no,
         msi.company,
         msi.po_ref_number,
         msi.invoice_date,
         msi.identity Supplier_id,
         Supplier_Info_API.Get_Name(msi.IDENTITY) Supplier_Name,
         msi.series_id Invoice_Identity,
         msi.Currency,
   
         inventory_part_cfp.Get_Cf$_Aim_Leadtype(inventory_part_cfp.Get_Objkey(so.contract, issue.part_no)) Lead_Type,
         issue.part_no,
         INVENTORY_PART_API.Get_Description(so.Contract,issue.PART_NO) description,      
         issue.lot_batch_no,
         --c.waiv_dev_rej_no wdr,   
         issue.pur_qty_in_store Arrived_Qty,
         CASE WHEN mh.issue_times > 1 THEN issue.pur_qty_in_store * 0.9
         ELSE subst.inventory_qty + byprod.inventory_qty * 0.8
         END metal_rec,
         issue.Paid_Amount/issue.pur_qty_in_store Purchase_Price,
         issue.Paid_Amount,
         so.order_no,
         so.release_no,
         so.sequence_no,
         so.qty_complete Lot_Size,
         INVENTORY_PART_API.Get_Unit_Meas(so.Contract,so.PART_NO) UoM,
         so.CF$_HEAT_NO Lot_No,
         issue.pur_qty_in_store / so.qty_complete Perc_Receiv,
         ANAL.ANALYSIS_NO,
         to_number(ANL_REQ_AIM_API.Get_Analysis_Result(ANAL.ANALYSIS_NO, 'SN')) SN_perc,
         to_number(ANL_REQ_AIM_API.Get_Analysis_Result(ANAL.ANALYSIS_NO, 'PB')) PB_perc,
         to_number(ANL_REQ_AIM_API.Get_Analysis_Result(ANAL.ANALYSIS_NO, 'AG')) AG_perc,
         to_number(ANL_REQ_AIM_API.Get_Analysis_Result(ANAL.ANALYSIS_NO, 'AU')) AU_perc,
         NVL(INV_CST_AIM_API.Get_Market_Sales_Price('SN', msi.invoice_date), 0) Sn_Price, 
         NVL(INV_CST_AIM_API.Get_Market_Sales_Price('PB', msi.invoice_date), 0) Pb_Price, 
         NVL(INV_CST_AIM_API.Get_Market_Sales_Price('AG', msi.invoice_date), 0) AG_Price, 
         NVL(INV_CST_AIM_API.Get_Market_Sales_Price('AU', msi.invoice_date), 0) AU_Price,
         mh.issue_times 
FROM (SELECT order_ref1, order_ref2, order_ref3, part_no, lot_batch_no, invoice_id, pur_qty_in_store, Paid_Amount
      FROM( SELECT   mh.order_ref1, 
                     mh.order_ref2, 
                     mh.order_ref3, 
                     mh.part_no,
                     mh.lot_batch_no,
                     msi.invoice_id,
                     sum(CASE mh.MATERIAL_HISTORY_ACTION_DB WHEN 'ISSUE' THEN mh.INVENTORY_QTY WHEN 'UNISSUE' THEN -mh.INVENTORY_QTY ELSE 0 END) QTY_ISSUED,
                     sum(pur_qty_in_store) pur_qty_in_store,
                     sum(Currency_Rate_API.Get_Currency_Rate( '11-RI', poi.currency_code, 1, msi.invoice_date) * ROUND((((poi.FUNIT_PRICE_PAID/poi.PRICE_CONV_FACTOR * (1 - poi.DISCOUNT/100)) * poi.QTY_INVOICED) + poi.ADDITIONAL_COST) , Currency_Code_API.Get_Currency_Rounding(Site_API.Get_Company(poi.CONTRACT), poi.CURRENCY_CODE)))  Paid_Amount
            FROM MATERIAL_HISTORY mh
            INNER JOIN RECEIPT_INVENTORY_LOCATION ril ON 
                              mh.part_no = ril.part_no AND
                              mh.contract =ril.contract AND
                              mh.configuration_id = ril.configuration_id AND
                              mh.location_no = ril.location_no AND
                              mh.lot_batch_no = ril.lot_batch_no AND
                              mh.serial_no = ril.serial_no AND
                              mh.eng_chg_level = ril.eng_chg_level AND
                              mh.waiv_dev_rej_no = ril.waiv_dev_rej_no AND
                              mh.activity_seq = ril.activity_seq
            INNER JOIN PURCHASE_ORDER_INVOICE poi ON 
                              poi.order_no = ril.order_no AND 
                              poi.line_no = ril.line_no AND 
                              poi.release_no = ril.release_no AND 
                              poi.receipt_no = ril.receipt_no
            INNER JOIN MAN_SUPP_INVOICE msi ON msi.invoice_id = poi.invoice_id                  
            WHERE mh.MATERIAL_HISTORY_ACTION_DB IN ('ISSUE', 'UNISSUE') 
            AND mh.part_no NOT IN ('65301', '65306', '89015', '89016', '89015-1', '89015-2', '89015-3', '89015-4')
            AND mh.lot_batch_no <> '*'
            AND msi.po_ref_number LIKE 'W%'
            GROUP BY mh.order_ref1, mh.order_ref2, mh.order_ref3, mh.part_no, mh.lot_batch_no, msi.invoice_id)
            WHERE QTY_ISSUED > 0) issue
            
INNER JOIN MAN_SUPP_INVOICE msi ON msi.invoice_id = issue.invoice_id
            
---ShopOrder
INNER JOIN SHOP_ORD_CFV so ON so.order_no = issue.order_ref1 AND
       so.release_no = issue.order_ref2 AND
       so.sequence_no = issue.order_ref3 AND        
       so.part_no = '99999'
       
-----Material History Issue       
INNER JOIN (SELECT order_ref1, order_ref2, order_ref3, count(*) issue_times
            FROM MATERIAL_HISTORY 
            WHERE MATERIAL_HISTORY_ACTION_DB IN ('ISSUE') 
               AND part_no NOT IN ('65301', '65306', '89015', '89016', '89015-1', '89015-2', '89015-3', '89015-4')
            GROUP BY order_ref1, order_ref2, order_ref3) mh ON 
       mh.order_ref1 = issue.order_ref1 AND
       mh.order_ref2 = issue.order_ref2 AND
       mh.order_ref3 = issue.order_ref3       

---SubstiturePart receives       
LEFT JOIN (SELECT order_ref1,
                  order_ref2,
                  order_ref3,
                  sum(inventory_qty) inventory_qty
            FROM    MATERIAL_HISTORY 
            WHERE MATERIAL_HISTORY_ACTION_DB IN ('RECSUBMFGPROD')
            AND expected_part_no = '99999'
            GROUP BY order_ref1, order_ref2, order_ref3) subst ON
       subst.order_ref1 = issue.order_ref1 AND
       subst.order_ref2 = issue.order_ref2 AND
       subst.order_ref3 = issue.order_ref3       
       
---ByProducts       
LEFT JOIN (SELECT order_ref1,
                  order_ref2,
                  order_ref3,
                  sum(inventory_qty) inventory_qty
            FROM  MATERIAL_HISTORY 
            WHERE MATERIAL_HISTORY_ACTION_DB IN ('RECBYPROD')
            AND expected_part_no = '99999'
            AND PART_NO IN ('3903', '3904', '3905', '3906', '3907', '3912', '3922', '3924', '3925', '3927')
            GROUP BY order_ref1, order_ref2, order_ref3) byprod ON
       byprod.order_ref1 = issue.order_ref1 AND
       byprod.order_ref2 = issue.order_ref2 AND
       byprod.order_ref3 = issue.order_ref3 
       
---Analysys       
LEFT JOIN (SELECT order_no, release_no, sequence_no, MAX(ANALYSIS_NO) ANALYSIS_NO
            FROM ANALYSIS_FULL_CFV
            WHERE CF$_AIM_FINALANALYSIS_DB = 'TRUE'
            GROUP BY order_no, release_no, sequence_no) ANAL ON ANAL.order_no = so.order_no AND
                                                               ANAL.release_no = so.release_no AND
                                                               ANAL.sequence_no = so.sequence_no  
      WHERE --ROWNUM < 1000 AND 
      lower(so.CONTRACT) = lower('&SITE')       
      --AND so.order_no IN ('38468')
      AND lower(to_char(INVOICE_DATE,'YYYY')) LIKE lower( '%&YEAR%' ) 
) main
LEFT outer JOIN (SELECT subst.order_ref1,
                  subst.order_ref2,
                  subst.order_ref3,
                  sum(ith.quantity) quantity,
                        sum(ith.quantity * col.base_sale_unit_price / Currency_Rate_API.Get_Currency_Rate( col.company, 'USD', 1, col.planned_due_date )) ammount,
                        min(date_applied) date_applied,
                        min(customer_no) customer_no
           FROM    MATERIAL_HISTORY subst
           INNER JOIN INVENTORY_TRANSACTION_HIST2 ith ON ith.contract = subst.contract AND ith.part_no = subst.part_no AND ith.lot_batch_no = subst.lot_batch_no
           INNER JOIN CUSTOMER_ORDER_LINE col ON ith.ORDER_NO = col.ORDER_NO AND ith.RELEASE_NO = col.line_no AND ith.SEQUENCE_NO = col.rel_no 
           WHERE subst.MATERIAL_HISTORY_ACTION_DB = 'RECSUBMFGPROD'
           AND subst.expected_part_no = '99999'
           AND ith.transaction_code = 'OESHIP'
           AND ith.ORDER_TYPE = 'Customer Order'
GROUP BY subst.order_ref1, subst.order_ref2, subst.order_ref3) sales ON sales.order_ref1 = order_no AND sales.order_ref2 = release_no AND sales.order_ref3 = sequence_no
