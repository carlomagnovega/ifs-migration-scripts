----Update ManufPart DefaultPrintUnit
DECLARE   
   CURSOR get_qaman IS
      SELECT a.objid,            
             a.objversion,
             a.CONTRACT,
             a.PART_NO
      FROM SALES_PART a
      INNER JOIN INVENTORY_PART b ON a.PART_NO = b.PART_NO AND a.CONTRACT = b.CONTRACT
      WHERE a.CONTRACT = '20MEX'
      AND b.TYPE_CODE_DB = 1
      AND a.sourcing_option_db <> 'SHOPORDER'
      AND a.FEE_CODE IS NULL;
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000);   
BEGIN
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;      
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('SOURCING_OPTION', 'Shop Order', attr_);
      
      SALES_PART_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
   END LOOP;   
END;