DECLARE   
   CURSOR get_qaman IS
      SELECT a.PART_NO,
             a.contract,
             a.objid,            
             a.objversion,
             QTY_CALC_ROUNDING
		FROM  INVENTORY_PART a
      WHERE contract = '33CX'
      and TYPE_CODE_DB = 1
      AND QTY_CALC_ROUNDING <> 4
      and Iso_Unit_Type_API.Encode(Iso_Unit_API.Get_Unit_Type(unit_meas)) <> 'DISCRETE';

   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000);   
   
BEGIN
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('QTY_CALC_ROUNDING', '4', attr_);   
      
      INVENTORY_PART_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      --COMMIT;
   END LOOP;   
END;