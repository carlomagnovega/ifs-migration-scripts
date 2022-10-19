SELECT 'INSERT INTO mtk_part_master_tab (part_no,description,provide_db,part_class,part_responsible,planning_method,unit_code,lot_tracking_code_db,part_main_group,eng_serial_tracking_code_db,serial_tracking_code_db,serial_rule_db,std_name,info_text,configurable_db,condition_code_usage_db,position_part_db,lot_quantity_rule_db,sub_lot_rule_db,is_eng_part,mtk_mode,dme_naics,multilevel_tracking_db,input_unit_meas_group_id,catch_unit_enabled_db,allow_as_not_consumed_db,weight_net,volume_net,uom_for_weight_net,uom_for_volume_net,freight_factor,receipt_issue_serial_track_db) VALUES ('''
      || PART_NO
      || ''',''' || description
      || ''',''' || provide_db
      || ''',''' || part_class
      || ''',''' || part_responsible
      || ''',''' || planning_method
      || ''',''' || unit_code
      || ''',''' || lot_tracking_code_db
      || ''',''' || part_main_group
      || ''',''' || eng_serial_tracking_code_db
      || ''',''' || serial_tracking_code_db
      || ''',''' || serial_rule_db
      || ''',''' || std_name
      || ''',''' || info_text
      || ''',''' || configurable_db
      || ''',''' || condition_code_usage_db
      || ''',''' || position_part_db
      || ''',''' || lot_quantity_rule_db
      || ''',''' || sub_lot_rule_db
      || ''',''' || is_eng_part
      || ''',''' || mtk_mode
      || ''',''' || dme_naics
      || ''',''' || multilevel_tracking_db
      || ''',''' || input_unit_meas_group_id
      || ''',''' || catch_unit_enabled_db
 --     || ''',''' || dme_pc_flex1
 --     || ''',''' || dme_pc_flex2
 --     || ''',''' || dme_pc_flex3
 --     || ''',''' || dme_pc_flex4
 --     || ''',''' || dme_pc_flex5
 --     || ''',''' || dme_pc_flex6
      || ''',''' || allow_as_not_consumed_db
      || ''',''' || weight_net
      || ''',''' || volume_net
      || ''',''' || uom_for_weight_net
      || ''',''' || uom_for_volume_net
      || ''',''' || freight_factor
      || ''',''' || receipt_issue_serial_track_db      
		||  ''');'   aa
FROM (SELECT b.part_no,
   replace(B.DESCRIPTION, '"', '-') description,
   'MAKE' provide_db,
   '' part_class,
   '' part_responsible,
   '' planning_method,
   unit_code,
   lot_tracking_code_db,
   part_main_group,
   eng_serial_tracking_code_db,
   serial_tracking_code_db,
   serial_rule_db,
   '' std_name,
   info_text,
   configurable_db,
   condition_code_usage_db,
   position_part_db,
   lot_quantity_rule_db,
   sub_lot_rule_db,
   'N' is_eng_part,
   'N' mtk_mode,
   '' dme_naics,
   multilevel_tracking_db,
   b.input_unit_meas_group_id,
   catch_unit_enabled_db,
   '' dme_pc_flex1,
   '' dme_pc_flex2,
   '' dme_pc_flex3,
   '' dme_pc_flex4,
   '' dme_pc_flex5,
   '' dme_pc_flex6,
   allow_as_not_consumed_db,
   weight_net,
   volume_net,
   uom_for_weight_net,
   uom_for_volume_net,
   freight_factor,
   receipt_issue_serial_track_db
FROM INVENTORY_PART_TAB a
INNER JOIN PART_CATALOG b ON a.PART_NO = b.PART_NO
WHERE a.CONTRACT = '33CX') a

 ---------------------------------------------------
TRUNCATE TABLE mtk_inventory_part_tab;
SELECT 'INSERT INTO mtk_inventory_part_tab (PART_NO,CONTRACT,DESCRIPTION,UNIT_MEAS,TYPE_CODE,ABC_CLASS,PLANNER_BUYER,PRIME_COMMODITY,SECOND_COMMODITY,ASSET_CLASS,PART_STATUS,HAZARD_CODE,ACCOUNTING_GROUP,PART_PRODUCT_CODE,PART_PRODUCT_FAMILY,TYPE_DESIGNATION,DIM_QUALITY,CREATE_DATE,NOTE_TEXT,INPUT_UNIT_MEAS_GROUP_ID,CATCH_UNIT_MEAS,DOP_NETTING_DB,EXPECTED_LEADTIME,DURABILITY_DAY,SUPERSEDES,COUNTRY_OF_ORIGIN,CUSTOMS_STAT_NO,TECHNICAL_COORDINATOR,PURCH_LEADTIME,MANUF_LEADTIME,SUPPLY_CODE_DB,INTRASTAT_CONV_FACTOR,QTY_CALC_ROUNDING,ESTIMATED_MATERIAL_COST,LATEST_PURCHASE_PRICE,AVERAGE_PURCHASE_PRICE,CYCLE_PERIOD,INVENTORY_VALUATION_METHOD,INVENTORY_PART_COST_LEVEL,ZERO_COST_FLAG,PART_COST_GROUP_ID,NEGATIVE_ON_HAND_DB,SHORTAGE_FLAG,FORECAST_CONSUMPTION_FLAG_DB,ONHAND_ANALYSIS_FLAG_DB,CYCLE_CODE_DB,EXT_SERVICE_COST_METHOD_DB,INVOICE_CONSIDERATION_DB,STD_NAME,PLANNING_METHOD,LOT_SIZE,MIN_ORDER_QTY,MAX_ORDER_QTY,MUL_ORDER_QTY,SHRINKAGE_FAC,STD_ORDER_SIZE,SAFETY_STOCK,ORDER_POINT_QTY,MAXWEEK_SUPPLY,ORDER_REQUISITION_DB,QTY_PREDICTED_CONSUMPTION,PROPOSAL_RELEASE_DB,BACKFLUSH_PART_DB,PROCESS_TYPE,MANUF_ENGINEER,DENSITY,MRP_CONTROL_FLAG_DB,ENG_REVISION,ENG_CHG_LEVEL,ENG_REVISION_DESC,STORAGE_WIDTH_REQUIREMENT,STORAGE_HEIGHT_REQUIREMENT,STORAGE_DEPTH_REQUIREMENT,STORAGE_VOLUME_REQUIREMENT,STORAGE_WEIGHT_REQUIREMENT,MIN_STORAGE_TEMPERATURE,MAX_STORAGE_TEMPERATURE,MIN_STORAGE_HUMIDITY,MAX_STORAGE_HUMIDITY,ENG_ATTRIBUTE,MTK_MODE,MIN_DURAB_DAYS_CO_DELIV,MIN_DURAB_DAYS_PLANNING,STOCK_MANAGEMENT_DB,PLANNING_METHOD_AUTO_DB) VALUES (''' 
                 || PART_NO
      || ''',''' || CONTRACT
      || ''',''' || DESCRIPTION
      || ''',''' || UNIT_MEAS
      || ''',''' || TYPE_CODE
      || ''',''' || ABC_CLASS
      || ''',''' || PLANNER_BUYER
      || ''',''' || PRIME_COMMODITY
      || ''',''' || SECOND_COMMODITY
      || ''',''' || ASSET_CLASS
      || ''',''' || PART_STATUS
      || ''',''' || HAZARD_CODE
      || ''',''' || ACCOUNTING_GROUP
      || ''',''' || PART_PRODUCT_CODE
      || ''',''' || PART_PRODUCT_FAMILY
      || ''',''' || TYPE_DESIGNATION
      || ''',''' || DIM_QUALITY
      || ''',''' || CREATE_DATE
      || ''',''' || NOTE_TEXT
      || ''',''' || INPUT_UNIT_MEAS_GROUP_ID
      || ''',''' || CATCH_UNIT_MEAS
      || ''',''' || DOP_NETTING_DB
      || ''',''' || EXPECTED_LEADTIME
      || ''',''' || DURABILITY_DAY
      || ''',''' || SUPERSEDES
      || ''',''' || COUNTRY_OF_ORIGIN
      || ''',''' || CUSTOMS_STAT_NO
      || ''',''' || TECHNICAL_COORDINATOR
      || ''',''' || PURCH_LEADTIME
      || ''',''' || MANUF_LEADTIME
      || ''',''' || SUPPLY_CODE_DB
      || ''',''' || INTRASTAT_CONV_FACTOR
      || ''',''' || QTY_CALC_ROUNDING
      || ''',''' || ESTIMATED_MATERIAL_COST
      || ''',''' || LATEST_PURCHASE_PRICE
      || ''',''' || AVERAGE_PURCHASE_PRICE
      || ''',''' || CYCLE_PERIOD
      || ''',''' || INVENTORY_VALUATION_METHOD
      || ''',''' || INVENTORY_PART_COST_LEVEL
      || ''',''' || ZERO_COST_FLAG
      || ''',''' || PART_COST_GROUP_ID
      || ''',''' || NEGATIVE_ON_HAND_DB
      || ''',''' || SHORTAGE_FLAG
      || ''',''' || FORECAST_CONSUMPTION_FLAG_DB
      || ''',''' || ONHAND_ANALYSIS_FLAG_DB
      || ''',''' || CYCLE_CODE_DB
      || ''',''' || EXT_SERVICE_COST_METHOD_DB
      || ''',''' || INVOICE_CONSIDERATION_DB
      || ''',''' || STD_NAME
      || ''',''' || PLANNING_METHOD
      || ''',''' || LOT_SIZE
      || ''',''' || MIN_ORDER_QTY
      || ''',''' || MAX_ORDER_QTY
      || ''',''' || MUL_ORDER_QTY
      || ''',''' || SHRINKAGE_FAC
      || ''',''' || STD_ORDER_SIZE
      || ''',''' || SAFETY_STOCK
      || ''',''' || ORDER_POINT_QTY
      || ''',''' || MAXWEEK_SUPPLY
      || ''',''' || ORDER_REQUISITION_DB
      || ''',''' || QTY_PREDICTED_CONSUMPTION
      || ''',''' || PROPOSAL_RELEASE_DB
      || ''',''' || BACKFLUSH_PART_DB
      || ''',''' || PROCESS_TYPE
      || ''',''' || MANUF_ENGINEER
      || ''',''' || DENSITY
      || ''',''' || MRP_CONTROL_FLAG_DB
      || ''',''' || ENG_REVISION
      || ''',''' || ENG_CHG_LEVEL
      || ''',''' || ENG_REVISION_DESC
      || ''',''' || STORAGE_WIDTH_REQUIREMENT
      || ''',''' || STORAGE_HEIGHT_REQUIREMENT
      || ''',''' || STORAGE_DEPTH_REQUIREMENT
      || ''',''' || STORAGE_VOLUME_REQUIREMENT
      || ''',''' || STORAGE_WEIGHT_REQUIREMENT
      || ''',''' || MIN_STORAGE_TEMPERATURE
      || ''',''' || MAX_STORAGE_TEMPERATURE
      || ''',''' || MIN_STORAGE_HUMIDITY
      || ''',''' || MAX_STORAGE_HUMIDITY
      || ''',''' || ENG_ATTRIBUTE
      || ''',''' || MTK_MODE
      || ''',''' || MIN_DURAB_DAYS_CO_DELIV
      || ''',''' || MIN_DURAB_DAYS_PLANNING
      || ''',''' || STOCK_MANAGEMENT_DB
      || ''',''' || PLANNING_METHOD_AUTO_DB       
		||  ''');'   aa
FROM (
SELECT a.PART_NO,
         a.CONTRACT,
         REPLACE(REPLACE(a.DESCRIPTION,'''','-'),'&','-') DESCRIPTION,
         a.UNIT_MEAS,
         a.TYPE_CODE,
         a.ABC_CLASS,
         a.PLANNER_BUYER,
         a.PRIME_COMMODITY,
         a.SECOND_COMMODITY,
         a.ASSET_CLASS,
         a.PART_STATUS,
         a.HAZARD_CODE,
         a.ACCOUNTING_GROUP,
         a.PART_PRODUCT_CODE,
         a.PART_PRODUCT_FAMILY,
         a.TYPE_DESIGNATION,
         a.DIM_QUALITY,
         '' CREATE_DATE,
         a.NOTE_TEXT,
         a.INPUT_UNIT_MEAS_GROUP_ID,
         a.CATCH_UNIT_MEAS,
         a.DOP_NETTING DOP_NETTING_DB,
         a.EXPECTED_LEADTIME,
         a.DURABILITY_DAY,
         a.SUPERSEDES,
         a.COUNTRY_OF_ORIGIN,
         a.CUSTOMS_STAT_NO,
         a.TECHNICAL_COORDINATOR_ID TECHNICAL_COORDINATOR,
         a.PURCH_LEADTIME,
         a.MANUF_LEADTIME,
         a.SUPPLY_CODE SUPPLY_CODE_DB,
         a.INTRASTAT_CONV_FACTOR,
         a.QTY_CALC_ROUNDING,
         c.ESTIMATED_MATERIAL_COST,
         c.LATEST_PURCHASE_PRICE,
         c.AVERAGE_PURCHASE_PRICE,
         a.CYCLE_PERIOD,
         a.INVENTORY_VALUATION_METHOD,
         a.INVENTORY_PART_COST_LEVEL,
         a.ZERO_COST_FLAG,
         a.PART_COST_GROUP_ID,
         a.NEGATIVE_ON_HAND NEGATIVE_ON_HAND_DB,
         a.SHORTAGE_FLAG,
         a.FORECAST_CONSUMPTION_FLAG FORECAST_CONSUMPTION_FLAG_DB,
         a.ONHAND_ANALYSIS_FLAG ONHAND_ANALYSIS_FLAG_DB,
         a.CYCLE_CODE CYCLE_CODE_DB,
         a.EXT_SERVICE_COST_METHOD EXT_SERVICE_COST_METHOD_DB,
         a.INVOICE_CONSIDERATION INVOICE_CONSIDERATION_DB,
         a.STD_NAME_ID STD_NAME,
         d.PLANNING_METHOD,
         d.LOT_SIZE,
         d.MIN_ORDER_QTY,
         d.MAX_ORDER_QTY,
         d.MUL_ORDER_QTY,
         d.SHRINKAGE_FAC,
         d.STD_ORDER_SIZE,
         d.SAFETY_STOCK,
         d.ORDER_POINT_QTY,
         d.MAXWEEK_SUPPLY,
         d.ORDER_REQUISITION_DB,
         d.QTY_PREDICTED_CONSUMPTION,
         d.PROPOSAL_RELEASE_DB,
         e.BACKFLUSH_PART_DB,
         '' PROCESS_TYPE,
         e.MANUF_ENGINEER,
         e.DENSITY,
         e.MRP_CONTROL_FLAG_DB,
         '' ENG_REVISION,
         '' ENG_CHG_LEVEL,
         '' ENG_REVISION_DESC,
         a.STORAGE_WIDTH_REQUIREMENT,
         a.STORAGE_HEIGHT_REQUIREMENT,
         a.STORAGE_DEPTH_REQUIREMENT,
         a.STORAGE_VOLUME_REQUIREMENT,
         a.STORAGE_WEIGHT_REQUIREMENT,
         a.MIN_STORAGE_TEMPERATURE,
         a.MAX_STORAGE_TEMPERATURE,
         a.MIN_STORAGE_HUMIDITY,
         a.MAX_STORAGE_HUMIDITY,
         a.ENG_ATTRIBUTE,
         '*' MTK_MODE,
         a.MIN_DURAB_DAYS_CO_DELIV,
         a.MIN_DURAB_DAYS_PLANNING,
         a.STOCK_MANAGEMENT STOCK_MANAGEMENT_DB,
         d.PLANNING_METHOD_AUTO_DB
    FROM INVENTORY_PART_TAB a
    LEFT JOIN MANUF_PART_ATTRIBUTE b
      ON a.CONTRACT = b.CONTRACT
     AND a.PART_NO = b.PART_NO
    LEFT JOIN INVENTORY_PART_CONFIG c
      ON a.CONTRACT = c.CONTRACT
     AND a.PART_NO = c.PART_NO
    LEFT JOIN INVENTORY_PART_PLANNING d
      ON a.CONTRACT = d.CONTRACT
     AND a.PART_NO = d.PART_NO
    LEFT JOIN MANUF_PART_ATTRIBUTE e
      ON a.CONTRACT = e.CONTRACT
     AND a.PART_NO = e.PART_NO
   WHERE a.CONTRACT IN ('33CX'))  aaa

