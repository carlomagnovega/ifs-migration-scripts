DECLARE   
   CONTRACT_ VARCHAR2(5) := '10MTL'; 
   COUNT_ID_ VARCHAR2(15) := 'CM-4'; 
   
   --@IgnoreTableOrViewAccess
   CURSOR get_not_new IS
      SELECT   a.CONTRACT,
               a.PART_NO,
               a.LOT_BATCH_NO,
               a.waiv_dev_rej_no,   
               a.configuration_id,
               a.location_no,
               a.serial_no,
               a.eng_chg_level,
               a.activity_seq,         
               a.SEQ,         
               a.QUANTITY,
               a.QTY_ONHAND,
               a.objkey,
               a.objversion,  
               bb.Description PART_DESC, 
               bb.Unit_Meas UOM, 
               INVENTORY_LOCATION_API.GET_WAREHOUSE(a.CONTRACT,INVENTORY_PART_DEF_LOC_API.Get_Picking_Location_No(a.CONTRACT, a.PART_NO)) WAREHOUSE, 
               bb.Part_Product_Family PRODUCT_FAMILY, 
               Inventory_Product_Family_API.Get_Description(bb.Part_Product_Family) PRODUCT_FAMILY_DESC, 
               bb.Planner_Buyer PLANNER_BUYER, 
               bb.ACCOUNTING_GROUP ACCOUNTING_GROUP, 
               Accounting_Group_API.Get_Description(bb.ACCOUNTING_GROUP) ACCOUNTING_GROUP_DESC, 
               bb.PRIME_COMMODITY COMM_GROUP1, 
               Commodity_Group_API.Get_Description(bb.PRIME_COMMODITY) COMM_GROUP1_DESC, 
               bb.SECOND_COMMODITY COMM_GROUP2,       
               Commodity_Group_API.Get_Description(bb.SECOND_COMMODITY) COMM_GROUP2_DESC, 
               bb.PART_PRODUCT_CODE PRODUCT_CODE, 
               Inventory_Product_Code_API.Get_Description(bb.PART_PRODUCT_CODE) PRODUCT_CODE_DESC, 
               bb.Inventory_Part_Cost_Level COST_LEVEL,
               INV_CST_AIM_API.Get_Count_Unit_Cost_Hist(a.CONTRACT,COUNT_ID_,a.SEQ,a.PART_NO) Unit_Cost_Hist
      FROM (SELECT 
         a.CF$_CONTRACT CONTRACT,
         c.PART_NO,
         c.LOT_BATCH_NO,
         c.waiv_dev_rej_no,   
         c.configuration_id,
         c.location_no,
         c.serial_no,
         c.eng_chg_level,
         c.activity_seq,         
         c.SEQ,         
         SUM(a.CF$_QUANTITY) QUANTITY,
         min(c.QTY_ONHAND) QTY_ONHAND,
         d.objkey,
         d.objversion
      FROM INVENT_COUNT_SHEET_CLV a
      INNER JOIN INVENT_COUNT_CLV b ON b.CF$_CONTRACT = a.CF$_CONTRACT 
      AND b.CF$_COUNT_ID = a.CF$_COUNT_ID
      INNER JOIN COUNTING_REPORT_LINE c ON c.INV_LIST_NO = b.CF$_INV_LIST_NO 
      AND c.SEQ = a.CF$_SEQ
      LEFT OUTER JOIN INVENT_COUNT_AUDIT_CLV d ON d.CF$_CONTRACT = a.CF$_CONTRACT 
      AND d.CF$_COUNT_ID = a.CF$_COUNT_ID
      AND d.CF$_SEQ = a.CF$_SEQ
      WHERE a.CF$_CONTRACT = CONTRACT_
      AND a.CF$_COUNT_ID = COUNT_ID_
      AND a.CF$_NEW_PART_DB= 'FALSE'
      AND a.CF$_CONFIRMED_DB= 'TRUE'
      --AND Counting_Result_API.Check_Exist(c.contract,c.part_no,c.configuration_id, c.location_no,c.lot_batch_no,c.serial_no,c.eng_chg_level,c.waiv_dev_rej_no,c.activity_seq,'*',c.last_count_date) = 'FALSE'
      GROUP BY a.CF$_CONTRACT,
         c.PART_NO,
         c.LOT_BATCH_NO,
         c.waiv_dev_rej_no,   
         c.configuration_id,
         c.serial_no,
         c.location_no,
         c.eng_chg_level,
         c.activity_seq,         
         c.SEQ, 
         d.objkey, 
         d.objversion      
         UNION ALL
         SELECT   b.CF$_CONTRACT CONTRACT,
         c.PART_NO,
                  c.LOT_BATCH_NO,
                  c.waiv_dev_rej_no,   
                  c.configuration_id,
                  c.location_no,
                  c.serial_no,
                  c.eng_chg_level,
                  c.activity_seq,         
                  c.SEQ,
                  0 QUANTITY,
                  c.qty_onhand QTY_ONHAND,
                  d.objkey,
                  d.objversion
         FROM 
         INVENT_COUNT_CLV b 
         INNER JOIN COUNTING_REPORT_LINE c ON c.INV_LIST_NO = b.CF$_INV_LIST_NO  
         LEFT JOIN INVENT_COUNT_SHEET_CLV a ON a.CF$_CONTRACT = b.CF$_CONTRACT 
         AND a.CF$_COUNT_ID = b.CF$_COUNT_ID
         AND a.CF$_SEQ = c.SEQ
         LEFT OUTER JOIN INVENT_COUNT_AUDIT_CLV d ON d.CF$_COUNT_ID = b.CF$_COUNT_ID
         AND d.CF$_SEQ = c.SEQ  
         WHERE b.CF$_CONTRACT = CONTRACT_
         AND b.CF$_COUNT_ID = COUNT_ID_
         AND a.CF$_CONTRACT IS NULL
         --AND Counting_Result_API.Check_Exist(c.contract,c.part_no,c.configuration_id, c.location_no,c.lot_batch_no,c.serial_no,c.eng_chg_level,c.waiv_dev_rej_no,c.activity_seq,'*',c.last_count_date) = 'FALSE'
         ) a
         INNER JOIN Inventory_Part bb ON bb.CONTRACT = a.CONTRACT AND bb.PART_NO = a.PART_NO;   
   
   --@IgnoreTableOrViewAccess
   CURSOR get_new IS
      SELECT   a.PART_NO,
               a.LOT_BATCH_NO,
               a.WDR,   
               a.SEQ,
               a.QUANTITY,
               a.QTY_ONHAND,
               a.objkey,
               a.objversion,  
               bb.Description PART_DESC, 
               bb.Unit_Meas UOM, 
               INVENTORY_PART_DEF_LOC_API.Get_Picking_Location_No(a.CONTRACT, a.PART_NO) LOCATION_NO, 
               INVENTORY_LOCATION_API.GET_WAREHOUSE(a.CONTRACT,INVENTORY_PART_DEF_LOC_API.Get_Picking_Location_No(a.CONTRACT, a.PART_NO)) WAREHOUSE, 
               bb.Part_Product_Family PRODUCT_FAMILY, 
               Inventory_Product_Family_API.Get_Description(bb.Part_Product_Family) PRODUCT_FAMILY_DESC, 
               bb.Planner_Buyer PLANNER_BUYER, 
               bb.ACCOUNTING_GROUP ACCOUNTING_GROUP, 
               Accounting_Group_API.Get_Description(bb.ACCOUNTING_GROUP) ACCOUNTING_GROUP_DESC, 
               bb.PRIME_COMMODITY COMM_GROUP1, 
               Commodity_Group_API.Get_Description(bb.PRIME_COMMODITY) COMM_GROUP1_DESC, 
               bb.SECOND_COMMODITY COMM_GROUP2,       
               Commodity_Group_API.Get_Description(bb.SECOND_COMMODITY) COMM_GROUP2_DESC, 
               bb.PART_PRODUCT_CODE PRODUCT_CODE, 
               Inventory_Product_Code_API.Get_Description(bb.PART_PRODUCT_CODE) PRODUCT_CODE_DESC, 
               bb.Inventory_Part_Cost_Level COST_LEVEL,
               INV_CST_AIM_API.Get_Count_Unit_Cost_Hist(a.CONTRACT,COUNT_ID_,'',a.PART_NO) Unit_Cost_Hist
      FROM (SELECT
         a.CF$_CONTRACT CONTRACT,
         a.CF$_PART_NO PART_NO,
         a.CF$_LOT_BATCH_NO LOT_BATCH_NO,
         a.CF$_WDR WDR,   
         a.CF$_SEQ SEQ,
         SUM(a.CF$_QUANTITY) QUANTITY,
         0 QTY_ONHAND,
         d.objkey,
         d.objversion
      FROM INVENT_COUNT_SHEET_CLV a
      INNER JOIN INVENT_COUNT_CLV b ON b.CF$_CONTRACT = a.CF$_CONTRACT AND b.CF$_COUNT_ID = a.CF$_COUNT_ID      
      LEFT OUTER JOIN INVENT_COUNT_AUDIT_CLV d ON a.CF$_PART_NO = d.CF$_PART_NO AND d.CF$_COUNT_ID = a.CF$_COUNT_ID
      AND UPPER(a.CF$_LOT_BATCH_NO) = UPPER(d.CF$_LOT_BATCH_NO)
      AND UPPER(a.CF$_WDR) = UPPER(d.CF$_WDR)
      AND NVL(a.CF$_SEQ,0) = NVL(d.CF$_SEQ,0)
      WHERE a.CF$_CONTRACT = CONTRACT_
      AND a.CF$_COUNT_ID = COUNT_ID_
      AND a.CF$_NEW_PART_DB= 'TRUE'
      AND a.CF$_CONFIRMED_DB= 'TRUE'
      GROUP BY a.CF$_CONTRACT, a.CF$_PART_NO, a.CF$_LOT_BATCH_NO, a.CF$_WDR, a.CF$_SEQ, d.objkey, d.objversion) a
      INNER JOIN Inventory_Part bb ON bb.CONTRACT = a.CONTRACT AND bb.PART_NO = a.PART_NO;
   
   info_                VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   objkey_              VARCHAR2(32000);
   attr_                VARCHAR2(32000);
   part_ownership_db_   VARCHAR2(20);
   audit_sheet_id_      NUMBER;
   conv_rate_           NUMBER;
   UNIT_COST_           NUMBER;
   UNIT_COST_HIST_      NUMBER;
