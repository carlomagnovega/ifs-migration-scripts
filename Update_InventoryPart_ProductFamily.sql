----Update InventoryPart 11RI
DECLARE   
   CURSOR get_qaman IS
		SELECT objid,            
			objversion 
		FROM  INVENTORY_PART
		where (PART_NO like '%BULK%') 
		and (CONTRACT IN ('10MTL','11RI')) 
		and (PLANNER_BUYER like 'SPEC_BULK');
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000);   
   
BEGIN
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('PART_PRODUCT_FAMILY', '28', attr_);      
	  
      INVENTORY_PART_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      --COMMIT;
   END LOOP;   
END;