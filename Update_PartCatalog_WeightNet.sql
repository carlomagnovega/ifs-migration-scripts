--Allow insert float values
alter session set NLS_NUMERIC_CHARACTERS = '.,';

---------------------
DECLARE   
   CURSOR get_qaman IS
      SELECT PART_NO,
             WEIGHT_NET,
             UOM_FOR_WEIGHT_NET,
             qcp.objid, 
             qcp.objversion
      FROM PART_CATALOG qcp
      WHERE WEIGHT_NET IS NULL
	  AND UOM_FOR_WEIGHT_NET IS NULL
	  AND upper( UNIT_CODE ) = upper( 'ea500g' );      
   
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
      Client_SYS.Add_To_Attr('WEIGHT_NET', '1.1023', attr_);
      Client_SYS.Add_To_Attr('UOM_FOR_WEIGHT_NET', 'lb', attr_);
	  
      PART_CATALOG_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      COMMIT;
   END LOOP;
   
END;