BEGIN
   
   --@IgnoreTableOrViewAccess
   DELETE FROM INVENT_COUNT_AUDIT_CLT a
      WHERE a.CF$_CONTRACT = CONTRACT_
      AND a.CF$_COUNT_ID = COUNT_ID_
      AND a.CF$_SEQ IS NULL
      AND ( NOT EXISTS (SELECT 1 FROM INVENT_COUNT_SHEET_CLV d
         WHERE a.CF$_PART_NO = d.CF$_PART_NO 
         AND UPPER(a.CF$_LOT_BATCH_NO) = (d.CF$_LOT_BATCH_NO)
         AND UPPER(a.CF$_WDR) = UPPER(d.CF$_WDR)
         AND d.CF$_CONFIRMED_DB = 'TRUE'
         AND d.CF$_NEW_PART = 'TRUE'
         AND d.CF$_SEQ IS NULL)); 
   
   --Determine Max Sequence
   --@IgnoreTableOrViewAccess
   SELECT NVL(MAX(CF$_AUDIT_SHEET_ID),0)+1 
   INTO audit_sheet_id_
   FROM INVENT_COUNT_AUDIT_CLV
   WHERE CF$_CONTRACT = CONTRACT_
   AND CF$_COUNT_ID = COUNT_ID_;
   
   --conv_rate_ := INV_CST_AIM_API.Get_Company_Currency_Conv(COMPANY_SITE_API.Get_Company(CONTRACT_), SYSDATE);
   
   FOR rec_ IN get_not_new LOOP    
      --Calculate UnitCost
      part_ownership_db_ := Inventory_Part_In_Stock_API.Get_Part_Ownership_Db(contract_,
      rec_.part_no,
      rec_.configuration_id,
      rec_.location_no,
      rec_.lot_batch_no,
      rec_.serial_no,
      rec_.eng_chg_level,
      rec_.waiv_dev_rej_no,
      rec_.activity_seq);
      UNIT_COST_HIST_ := rec_.Unit_Cost_Hist; --INV_CST_AIM_API.Get_Inventory_Value( CONTRACT_, rec_.PART_NO, rec_.configuration_id, rec_.LOT_BATCH_NO, rec_.serial_no);
      IF part_ownership_db_ IN (Part_Ownership_API.DB_COMPANY_OWNED, Part_Ownership_API.DB_CONSIGNMENT) THEN
         UNIT_COST_ := UNIT_COST_HIST_;
      ELSE
         UNIT_COST_ := 0;
      END IF;  
      
      Client_SYS.Clear_Attr(attr_);     
      Client_SYS.Add_To_Attr('CF$_ACCOUNTING_GROUP', rec_.ACCOUNTING_GROUP, attr_);  
      Client_SYS.Add_To_Attr('CF$_ACCOUNTING_GROUP_DESC', rec_.ACCOUNTING_GROUP_DESC, attr_);  
      Client_SYS.Add_To_Attr('CF$_COMM_GROUP1', rec_.COMM_GROUP1, attr_);  
      Client_SYS.Add_To_Attr('CF$_COMM_GROUP1_DESC', rec_.COMM_GROUP1_DESC, attr_);  
      Client_SYS.Add_To_Attr('CF$_COMM_GROUP2', rec_.COMM_GROUP2, attr_);  
      Client_SYS.Add_To_Attr('CF$_COMM_GROUP2_DESC', rec_.COMM_GROUP2_DESC, attr_);  
      Client_SYS.Add_To_Attr('CF$_COST_LEVEL', rec_.COST_LEVEL, attr_);  
      Client_SYS.Add_To_Attr('CF$_LOCATION_NO', rec_.LOCATION_NO, attr_);  
      Client_SYS.Add_To_Attr('CF$_PART_DESC', rec_.PART_DESC, attr_);  
      Client_SYS.Add_To_Attr('CF$_PLANNER_BUYER', rec_.PLANNER_BUYER, attr_);  
      Client_SYS.Add_To_Attr('CF$_PRODUCT_CODE', rec_.PRODUCT_CODE, attr_);  
      Client_SYS.Add_To_Attr('CF$_PRODUCT_CODE_DESC', rec_.PRODUCT_CODE_DESC, attr_);  
      Client_SYS.Add_To_Attr('CF$_PRODUCT_FAMILY', rec_.PRODUCT_FAMILY, attr_);  
      Client_SYS.Add_To_Attr('CF$_PRODUCT_FAMILY_DESC', rec_.PRODUCT_FAMILY_DESC, attr_);  
      Client_SYS.Add_To_Attr('CF$_UOM', rec_.UOM, attr_);  
      Client_SYS.Add_To_Attr('CF$_WAREHOUSE', rec_.WAREHOUSE, attr_);   
      Client_SYS.Add_To_Attr('CF$_QUANTITY', rec_.QUANTITY, attr_);
      Client_SYS.Add_To_Attr('CF$_QTY_ONHAND', rec_.QTY_ONHAND, attr_);
      Client_SYS.Add_To_Attr('CF$_UNIT_COST', UNIT_COST_, attr_);
      Client_SYS.Add_To_Attr('CF$_UNIT_COST_HIST', UNIT_COST_HIST_, attr_);        
      
      IF(rec_.objkey IS NULL) THEN     --NEW
         Client_SYS.Add_To_Attr('CF$_AUDIT_SHEET_ID', audit_sheet_id_, attr_);
         Client_SYS.Add_To_Attr('CF$_CONTRACT', CONTRACT_, attr_);
         Client_SYS.Add_To_Attr('CF$_COUNT_ID', COUNT_ID_, attr_);
         Client_SYS.Add_To_Attr('CF$_PART_NO', rec_.PART_NO, attr_);
         Client_SYS.Add_To_Attr('CF$_LOT_BATCH_NO', rec_.LOT_BATCH_NO, attr_);
         Client_SYS.Add_To_Attr('CF$_WDR', rec_.WAIV_DEV_REJ_NO, attr_);
         Client_SYS.Add_To_Attr('CF$_SEQ', rec_.SEQ, attr_);
         
         INVENT_COUNT_AUDIT_CLP.New__(info_, objkey_, objversion_, attr_, 'DO');
         audit_sheet_id_ := audit_sheet_id_ + 1;
      ELSE --Update
         objkey_     := rec_.objkey;
         objversion_ := rec_.objversion;                  
         INVENT_COUNT_AUDIT_CLP.Modify__(info_, objkey_, objversion_, attr_, 'DO');
      END IF;      
   END LOOP;
   
   FOR rec_ IN get_new LOOP    
      UNIT_COST_      := rec_.Unit_Cost_Hist; -- NVL(INV_CST_AIM_API.Get_Average_Cost( CONTRACT_, rec_.PART_NO), 0);
      
      Client_SYS.Clear_Attr(attr_);      
      Client_SYS.Add_To_Attr('CF$_ACCOUNTING_GROUP', rec_.ACCOUNTING_GROUP, attr_);  
      Client_SYS.Add_To_Attr('CF$_ACCOUNTING_GROUP_DESC', rec_.ACCOUNTING_GROUP_DESC, attr_);  
      Client_SYS.Add_To_Attr('CF$_COMM_GROUP1', rec_.COMM_GROUP1, attr_);  
      Client_SYS.Add_To_Attr('CF$_COMM_GROUP1_DESC', rec_.COMM_GROUP1_DESC, attr_);  
      Client_SYS.Add_To_Attr('CF$_COMM_GROUP2', rec_.COMM_GROUP2, attr_);  
      Client_SYS.Add_To_Attr('CF$_COMM_GROUP2_DESC', rec_.COMM_GROUP2_DESC, attr_);  
      Client_SYS.Add_To_Attr('CF$_COST_LEVEL', rec_.COST_LEVEL, attr_);  
      Client_SYS.Add_To_Attr('CF$_LOCATION_NO', rec_.LOCATION_NO, attr_);  
      Client_SYS.Add_To_Attr('CF$_PART_DESC', rec_.PART_DESC, attr_);  
      Client_SYS.Add_To_Attr('CF$_PLANNER_BUYER', rec_.PLANNER_BUYER, attr_);  
      Client_SYS.Add_To_Attr('CF$_PRODUCT_CODE', rec_.PRODUCT_CODE, attr_);  
      Client_SYS.Add_To_Attr('CF$_PRODUCT_CODE_DESC', rec_.PRODUCT_CODE_DESC, attr_);  
      Client_SYS.Add_To_Attr('CF$_PRODUCT_FAMILY', rec_.PRODUCT_FAMILY, attr_);  
      Client_SYS.Add_To_Attr('CF$_PRODUCT_FAMILY_DESC', rec_.PRODUCT_FAMILY_DESC, attr_);  
      Client_SYS.Add_To_Attr('CF$_UOM', rec_.UOM, attr_);  
      Client_SYS.Add_To_Attr('CF$_WAREHOUSE', rec_.WAREHOUSE, attr_);  
      Client_SYS.Add_To_Attr('CF$_UNIT_COST', UNIT_COST_, attr_);
      Client_SYS.Add_To_Attr('CF$_UNIT_COST_HIST', rec_.Unit_Cost_Hist, attr_);  
      Client_SYS.Add_To_Attr('CF$_QUANTITY', rec_.QUANTITY, attr_);
      
      IF(rec_.objkey IS NULL) THEN     --NEW         
         Client_SYS.Add_To_Attr('CF$_AUDIT_SHEET_ID', audit_sheet_id_, attr_);
         Client_SYS.Add_To_Attr('CF$_CONTRACT', CONTRACT_, attr_);
         Client_SYS.Add_To_Attr('CF$_COUNT_ID', COUNT_ID_, attr_);
         Client_SYS.Add_To_Attr('CF$_PART_NO', rec_.PART_NO, attr_);
         Client_SYS.Add_To_Attr('CF$_LOT_BATCH_NO', rec_.LOT_BATCH_NO, attr_);
         Client_SYS.Add_To_Attr('CF$_WDR', rec_.WDR, attr_);
         Client_SYS.Add_To_Attr('CF$_SEQ', rec_.SEQ, attr_);
         Client_SYS.Add_To_Attr('CF$_QUANTITY', rec_.QUANTITY, attr_);
         Client_SYS.Add_To_Attr('CF$_QTY_ONHAND', rec_.QTY_ONHAND, attr_);
         
         INVENT_COUNT_AUDIT_CLP.New__(info_, objkey_, objversion_, attr_, 'DO');
         audit_sheet_id_ := audit_sheet_id_ + 1;
      ELSE --Update
         objkey_     := rec_.objkey;
         objversion_ := rec_.objversion;                  
         INVENT_COUNT_AUDIT_CLP.Modify__(info_, objkey_, objversion_, attr_, 'DO');
      END IF;      
   END LOOP;
   
   --@IgnoreTableOrViewAccess
   SELECT objkey, objversion INTO objkey_, objversion_
   FROM INVENT_COUNT_CLV
   WHERE CF$_CONTRACT = CONTRACT_ AND CF$_COUNT_ID = COUNT_ID_;
   
   Client_SYS.Clear_Attr(attr_);
   Client_SYS.Add_To_Attr('CF$_LAST_REFRESH', SYSDATE, attr_);      
   INVENT_COUNT_CLP.Modify__(info_, objkey_, objversion_, attr_, 'DO');
   
EXCEPTION
   WHEN OTHERS THEN
      RAISE;
END;