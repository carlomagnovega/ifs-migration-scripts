----Update Inventory_Part Alloy
DECLARE   
   CURSOR get_qaman IS
      SELECT
         a.objid,
         a.CONTRACT,
         a.PART_NO,
         c.objkey CF$_AIM_ALLOYSPEC
      FROM Inventory_Part_CFV a
      INNER JOIN Inventory_Part_CFV b ON b.PART_NO = a.PART_NO 
            AND b.CONTRACT = '10MTL' 
            AND a.CONTRACT = '33CX'
            AND b.PART_PRODUCT_FAMILY = '06'
      LEFT JOIN CONTROL_PLAN_TEMPL_HEADER_CLV c ON c.CF$_SPEC_ID = b.CF$_AIM_ALLOYSPEC
      WHERE b.CF$_AIM_ALLOYSPEC IS NOT NULL
      AND a.CF$_AIM_ALLOYSPEC IS NULL;
   
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
      Client_SYS.Add_To_Attr('CF$_AIM_ALLOYSPEC', row_.CF$_AIM_ALLOYSPEC, attr_cf_); 
      INVENTORY_PART_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');
      COMMIT;
   END LOOP;   
END;
