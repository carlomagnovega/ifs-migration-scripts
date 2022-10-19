----Update Inventory_Part CustomFields
DECLARE   
   CURSOR get_qaman IS
      SELECT qcp.objid                            
      FROM Inventory_Part_CFV qcp
      WHERE CONTRACT = '11RI'
      AND qcp.TYPE_CODE = 'Manufactured';      
   
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
      Client_SYS.Add_To_Attr('CF$_AIM_COEF_METAL', '1', attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIM_COEF_MFG', '1', attr_cf_);
 
      INVENTORY_PART_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');
      COMMIT;
   END LOOP;
   
END;