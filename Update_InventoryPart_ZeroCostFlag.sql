----Update Inventory_Part Zero_Cost_Flag
DECLARE   
   CURSOR get_qaman IS
      SELECT qcp.objid, qcp.objversion
      FROM Inventory_Part qcp
      WHERE CONTRACT = '11RI'
      AND qcp.ZERO_COST_FLAG <> 'Zero Cost Allowed';      
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('ZERO_COST_FLAG', 'Zero Cost Allowed', attr_);
 
      INVENTORY_PART_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      COMMIT;
   END LOOP;
   
END;
