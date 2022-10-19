----Delete some PROD_STRUCTURE
UPDATE manuf_struct_alternate_tab PST
SET ROWSTATE = 'Tentative'
WHERE EXISTS (SELECT 1 
                     FROM MTK_MANUF_STRUCTURE_HEAD_TAB MST 
                     where MST.CONTRACT = PST.CONTRACT  AND MST.PART_NO = PST.PART_NO);

DECLARE   
   CURSOR get_qaman IS
      SELECT objid,  
             objversion,
             a.Contract, 
             a.Part_No,
             a.eng_chg_level,
             a.bom_type,
             a.alternative_no
      FROM PROD_STRUCTURE a
      INNER JOIN MTK_MANUF_STRUCTURE_HEAD_TAB b ON a.Contract = b.Contract AND a.Part_No = b.Part_No;
   
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
   no_alt_recs_         NUMBER;
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_qaman LOOP
      objid_      := row_.objid;
      objversion_ := row_.objversion;
      
      no_alt_recs_ := 1;
      
      PROD_STRUCTURE_API.REMOVE__( info_ , objid_ , objversion_ , 'DO' );
      COMMIT;      
   END LOOP;   
END;