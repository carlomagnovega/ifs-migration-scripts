SELECT
   PART_NO,
   CONTRACT,
   VENDOR_NO,
   replace(VENDOR_PART_DESCRIPTION, '"', '-') VENDOR_PART_DESCRIPTION,
   VENDOR_PART_NO,
   PRICE_UNIT_MEAS,
   BUY_UNIT_MEAS,
   CONV_FACTOR,
   LIST_PRICE,
   CURRENCY_CODE,
   PRICE_CONV_FACTOR,
   '' EAN_NO,
   STANDARD_PACK_SIZE,
   primary_vendor_db FLAG_VENDOR,
   STATUS_CODE,
   CONTACT,
   MINIMUM_QTY,
   VENDOR_MANUF_LEADTIME,
   STD_MULTIPLE_QTY,
   RECEIVE_CASE_DB,
   INSPECTION_CODE,
   SAMPLE_PERCENT,
   SAMPLE_QTY,
   '' MTK_MODE,
   PART_OWNERSHIP_DB,
   EXTERNAL_SERVICE_ALLOWED_DB,
   INTERNAL_CONTROL_TIME,
   MULTISITE_PLANNED_PART_DB,
   FEE_CODE,
   SUPPLY_CONFIGURATION_DB,
   ORDERS_PRICE_OPTION_DB,
   QTY_CALC_ROUNDING,
   ASSORTMENT,
   ADDITIONAL_COST_AMOUNT,
   DISCOUNT,
   DELIVERY_PATTERN_ID   
FROM PURCHASE_PART_SUPPLIER a
WHERE VENDOR_NO = 1015


DECLARE   
   CURSOR get_qaman IS
      SELECT a.objid,  
             a.objversion
      FROM PURCHASE_PART_SUPPLIER a
	  WHERE VENDOR_NO = 1015;
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_qaman LOOP
      objid_      := row_.objid;
      objversion_ := row_.objversion;
      
      PURCHASE_PART_SUPPLIER_API.REMOVE__( info_ , objid_ , objversion_ , 'DO' );
      COMMIT;      
   END LOOP;   
END;

