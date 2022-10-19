----Update ManufPart DefaultPrintUnit
DECLARE   
   CURSOR get_qaman IS
   SELECT b.objid,            
         b.objversion,
         a.CONTRACT,
          a.PART_NO,
          a.PLANNER_BUYER,
          a.input_unit_meas_group_id,
          a.unit_meas,
         b.default_print_unit
   FROM INVENTORY_PART a
   INNER JOIN MANUF_PART_ATTRIBUTE b ON a.CONTRACT = b.CONTRACT AND a.PART_NO = b.PART_NO
   INNER JOIN PART_CATALOG pct ON pct.PART_NO = a.PART_NO
   WHERE a.CONTRACT = '20MEX' 
   and (a.PLANNER_BUYER like 'FLUX_RAW_MX')
   AND a.unit_meas = 'kg'
   AND (b.default_print_unit IS NULL OR b.default_print_unit <> 'g');

   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000);   
BEGIN
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('DEFAULT_PRINT_UNIT', 'g', attr_);
      MANUF_PART_ATTRIBUTE_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
   END LOOP;   
END;