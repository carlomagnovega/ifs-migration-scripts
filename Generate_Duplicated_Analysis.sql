DECLARE   
   CURSOR get_qaman IS
      SELECT   a.CONTRACT,
               a.PART_NO,       
               a.LOT_BATCH_NO,
               a.waiv_dev_rej_no,
               a.expiration_date,
               LBM.order_ref1                     order_no,
               LBM.order_ref2                     release_no,
               LBM.order_ref3                     sequence_no,
               (SELECT min(ANALYSIS_NO)
                FROM SHOP_ORDER_ANALYSIS_CFV b 
                WHERE b.ORDER_NO = LBM.order_ref1
                AND b.RELEASE_NO = LBM.order_ref2
                AND b.SEQUENCE_NO = LBM.order_ref3
                AND b.CF$_AIM_FINAL_ANALYSIS_DB = 'TRUE'
                AND b.objstate = 'Confirmed') ANALYSIS_NO
      FROM INVENTORY_PART_IN_STOCK a
      INNER JOIN INVENTORY_PART IPT ON a.PART_NO = ipt.PART_NO AND a.CONTRACT = ipt.CONTRACT
      INNER JOIN PART_CATALOG PCT ON a.PART_NO = pct.PART_NO 
      INNER JOIN LOT_BATCH_MASTER LBM ON LBM.PART_NO = a.PART_NO AND LBM.lot_batch_no = a.lot_batch_no
      WHERE (a.QTY_ONHAND-a.QTY_RESERVED) > 0
      AND ( a.expiration_date IS NULL OR a.expiration_date > SYSDATE)
      AND IPT.TYPE_CODE_DB = 1
      AND ipt.part_product_family IN ('02', '06', '09')
      AND ipt.planner_buyer IN ('CASTING_SE-FG','CASTING_RAW', 'POWDER_SE-FG', 'RECLAIM_SE-FG')
      AND pct.LOT_TRACKING_CODE_DB = (select PART_LOT_TRACKING_API.Encode('Lot Tracking') from dual)
      AND NOT EXISTS (SELECT 1 FROM AIM_ANALYSIS_FULL_CFV AFC WHERE (AFC.PART_NO = a.part_no) AND AFC.LOT_BATCH_NO = a.LOT_BATCH_NO AND AFC.CF$_AIM_FINALANALYSIS_DB = 'TRUE' AND AFC.objstate = 'Confirmed')
      AND LBM.order_ref1 IS NOT NULL
      AND EXISTS (SELECT control_plan_no
                  FROM QMAN_CONTROL_PLAN_INVENT d
                  WHERE d.contract = a.contract
                  AND d.part_no = a.part_no
                  AND d.objstate = 'Active')
      AND EXISTS (SELECT ANALYSIS_NO
               FROM SHOP_ORDER_ANALYSIS_CFV b 
               WHERE b.ORDER_NO = LBM.order_ref1
               AND b.RELEASE_NO = LBM.order_ref2
               AND b.SEQUENCE_NO = LBM.order_ref3
               AND b.CF$_AIM_FINAL_ANALYSIS_DB = 'TRUE'
               AND b.objstate = 'Confirmed');
   
BEGIN
   FOR row_ IN get_qaman LOOP 
      ANL_REQ_AIM_API.Generate_Duplicate_Analysis( row_.contract,
                                                   row_.PART_NO,
                                                   row_.LOT_BATCH_NO,
                                                   row_.ANALYSIS_NO);
      COMMIT;
   END LOOP;   
END;
