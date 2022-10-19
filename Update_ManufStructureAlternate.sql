---Update ManufStructure Alternate
DECLARE   
   CURSOR get_mfstr IS
      SELECT objid,  objversion 
      FROM PROD_STRUCT_ALTERNATE a
      WHERE use_cost_distribution_DB = 'STANDARD'
      AND EXISTS (SELECT 1 FROM PROD_STRUCTURE b WHERE a.contract = b.contract AND a.part_no = b.part_no);
      
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_mfstr LOOP
      objid_      := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(info_);
      Client_SYS.Clear_Attr(attr_);
	  Client_SYS.Add_To_Attr('USE_COST_DISTRIBUTION_DB', 'DISTRIBUTION', attr_);

      PROD_STRUCT_ALTERNATE_API.MODIFY__( info_ , objid_ , objversion_, attr_, 'DO' );
      
      COMMIT;
   END LOOP;   
END;