-----------------------------


--Update Custom FIelds
DECLARE   
   CURSOR get_qaman IS
      SELECT
         qcp.objid,
         qcp.PART_NO,
         qcp.CONTRACT,
         ium.objkey CF$_AIM_BASEHUOM,
         qcpa.CF$_AIM_COEF_METAL,
         qcpa.CF$_AIM_COEF_MFG,
         qcpa.CF$_AIM_FORMAT,
         a.objkey CF$_AIM_ALLOYSPEC,
         smt.objkey CF$_MARKET,
         qcpa.CF$_MICRON,
         qcpa.CF$_DIAMETER,
         qcpa.CF$_FG_FORMAT,
         qcpa.CF$_FLUX_TYPE,
         qcpa.CF$_LABEL_BOXES_LAYOUT,
         qcpa.CF$_LABEL_LAYOUT,
         qcpa.CF$_LABEL_UM,
         qcpa.CF$_AIM_LEADTYPE,
         qcpa.CF$_PER_FLUX,
         qcpa.CF$_PER_METAL,
         qcpa.CF$_PROD_ALLOY1,
         qcpa.CF$_PROD_ALLOY2,
         qcpa.CF$_PROD_ALLOY3,
         qcpa.CF$_QTY_PER_BOX,
         qcpa.CF$_UNIT_WEIGHT,
         qcpa.CF$_UPC
      FROM Inventory_Part_CFV qcpa
      inner join MTK_INVENTORY_PART_INDHK_TAB f on f.INVPARTNO = qcpa.PART_NO AND f.SUPPLINGSITE = qcpa.CONTRACT AND f.ORDERTYPE = 'HK'
      INNER JOIN Inventory_Part qcp ON qcp.PART_NO = qcpa.PART_NO AND qcp.CONTRACT = '30HK'
      LEFT JOIN CONTROL_PLAN_TEMPL_HEADER_CLV a ON a.CF$_SPEC_ID = qcpa.CF$_AIM_ALLOYSPEC
      LEFT JOIN INPUT_UNIT_MEAS_GROUP ium ON ium.input_unit_meas_group_id = UPPER(qcpa.CF$_AIM_BASEHUOM)
      LEFT JOIN SALES_MARKET smt ON MARKET_CODE = qcpa.CF$_MARKET;
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Clear_Attr(attr_cf_);
      
      Client_SYS.Add_To_Attr('CF$_FG_FORMAT', row_.CF$_FG_FORMAT, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIM_ALLOYSPEC', row_.CF$_AIM_ALLOYSPEC, attr_cf_);
      
      Client_SYS.Add_To_Attr('CF$_AIM_BASEHUOM', row_.CF$_AIM_BASEHUOM, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIM_COEF_METAL', row_.CF$_AIM_COEF_METAL, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIM_COEF_MFG', row_.CF$_AIM_COEF_MFG, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIM_FORMAT', row_.CF$_AIM_FORMAT, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_MARKET', row_.CF$_MARKET, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_MICRON', row_.CF$_MICRON, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_DIAMETER', row_.CF$_DIAMETER, attr_cf_);      
      Client_SYS.Add_To_Attr('CF$_FLUX_TYPE', row_.CF$_FLUX_TYPE, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_LABEL_BOXES_LAYOUT', row_.CF$_LABEL_BOXES_LAYOUT, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_LABEL_LAYOUT', row_.CF$_LABEL_LAYOUT, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_LABEL_UM', row_.CF$_LABEL_UM, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIM_LEADTYPE', row_.CF$_AIM_LEADTYPE, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_PER_FLUX', row_.CF$_PER_FLUX, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_PER_METAL', row_.CF$_PER_METAL, attr_cf_);      
      Client_SYS.Add_To_Attr('CF$_PROD_ALLOY1', row_.CF$_PROD_ALLOY1, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_PROD_ALLOY2', row_.CF$_PROD_ALLOY2, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_PROD_ALLOY3', row_.CF$_PROD_ALLOY3, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_QTY_PER_BOX', row_.CF$_QTY_PER_BOX, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_UNIT_WEIGHT', row_.CF$_UNIT_WEIGHT, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_UPC', row_.CF$_UPC, attr_cf_);
      
      INVENTORY_PART_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');
      COMMIT;
   END LOOP;   
END;

------
SELECT 'INSERT INTO mtk_inventory_part_tab (PART_NO,CONTRACT,DESCRIPTION,UNIT_MEAS,TYPE_CODE,ABC_CLASS,PLANNER_BUYER,PRIME_COMMODITY,SECOND_COMMODITY,ASSET_CLASS,PART_STATUS,HAZARD_CODE,ACCOUNTING_GROUP,PART_PRODUCT_CODE,PART_PRODUCT_FAMILY,TYPE_DESIGNATION,DIM_QUALITY,CREATE_DATE,NOTE_TEXT,INPUT_UNIT_MEAS_GROUP_ID,CATCH_UNIT_MEAS,DOP_NETTING_DB,EXPECTED_LEADTIME,DURABILITY_DAY,SUPERSEDES,COUNTRY_OF_ORIGIN,CUSTOMS_STAT_NO,TECHNICAL_COORDINATOR,PURCH_LEADTIME,MANUF_LEADTIME,SUPPLY_CODE_DB,INTRASTAT_CONV_FACTOR,QTY_CALC_ROUNDING,ESTIMATED_MATERIAL_COST,LATEST_PURCHASE_PRICE,AVERAGE_PURCHASE_PRICE,CYCLE_PERIOD,INVENTORY_VALUATION_METHOD,INVENTORY_PART_COST_LEVEL,ZERO_COST_FLAG,PART_COST_GROUP_ID,NEGATIVE_ON_HAND_DB,SHORTAGE_FLAG,FORECAST_CONSUMPTION_FLAG_DB,ONHAND_ANALYSIS_FLAG_DB,CYCLE_CODE_DB,EXT_SERVICE_COST_METHOD_DB,INVOICE_CONSIDERATION_DB,STD_NAME,PLANNING_METHOD,LOT_SIZE,MIN_ORDER_QTY,MAX_ORDER_QTY,MUL_ORDER_QTY,SHRINKAGE_FAC,STD_ORDER_SIZE,SAFETY_STOCK,ORDER_POINT_QTY,MAXWEEK_SUPPLY,ORDER_REQUISITION_DB,QTY_PREDICTED_CONSUMPTION,PROPOSAL_RELEASE_DB,BACKFLUSH_PART_DB,PROCESS_TYPE,MANUF_ENGINEER,DENSITY,MRP_CONTROL_FLAG_DB,ENG_REVISION,ENG_CHG_LEVEL,ENG_REVISION_DESC,STORAGE_WIDTH_REQUIREMENT,STORAGE_HEIGHT_REQUIREMENT,STORAGE_DEPTH_REQUIREMENT,STORAGE_VOLUME_REQUIREMENT,STORAGE_WEIGHT_REQUIREMENT,MIN_STORAGE_TEMPERATURE,MAX_STORAGE_TEMPERATURE,MIN_STORAGE_HUMIDITY,MAX_STORAGE_HUMIDITY,ENG_ATTRIBUTE,MTK_MODE,MIN_DURAB_DAYS_CO_DELIV,MIN_DURAB_DAYS_PLANNING,STOCK_MANAGEMENT_DB,PLANNING_METHOD_AUTO_DB) VALUES (''' 
                 || PART_NO
      || ''',''' || CONTRACT
      || ''',''' || DESCRIPTION
      || ''',''' || UNIT_MEAS
      || ''',''' || TYPE_CODE
      || ''',''' || ABC_CLASS
      || ''',''' || PLANNER_BUYER
      || ''',''' || PRIME_COMMODITY
      || ''',''' || SECOND_COMMODITY
      || ''',''' || ASSET_CLASS
      || ''',''' || PART_STATUS
      || ''',''' || HAZARD_CODE
      || ''',''' || ACCOUNTING_GROUP
      || ''',''' || PART_PRODUCT_CODE
      || ''',''' || PART_PRODUCT_FAMILY
      || ''',''' || TYPE_DESIGNATION
      || ''',''' || DIM_QUALITY
      || ''',''' || CREATE_DATE
      || ''',''' || NOTE_TEXT
      || ''',''' || INPUT_UNIT_MEAS_GROUP_ID
      || ''',''' || CATCH_UNIT_MEAS
      || ''',''' || DOP_NETTING_DB
      || ''',''' || EXPECTED_LEADTIME
      || ''',''' || DURABILITY_DAY
      || ''',''' || SUPERSEDES
      || ''',''' || COUNTRY_OF_ORIGIN
      || ''',''' || CUSTOMS_STAT_NO
      || ''',''' || TECHNICAL_COORDINATOR
      || ''',''' || PURCH_LEADTIME
      || ''',''' || MANUF_LEADTIME
      || ''',''' || SUPPLY_CODE_DB
      || ''',''' || INTRASTAT_CONV_FACTOR
      || ''',''' || QTY_CALC_ROUNDING
      || ''',''' || ESTIMATED_MATERIAL_COST
      || ''',''' || LATEST_PURCHASE_PRICE
      || ''',''' || AVERAGE_PURCHASE_PRICE
      || ''',''' || CYCLE_PERIOD
      || ''',''' || INVENTORY_VALUATION_METHOD
      || ''',''' || INVENTORY_PART_COST_LEVEL
      || ''',''' || ZERO_COST_FLAG
      || ''',''' || PART_COST_GROUP_ID
      || ''',''' || NEGATIVE_ON_HAND_DB
      || ''',''' || SHORTAGE_FLAG
      || ''',''' || FORECAST_CONSUMPTION_FLAG_DB
      || ''',''' || ONHAND_ANALYSIS_FLAG_DB
      || ''',''' || CYCLE_CODE_DB
      || ''',''' || EXT_SERVICE_COST_METHOD_DB
      || ''',''' || INVOICE_CONSIDERATION_DB
      || ''',''' || STD_NAME
      || ''',''' || PLANNING_METHOD
      || ''',''' || LOT_SIZE
      || ''',''' || MIN_ORDER_QTY
      || ''',''' || MAX_ORDER_QTY
      || ''',''' || MUL_ORDER_QTY
      || ''',''' || SHRINKAGE_FAC
      || ''',''' || STD_ORDER_SIZE
      || ''',''' || SAFETY_STOCK
      || ''',''' || ORDER_POINT_QTY
      || ''',''' || MAXWEEK_SUPPLY
      || ''',''' || ORDER_REQUISITION_DB
      || ''',''' || QTY_PREDICTED_CONSUMPTION
      || ''',''' || PROPOSAL_RELEASE_DB
      || ''',''' || BACKFLUSH_PART_DB
      || ''',''' || PROCESS_TYPE
      || ''',''' || MANUF_ENGINEER
      || ''',''' || DENSITY
      || ''',''' || MRP_CONTROL_FLAG_DB
      || ''',''' || ENG_REVISION
      || ''',''' || ENG_CHG_LEVEL
      || ''',''' || ENG_REVISION_DESC
      || ''',''' || STORAGE_WIDTH_REQUIREMENT
      || ''',''' || STORAGE_HEIGHT_REQUIREMENT
      || ''',''' || STORAGE_DEPTH_REQUIREMENT
      || ''',''' || STORAGE_VOLUME_REQUIREMENT
      || ''',''' || STORAGE_WEIGHT_REQUIREMENT
      || ''',''' || MIN_STORAGE_TEMPERATURE
      || ''',''' || MAX_STORAGE_TEMPERATURE
      || ''',''' || MIN_STORAGE_HUMIDITY
      || ''',''' || MAX_STORAGE_HUMIDITY
      || ''',''' || ENG_ATTRIBUTE
      || ''',''' || MTK_MODE
      || ''',''' || MIN_DURAB_DAYS_CO_DELIV
      || ''',''' || MIN_DURAB_DAYS_PLANNING
      || ''',''' || STOCK_MANAGEMENT_DB
      || ''',''' || PLANNING_METHOD_AUTO_DB       
		||  ''');'   aa
FROM (
