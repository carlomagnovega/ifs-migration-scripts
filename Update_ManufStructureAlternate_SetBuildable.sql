DECLARE   
   CURSOR get_qaman IS
      SELECT objid,  objversion
      FROM PROD_STRUCT_ALTERNATE a
	  WHERE a.STATE <> 'Buildable'
	  AND EXISTS (SELECT 1 FROM PROD_STRUCTURE b WHERE a.contract = b.contract 
				 AND a.part_no = b.part_no
				 AND a.ENG_CHG_LEVEL =b.ENG_CHG_LEVEL 
				 AND    a.ALTERNATIVE_NO =b.ALTERNATIVE_NO 
             AND a.BOM_TYPE =b.BOM_TYPE 
             AND b.qty_per_assembly > 0);
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
BEGIN
   
   FOR row_ IN get_qaman LOOP
      objid_      := row_.objid;
      objversion_ := row_.objversion;
      attr_ := '';

      PROD_STRUCT_ALTERNATE_API.BUILD__( info_ , objid_ , objversion_ , attr_, 'DO' );
      COMMIT;
   END LOOP;   
END;