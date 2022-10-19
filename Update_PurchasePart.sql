DECLARE   
   CURSOR get_qaman IS
		SELECT a.objid, a.objversion
      FROM PURCHASE_PART a   
      WHERE CONTRACT = '40UK' and upper( TAXABLE_DB ) = upper( 'FALSE' );   
   
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
      Client_SYS.Add_To_Attr('TAXABLE_DB', 'TRUE', attr_);
      
      PURCHASE_PART_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      COMMIT;
   END LOOP;   
END;

------------------------------
DECLARE   
   CURSOR get_qaman IS
		SELECT qcp.objid, qcp.objversion
		FROM PURCHASE_PART qcp
		WHERE CONTRACT IN ('40UK');   
   
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
      Client_SYS.Add_To_Attr('BUYER_CODE', 'CORPBUYER', attr_);

      PURCHASE_PART_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      COMMIT;
   END LOOP;   
END;

