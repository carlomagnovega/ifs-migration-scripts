SELECT 'INSERT INTO mtk_sales_part_tab (catalog_no,catalog_type_db,catalog_desc,part_no,contract,price_unit_meas,conv_factor,price_conv_factor,sales_unit_meas,date_entered,list_price,sourcing_option,rule_id,sales_price_group_id,catalog_group,discount_group,taxable_db,fee_code,activeind_db,close_tolerance,print_control_code,mtk_mode, note_text,minimum_qty,replacement_part_no,date_of_replacement,create_sm_object_option_db,expected_average_price,sales_type_db) VALUES (''' 
                 || catalog_no
      || ''',''' || catalog_type
      || ''',''' || catalog_desc
      || ''',''' || part_no
      || ''',''' || contract
      || ''',''' || price_unit_meas
      || ''',''' || conv_factor
      || ''',''' || price_conv_factor
      || ''',''' || sales_unit_meas
      || ''',''' || date_entered
      || ''',''' || list_price
      || ''',''' || sourcing_option
      || ''',''' || rule_id
      || ''',''' || sales_price_group_id
      || ''',''' || catalog_group
      || ''',''' || discount_group
      || ''',''' || taxable
      || ''',''' || fee_code
      || ''',''' || activeind
      || ''',''' || close_tolerance
      || ''',''' || print_control_code
      || ''',''' || mtk_mode
      || ''',''' || note_text
      || ''',''' || minimum_qty
      || ''',''' || replacement_part_no
      || ''',''' || date_of_replacement
      || ''',''' || create_sm_object_option
      || ''',''' || expected_average_price
      || ''',''' || sales_type             
		||  ''');'   aa
FROM (
   SELECT catalog_no,
   catalog_type,
   catalog_desc,
   part_no,
   contract,
   price_unit_meas,
   conv_factor,
   price_conv_factor,
   sales_unit_meas,
   date_entered,
   list_price,
   sourcing_option,
   rule_id,
   sales_price_group_id,
   catalog_group,
   discount_group,
   taxable,
   'GOODS' fee_code,
   activeind,
   close_tolerance,
   print_control_code,
   '*' mtk_mode,
   note_text,
   minimum_qty,
   replacement_part_no,
   date_of_replacement,
   create_sm_object_option,
   expected_average_price,
   sales_type             

FROM SALES_PART_TAB
WHERE CONTRACT  IN ('32IND', '30HK'))aaa

---------------------------------------
SELECT 'INSERT INTO mtk_sales_part_tab (catalog_no,catalog_type_db,catalog_desc,part_no,contract,price_unit_meas,conv_factor,price_conv_factor,sales_unit_meas,date_entered,list_price,sourcing_option,rule_id,sales_price_group_id,catalog_group,discount_group,taxable_db,fee_code,activeind_db,close_tolerance,print_control_code,mtk_mode, note_text,minimum_qty,replacement_part_no,date_of_replacement,create_sm_object_option_db,expected_average_price,sales_type_db) VALUES (''' 
|| catalog_no
|| ''',''' || catalog_type
|| ''',''' || catalog_desc
|| ''',''' || part_no
|| ''',''' || contract
|| ''',''' || price_unit_meas
|| ''',''' || conv_factor
|| ''',''' || price_conv_factor
|| ''',''' || sales_unit_meas
|| ''',''' || date_entered
|| ''',''' || list_price
|| ''',''' || sourcing_option
|| ''',''' || rule_id
|| ''',''' || sales_price_group_id
|| ''',''' || catalog_group
|| ''',''' || discount_group
|| ''',''' || taxable
|| ''',''' || fee_code
|| ''',''' || activeind
|| ''',''' || close_tolerance
|| ''',''' || print_control_code
|| ''',''' || mtk_mode
|| ''',''' || note_text
|| ''',''' || minimum_qty
|| ''',''' || replacement_part_no
|| ''',''' || date_of_replacement
|| ''',''' || create_sm_object_option
|| ''',''' || expected_average_price
|| ''',''' || sales_type             
||  ''');'   aa
FROM (SELECT part_no catalog_no,
       'INV' catalog_type,
             description catalog_desc,
             part_no,
             contract,
             UNIT_MEAS price_unit_meas,
             '1' conv_factor,
             '1' price_conv_factor,
             UNIT_MEAS sales_unit_meas,
              to_date('2010-01-01', 'YYYY-MM-DD') date_entered,
             '0' list_price,
             'SHOPORDER' sourcing_option,
             '' rule_id,
             '*' sales_price_group_id,
             '*' catalog_group,
             '' discount_group,
             'TRUE' taxable,
             'GOODS' fee_code,
             'Y' activeind,
             '0' close_tolerance,
             '' print_control_code,
             '*' mtk_mode,
             '' note_text,
             '' minimum_qty,
             '' replacement_part_no,
             '' date_of_replacement,
             'DONOTCREATESMOBJECT' create_sm_object_option,
             '' expected_average_price,
             'SALES' sales_type             
FROM INVENTORY_PART_TAB --SALES_PART_TAB
WHERE CONTRACT  IN ('33CX')
AND PLANNER_BUYER IN ('CASTING_FG', 'CASTING_FG_CX', 'EXTRUSION_FG', 'EXTRUSION_FG_CX' ,'FLUX_FG_CX','MEDIUM_FG_CX','PASTE_FG_CX','POWDER_FG','POWDER_FG_CX','SPEC_EXTRUSION_FG','SPEC_RESALE_FG'))aaa


----Update SalesPart Taxes
DECLARE   
   CURSOR get_qaman IS
      SELECT a.objid,            
             a.objversion,
             a.CONTRACT,
             a.PART_NO,
             TAX_CLASS_ID,
             TAX_CODE
      FROM SALES_PART a
      WHERE a.CONTRACT = '33CX'
      --AND a.FEE_CODE IS NULL
      AND (TAX_CLASS_ID IS NULL OR  TAX_CLASS_ID <> 'GOODS');
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000);   
BEGIN
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;      
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('TAX_CODE', '', attr_);
      Client_SYS.Add_To_Attr('TAX_CLASS_ID', 'GOODS', attr_);
      
      SALES_PART_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
   END LOOP;   
END;

-----------------------------------
DECLARE   
   CURSOR get_qaman IS
      SELECT a.objid,            
             a.objversion,
             a.CONTRACT,
             a.PART_NO,
             TAX_CLASS_ID,
             TAX_CODE
      FROM SALES_PART a
      WHERE a.CONTRACT = '33CX'
      AND (TAXABLE_DB <> 'TRUE');
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000);   
BEGIN
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;      
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('TAXABLE_DB', 'TRUE', attr_);
      SALES_PART_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
   END LOOP;   
END;

