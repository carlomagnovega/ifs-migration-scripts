----Update SalesPart Taxes
DECLARE   
   CURSOR get_qaman IS
      SELECT a.objid,            
             a.objversion,
             a.CONTRACT,
             a.PART_NO,
             TAX_CLASS_ID,
             TAX_CODE
      FROM SALES_PART a
      WHERE a.CONTRACT = '33CX'
      --AND a.FEE_CODE IS NULL
      AND (TAX_CLASS_ID IS NULL OR  TAX_CLASS_ID <> 'GOODS');
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000);   
BEGIN
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;      
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('TAX_CODE', '', attr_);
      Client_SYS.Add_To_Attr('TAX_CLASS_ID', 'GOODS', attr_);
      
      SALES_PART_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
   END LOOP;   
END;

--------------------------------
DECLARE   
   CURSOR get_qaman IS
		SELECT qcp.objid, qcp.objversion
		FROM SALES_PART qcp
		WHERE CONTRACT IN ('34MAY')
		AND qcp.fee_code <> 'MALAYSIA NO SALE TAX';   
   
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
      Client_SYS.Add_To_Attr('FEE_CODE', 'MALAYSIA NO SALE TAX', attr_);

      SALES_PART_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      COMMIT;
   END LOOP;   
END;

-------------------------------------
DECLARE   
   CURSOR get_qaman IS
      SELECT objid, 
             objversion
		FROM SALES_PART qcp
      WHERE CONTRACT = '21BRA' 
      and upper( SOURCING_OPTION ) <> upper( 'Inventory Order' );   
   
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
      Client_SYS.Add_To_Attr('SOURCING_OPTION', 'Inventory Order', attr_);
      
      SALES_PART_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      COMMIT;
   END LOOP;   
END;

