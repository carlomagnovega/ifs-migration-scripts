DECLARE   
   CURSOR get_qaman IS
      SELECT a.objid,
             CF$_AIM_PRODUCTION_ALLOY,
             Commodity_Group_API.Get_Description(SECOND_COMMODITY) PRODUCTION_ALLOY
      FROM INVENTORY_PART_CFV a
      WHERE CONTRACT = '40UK' and SECOND_COMMODITY is not NULL 
      AND CF$_AIM_PRODUCTION_ALLOY IS NULL;
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      Client_SYS.Clear_Attr(attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIM_PRODUCTION_ALLOY', row_.PRODUCTION_ALLOY, attr_cf_); 
      
      INVENTORY_PART_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');
      COMMIT;
   END LOOP;   
END;